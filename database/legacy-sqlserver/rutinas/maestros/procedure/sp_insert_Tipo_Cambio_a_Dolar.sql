CREATE PROCEDURE [dbo].[sp_insert_Tipo_Cambio_a_Dolar]
	@CODI_MONE_ORIG [char](2),
	@FECH_CAMB [datetime],
	@COMPRA [decimal](8, 4),
	@VENTA [decimal](8, 4)
WITH EXECUTE AS CALLER
AS
INSERT INTO [TIPO_CAMBIO_A_DOLAR] 
	 ( [CODI_MONE_ORIG],
	 [FECH_CAMB],
	 [COMPRA],
	 [VENTA]) 
 
VALUES 
	( @CODI_MONE_ORIG,
	 @FECH_CAMB,
	 @COMPRA,
	 @VENTA)
GO
