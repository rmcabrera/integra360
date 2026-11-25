CREATE PROCEDURE [dbo].[PA_Personal_Qta_Medio_Presentacio_Exporta]
WITH EXECUTE AS CALLER
AS
--OJO: DENTRO DEL PERIODO
SELECT isnull(cast(TDI.Codi_Sunat as varchar(5)),'')		+ '|'+
	  left(isnull(Personal.nro_docu_iden,'') ,15)			+ '|'+			
	  pp.nro_operacion + '|' +
	  isnull(convert(char(10), pp.Fech_Inicio ,103),'') + '|' +			
	  cast(pp.Anio as varchar(4)) + '|' +
	  cast(pp.Medio_Presenta as varchar(1)) + '|' 
        
FROM Personal inner join Tipo_Docu_Iden TDI on TDI.Codi_Tipo_Docu_Iden = PERSONAL.Codi_Tipo_Docu_Iden 
INNER JOIN PERSONAL_CATEGORIA ON PERSONAL.CODI_PERS = PERSONAL_CATEGORIA.CODI_PERS
inner join personal_periodo pp on pp.Codi_Pers_categ=PERSONAL_CATEGORIA.Codi_Pers_categ

where personal.esta_acti=1	and PERSONAL_CATEGORIA.tipo_cat_trab='Q'
GO
