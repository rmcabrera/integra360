CREATE PROCEDURE [dbo].[usp_reporte_compromisos_pactados_detalle]
	@codi_alma [char](2),
	@fecha_ini [datetime],
	@fecha_fin [datetime]
WITH EXECUTE AS CALLER
AS
--declare @codi_alma char(2),@fecha_ini datetime,@fecha_fin datetime       
--select @codi_alma='01',@fecha_ini ='01/01/2012',@fecha_fin='13/09/2012'    
      
declare @t table (codi_clie_prov char(5),codi_comp numeric(18,0),nro_comp numeric(18,0),codi_prod char(8),cantidad numeric(18,2),fecha_venc datetime,fecha_emision datetime,LUGAR VARCHAR(50))    
insert @t    
select codi_clie_prov,c.codi_comp,nro_comp,codi_prod,cantidad,fecha_venc,fecha,lugar    
from compromisos_pactados c join compromisos_pactados_deta d on d.codi_comp=c.codi_comp      
where (@codi_alma is null or codi_alma=@codi_alma)  and    
cast(convert(char(10),fecha,103) as datetime) between  cast(convert(char(10),@fecha_ini,103) as datetime) and cast(convert(char(10),@fecha_fin,103) as datetime)     
    
select co.codi_clie_prov,case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end  razo_soci,    
nro_comp nro_compromiso,    
(select fecha_venc from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) fecha_venc,    
(select cantidad from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) cant_compromiso,    
do.codi_orde_comp,nro_orde_comp,cast(convert(char(10),fecha,103) as datetime) as fecha_oc,    
do.codi_prod,desc_prod,do.cantidad cant_oc,    
(select nemo_alma from almacen A (nolock) where A.codi_alma=@codi_alma) almacen,      
 (select razon_social from empresa (nolock)) Empresa ,    
(select fecha_emision from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) fecha_emision,  
(select lugar from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) lugar  
from detalle_orden_compra do join ORDEN_de_COMPRA co on co.codi_orde_comp=do.codi_orde_comp       
       join cliente_proveedor p on p.codi_clie_prov = co.codi_clie_prov    
       join productos pr on pr.codi_prod=do.codi_prod    
where  estado <>'N' and co.nro_comp in (select nro_comp from @t)
GO
