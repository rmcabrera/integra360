CREATE PROCEDURE [dbo].[sp_delete_sist_pens]
	@CODI_sist_pens [char](2)
WITH EXECUTE AS CALLER
AS
DELETE [Sistema_Pensiones] 

WHERE 
	( [CODI_sist_pens]	 = @CODI_sist_pens)
GO
