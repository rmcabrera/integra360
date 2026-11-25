CREATE PROCEDURE [dbo].[usp_reporte_compromisos_pactados_detalle_d]
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @codi_alma char(2),@fec1 datetime,@fec2 datetime        
--select @codi_alma='01',@fec1='08/10/2012',@fec2='17/10/2012'             
                
/*Solo los pendientes**/          
declare @t table (codi_clie_prov char(5),codi_comp numeric(18,0),nro_comp numeric(18,0),codi_prod char(8),cantidad numeric(18,2),          
  fecha_venc datetime,fecha_emision datetime,LUGAR VARCHAR(50),prec_unit numeric(18,4) null,tipo char(1),dias_fal int,moneda char(2))              
          
          
insert @t              
select sql.codi_clie_prov,codi_comp,nro_comp,sql.codi_prod,cantidad,                
fecha_venc,fecha fecha_emision,              
lugar,p_unit ,tipo ,  DATEDIFF(dd,fecha, fecha_venc) ,moneda     
      
      
from (                
        
select codi_clie_prov,c.codi_comp,nro_comp,codi_prod,cantidad,fecha_venc,                
 (select isnull(sum(cantidad),0) from detalle_orden_compra do join ORDEN_de_COMPRA co on co.codi_orde_comp=do.codi_orde_comp                 
and nro_comp=c.nro_comp and codi_prod=d.codi_prod and estado <>'N') oc,        
lugar,            
(select isnull(sum(dni.cantidad),0)           
from DETALLE_NOTA_INGRESO dni join detalle_orden_compra do on do.codi_deta_orde_comp=dni.codi_deta_orde_comp            
         join ORDEN_de_COMPRA co on co.codi_orde_comp=do.codi_orde_comp            
    and nro_comp=c.nro_comp and do.codi_prod=d.codi_prod and estado <>'N') ni ,fecha ,          
d.p_unit p_unit,tipo,codi_mone moneda        
from compromisos_pactados c join compromisos_pactados_deta d on d.codi_comp=c.codi_comp                
where (@codi_alma is null or codi_alma=@codi_alma)                
        
) SQL join cliente_proveedor p on p.codi_clie_prov=sql.codi_clie_prov                
      join productos pr on pr.codi_prod=sql.codi_prod                
where ni<cantidad  AND (fecha BETWEEN @fec1 AND @fec2)      
        
  
        
          
select co.codi_clie_prov,case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end  razo_soci,              
co.nro_comp nro_compromiso,              
(select fecha_emision from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) fecha_ini_comp,              
(select fecha_venc from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) fecha_fin_comp,              
(select cantidad from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) cant_compromiso,         
        
do.codi_prod,UPPER(desc_prod),          
(select UPPER(des_lin_pro)          
from productos p join sub_familia_producto sf on sf.codi_sub_fami_prod=p.codi_sub_fami_prod          
  join familia_producto f on f.codi_fami_prod=sf.codi_fami_prod          
  join linea_familia_pro l on l.cod_lin_pro=f.cod_lin_pro          
where codi_prod=do.codi_prod) linea_producto,          
(select UPPER(desc_unid_medi) from unidad_medida where codi_unid_medi=(select codi_unid_medi from productos where codi_prod=do.codi_prod)) unid_medida,          
(select prec_unit from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp)  p_unit_oc,          
dni.codi_nota_ingr, nro_nota_ingr,fech_nota_ingr,        
do.codi_orde_comp,RTRIM(nro_orde_comp),cast(convert(char(10),co.fecha,103) as datetime) as fecha_oc,              
(select NEMO_ALMA from ALMACEN where CODI_ALMA=ni.codi_alma_dest) unidad_operativa,        
 dni.cantidad cant_note_ingr,        
dni.cantidad *(select prec_unit from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) valorizacion,        
        
(select nemo_alma from almacen A (nolock) where A.codi_alma=@codi_alma) almacen,                
 (select razon_social from empresa (nolock)) Empresa ,              
(select lugar from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) lugar,      
(select tipo from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) tipo,         
(select dias_fal from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) dias_falt,    
(select LTRIM(RTRIM(simbolo)) from monedas where codi_mone=moneda) moneda,    
case when (select tipo from @t t where t.codi_prod=do.codi_prod and nro_comp=co.nro_comp) ='P' THEN 'PALABRA' ELSE 'ORDEN DE COMPRA' END tipo_FULL         
from detalle_orden_compra do join ORDEN_de_COMPRA co on co.codi_orde_comp=do.codi_orde_comp                 
       join cliente_proveedor p on p.codi_clie_prov = co.codi_clie_prov              
       join productos pr on pr.codi_prod=do.codi_prod            
    left join DETALLE_NOTA_INGRESO dni on do.codi_deta_orde_comp=dni.codi_deta_orde_comp            
       left join nota_ingreso ni on ni.codi_nota_ingr=dni.codi_nota_ingr         
 join @t t on t.nro_comp=co.nro_comp and t.codi_prod=do.codi_prod        
where  co.estado <>'N' and co.nro_comp in (select nro_comp from @t)
GO
