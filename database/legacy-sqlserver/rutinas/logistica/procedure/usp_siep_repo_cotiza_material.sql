CREATE PROCEDURE [dbo].[usp_siep_repo_cotiza_material]
	@codi [int]
WITH EXECUTE AS CALLER
AS
--declare @codi int 
--select @codi=2

set nocount on
select  c.codi_coti,   
        c.nro_cotiza,   
        c.fecha,   
        c.codi_alma,  
        --c.codi_clie_prov,
	(select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end
		from dbo.cliente_proveedor x(nolock) where x.codi_clie_prov=c.codi_clie_prov) cliente,
        c.lugar_ent, c.tiempo_ent, c.observaciones, c.fecha_venc, c.forma_pago,
	d.cantidad, 
	(select isnull(simb_unid_medi,'') from dbo.unidad_medida (nolock) where codi_unid_medi in
		 (select isnull(codi_unid_medi,'') from dbo.productos p(nolock) where p.codi_prod=d.codi_prod)) des_unid_medi,	
	(select isnull(desc_prod,'') from dbo.productos p(nolock) where p.codi_prod=d.codi_prod) desc_prod, d.p_unit,
	(select top 1 razon_social from dbo.empresa (nolock) ) Empresa,
	(select top 1 direccion from empresa) Direccion
from dbo.cotizacion c(nolock)
join dbo.cotizacion_deta d(nolock)
on c.codi_coti=d.codi_coti
where c.codi_coti= @codi
GO
