CREATE PROCEDURE [dbo].[SP_delete_RECEP_MATPRIMA]
	@codi_ticket_1 [char](10)
WITH EXECUTE AS CALLER
AS
DELETE [RECEP_MATPRIMA] 

WHERE 
	( [codi_ticket]	 = @codi_ticket_1)
GO
