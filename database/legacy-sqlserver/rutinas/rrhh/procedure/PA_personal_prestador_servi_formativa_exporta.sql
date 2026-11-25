CREATE PROCEDURE [dbo].[PA_personal_prestador_servi_formativa_exporta]
WITH EXECUTE AS CALLER
AS
--- OJO : DEBE DE ESTAR DENTRO DEL PERIODO

SELECT 
	isnull(cast(TIPO_DOCU_IDEN.codi_sunat as varchar(2)),'')		+ '|'+
	left(isnull(PERSONAL.NRO_DOCU_IDEN,'') ,15)			+ '|'+
	cast(PERSONAL_CATEGORIA.tipo_seg_med as varchar(1)) + '|'+   
	NIVEL.Codi_Nivel_Sunat + '|'+   
	OCUPACION.Codi_Ocu_Sunat + '|'+   
	cast(PERSONAL_CATEGORIA.madre_resp_fam as varchar(1))+ '|'+   
	cast(PERSONAL_CATEGORIA.Discapacidad as varchar(1))+ '|'+   
	cast(PERSONAL_CATEGORIA.centro_form_prof as varchar(1))+ '|'+   
	cast(PERSONAL_CATEGORIA.horario_noctur as varchar(1)) + '|'  

FROM PERSONAL inner join TIPO_DOCU_IDEN on personal.codi_tipo_docu_iden=TIPO_DOCU_IDEN.codi_tipo_docu_iden
	inner join PERSONAL_CATEGORIA on personal.codi_pers=PERSONAL_CATEGORIA.codi_pers
       	inner join NIVEL on nivel.codi_nivel=PERSONAL_CATEGORIA.codi_nivel  
	inner join  OCUPACION  on PERSONAL_CATEGORIA.Codi_Ocu = OCUPACION.Codi_Ocu

where PERSONAL_CATEGORIA.TIPO_CAT_TRAB='M' and personal.esta_acti in (1)
GO
