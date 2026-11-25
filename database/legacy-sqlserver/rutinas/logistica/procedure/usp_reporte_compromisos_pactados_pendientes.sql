CREATE PROCEDURE [dbo].[usp_reporte_compromisos_pactados_pendientes]
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @codi_alma char(2),@fec1 datetime,@fec2 datetime           
--select @codi_alma='01',@fec1='09/10/2012',@fec2='09/10/2012'          
          
select sql.codi_clie_prov,case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end  razo_soci,codi_comp,nro_comp,sql.codi_prod,desc_prod,cantidad cant_pacto,          
oc canti_oc,(cantidad - ni )cant_falt,fecha_venc,          
(select nemo_alma from almacen A (nolock) where A.codi_alma=@codi_alma) almacen,          
 (select razon_social from empresa (nolock)) Empresa ,UPPER(lugar)  ,      
ni,    
fecha fecha_inicio,precio_pactado,    
(select LTRIM(RTRIM(simbolo)) from monedas where codi_mone=moneda) moneda,case tipo when 'P' THEN 'Palabra'    
   when 'O' then 'Orden de Compra'   end tipo,  
DATEDIFF ( dd , fecha , fecha_venc ) dias_falt  
  
      
from (          
select codi_clie_prov,c.codi_comp,nro_comp,codi_prod,cantidad,fecha_venc,          
(select isnull(sum(cantidad),0) from detalle_orden_compra do join ORDEN_de_COMPRA co on co.codi_orde_comp=do.codi_orde_comp           
and nro_comp=c.nro_comp and codi_prod=d.codi_prod and estado <>'N') oc,lugar,      
(select isnull(sum(dni.cantidad),0)      
from DETALLE_NOTA_INGRESO dni join detalle_orden_compra do on do.codi_deta_orde_comp=dni.codi_deta_orde_comp      
         join ORDEN_de_COMPRA co on co.codi_orde_comp=do.codi_orde_comp      
    and nro_comp=c.nro_comp and do.codi_prod=d.codi_prod and estado <>'N') ni ,    
c.fecha,p_unit precio_pactado,codi_mone moneda,tipo      
          
from compromisos_pactados c join compromisos_pactados_deta d on d.codi_comp=c.codi_comp          
where (@codi_alma is null or codi_alma=@codi_alma)
and cast(convert(char(10),fecha,103) as datetime)  between  @fec1 and @fec2      
) SQL join cliente_proveedor p on p.codi_clie_prov=sql.codi_clie_prov          
      join productos pr on pr.codi_prod=sql.codi_prod          
where ni<cantidad
GO
