CREATE PROCEDURE [dbo].[usp_repo_cros_resum_venta_sucur_anios_group_dico]
	@anio_i [int],
	@anio_f [int],
	@tipo [int]
WITH EXECUTE AS CALLER
AS
--declare @anio_i int,@anio_f int,@tipo int  
--select @anio_i='2019',@anio_f='2021',@tipo=1   
  
select codi_alma, Nemo as 'Nemo',  
 linea,   
 sum(cantidad) cantidad,   
 sum(prec_costo) costo,  
 sum(venta) venta,anio  
from  
(  SELECT SI_AGROG.DBO.FACTURA.CODI_ALMA,   
 (Select nemo_alma from SI_AGROG.DBO.almacen A (nolock) where a.codi_alma=SI_AGROG.DBO.factura.codi_alma) Nemo,
 (select (select (select (select des_lin_pro from SI_AGROG.DBO.LINEA_FAMILIA_PRO L (nolock)   
      where l.cod_lin_pro in (select F.cod_lin_pro from SI_AGROG.DBO.familia_producto F (nolock)  
     where F.codi_fami_prod in (select  S.codi_fami_prod from SI_AGROG.DBO.sub_familia_producto S (nolock)  
    where codi_sub_fami_prod in (select P.codi_sub_fami_prod from SI_AGROG.DBO.Productos P (nolock)   
     where P.codi_prod =D.codi_prod) )))))) Linea,  
 sum(D.CANT_ITEM)  cantidad,  
 SUM(D.CANT_ITEM *(D.PREC_ITEM * (CASE WHEN SI_AGROG.DBO.factura.codi_mone='01' THEN 1 ELSE SI_AGROG.DBO.factura.tcambio END))) venta,  
 SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + SI_AGROG.dbo.f_igv(fech_fact)/100 end))) prec_costo,  
 year(SI_AGROG.DBO.FACTURA.FECH_FACT) anio  
    FROM SI_AGROG.DBO.FACTURA (nolock),     
         SI_AGROG.DBO.FACTURA_DETALLE D(nolock),   
  SI_AGROG.DBO.productos (nolock)  
   WHERE  D.CODI_FACT = SI_AGROG.DBO.FACTURA.CODI_FACT  and    
   D.codi_prod=SI_AGROG.DBO.productos.codi_prod and   
 ( year(SI_AGROG.DBO.FACTURA.FECH_FACT)>=@anio_i ) and (year(SI_AGROG.DBO.FACTURA.FECH_FACT) <= @anio_f ) and   
 ( ISNULL(SI_AGROG.DBO.FACTURA.ESTADO,'')<>'A') and  
   codi_tipo_pago=@tipo  
 group by  SI_AGROG.DBO.factura.codi_alma, D.codi_prod,year(SI_AGROG.DBO.FACTURA.FECH_FACT)
 
 union all
 
 SELECT SI_DCVP.DBO.FACTURA.CODI_ALMA,   
 (Select nemo_alma from SI_DCVP.DBO.almacen A (nolock) where a.codi_alma=SI_DCVP.DBO.factura.codi_alma) Nemo,
 (select (select (select (select des_lin_pro from SI_DCVP.DBO.LINEA_FAMILIA_PRO L (nolock)   
      where l.cod_lin_pro in (select F.cod_lin_pro from SI_DCVP.DBO.familia_producto F (nolock)  
     where F.codi_fami_prod in (select  S.codi_fami_prod from SI_DCVP.DBO.sub_familia_producto S (nolock)  
    where codi_sub_fami_prod in (select P.codi_sub_fami_prod from SI_DCVP.DBO.Productos P (nolock)   
     where P.codi_prod =D.codi_prod) )))))) Linea,  
 sum(D.CANT_ITEM)  cantidad,  
 SUM(D.CANT_ITEM *(D.PREC_ITEM * (CASE WHEN SI_DCVP.DBO.factura.codi_mone='01' THEN 1 ELSE SI_DCVP.DBO.factura.tcambio END))) venta,  
 SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + SI_DCVP.dbo.f_igv(fech_fact)/100 end))) prec_costo,  
 year(SI_DCVP.DBO.FACTURA.FECH_FACT) anio  
    FROM SI_DCVP.DBO.FACTURA (nolock),     
         SI_DCVP.DBO.FACTURA_DETALLE D(nolock),   
  SI_DCVP.DBO.productos (nolock)  
   WHERE  D.CODI_FACT = SI_DCVP.DBO.FACTURA.CODI_FACT  and    
   D.codi_prod=SI_DCVP.DBO.productos.codi_prod and   
 ( year(SI_DCVP.DBO.FACTURA.FECH_FACT)>=@anio_i ) and (year(SI_DCVP.DBO.FACTURA.FECH_FACT) <= @anio_f ) and   
 ( ISNULL(SI_DCVP.DBO.FACTURA.ESTADO,'')<>'A') and  
   codi_tipo_pago=@tipo  
 group by  SI_DCVP.DBO.factura.codi_alma, D.codi_prod,year(SI_DCVP.DBO.FACTURA.FECH_FACT) 
 
) SQL  

group by codi_alma, linea,anio, nemo  
order by linea,anio,codi_alma
GO
