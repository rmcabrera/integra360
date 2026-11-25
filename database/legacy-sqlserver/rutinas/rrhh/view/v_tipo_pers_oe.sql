CREATE VIEW [dbo].[v_tipo_pers_oe]
AS
SELECT     plt.codi_tipo_pers, tt.DESC_TIPO_PERS
FROM         (SELECT DISTINCT codi_tipo_pers
                       FROM          planilla_de_empleados
                       UNION
                       SELECT DISTINCT codi_tipo_pers
                       FROM         planilla_de_obreros) plt INNER JOIN
                      dbo.TIPO_TRABAJADOR tt ON plt.codi_tipo_pers = tt.CODI_TIPO_PERS
GO
