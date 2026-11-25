CREATE PROCEDURE [dbo].[usp_repo_cros_resum_venta_sucur_anios_dos_cons]
	@anio_i [int],
	@anio_f [int],
	@tipo [int],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio_i int,@anio_f int,@tipo int,@codi_alma  char(2)    
--select @anio_i='2009',@anio_f='2010',@tipo=1      
    
    
    
select codi_alma,  Nemo,      
 linea,       
 sum(cantidad) cantidad,       
 sum(prec_costo) costo,      
 sum(venta) venta,anio      
from      
(  SELECT si_agrog.dbo.FACTURA.CODI_ALMA,       
(Select nemo_alma from si_agrog.dbo.almacen A (nolock) where a.codi_alma=si_agrog.dbo.FACTURA.codi_alma) Nemo,  
 (select (select (select (select des_lin_pro from si_agrog.dbo.LINEA_FAMILIA_PRO L (nolock)       
      where l.cod_lin_pro in (select F.cod_lin_pro from si_agrog.dbo.familia_producto F (nolock)      
     where F.codi_fami_prod in (select  S.codi_fami_prod from si_agrog.dbo.sub_familia_producto S (nolock)      
    where codi_sub_fami_prod in (select P.codi_sub_fami_prod from si_agrog.dbo.Productos P (nolock)       
     where P.codi_prod =D.codi_prod) )))))) Linea,      
 sum(D.CANT_ITEM)  cantidad,      
 SUM(D.CANT_ITEM *(D.PREC_ITEM * (CASE WHEN si_agrog.dbo.factura.codi_mone='01' THEN 1 ELSE si_agrog.dbo.factura.tcambio END))) venta,      
 SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + si_agrog.dbo.f_igv(fech_fact)/100 end))) prec_costo,      
 year(si_agrog.dbo.FACTURA.FECH_FACT) anio      
    FROM si_agrog.dbo.FACTURA (nolock),         
         si_agrog.dbo.FACTURA_DETALLE D(nolock),       
  si_agrog.dbo.productos (nolock)      
   WHERE  D.CODI_FACT = si_agrog.dbo.FACTURA.CODI_FACT  and        
   D.codi_prod=si_agrog.dbo.productos.codi_prod and       
 ( year(si_agrog.dbo.FACTURA.FECH_FACT)>=@anio_i ) and (year(si_agrog.dbo.FACTURA.FECH_FACT) <= @anio_f ) and       
 ( ISNULL(si_agrog.dbo.FACTURA.ESTADO,'')<>'A') and      
   codi_tipo_pago=@tipo     
  group by  si_agrog.dbo.factura.codi_alma, D.codi_prod,year(si_agrog.dbo.FACTURA.FECH_FACT)  
  
union all  
  
SELECT si_agrom.dbo.FACTURA.CODI_ALMA,       
(Select nemo_alma from si_agrom.dbo.almacen A (nolock) where a.codi_alma=si_agrom.dbo.FACTURA.codi_alma) Nemo,  
 (select (select (select (select des_lin_pro from si_agrom.dbo.LINEA_FAMILIA_PRO L (nolock)       
      where l.cod_lin_pro in (select F.cod_lin_pro from si_agrom.dbo.familia_producto F (nolock)      
     where F.codi_fami_prod in (select  S.codi_fami_prod from si_agrom.dbo.sub_familia_producto S (nolock)      
    where codi_sub_fami_prod in (select P.codi_sub_fami_prod from si_agrom.dbo.Productos P (nolock)       
     where P.codi_prod =D.codi_prod) )))))) Linea,      
 sum(D.CANT_ITEM)  cantidad,      
 SUM(D.CANT_ITEM *(D.PREC_ITEM * (CASE WHEN si_agrom.dbo.factura.codi_mone='01' THEN 1 ELSE si_agrom.dbo.factura.tcambio END))) venta,      
 SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + si_agrom.dbo.f_igv(fech_fact)/100 end))) prec_costo,      
 year(si_agrom.dbo.FACTURA.FECH_FACT) anio      
    FROM si_agrom.dbo.FACTURA (nolock),         
         si_agrom.dbo.FACTURA_DETALLE D(nolock),       
  si_agrom.dbo.productos (nolock)      
   WHERE  D.CODI_FACT = si_agrom.dbo.FACTURA.CODI_FACT  and        
   D.codi_prod=si_agrom.dbo.productos.codi_prod and       
 ( year(si_agrom.dbo.FACTURA.FECH_FACT)>=@anio_i ) and (year(si_agrom.dbo.FACTURA.FECH_FACT) <= @anio_f ) and       
 ( ISNULL(si_agrom.dbo.FACTURA.ESTADO,'')<>'A') and      
   codi_tipo_pago=@tipo     
  group by  si_agrom.dbo.factura.codi_alma, D.codi_prod,year(si_agrom.dbo.FACTURA.FECH_FACT)  
  
  
) SQL      
group by codi_alma, linea,anio,nemo      
order by linea,anio,codi_alma
GO
