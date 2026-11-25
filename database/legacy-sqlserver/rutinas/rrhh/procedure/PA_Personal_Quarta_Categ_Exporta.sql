CREATE PROCEDURE [dbo].[PA_Personal_Quarta_Categ_Exporta]
WITH EXECUTE AS CALLER
AS
--OJO: QUE ESTEN DENTRO DEL MISMO PERIODO
 SELECT isnull(cast(TDI.Codi_Sunat as varchar(5)),'')		+ '|'+
	   left(isnull(Personal.nro_docu_iden,'') ,15)			+ '|'+
	   PERSONAL_CATEGORIA.ruc + '|' 
        
 FROM Personal INNER JOIN PERSONAL_CATEGORIA ON PERSONAL.CODI_PERS = PERSONAL_CATEGORIA.CODI_PERS
	 inner join Tipo_Docu_Iden TDI on TDI.Codi_Tipo_Docu_Iden = PERSONAL.Codi_Tipo_Docu_Iden 
	where personal.esta_acti=1	  and PERSONAL_CATEGORIA.tipo_cat_trab='Q'
GO
