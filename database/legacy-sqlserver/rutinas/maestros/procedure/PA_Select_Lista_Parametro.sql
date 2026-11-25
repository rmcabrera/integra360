CREATE PROCEDURE [dbo].[PA_Select_Lista_Parametro]
WITH EXECUTE AS CALLER
AS
Select  cod_param,  desc_param, codi_prod
From Parametro
GO
