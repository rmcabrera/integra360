CREATE PROCEDURE [dbo].[sp_insert_PLAN_EMPL]
	@CODI_PLAN_EMPL [char](10),
	@ANIO [char](4),
	@MES [char](2),
	@CODI_PERS [char](5),
	@CODI_TIPO_PLAN [char](2),
	@FECH_INIC [datetime],
	@FECH_TERM [datetime],
	@IMPORTE [decimal](9, 2),
	@ESTADO [char](1),
	@INDI_TIEM [char](5),
	@FORM_PAGO [varchar](20),
	@NRO_CHEQ [varchar](30),
	@FECH_PAGO [datetime]
WITH EXECUTE AS CALLER
AS
INSERT INTO [PLANILLA_DE_EMPLEADOS] 
	 ( [CODI_PLAN_EMPL],
	 [ANIO],
	 [MES],
	 [CODI_PERS],
	 [CODI_TIPO_PLAN],
	 [FECH_INIC],
	 [FECH_TERM],
	 [IMPORTE],
	 [ESTADO],
	 [INDI_TIEM],
	 [FORM_PAGO],
	 [NRO_CHEQ],
	 [FECH_PAGO])
 
VALUES 
	(@CODI_PLAN_EMPL,
	 @ANIO,
	 @MES,
	 @CODI_PERS,
	 @CODI_TIPO_PLAN,
	 @fech_inic,
	 @FECH_TERM,
	 @IMPORTE,
	 @ESTADO,
	 @INDI_TIEM,
	 @FORM_PAGO,
	 @NRO_CHEQ,
	 @FECH_PAGO)
GO
