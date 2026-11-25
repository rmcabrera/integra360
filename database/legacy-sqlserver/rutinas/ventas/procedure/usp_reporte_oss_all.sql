CREATE PROCEDURE [dbo].[usp_reporte_oss_all]
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime, @fec2 datetime
--select @fec1='30/11/2010', @fec2='30/11/2010'

set nocount on 
select p.codi_orden_soli, p.nro_orden_soli,
	dbo.f_cliente_proveedor(codi_clie_prov) cliente,
	(select isnull(origen,'') + ' - ' + isnull(destino,'') from dbo.ruta_orden r(nolock) where r.codi_ruta=p.codi_ruta) ruta,
        p.contacto, p.telefono, p.fecha, p.condicion,   
        p.codi_aux, p.facturado,  
        dbo.f_cliente_proveedor(responsable) desc_responsable, p.codi_mone,
	(select case when p.codi_mone='01' then p.flete else 0 end) flete_s,
	(select case when p.codi_mone='02' then p.flete else 0 end) flete_d
	/*(select isnull(desc_unid_oper,'') from dbo.unid_oper u(nolock) where u.codi_unid_oper=d.codi_tracto) desc_tracto,
	(select isnull(desc_unid_oper,'') from dbo.unid_oper c(nolock) where c.codi_unid_oper=d.codi_carreta) desc_carreta,	
	(select isnull(desc_trans,'') from dbo.transportistas x(nolock) where x.codi_trans= d.codi_trans) desc_chofer,
	(select isnull(descripcion,'') from dbo.tipo_carga w(nolock) where w.codi_carga=d.codi_carga) desc_carga,
	cantidad, 
	(select isnull(simb_unid_medi,'') from dbo.unidad_medida m(nolock) where m.codi_unid_medi=d.codi_unid_medi) simb_unid_medi,
	precio, estado, observacion*/
from dbo.ORDEN_SOLICITUD_SERVICIO p(nolock)
where cast(convert(char(10),fecha,103) as smalldatetime) between @fec1 and @fec2
GO
