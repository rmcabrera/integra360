CREATE PROCEDURE [dbo].[sp_insert_line_clas_cuen]
	@codi_lcc [char](5),
	@desc_lcc [varchar](100),
	@codi_subc [char](3)
WITH EXECUTE AS CALLER
AS
INSERT INTO [LINEA_CLASE_C] 
	 ( [CODI_LCC],
	 [desc_lcc],
	 [codi_subc]) 
 
VALUES 
	(@CODI_lcc,
	 @desc_lcc,
	 @codi_subc)
GO
