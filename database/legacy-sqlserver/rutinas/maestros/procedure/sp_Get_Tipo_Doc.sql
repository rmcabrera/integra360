CREATE PROCEDURE [dbo].[sp_Get_Tipo_Doc]
	@Codi_Tipo_Docu [char](4) OUTPUT,
	@Desc_Tipo_Docu [varchar](150) OUTPUT
WITH EXECUTE AS CALLER
AS
Select Codi_Tipo_Docu, Desc_Tipo_Docu From Tipo_Documento
	Where Tipo_Cont = "C"
GO
