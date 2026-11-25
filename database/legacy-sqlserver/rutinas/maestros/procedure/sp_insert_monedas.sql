CREATE PROCEDURE [dbo].[sp_insert_monedas]
	@CODI_MONE [char](2),
	@DESC_MONE [varchar](50),
	@simbolo [char](10),
	@codi_sunat [tinyint]
WITH EXECUTE AS CALLER
AS
INSERT INTO [MONEDAS] 
	 ( [CODI_MONE],
	 [DESC_MONE],
	 [SIMBOLO],
	codi_sunat)
 
VALUES 
	( @CODI_MONE,
	 @DESC_MONE,
	 @SIMBOLO,
	@codi_sunat)
GO
