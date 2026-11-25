CREATE PROCEDURE [dbo].[PA_Personal_Otros_Empleados_Exporta]
WITH EXECUTE AS CALLER
AS
--OJO QUE ESTEN DENTRO DEL PERIODO

SELECT  

 cast( (select td.Codi_Sunat from TIPO_DOCU_IDEN td where td.Codi_Tipo_Docu_Iden=PERSONAL.Codi_Tipo_Docu_Iden) as char(1)) + '|'+ 

 PERSONAL.NRO_DOCU_IDEN + '|'  +
	
 poe.ruc + '|' + poe.razon_social + '|'  

 FROM PERSONAL INNER JOIN PERSONAL_CATEGORIA ON PERSONAL.CODI_PERS = PERSONAL_CATEGORIA.CODI_PERS
 inner join PERSONAL_OTROS_EMPLE_QTA_CAT poe on poe.codi_pers_categ=PERSONAL_CATEGORIA.CODI_PERS_categ

 where personal.esta_acti in (1)
GO
