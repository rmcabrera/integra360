CREATE PROCEDURE [dbo].[PA_Registro_Ventas_libro_validad_documento_asociado]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2)        
--select  @anio ='2012', @mes ='01'      
        
set quoted_identifier off        
set nocount on         
declare @SQLString nvarchar(4000), @cond varchar(100)        
      
       
create table #tx ( compr varchar(10) null, fecha datetime null, fecha_venc datetime null,        
   docu char(4) null, serie varchar(5) null,        
   nro_docu varchar(20) null, codi_clie_prov char(5) null,         
   vfexp numeric(12,2) null, base_impo numeric(12,2) null, exo numeric(12,2) null,        
   inafecta numeric(12,2) null, isc numeric(12,2) null, igv numeric(12,2) null, otros numeric(12,2) null,        
   total numeric(12,2) null, tpc numeric(12,4) null, fecha_nd_nc datetime null,        
   tipo_docu_nd_nc char(4) null, serie_nd_nc varchar(6) null, nro_docu_nd_nc varchar(20) null,        
   dolar numeric(12,2) null)        
      
set @SQLSTring ="SELECT compr,        
   max(fecha) fecha,         
   max(fecha_venc) fecha_venc,        
   --right(max(codi_Tipo_docu),2) Docu,        
   max(codi_tipo_docu)Docu,        
   max(serie) serie,        
   max(nro_docu) nro_docu,        
   max(case when codi_clie_prov='02524' then '' else codi_clie_prov end ) codi_clie_prov,        
          
   sum(case when (registro is null or rtrim(registro)='') and left(nro_cuen,2)<>'40' and isnull(tipo_venta ,'')='E'        
                          then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  vfexp,        
   sum(case when (registro is null or rtrim(registro)='') and left(nro_cuen,2)<>'40' and isnull(tipo_venta,'') not in ('E','4','5','6')        
                          then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  BASE_IMPO,        
   sum(case when (registro is null or rtrim(registro)='') and left(nro_cuen,2)<>'40' and isnull(tipo_venta,'') ='5'        
                          then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  EXO,        
   sum(case when (registro is null or rtrim(registro)='') and left(nro_cuen,2)<>'40' and isnull(tipo_venta,'') ='6'        
                         then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  AS INAFECTA,         
   0.0 AS ISC,        
   sum(case when left(nro_cuen,2)='40' then  importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  igv,        
   0.0 as OTROS,        
   sum(case when not(registro is null or rtrim(registro)='') then  importe*case when cargo_abono='C' then 1 else -1 end  else 0 end)  total,        
   max(tipo_cambio) tpc,        
   max(FECHA_ND_NC) fecha_nd_nc, RIGHT(max(TIPO_DOCU_ND_NC),2) tipo_docu_nd_nc,         
   max(SERIE_ND_NC) serie_nd_nc, max(NRO_DOCU_ND_NC) nro_docu_nd_nc,        
   sum(case when not(registro is null or rtrim(registro)='') then  importe_d*case when cargo_abono='C' then 1 else -1 end  else 0 end) dolar        
  FROM Movi_Contables M(nolock)        
  where anio='"+@anio +"' and mes ='"+@mes+"' and subdia='V' "+''+"        
  group by codi_tipo_docu,serie, compr        
  order by cast(compr as int)"        
          
insert #TX (compr , fecha , fecha_venc ,docu , serie , nro_docu , codi_clie_prov ,         
  vfexp , base_impo , exo , inafecta , isc , igv , otros ,total , tpc , fecha_nd_nc ,        
  tipo_docu_nd_nc , serie_nd_nc , nro_docu_nd_nc ,dolar )        
execute sp_Executesql @SQLstring         
        
      

      
select       
cast(compr as varchar) compr ,       
convert(char(10),fecha,103 ) fecha_emision,      
isnull((select codi_sunat from tipo_documento t (nolock) where t.codi_tipo_docu = docu),'00') docu       
,case when isnull((select codi_sunat from tipo_documento t (nolock) where t.codi_tipo_docu = docu),'00') ='00' then '-' else  cast(serie as varchar) end  serie,      
cast(nro_docu as varchar) nro_docu,
 isnull((select ruc from cliente_proveedor C (nolock) where C.codi_clie_prov = T.codi_clie_prov),'-') Ruc  ,      
isnull( (select case when upper(tipo_pers) ='JURÍDICA' then razo_soci else denominacion end         
  from cliente_proveedor C (nolock) where C.codi_clie_prov = T.codi_clie_prov),'-') Razon 
from #Tx T        
where isnull((select codi_sunat from tipo_documento t (nolock) where t.codi_tipo_docu = docu),'00') in ('07','08','87','88','97','98')
and ((fecha_nd_nc) is null or tipo_docu_nd_nc is null or serie_nd_nc is null or nro_docu_nd_nc is null)

drop table #Tx        
set quoted_identifier on
GO
