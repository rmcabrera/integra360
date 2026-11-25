CREATE PROCEDURE [dbo].[PA_Select_Parametro]
	@codi [smallint]
WITH EXECUTE AS CALLER
AS
Select *
From Parametro
Where cod_param = @codi
GO
