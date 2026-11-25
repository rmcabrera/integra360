CREATE PROCEDURE [dbo].[usp_repo_clie_x_linea]
	@FI [datetime],
	@FF [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @FI datetime , @FF datetime, @alma char(2)
--select @fi='01/01/2017', @ff='31/01/2017' , @alma='04'

set nocount on 


declare @alm table (codi_alma char(2))

if @alma='00'
	insert @alm
	select codi_alma from almacen (nolock)
else
	insert @alm
	select @alma

declare @Rx table (almacen varchar(50), codi_prod char(8) , cliente varchar(250), precio numeric(12,2) null,
				cantidad numeric(12,2) null, linea varchar(50))		
				
insert @Rx				
SELECT ALMACEN.NEMO_ALMA,   
       FACTURA_DETALLE.CODI_PROD,
		(Select isnull(denominacion,'NO DEFINIDO') from cliente_proveedor where codi_clie_prov=FACTURA.CODI_CLIE_PROV) CLIENTE,
		(FACTURA_DETALLE.PREC_ITEM * (CASE WHEN factura.codi_mone='01' THEN 1 ELSE factura.tcambio END)) PREC_ITEM,
		cant_item,
		(select (select (select (select cod_lin_pro from LINEA_FAMILIA_PRO L (nolock) 
							where l.cod_lin_pro in (select F.cod_lin_pro from familia_producto F (nolock)
						where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
					where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
						where P.codi_prod =PRODUCTOS.codi_prod) )))))) Linea         
    FROM ALMACEN (nolock),   
         FACTURA(nolock),   
         FACTURA_DETALLE(nolock),   
         PRODUCTOS(nolock),   
         PRESENTACION  (nolock)
   WHERE ( ALMACEN.CODI_ALMA = FACTURA.CODI_ALMA ) and  
         ( FACTURA_DETALLE.CODI_FACT = FACTURA.CODI_FACT ) and  
         ( PRODUCTOS.CODI_PROD = FACTURA_DETALLE.CODI_PROD ) and  
         ( PRODUCTOS.cod_pres = PRESENTACION.cod_pres ) and
		( ISNULL(FACTURA.ESTADO,'')<>'A') and
		( FACTURA.FECH_FACT >= @FI) and
		( FACTURA.FECH_FACT < DATEADD(DAY,1,@FF))
		and factura.codi_alma in (select a.codi_alma from @Alm A )

select	max(case when @alma='00' then 'TODOS' else almacen end ) as Almacen, 
--		codi_prod, 
		cliente, 
--		precio, 
--		cantidad, 
		--linea, 
		sum(case when linea='04' then precio*cantidad else 0 end) as FComp,
		sum(case when linea='06' then precio*cantidad else 0 end) as FGene,
		sum(case when linea='03' then precio*cantidad else 0 end) as Herra,
		sum(case when linea='05' then precio*cantidad else 0 end) as Nutri,
		sum(case when linea='01' then precio*cantidad else 0 end) as Pesti,
		sum(case when linea='02' then precio*cantidad else 0 end) as Semi,
		sum(precio*cantidad) as total
from @Rx
group by cliente
GO
