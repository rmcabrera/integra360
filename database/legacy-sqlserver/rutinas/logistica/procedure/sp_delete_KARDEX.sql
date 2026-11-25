CREATE PROCEDURE [dbo].[sp_delete_KARDEX]
	@codi_kard_1 [char](20)
WITH EXECUTE AS CALLER
AS
DELETE [KARDEX] 

WHERE 
	( [codi_kard]	 = @codi_kard_1)
GO
