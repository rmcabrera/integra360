CREATE PROCEDURE [dbo].[usp_stock_pendiente_all]
	@per [int]
WITH EXECUTE AS CALLER
AS
--declare @per int 
--select @per=2018

set nocount on 

declare @cod char(8)

create table #Rp (idd int, codi_prod char(8),  desc_prod varchar(150) , 
					codi_alma char(2) , nemo_alma varchar(50) , stock int, letras int, pendiente numeric(12,2) null, saldo numeric(12,2) null,
						cancelado numeric(12,2) null, empresa varchar(150) ,
						 prec_prom numeric(12,4) null, valorizado numeric(12,2)  null) 

declare @PX table (codi_prod char(8))

insert @Px
select distinct codi_prod
from kardex (nolock) where periodo=@per --and codi_prod='00080428'

declare c1 cursor for select codi_prod from @Px
open c1 
fetch c1 into @cod
while @@FETCH_STATUS=0
begin
	
	insert #Rp
	exec usp_stock_pendiente @prod =@cod, @per =@per, @tipo ='R'

	fetch c1 into @cod
end 
close c1
deallocate c1


create table  #Prec (codi_alma char(2) null, codi_prod char(8), prec_venta numeric(12,2) null)


insert #Prec
select distinct A.codi_alma, a.codi_prod, 
	max(round( case when  codi_mone='01' then 
			(prec_costo * ( 1 +  prec_porc_uti_esp / 100) *  case when  cod_impuesto=3 then 1 else  (1 + dbo.f_igv(getdate())/100.00) end  ) 
		else 
			(prec_costo * ( 1 +  prec_porc_uti_esp / 100) *  case when cod_impuesto=3 then 1 else (1 + dbo.f_igv(getdate())/100.00) end  )* tcambio 
		end , nro_decim_precio ) ) as precio_venta
from #Rp A
join almacen_producto B (nolock)
on A.codi_prod=B.codi_prod
join productos P (nolock)
on P.codi_prod=A.codi_prod
group by A.codi_alma, a.codi_prod

select idd, R.codi_prod, 
		Desc_prod,
		R.codi_alma, 
		Nemo_Alma,
		stock, 
		letras, 
		pendiente, 
		saldo, 
		cancelado,
		Empresa,
		prec_prom, 	
		
		case when Valorizado<0 then 0 else Valorizado end as Valorizado,
		
		(select (select cod_lin_pro  from familia_producto f (nolock)  
				where f.codi_fami_prod=s.codi_fami_prod) from sub_familia_producto S (nolock)
			where S.codi_sub_fami_prod in  (select P.codi_sub_fami_prod from productos P (nolock) where P.codi_prod=r.codi_prod)) as CodLinea,
		
		(select (select (select des_lin_pro from LINEA_FAMILIA_PRO L (nolock) where l.cod_lin_pro=F.cod_lin_pro) 
				 from familia_producto f (nolock)  
				where f.codi_fami_prod=s.codi_fami_prod) from sub_familia_producto S (nolock)
			where S.codi_sub_fami_prod in  (select P.codi_sub_fami_prod from productos P (nolock) where P.codi_prod=r.codi_prod)) as DesLinea,

		cast(case when cancelado<0 then cancelado*prec_prom else 0 end as numeric(12,2)) as NoPagado,

		(select s.desc_sub_fami_prod from sub_familia_producto S (nolock)
			where S.codi_sub_fami_prod in  (select P.codi_sub_fami_prod from productos P (nolock) where P.codi_prod=r.codi_prod)) as SubFamilia,

		dbo.F_Cliente_Proveedor((select P.codi_clie_prov from productos P (nolock) where P.codi_prod=r.codi_prod)) as Proveedor,
		(select codi_mone from productos P (nolock) where P.codi_prod=r.codi_prod) as codi_mone,
		prec_venta
from #Rp R 
join #prec P
on R.codi_prod=P.codi_prod
--where codi_prod=00012282

drop table #Rp
drop table #Prec
GO
