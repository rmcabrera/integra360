CREATE PROCEDURE [dbo].[usp_siep_repo_hoja_vida]
	@codi [int]
WITH EXECUTE AS CALLER
AS
--declare @codi int 
--select @codi=1

set nocount on
select   p.codi_hoja, p.grupo, p.razon, p.ruc, p.email_emp, p.email_logi, p.email_ventas, p.email_tecni,   
         p.direccion, p.localidad, p.provincia, p.departamento, p.telef, p.celular, p.cobertura, p.ape_1,   
         p.ape_2, p.nombres, p.codigo, p.cargo, p.propietario, p.arrendatario, p.jefe_campo, p.logistica,   
         p.zona_pers, p.prov_pers, p.dist_pers, p.depa_pers, p.email, p.fech_nac, p.dni, p.telef_pers,   
         p.estado_civ, p.celular_pers, p.grado, p.familia, p.especie, p.variedad, p.siembra, p.surco,
	 p.golpE, p.surco_2, p.area, p.semilla, p.nro_semilla, p.densidad,
	 d.codi_hoja, d.codi_deta, d.etapa, d.fecha_prog, fecha_vis, d.diagnostico, d.recomendacion,
	 d.dosis, d.gasto, d.gasto_agro, d.gasto_total  
from dbo.hoja_vida p(nolock)
join dbo.hoja_vida_deta d(nolock)
on p.codi_hoja=d.codi_hoja
where p.codi_hoja= @codi
GO
