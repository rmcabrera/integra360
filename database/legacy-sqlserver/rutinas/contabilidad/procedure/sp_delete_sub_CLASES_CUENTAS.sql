CREATE PROCEDURE [dbo].[sp_delete_sub_CLASES_CUENTAS]
	@CODI_subc [char](3)
WITH EXECUTE AS CALLER
AS
DELETE [sub_CLAS_CUEN] 

WHERE 
	( [CODI_subc]	 = @CODI_subc)
GO
