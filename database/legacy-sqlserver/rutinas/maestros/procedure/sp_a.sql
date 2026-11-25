CREATE PROCEDURE [dbo].[sp_a]
WITH EXECUTE AS CALLER
AS
Select estado, desc_esta
From Estados
GO
