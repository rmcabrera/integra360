CREATE PROCEDURE [dbo].[usp_reporte_oss_liquida_x_tracto_beta]
	@id [int]
WITH EXECUTE AS CALLER
AS
declare @igv numeric(18,2)
--declare @id int
--select @id=1

set nocount on
select @igv= dbo.f_igv(fecha)/100 from dbo.orden_solicitud_servicio w(nolock) where w.codi_orden_soli=@id

select 1 N, a.codi_orden_soli, cast(a.nro_orden_soli as varchar) nro, A.fecha, dbo.f_cliente_proveedor(codi_clie_prov) cliente,
       (select origen + ' - ' + destino from dbo.ruta_orden s(nolock) where s.codi_ruta=A.codi_ruta) ruta,
       'SOLICITUD DE SERVICIO' concepto, 
       (case when A.facturado='1' then (B.importe * @igv) + b.importe else B.importe end) importe, 
       codi_Tracto
from dbo.orden_solicitud_servicio A(nolock)
join dbo.orden_solicitud_servicio_deta B(nolock)
on A.codi_orden_soli=B.codi_orden_soli
where A.codi_orden_soli=@id
--group by codi_tracto, a.codi_orden_soli

union all

select 2 N, x.codi_liqu, w.serie + ' - '+ w.nro_docu, w.fecha fecha, dbo.f_cliente_proveedor(w.codi_clie_prov) cliente, 
       (zona_part + ' - ' + zona_dest) ruta, (select desc_reemb from dbo.tipo_reembolso z(nolock) where z.tipo_reemb=w.tipo_contab) concepto,
       w.importe,placa_tracto
from dbo.liquidacion x(nolock)
join dbo.liquidacion_deta w(nolock)
on x.codi_liqu=w.codi_liqu
where x.codi_orden_soli=@id
--group by placa_tracto, x.codi_liqu
GO
