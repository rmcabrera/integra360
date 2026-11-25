CREATE PROCEDURE [dbo].[SP_insert_DETALLE_RECEP_MATPRIMA]
	@codi_ticket_1 [char](10),
	@codi_espe_1 [char](2),
	@tones_decla_1 [numeric](12, 4),
	@tone_reci_1 [numeric](12, 4),
	@porc_espe_1 [numeric](12, 3)
WITH EXECUTE AS CALLER
AS
INSERT INTO [DETALLE_RECEP_MATPRIMA] 
	 ( [codi_ticket],
	 [codi_espe],
	 [tones_decla],
	 [tone_reci],
	 [porc_espe]) 
 
VALUES 
	( @codi_ticket_1,
	 @codi_espe_1,
	 @tones_decla_1,
	 @tone_reci_1,
	 @porc_espe_1)
GO
