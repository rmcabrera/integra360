CREATE PROCEDURE [dbo].[usp_reporte_productos_venta_vence]
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @alma char(2)
--select @alma='05'

set nocount on

create table #Px(codi_prod char(8))

insert #Px
select codi_prod
from(
select codi_prod, datediff(d, getdate(), fec_vence) dias
from producto_almacen_lote (nolock)
where codi_alma=@alma and isnull(stock,0)<>0 and fec_vence is not null
--and codi_prod='00011673'
) as sql
where dias between 1 and 31


--select * from #Px

create table #PxF(codi_prod char(8), fec datetime)

insert #PxF
select B.codi_prod, max(fech_Fact) fech_Fact
from factura A(nolock)
join factura_detalle B(nolock)
on A.codi_Fact=B.codi_Fact
join #Px P(nolock)
on P.codi_prod=B.codi_prod
where A.codi_alma=@alma and codi_tipo_pago=1 --and B.codi_prod='00080673'
and cast(CONVERT(char(10),fech_Fact,103)as datetime) <=getdate()

group by B.codi_prod


--select * from #PxF

create table #Sx(codi_prod char(8), sald_real numeric(18,2) null)

insert #Sx
select K.codi_prod, sum(cant_ingr) - sum(cant_sali) 
from kardex K(nolock)
join #Px P(nolock)
on K.codi_prod=P.codi_prod
where periodo=year(getdate()) and K.codi_alma=@alma 
group by K.codi_prod
having sum(cant_ingr) - sum(cant_sali) <> 0 


--select * from #Sx

create table #Rx(codi_prod char(8) null, desc_prod varchar(150) null, sub_familia varchar(150) null, laboratorio varchar(150) null,
				dias numeric(18) null, fec_vence datetime null)

insert #Rx
select P.codi_prod, desc_prod,

		(select desc_sub_Fami_prod from sub_familia_producto S(nolock) where S.codi_sub_fami_prod=P.codi_sub_fami_prod) as sub_familia,	
		
		dbo.f_cliente_proveedor(P.codi_clie_prov) as laboratorio,
		
		datediff(d, fec, getdate()) as dias,
		
		fec_vence

from producto_almacen_lote PAL(nolock)
join #Px A
on PAL.codi_prod=A.codi_prod
join productos P(nolock)
on A.codi_prod=P.codi_prod
left join #PxF B
on P.codi_prod = B.codi_prod
where codi_alma=@alma and isnull(PAL.stock,0)<>0 and fec_vence is not null

order by desc_prod


select R.codi_prod, desc_prod, sub_familia, laboratorio,
				dias, sald_real, fec_vence
from #Rx R
join #Sx S
on R.codi_prod=S.codi_prod
--where isnull(sald_real,0) <> 0


drop table #Px
drop table #PxF
drop table #Rx
drop table #Sx
GO
