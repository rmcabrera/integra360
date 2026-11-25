CREATE PROCEDURE [dbo].[SP_insert_BOLETAS]
	@CODI_BOLE_1 [char](10),
	@SERIE_2 [char](3),
	@NUMERO_3 [char](6),
	@CODI_CLIE_PROV_4 [char](5),
	@FECHA_5 [datetime],
	@MONTO_6 [numeric](12, 2),
	@TIPO_7 [char](2),
	@CODI_MONE_8 [char](2),
	@ESTADO_9 [char](1)
WITH EXECUTE AS CALLER
AS
INSERT INTO [BOLETAS] 
	 ( [CODI_BOLE],
	 [SERIE],
	 [NUMERO],
	 [CODI_CLIE_PROV],
	 [FECHA],
	 [MONTO],
	 [TIPO],
	 [CODI_MONE],
	 [ESTADO]) 
 
VALUES 
	( @CODI_BOLE_1,
	 @SERIE_2,
	 @NUMERO_3,
	 @CODI_CLIE_PROV_4,
	 @FECHA_5,
	 @MONTO_6,
	 @TIPO_7,
	 @CODI_MONE_8,
	 @ESTADO_9)
GO
