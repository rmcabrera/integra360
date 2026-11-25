CREATE PROCEDURE [dbo].[PA_MANT_CREDITOS_REG]
	@tipo [char](1),
	@F1 [datetime],
	@F2 [datetime],
	@est [char](1)
WITH EXECUTE AS CALLER
AS
--declare @tipo char(1), @F1 datetime, @F2 datetime, @est char(1)
--select @tipo='E', @F1 ='01/01/2000', @F2 ='03/10/2015', @est=1

set nocount on 

if @tipo='F'
begin
	select codi_credito, 
	       ltrim((select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
	       from cliente_proveedor cp(nolock) where cp.codi_clie_prov=c.codi_clie_prov)) as denominacion,
	       fec_inic_cred, fec_fin_cred, estado, 
	       (select simbolo from monedas m(nolock) where m.codi_mone=c.codi_mone) as codi_mone,
	       monto_cred as importe, tipo_pago, interes, igv, gastos, total,
	
	       (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') 
	        from usuarios U(nolock) where U.codi_usua=codi_usua_autoriza) autoriza,
	
	       (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') 
		from usuarios U(nolock) where U.codi_usua=codi_usua_responsa) responsable, 
		(select d.doc_garantia from documento_garantia d(nolock) where d.codi_docg= casT(c.doc_garantia as numeric)) doc,
		(select descripcion from creditos_lineas cl(nolock) where cl.codi_lin_cred=c.codi_lin_cred) linea,
		(select desc_proy from proyecto p(nolock) where p.codi_proy = c.codi_proy) proyecto
	from creditos c(nolock)
	where cast(convert(char(10),fec_inic_cred,103) as datetime) between @F1 and @F2
end

if @tipo='E'
begin
	select codi_credito, 
	       ltrim((select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
	       from cliente_proveedor cp(nolock) where cp.codi_clie_prov=c.codi_clie_prov)) as denominacion,
	       fec_inic_cred, fec_fin_cred, estado, 
	       (select simbolo from monedas m(nolock) where m.codi_mone=c.codi_mone) as codi_mone,
	       monto_cred as importe, tipo_pago, interes, igv, gastos, total,
	
	       (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') 
	        from usuarios U(nolock) where U.codi_usua=codi_usua_autoriza) autoriza,
	
	       (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') 
		from usuarios U(nolock) where U.codi_usua=codi_usua_responsa) responsable, 
		(select d.doc_garantia from documento_garantia d(nolock) where d.codi_docg= casT(c.doc_garantia as numeric)) doc,
		(select descripcion from creditos_lineas cl(nolock) where cl.codi_lin_cred=c.codi_lin_cred) linea,
		(select desc_proy from proyecto p(nolock) where p.codi_proy = c.codi_proy) proyecto
	from creditos c(nolock)
	where @est is null or isnull(estado,'')=@est
end
GO
