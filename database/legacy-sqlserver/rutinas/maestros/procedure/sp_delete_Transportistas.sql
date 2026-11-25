CREATE PROCEDURE [dbo].[sp_delete_Transportistas]
	@Codi_Trans_1 [char](3)
WITH EXECUTE AS CALLER
AS
DELETE [Transportistas] 

WHERE 
	( [Codi_Trans]	 = @Codi_Trans_1)
GO
