CREATE PROCEDURE [dbo].[usp_reporte_oss_liquida_all]
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime, @fec2 datetime
--select @fec1='01/11/2010', @fec2='10/12/2010'

set nocount on 
select p.codi_orden_soli, max(p.nro_orden_soli) nro_orden_soli,
      dbo.f_cliente_proveedor(max(codi_clie_prov)) cliente,
      (select isnull(origen,'') + ' - ' + isnull(destino,'') from dbo.ruta_orden r(nolock) where r.codi_ruta=max(p.codi_ruta)) ruta,
      max(p.fecha) fecha, max(p.codi_aux) codi_aux, max(p.facturado) facturado,  
      dbo.f_cliente_proveedor(max(responsable)) desc_responsable,
      (select case when max(p.codi_mone)='01' then max(p.flete) else 0 end) flete_s,
      (select case when max(p.codi_mone)='02' then max(p.flete) else 0 end) flete_d,
       (select isnull(sum(importe),0) from dbo.liquidacion_deta w(nolock) where w.codi_liqu in
       		(select codi_liqu from dbo.liquidacion z(nolock) where z.codi_orden_soli is not null and z.codi_orden_soli=p.codi_orden_soli)) importe,      
	0.00 as importe_d
from dbo.orden_solicitud_servicio p(nolock)
where cast(convert(char(10),fecha,103) as smalldatetime) between @fec1 and @fec2 
group by p.codi_orden_soli
GO
