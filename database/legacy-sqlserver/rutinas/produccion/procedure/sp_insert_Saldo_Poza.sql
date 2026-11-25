CREATE PROCEDURE [dbo].[sp_insert_Saldo_Poza]
	@codi_sald_poza_1 [char](10),
	@codi_turn_1 [char](2),
	@codi_poza_1 [char](2),
	@sald_ante_1 [numeric](12, 3),
	@cant_desc_poza_1 [numeric](12, 3),
	@cons_prod_1 [numeric](12, 3),
	@sald_fina_1 [numeric](12, 3),
	@fecha_1 [datetime]
WITH EXECUTE AS CALLER
AS
INSERT INTO [Saldo_Poza] 
	 ( [codi_sald_poza],
	 [codi_turn],
	 [codi_poza],
	 [sald_ante],
	 [cant_desc_poza],
	 [cons_prod],
	 [sald_fina],
	 [fecha])  	 
VALUES 
	( @codi_sald_poza_1,
	 @codi_turn_1,
	 @codi_poza_1,
	 @sald_ante_1,
	 @cant_desc_poza_1,
	 @cons_prod_1,
	 @sald_fina_1,
	 @fecha_1)
GO
