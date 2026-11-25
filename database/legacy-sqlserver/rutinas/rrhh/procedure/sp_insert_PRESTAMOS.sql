CREATE PROCEDURE [dbo].[sp_insert_PRESTAMOS]
	@CODI_PRES_1 [char](6),
	@CODI_PERS_2 [char](5),
	@NRO_PRES_3 [int],
	@FECH_PRES_4 [datetime],
	@MOTI_PRES_5 [varchar](100),
	@ESTA_ACTI_6 [bit],
	@TIPO_DESC_7 [bit],
	@CODI_MONE_8 [char](2),
	@MONTO_9 [decimal](9, 2),
	@MONT_DESC_10 [decimal](9, 2),
	@INTE_TIEM_DESC_11 [varchar](20),
	@TIPO_PRES_12 [char](2),
	@SALDO_13 [decimal](9, 2)
WITH EXECUTE AS CALLER
AS
INSERT INTO [PRESTAMOS] 
	 ( [CODI_PRES],
	 [CODI_PERS],
	 [NRO_PRES],
	 [FECH_PRES],
	 [MOTI_PRES],
	 [ESTA_ACTI],
	 [TIPO_DESC],
	 [CODI_MONE],
	 [MONTO],
	 [MONT_DESC],
	 [INTE_TIEM_DESC],
	 [codi_TIPO_PREs],
	 [SALDO]) 
 
VALUES 
	( @CODI_PRES_1,
	 @CODI_PERS_2,
	 @NRO_PRES_3,
	 @FECH_PRES_4,
	 @MOTI_PRES_5,
	 @ESTA_ACTI_6,
	 @TIPO_DESC_7,
	 @CODI_MONE_8,
	 @MONTO_9,
	 @MONT_DESC_10,
	 @INTE_TIEM_DESC_11,
	 @TIPO_PRES_12,
	 @SALDO_13)
GO
