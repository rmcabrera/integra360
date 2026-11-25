CREATE PROCEDURE [dbo].[sp_delete_Line_clas_cuen]
	@CODI_lcc [char](5)
WITH EXECUTE AS CALLER
AS
DELETE [linea_clase_c] 

WHERE 
	( [CODI_lcc]	 = @CODI_lcc)
GO
