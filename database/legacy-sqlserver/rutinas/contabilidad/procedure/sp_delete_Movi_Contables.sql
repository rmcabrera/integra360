CREATE PROCEDURE [dbo].[sp_delete_Movi_Contables]
	@Codi_Contable_1 [char](10)
WITH EXECUTE AS CALLER
AS
DELETE [Movi_Contables] 

WHERE 
	( [Codi_Contable]	 = @Codi_Contable_1)
GO
