CREATE PROCEDURE [dbo].[sp_insert_Transportistas]
	@Codi_Trans_1 [char](3),
	@Desc_Trans_2 [char](100),
	@Iden_3 [char](20),
	@Direccion_4 [char](150)
WITH EXECUTE AS CALLER
AS
INSERT INTO [Transportistas] 
	 ( [Codi_Trans],
	 [Desc_Trans],
	 [Iden],
	 [Direccion]) 
 
VALUES 
	( @Codi_Trans_1,
	 @Desc_Trans_2,
	 @Iden_3,
	 @Direccion_4)
GO
