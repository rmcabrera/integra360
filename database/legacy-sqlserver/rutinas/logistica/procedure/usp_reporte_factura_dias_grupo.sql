CREATE PROCEDURE [dbo].[usp_reporte_factura_dias_grupo]
	@fec1 [datetime],
	@fec2 [datetime],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime, @fec2 datetime, @codi_alma char(2)  
--select @fec1='01/05/2012', @fec2='10/05/2012', @codi_alma='00'  
  
set nocount on  
declare @alma table (codi_alma char(2) null)  
if @codi_alma = '00'  
begin  
 insert @alma  
 Select codi_alma from dbo.almacen (nolock)  
end   
else  
begin insert @alma  
 Select codi_alma from dbo.almacen (nolock) where codi_alma = @codi_alma  
  
end  
  
select max(fech_fact) fech_fact,    
 (select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end  
 from dbo. cliente_proveedor c(nolock) where c.codi_clie_prov=f.codi_clie_prov) cliente,  
 (select desc_cultivo from dbo.cultivos B(nolock) where B.cod_cultivo=f.cod_cultivo) cultivo,  
 isnull(sum(hectarea),0) hectarea, isnull(sum(tota_fact),0) tota_fact,   
 (select top 1 razon_social from empresa (nolock) ) empresa,   
 (select ruc from empresa (nolock) ) ruc, isnull(sum(nro_dias),0) nro_dias,  
 datediff(dd,min(fech_fact),@fec2) + isnull(sum(nro_dias),0) dias,   
 min(fech_fact) fech_fact_min, codi_clie_prov,   
 (select desc_tipo_medio_pago from tipo_pago (nolock) where codi_tipo_medio_pago=max(F.codi_tipo_pago) ) tipo_pago,
(select desc_zona from zonas where cod_zona=f.cod_zona)    
from dbo.factura F(nolock)  
where cast(convert(varchar(10),fech_fact,103) as smalldatetime) between @fec1 and @fec2   
and isnull(f.codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)   
group by codi_clie_prov, cod_cultivo,cod_zona
GO
