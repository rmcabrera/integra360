CREATE PROCEDURE [dbo].[sp_Get_Tipo_Pers]
	@Codi_Tipo_Pers [char](2) OUTPUT,
	@Desc_Tipo_Pers [varchar](50) OUTPUT
WITH EXECUTE AS CALLER
AS
Select Codi_Tipo_Pers, Desc_Tipo_Pers From Tipo_Trabajador
GO
