CREATE PROCEDURE [dbo].[sp_insert_INSUMOS]
	@CODI_INSU_1 [char](10),
	@CODI_TURN_1 [char](2),
	@CODI_PROD_1 [char](8),
	@STOC_INIC_1 [numeric](12, 3),
	@NRO_NOTA_INGR_1 [char](10),
	@CANT_INGR_1 [numeric](12, 3),
	@MOTI_INGR_1 [varchar](100),
	@NRO_VALE_SALI_1 [char](10),
	@CANT_SALI_1 [numeric](12, 3),
	@NRO_CUEN_1 [char](7),
	@STOC_FINA_1 [numeric](12, 3),
	@FECH_INSU_1 [datetime]
WITH EXECUTE AS CALLER
AS
INSERT INTO [INSUMOS] 
	 ( [CODI_INSU],
	 [CODI_TURN],
	 [CODI_PROD],
	 [STOC_INIC],
	 [NRO_NOTA_INGR],
	 [CANT_INGR],
	 [MOTI_INGR],
	 [NRO_VALE_SALI],
	 [CANT_SALI],
	 [NRO_CUEN],
	 [STOC_FINA],
	 [FECH_INSU]) 
 
VALUES 
	( @CODI_INSU_1,
	 @CODI_TURN_1,
	 @CODI_PROD_1,
	 @STOC_INIC_1,
	 @NRO_NOTA_INGR_1,
	 @CANT_INGR_1,
	 @MOTI_INGR_1,
	 @NRO_VALE_SALI_1,
	 @CANT_SALI_1,
	 @NRO_CUEN_1,
	 @STOC_FINA_1,
	 @FECH_INSU_1)
GO
