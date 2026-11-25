CREATE PROCEDURE [dbo].[sp_insert_sub_clases_cuenta]
	@codi_subc [char](3),
	@desc_subc [varchar](100),
	@codi_clas_cuen [char](2)
WITH EXECUTE AS CALLER
AS
INSERT INTO [sub_clas_cuen] 
	 ( [CODI_subc],
	 [desc_subc],
	 [codi_clas_cuen]) 
 
VALUES 
	(@CODI_subc,
	 @desc_subc,
	 @codi_clas_cuen)
GO
