CREATE VIEW [dbo].[v_tipo_plan_oe]
AS
SELECT     ptp.codi_tipo_plan, tp.DESC_TIPO_PLAN
FROM         (SELECT DISTINCT pl.codi_tipo_plan
                       FROM          (SELECT DISTINCT codi_tipo_plan
                                               FROM          planilla_de_empleados
                                               UNION
                                               SELECT DISTINCT codi_tipo_plan
                                               FROM         planilla_de_obreros) pl) ptp INNER JOIN
                      dbo.TIPOS_PLANILLAS tp ON ptp.codi_tipo_plan = tp.CODI_TIPO_PLAN
GO
