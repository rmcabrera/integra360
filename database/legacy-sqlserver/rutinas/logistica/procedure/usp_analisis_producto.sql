CREATE PROCEDURE [dbo].[usp_analisis_producto]
	@per [int],
	@f1 [datetime],
	@f2 [datetime],
	@ls_tipo [char](2),
	@ls_Dato [varchar](5)
WITH EXECUTE AS CALLER
AS
--declare @per int , @f1 datetime, @f2 datetime ,@ls_tipo char(2), @ls_Dato varchar(5)
--select @per = 2016, @f1='01/04/2016' , @f2='07/04/2016', @ls_tipo='00' , @ls_dato=''

set nocount on
create table #Tx (codi_alma char(2) , codi_prod char(8), tipo char(2) , cantidad numeric(12,2))

declare @TablaAx table (codigo varchar(5))

if @ls_tipo<>'00'
begin
	insert @TablaAx
	select @ls_dato
end

insert #Tx
select '00', codi_prod, '01' as tipo_nota_ingr, sum(cant_ingr) compras
from kardex A(nolock)
join nota_ingreso B (nolock)
on A.codi_docu_i_o=B.codi_nota_ingr
where periodo=@per and tipo_nota_ingr in ('01','26') and 
		cast(convert(char(10),fech_tran,103) as datetime) between @f1 and @f2 and i_o=1		
group by codi_prod

insert #Tx
select tipo, codi_prod, tipo_nota_ingr, sum(compras)
from
	(select '99' as tipo, codi_prod, 
			'04' as tipo_nota_ingr, 
			sum(case when tipo_nota_ingr='04' or fech_tran<@f1 then cant_ingr else 0 end) compras		
	from kardex A(nolock)
	join nota_ingreso B (nolock)
	on A.codi_docu_i_o=B.codi_nota_ingr
	where periodo=@per and 
			cast(convert(char(10),fech_tran,103) as datetime) <= @f1 and i_o=1
	group by codi_prod
	union all
	select '99', codi_prod, 
			'04' as tipo_nota_ingr, 
			-1*sum(case when fech_tran<@f1 then cant_sali else 0 end) compras		
	from kardex A(nolock)
	where periodo=@per and 
			cast(convert(char(10),fech_tran,103) as datetime) < @f1 and i_o=2
	group by codi_prod) as SQ
group by tipo, tipo_nota_ingr, codi_prod	


insert #Tx
select A.codi_alma, codi_prod, tipo_sali, -1*sum(cant_sali) compras
from kardex A(nolock)
join docu_sali_mate B (nolock)
on A.codi_docu_i_o=B.codi_docu_sali
where periodo=@per and tipo_sali in ('08') and cast(convert(char(10),fech_tran,103) as datetime) between @f1 and @f2 and i_o=2
group by A.codi_alma, codi_prod,tipo_sali

select case when codi_alma='99' then '00' else codi_alma end +' - ' + 
				case when codi_alma='00' then 'Compras' 
					when codi_alma='99' then 'Ant.'
					else (select nemo_alma from almacen A (nolock)
			where A.codi_alma=T.codi_alma) end   as Almacen,
		T.codi_prod,
		(select desc_prod from productos P (nolock) where p.codi_prod=T.codi_prod) DesProd,
		(select dbo.f_cliente_proveedor(codi_clie_prov ) from productos P (nolock) where p.codi_prod=T.codi_prod)  as laboratorio,
		tipo, cantidad	
from #Tx T
join productos P (nolock)
on T.codi_prod=P.codi_prod
join sub_familia_producto S (nolock)
on S.codi_sub_fami_prod=P.codi_sub_fami_prod
join familia_producto F (nolock)
on F.codi_fami_prod=S.codi_fami_prod
where (Codi_clie_prov in (select codigo from @TablaAx) or
		P.codi_sub_fami_prod in (select codigo from @TablaAx) or
			cod_lin_pro in (select codigo from @TablaAx)) or @ls_dato=''
--order by 3
		
drop table #Tx
GO
