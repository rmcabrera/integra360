CREATE PROCEDURE [dbo].[sp_update_Domi]
	@Codi_Domi_1 [char](3),
	@Codi_Domi_2 [char](3),
	@Desc_Domi_3 [char](150),
	@Distrito_4 [char](30),
	@Provincia_5 [char](30),
	@Departamento_6 [char](30)
WITH EXECUTE AS CALLER
AS
UPDATE [Domicilio] 

SET  [Codi_Domi]	 = @Codi_Domi_2,
	 [Desc_Domi]	 = @Desc_Domi_3,
	 [Distrito]	 = @Distrito_4,
	 [Provincia]	 = @Provincia_5,
	 [Departamento]	 = @Departamento_6 

WHERE 
	( [Codi_Domi]	 = @Codi_Domi_1)
GO
