CREATE PROCEDURE [dbo].[SP_insert_OTROS_CONSUMOS]
	@codi_otro_insu_1 [char](10),
	@codi_turn_1 [char](2),
	@fech_otro_cons_1 [datetime],
	@cons_agua_1 [numeric](12, 4),
	@cons_ener_1 [numeric](12, 4),
	@cons_petr_1 [numeric](12, 4)
WITH EXECUTE AS CALLER
AS
INSERT INTO [OTROS_CONSUMOS] 
	 ( [codi_otro_insu],
	 [codi_turn],
	 [fech_otro_cons],
	 [cons_agua],
	 [cons_ener],
	 [cons_petr]) 
 
VALUES 
	( @codi_otro_insu_1,
	 @codi_turn_1,
	 @fech_otro_cons_1,
	 @cons_agua_1,
	 @cons_ener_1,
	 @cons_petr_1)
GO
