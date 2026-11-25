CREATE PROCEDURE [dbo].[PA_Personal_Pensionista_Exporta]
WITH EXECUTE AS CALLER
AS
--OJO : DEBEN DE ESTAR DENTRO DEL PERIODO

SELECT isnull(cast(TDI.Codi_Sunat as varchar(2)),'')		+ '|'+
	left(isnull(P.nro_docu_iden,'') ,15)			+ '|'+
  	CAST(TP.Codi_Tipo_Pers_Sunat as varchar(2)) + '|'+  
	CAST(PENS.Codi_Pension_Sunat as varchar(2))+ '|'+
	isnull(convert(char(10), PC.FECH_INGRE,103),'') 		+ '|'+
	PC.NRO_CUPSS + '|'+
	cast(STP.Codi_Situ_Trab_Pens_Sunat as char(2))+ '|'+
	MP.Codi_Sunat+ '|'
 
	From Personal P
		inner join Tipo_Docu_Iden TDI on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden 
		inner join PERSONAL_CATEGORIA PC on PC.codi_PERS=p.CODI_PERS
		INNER JOIN TIPO_PERSONAL TP ON TP.Codi_Tipo_Pers=PC.Codi_Tipo_Pers  
		INNER JOIN PENSION PENS ON PENS.Codi_Pension=PC.Codi_Pension
		INNER JOIN SITU_TRAB_PENS STP ON STP.Codi_Situ_Trab_Pens=Pc.Codi_Situ_Trab_Pens	
		INNER JOIN TIPO_PAGO MP ON MP.Codi_Tipo_Medio_Pago=PC.Codi_Tipo_Medio_Pago  
		
WHERE P.esta_acti in (1) and PC.TIPO_CAT_TRAB='P'
GO
