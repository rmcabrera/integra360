CREATE PROCEDURE [dbo].[usp_reporte_oss_liquida]
	@id [int]
WITH EXECUTE AS CALLER
AS
--declare @id int
--select @id=1

set nocount on
select distinct 1 N, A.codi_orden_soli id, cast(a.nro_orden_soli as varchar) nro, A.fecha, dbo.f_cliente_proveedor(codi_clie_prov) cliente,
       (select origen + ' - ' + destino from dbo.ruta_orden s(nolock) where s.codi_ruta=A.codi_ruta) ruta,
       'SOLICITUD DE SERVICIO' concepto, flete
from dbo.orden_solicitud_servicio A(nolock)
join dbo.orden_solicitud_servicio_deta B(nolock)
on A.codi_orden_soli=B.codi_orden_soli
where A.codi_orden_soli=@id

union all

select 2 N, x.codi_liqu, w.serie + ' - '+ w.nro_docu, w.fecha, dbo.f_cliente_proveedor(w.codi_clie_prov) cliente, 
       (zona_part + ' - ' + zona_dest) ruta, (select desc_reemb from dbo.tipo_reembolso z(nolock) where z.tipo_reemb=w.tipo_contab) concepto,
       w.importe
from dbo.liquidacion x(nolock)
join dbo.liquidacion_deta w(nolock)
on x.codi_liqu=w.codi_liqu
where x.codi_orden_soli=@id
GO
