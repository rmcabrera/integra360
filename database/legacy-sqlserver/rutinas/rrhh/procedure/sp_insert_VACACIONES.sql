CREATE PROCEDURE [dbo].[sp_insert_VACACIONES]
	@CODI_PERS_1 [char](5),
	@FECH_INIC_2 [datetime],
	@FECH_TERM_3 [datetime],
	@NRO_DIAS_4 [smallint],
	@ANIO_5 [char](4),
	@MES_6 [char](2),
	@ESTA_ACTI_7 [bit]
WITH EXECUTE AS CALLER
AS
INSERT INTO [VACACIONES] 
	 ( [CODI_PERS],
	 [FECH_INIC],
	 [FECH_TERM],
	 [NRO_DIAS],
	 [ANIO],
	 [MES],
	 [ESTA_ACTI]) 
 
VALUES 
	( @CODI_PERS_1,
	 @FECH_INIC_2,
	 @FECH_TERM_3,
	 @NRO_DIAS_4,
	 @ANIO_5,
	 @MES_6,
	 @ESTA_ACTI_7)
GO
