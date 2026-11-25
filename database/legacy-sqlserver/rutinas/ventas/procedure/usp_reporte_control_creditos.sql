CREATE PROCEDURE [dbo].[usp_reporte_control_creditos]
	@tipo [char](1),
	@F1 [datetime],
	@F2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @tipo char(1), @F1 datetime, @F2 datetime
--select @tipo='V', @F1='01/01/2014', @F2='31/10/2015'

set nocount on

if @tipo='I'
begin
	select 	ltrim((select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
		from cliente_proveedor cp(nolock) where cp.codi_clie_prov = a.codi_clie_prov)) entidad,
		ltrim((select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
		from cliente_proveedor cp(nolock) where cp.codi_clie_prov = a.codi_clie_fav)) cliente,
	       (select descripcion from creditos_tipos ct(nolock) where ct.codi_tipo_cred = tipo_pago) tipo_cred, 
	       fec_inic_cred, fec_fin_cred, monto_cred, gastos, b.fecha as fecha_venc, valor as cuota,
	       (select descripcion from creditos_lineas cl(nolock) where cl.codi_lin_cred = a.codi_lin_cred) linea,
	       (select desc_proy from proyecto p(nolock) where p.codi_proy = a.codi_proy) proyecto,
	       (case when isnull(activo,'')='0' then null else isnull(datediff(dd, getdate(), b.fecha),0) end) dias,
		(select simbolo from monedas m(nolock) where m.codi_mone=a.codi_mone) moneda

	from creditos a(nolock)
	left join creditos_detalle b(nolock)
	on a.codi_credito = b.codi_credito
	where cast(convert(char(10), fec_inic_cred, 103) as datetime) between @F1 and @F2
end

if @tipo='F'
begin
	select ltrim((select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
		from cliente_proveedor cp(nolock) where cp.codi_clie_prov = a.codi_clie_prov)) entidad,
		ltrim((select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
		from cliente_proveedor cp(nolock) where cp.codi_clie_prov = a.codi_clie_fav)) cliente,
	       (select descripcion from creditos_tipos ct(nolock) where ct.codi_tipo_cred = tipo_pago) tipo_cred, 
	       fec_inic_cred, fec_fin_cred, monto_cred, gastos, b.fecha as fecha_venc, valor as cuota,
	       (select descripcion from creditos_lineas cl(nolock) where cl.codi_lin_cred = a.codi_lin_cred) linea,
	       (select desc_proy from proyecto p(nolock) where p.codi_proy = a.codi_proy) proyecto,
		(case when isnull(activo,'')='0' then null else isnull(datediff(dd, getdate(), b.fecha),0) end) dias,
		(select simbolo from monedas m(nolock) where m.codi_mone=a.codi_mone) moneda

	from creditos a(nolock)
	left join creditos_detalle b(nolock)
	on a.codi_credito = b.codi_credito
	where cast(convert(char(10), fec_fin_cred, 103) as datetime) between @F1 and @F2
end

if @tipo='V'
begin
	select ltrim((select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
		from cliente_proveedor cp(nolock) where cp.codi_clie_prov = a.codi_clie_prov)) entidad,
		ltrim((select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
		from cliente_proveedor cp(nolock) where cp.codi_clie_prov = a.codi_clie_fav)) cliente,
	       (select descripcion from creditos_tipos ct(nolock) where ct.codi_tipo_cred = tipo_pago) tipo_cred, 
	       fec_inic_cred, fec_fin_cred, monto_cred, gastos, b.fecha as fecha_venc, valor as cuota,
	       (select descripcion from creditos_lineas cl(nolock) where cl.codi_lin_cred = a.codi_lin_cred) linea,
	       (select desc_proy from proyecto p(nolock) where p.codi_proy = a.codi_proy) proyecto,
		(case when isnull(activo,'')='0' then null else isnull(datediff(dd, getdate(), b.fecha),0) end) dias,
		(select simbolo from monedas m(nolock) where m.codi_mone=a.codi_mone) moneda
	from creditos a(nolock)
	left join creditos_detalle b(nolock)
	on a.codi_credito = b.codi_credito
	where cast(convert(char(10), b.fecha, 103) as datetime) between @F1 and @F2
end
GO
