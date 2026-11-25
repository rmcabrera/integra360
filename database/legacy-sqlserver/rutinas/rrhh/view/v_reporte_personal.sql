CREATE VIEW [dbo].[v_reporte_personal]
AS
SELECT     personal.codi_pers, personal.CODI_AREA,
                          (SELECT     areas.nomb_area
                            FROM          areas
                            WHERE      areas.codi_area = personal.codi_area) AS Area, personal.codi_area_grup,
                          (SELECT     area_grup.desc_area_grup
                            FROM          area_grup
                            WHERE      area_grup.codi_area_grup = personal.codi_area_grup) AS Area_grup,
                          (SELECT     SUB_area_grup.desc_sub_area_grup
                            FROM          SUB_area_grup
                            WHERE      sub_area_grup.codi_sub_area_grup = personal.codi_sub_area_grup) AS sub_Area_grup,
                          (SELECT     area_grup.jera_area
                            FROM          area_grup
                            WHERE      area_grup.codi_area_grup = personal.codi_area_grup) AS jera_Area_grup, 
                          (SELECT     SUB_area_grup.nro_jera
                            FROM          SUB_area_grup
                            WHERE      sub_area_grup.codi_sub_area_grup = personal.codi_sub_area_grup) AS jera_sub_Area_grup,
                      personal.apel_1 + ' ' + personal.apel_2 + isnull(' ' + personal.nomb_1 + ' ', '') + isnull(' ' + personal.nomb_2 + ' ', '') AS Nombre, 
                      personal.nro_docu_iden, PERSONAL.FECH_CESE,
	         personal.codi_carg,
                          (SELECT     cargos.carg_mostrar
                            FROM          cargos
                            WHERE      cargos.codi_carg = personal.codi_carg) AS Carg, 
                          (SELECT     cargos.jera
                            FROM          cargos
                            WHERE      cargos.codi_carg = personal.codi_carg) AS jera_carg, 
		personal.nro_cupss, personal.direccion,
                          (SELECT     empresa.inicial
                            FROM          empresa) AS Empre,
                          (SELECT     sistema_pensiones.desc_sist_pens
                            FROM          sistema_pensiones
                            WHERE      sistema_pensiones.codi_sist_pens = personal.codi_sist_pens) AS sist_pens, CASE WHEN
                          (SELECT     tipo_trabajador.desc_tipo_pers
                            FROM          tipo_trabajador
                            WHERE      tipo_trabajador.codi_tipo_pers IN
                                                       (SELECT     personal_por_tipo_trabajador.codi_tipo_pers
                                                         FROM          personal_por_tipo_trabajador
                                                         WHERE      personal_por_tipo_trabajador.codi_pers = personal.codi_pers ) ) = 'Empleados' THEN 'SLDO' ELSE 'SLRIO' END Planilla, 
                      CASE personal.Tipo_situ_labo WHEN 'E' THEN 'EST.' WHEN 'C' THEN 'CONT' ELSE '' END AS COND, personal.fech_ingre, 
		dbo.f_asig_fami_pers(personal.codi_pers, getdate() ) + personal.suel_basi as suel_basi, 
                      CASE WHEN
                          (SELECT     COUNT(prestamos.codi_pers)
                            FROM          prestamos
                            WHERE      prestamos.codi_pers = personal.codi_pers AND prestamos.esta_acti = 1) <= 0 THEN 'No' ELSE 'Si' END AS SaldoCtaCte,
                          (SELECT     MAX(contratos_personal.fech_inic_cont)
                            FROM          CONTRATOS_PERSONAL
                            WHERE      CONTRATOS_PERSONAL.esta_cont='1' and CONTRATOS_PERSONAL.codi_pers = personal.codi_pers) AS inic_cont,
                          (SELECT     MAX(contratos_personal.fech_fin_cont)
                            FROM          CONTRATOS_PERSONAL
                            WHERE      CONTRATOS_PERSONAL.esta_cont='1' and CONTRATOS_PERSONAL.codi_pers = personal.codi_pers) AS fin_cont,
                          (SELECT     SUM(valores_sistema_pensiones.valor)
                            FROM          VALORES_SISTEMA_PENSIONES
                            WHERE      VALORES_SISTEMA_PENSIONES.codi_sist_pens = personal.codi_sist_pens AND valores_sistema_pensiones.codi_rubr <> '04' AND 
                                                   valores_sistema_pensiones.anio_mes IN
                                                       (SELECT     MAX(valores_sistema_pensiones.anio_mes)
                                                         FROM          VALORES_SISTEMA_PENSIONES
                                                         WHERE      VALORES_SISTEMA_PENSIONES.codi_sist_pens = personal.codi_sist_pens)) AS porc_pens,
		( Select ptt.codi_tipo_pers from  personal_por_tipo_trabajador ptt where personal.codi_pers = ptt.codi_pers ) as tipo_trab,
		(SELECT     empresa.razon_social + '       ' + grupo FROM empresa) AS Empresa,
		ISNULL( DBO.F_TELE_PERS ( PERSONAL.CODI_PERS) , '')  AS TELE
FROM         personal
WHERE     personal.codi_pers <> '00000' AND LEFT(personal.codi_carg, 2) <> '10' --AND personal.esta_acti = 1
GO
