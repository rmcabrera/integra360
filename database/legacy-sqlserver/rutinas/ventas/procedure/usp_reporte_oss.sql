CREATE PROCEDURE [dbo].[usp_reporte_oss]
	@id [int]
WITH EXECUTE AS CALLER
AS
--declare @id int
--select @id=1
set nocount on 
select p.codi_orden_soli, p.nro_orden_soli,
	dbo.f_cliente_proveedor(codi_clie_prov) cliente,
	(select isnull(origen,'') + ' - ' + isnull(destino,'') from dbo.ruta_orden r(nolock) where r.codi_ruta=p.codi_ruta) ruta,
        p.contacto, p.telefono, p.fecha, p.condicion,   
        p.codi_aux, p.facturado,  
        dbo.f_cliente_proveedor(responsable) desc_responsable,
        p.flete, p.igv,
	(select isnull(desc_unid_oper,'') from dbo.unid_oper u(nolock) where u.codi_unid_oper=d.codi_tracto) desc_tracto,
	(select isnull(desc_unid_oper,'') from dbo.unid_oper c(nolock) where c.codi_unid_oper=d.codi_carreta) desc_carreta,	
	(select isnull(desc_trans,'') from dbo.transportistas x(nolock) where x.codi_trans= d.codi_trans) desc_chofer,
	(select isnull(descripcion,'') from dbo.tipo_carga w(nolock) where w.codi_carga=d.codi_carga) desc_carga,
	cantidad, 
	(select isnull(simb_unid_medi,'') from dbo.unidad_medida m(nolock) where m.codi_unid_medi=d.codi_unid_medi) simb_unid_medi,
	precio, estado, observacion, codi_mone,
	(select isnull(desc_mone,'') from dbo.monedas m(nolock) where m.codi_mone=p.codi_mone) moneda
from dbo.ORDEN_SOLICITUD_SERVICIO p(nolock)
join dbo.ORDEN_SOLICITUD_SERVICIO_DETA d(nolock)
on p.codi_orden_soli=d.codi_orden_soli 
where p.codi_orden_soli=@id
GO
