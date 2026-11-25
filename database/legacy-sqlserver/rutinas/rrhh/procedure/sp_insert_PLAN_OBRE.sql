CREATE PROCEDURE [dbo].[sp_insert_PLAN_OBRE]
	@CODI_PLAN_OBRE [char](10),
	@FECH_INIC [datetime],
	@FECH_TERM [datetime],
	@CODI_PERS [char](5),
	@CODI_TIPO_PLAN [char](2),
	@IMPORTE [decimal](9, 2),
	@ANIO [char](4),
	@MES [char](2),
	@ESTADO [char](1),
	@INDI_TIEM [char](5),
	@FORM_PAGO [varchar](20),
	@NRO_CHEQ [varchar](30),
	@FECH_PAGO [datetime]
WITH EXECUTE AS CALLER
AS
INSERT INTO [PLANILLA_DE_OBREROS] 
	 ( [CODI_PLAN_OBRE],
	 [FECH_INIC],
	 [FECH_TERM],
	 [CODI_PERS],
	 [CODI_TIPO_PLAN],
	 [IMPORTE],
	 [ANIO],
	 [MES],
	 [ESTADO],
	 [INDI_TIEM],
	 [FORM_PAGO],
	 [NRO_CHEQ],
	 [FECH_PAGO]) 
VALUES 
	(@CODI_PLAN_OBRE,
	 @FECH_INIC,
	 @FECH_TERM,
	 @CODI_PERS,
	 @CODI_TIPO_PLAN,
	 @IMPORTE,
	 @ANIO,
	 @MES,
	 @ESTADO,
	 @INDI_TIEM,
	 @FORM_PAGO,
	 @NRO_CHEQ,
	 @FECH_PAGO)
GO
