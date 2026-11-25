CREATE PROCEDURE [dbo].[sp_delete_Domicilio]
	@Codi_Domi_1 [char](3)
WITH EXECUTE AS CALLER
AS
DELETE [Domicilio] 

WHERE 
	( [Codi_Domi]	 = @Codi_Domi_1)
GO
