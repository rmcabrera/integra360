CREATE PROCEDURE [dbo].[sp_Get_Personal]
	@Codi_Pers [char](5) OUTPUT,
	@Apel_1 [varchar](50) OUTPUT,
	@Apel_2 [varchar](50) OUTPUT,
	@Nomb_1 [varchar](50) OUTPUT,
	@Nomb_2 [varchar](50) OUTPUT
WITH EXECUTE AS CALLER
AS
Select Codi_Pers, Apel_1, Apel_2, Nomb_1, Nomb_2 From Personal
GO
