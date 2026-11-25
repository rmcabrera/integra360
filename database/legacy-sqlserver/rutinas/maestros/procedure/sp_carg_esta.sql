CREATE PROCEDURE [dbo].[sp_carg_esta]
	@codi_esta [char](1) OUTPUT,
	@desc_esta [varchar](50) OUTPUT
WITH EXECUTE AS CALLER
AS
Select estado, desc_esta
From Estados
GO
