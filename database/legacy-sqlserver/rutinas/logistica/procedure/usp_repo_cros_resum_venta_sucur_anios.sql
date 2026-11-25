CREATE PROCEDURE [dbo].[usp_repo_cros_resum_venta_sucur_anios]
	@anio_i [int],
	@anio_f [int],
	@tipo [int]
WITH EXECUTE AS CALLER
AS
--declare @anio_i int,@anio_f int,@tipo int  
--select @anio_i='2009',@anio_f='2010',@tipo=1   
  
select codi_alma, (Select nemo_alma from almacen A (nolock) where a.codi_alma=sql.codi_alma) Nemo,  
 linea,   
 sum(cantidad) cantidad,   
 sum(prec_costo) costo,  
 sum(venta) venta,anio  
from  
(  SELECT FACTURA.CODI_ALMA,   
 (select (select (select (select des_lin_pro from LINEA_FAMILIA_PRO L (nolock)   
      where l.cod_lin_pro in (select F.cod_lin_pro from familia_producto F (nolock)  
     where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)  
    where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock)   
     where P.codi_prod =D.codi_prod) )))))) Linea,  
 sum(D.CANT_ITEM)  cantidad,  
 SUM(D.CANT_ITEM *(D.PREC_ITEM * (CASE WHEN factura.codi_mone='01' THEN 1 ELSE factura.tcambio END))) venta,  
 SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end))) prec_costo,  
 year(FACTURA.FECH_FACT) anio  
    FROM FACTURA (nolock),     
         FACTURA_DETALLE D(nolock),   
  productos (nolock)  
   WHERE  D.CODI_FACT = FACTURA.CODI_FACT  and    
   D.codi_prod=productos.codi_prod and   
 ( year(FACTURA.FECH_FACT)>=@anio_i ) and (year(FACTURA.FECH_FACT) <= @anio_f ) and   
 ( ISNULL(FACTURA.ESTADO,'')<>'A') and  
   codi_tipo_pago=@tipo  
 group by  factura.codi_alma, D.codi_prod,year(FACTURA.FECH_FACT)) SQL  
group by codi_alma, linea,anio  
order by linea,anio,codi_alma
GO
