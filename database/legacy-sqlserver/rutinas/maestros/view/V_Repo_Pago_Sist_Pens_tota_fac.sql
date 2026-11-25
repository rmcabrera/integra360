CREATE VIEW [dbo].[V_Repo_Pago_Sist_Pens_tota_fac]
AS
SELECT     CODI_PERS, APEL_1, APEL_2, NOMB_1, NOMB_2, CODI_TIPO_PERS, CODI_SIST_PENS, NRO_CUPSS, CODI_PLAN, CODI_TIPO_PLAN, ANIO, MES, 
                      CODI_CONC, VALOR, MONTO, nro_docu_iden, fech_inic, fech_term
FROM         (SELECT     CODI_PERS, APEL_1, APEL_2, NOMB_1, NOMB_2, CODI_TIPO_PERS, CODI_SIST_PENS, NRO_CUPSS, CODI_PLAN, CODI_TIPO_PLAN, 
                                              ANIO, MES, CODI_CONC, VALOR, MONTO, nro_docu_iden, fech_inic, fech_term
                       FROM          dbo.V_Repo_Pago_Sist_Pens_fac
                       UNION all
                       SELECT     codi_pers, apel_1, apel_2, nomb_1, nomb_2, CODI_TIPO_PERS, codi_sist_pens, nro_cupss, codi_plan, codi_tipo_plan, anio, mes, 
                                             codi_conc, valor, monto, nro_docu_iden, fech_inic, fech_term
                       FROM         dbo.V_Repo_Pago_Sist_Pens_obre_fac ) deri_tota
GO
