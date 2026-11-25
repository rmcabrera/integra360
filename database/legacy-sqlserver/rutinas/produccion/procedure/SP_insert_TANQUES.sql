CREATE PROCEDURE [dbo].[SP_insert_TANQUES]
	@CODI_TANQ_1 [char](2),
	@NOMBRE_1 [varchar](50),
	@STOC_1 [numeric](12, 3),
	@CAPA_1 [numeric](12, 3)
WITH EXECUTE AS CALLER
AS
INSERT INTO [TANQUES] 
	 ( [CODI_TANQ],
	 [DESC_TANQ],
	[STOC_TANQ],
	[CAPA_TANQ]) 
 
VALUES 
	( @CODI_TANQ_1,
	 @NOMBRE_1,
	@stoc_1,
	@CAPA_1)
GO
