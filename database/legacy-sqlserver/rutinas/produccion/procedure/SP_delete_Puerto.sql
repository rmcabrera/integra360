CREATE PROCEDURE [dbo].[SP_delete_Puerto]
	@Codi_Puer [char](2)
WITH EXECUTE AS CALLER
AS
DELETE [Puerto] 

WHERE 
	 [Codi_Puer]	 = @Codi_Puer
GO
