CREATE VIEW [dbo].[v_trab_plan_oe]
AS
SELECT     TOP 100 PERCENT pe.CODI_PERS, pe.APEL_1, pe.APEL_2, pe.NOMB_1, ISNULL(pe.NOMB_2, '') AS nomb_2
FROM         (SELECT DISTINCT codi_pers
                       FROM          (SELECT DISTINCT codi_pers
                                               FROM          planilla_de_empleados
                                               UNION
                                               SELECT DISTINCT codi_pers
                                               FROM         planilla_de_obreros) pl) plu INNER JOIN
                      dbo.PERSONAL pe ON plu.codi_pers = pe.CODI_PERS
ORDER BY pe.APEL_1, pe.APEL_2, pe.NOMB_1, pe.NOMB_2
GO
