CREATE PROCEDURE [dbo].[SP_GETDATE_SRV]
	@fechora [datetime] OUTPUT
WITH EXECUTE AS CALLER
AS
Select @fechora = getdate()
GO
