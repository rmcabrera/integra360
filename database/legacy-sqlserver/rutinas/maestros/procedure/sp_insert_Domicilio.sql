CREATE PROCEDURE [dbo].[sp_insert_Domicilio]
	@Codi_Domi_1 [char](3),
	@Desc_Domi_2 [char](150),
	@Distrito_3 [char](30),
	@Provincia_4 [char](30),
	@Departamento_5 [char](30)
WITH EXECUTE AS CALLER
AS
INSERT INTO [Domicilio] 
	 ( [Codi_Domi],
	 [Desc_Domi],
	 [Distrito],
	 [Provincia],
	 [Departamento]) 
 
VALUES 
	( @Codi_Domi_1,
	 @Desc_Domi_2,
	 @Distrito_3,
	 @Provincia_4,
	 @Departamento_5)
GO
