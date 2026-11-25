CREATE PROCEDURE [dbo].[usp_registro_cuentas]
WITH EXECUTE AS CALLER
AS
set nocount on
select isnull(r.codi_repo,0) codi_repo, isnull(r.desc_repo,'') descripcion_repo,
       isnull(rg.codi_grupo,0) codi_grupo, isnull(rg.desc_grupo,'') descripcion_grupo, isnull(rg.codi_repo,r.codi_repo) codi_repo_rg,
       isnull(cr.tipo_cuen,0) tipo_cuen , isnull(cr.descripcion,'') descripcion, isnull(cr.codi_grupo,rg.codi_grupo) codi_grupo_cr,
       isnull(cp.codi_partida,'') codi_partida_cp, isnull(cp.descripcion,'') descripcion_cp
from dbo.reporte_eeff r(nolock) 
left join dbo.reporte_eeff_grupo rg(nolock)
on r.codi_repo = rg.codi_repo
left join dbo.cuentas_reporte cr(nolock)
on rg.codi_grupo = cr.codi_grupo
left join dbo.cuentas_partida cp
on cr.tipo_cuen = cp.tipo_cuen
GO
