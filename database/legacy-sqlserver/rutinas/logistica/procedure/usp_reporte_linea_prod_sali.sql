CREATE PROCEDURE [dbo].[usp_reporte_linea_prod_sali]
	@F1 [datetime],
	@F2 [datetime],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @F1 datetime, @F2 datetime, @codi_alma char(2)
--select @F1='15/02/2015', @F2 ='17/02/2015', @codi_alma='02'

set nocount on
declare @alma table (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock)
END
ELSE
BEGIN
	insert @alma
	Select codi_alma from almacen  (nolock) where codi_alma = @codi_alma
END

declare @Tx table(codi_prod char(8) null, cantidad numeric(12,2) null)

insert @Tx
select distinct codi_prod, isnull(sum(cantidad),0) cantidad
from docu_sali_mate S(nolock)
join detalle_docu_sali D(nolock)
on S.codi_docu_sali = D.codi_docu_sali
where S.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) 
and cast(convert(char(10), fech_emis, 103) as datetime) between @F1 and @F2 and isnull(estado,'')<>'A' and isnull(tipo_sali,'')<>'08'
group by codi_prod

--select * from @Tx

select distinct D.codi_prod, (select desc_prod from productos (nolock) where codi_prod=D.codi_prod) as Desc_prod,
	( Select (Select desc_fami_prod from familia_producto F where F.codi_fami_prod= S.codi_fami_prod) from sub_familia_producto S 
		where S.codi_sub_fami_prod in ( select P.codi_sub_fami_prod from Productos P where P.codi_prod=D.codi_prod) ) Familia,
	(select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where L.cod_lin_pro in
		(select cod_lin_pro from FAMILIA_PRODUCTO FP(nolock) where FP.codi_fami_prod in 
			(select codi_fami_prod from SUB_FAMILIA_PRODUCTO SF(nolock) where SF.codi_sub_fami_prod in
				(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=D.codi_prod) ) ) ) linea,
	isnull(sum(D.cant_item),0) cant_item, isnull(sum(T.cantidad),0) otros,	
	
	(select sum(cant_ingr - cant_sali) 
		from kardex k (nolock)
		where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) 
		and cast(convert(char(10),fech_tran,103)  as datetime )<= @F2 and periodo=year(@F2) and K.codi_prod =D.codi_prod
	group by codi_prod) -
	
	(select isnull(sum(cantidad),0)
	from registro_vale a(nolock)
	join registro_vale_detalle b(nolock)
	on a.codi_vale=b.codi_vale
	where /*year(fecha)=year(@F2) and*/ cast(convert(char(10),fecha,103)  as datetime )<= @F2
	and isnull(a.codi_fact,'')='' and isnull(estado,'')=''
	and a.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) 
	and b.codi_prod=D.codi_prod) stock,

	(Select razon_social from empresa (nolock) ) as rs_empr ,
	(case when @codi_alma='00' then 'TODOS' else
		(select nemo_alma from almacen (nolock) where codi_alma=@codi_alma) end ) Sucursal,
	/*(select left(nemo_alma,4) from almacen (nolock) where codi_alma=max(S.codi_alma) )*/ '' Sucursal_prod
from factura S(nolock)
join factura_detalle D(nolock)
on S.codi_fact = D.codi_fact
left join @Tx T
on D.codi_prod = T.codi_prod
where S.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) 
and cast(convert(char(10), fech_fact, 103) as datetime) between @F1 and @F2 and isnull(estado,'')<>'A'
--and D.codi_prod='00080569'
group by D.codi_prod
GO
