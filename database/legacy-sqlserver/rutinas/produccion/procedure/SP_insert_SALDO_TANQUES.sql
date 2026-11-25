CREATE PROCEDURE [dbo].[SP_insert_SALDO_TANQUES]
	@codi_sald_tanq_1 [char](10),
	@codi_tanq_auxi_1 [char](3),
	@codi_turn_1 [char](2),
	@petr_ante_1 [numeric](12, 3),
	@petr_ingr_1 [numeric](12, 3),
	@petr_sali_1 [numeric](12, 3),
	@petr_fina_1 [numeric](12, 3),
	@fecha_1 [datetime]
WITH EXECUTE AS CALLER
AS
INSERT INTO [SALDO_TANQUES] 
	 ( [codi_sald_tanq],
	 [codi_tanq_auxi],
	 [codi_turn],
	 [petr_ante],
	 [petr_ingr],
	 [petr_sali],
	 [petr_fina],
	 [fecha]) 
 
VALUES 
	( @codi_sald_tanq_1,
	 @codi_tanq_auxi_1,
	 @codi_turn_1,
	 @petr_ante_1,
	 @petr_ingr_1,
	 @petr_sali_1,
	 @petr_fina_1,
	 @fecha_1)
GO
