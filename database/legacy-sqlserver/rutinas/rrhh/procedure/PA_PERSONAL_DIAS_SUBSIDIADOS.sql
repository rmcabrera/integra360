CREATE PROCEDURE [dbo].[PA_PERSONAL_DIAS_SUBSIDIADOS]
	@ANIO [char](4),
	@MES [varchar](2)
WITH EXECUTE AS CALLER
AS
--declare @ANIO CHAR(4) , @MES VARCHAR(2) 
--select @ANIO ='2008', @MES ='06'
--PARA LOS DIAS SUBSIDIADOS SOLO SEGUN SUNAT SON DE DOS TIPOS:
---21 - INCAPACIDAD TEMPORAL (INVALIDEZ, ACCIDENTE, ETC)
---22 - S.I MATERNIDAD DURANTE EL DESCANSO PRE Y POST NATAL
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--CASO DE LOS DIAS SUBSIDIADOS CON O SIN GOCE
-- HAY QUE TENER EN CUENTA EL TIPO DE SUSPENSION SEGUN SUNAT - ESTO PODRIA VERSE CON EL CAMPO GOCE 
--select * from licencias_por_personal where month(fech_inic)=1 and year(fech_inic)=2008 and codi_tipo
-------
set nocount on 

create table #personal_dias_subsidiados_trabajados
 (CODI_PERS CHAR(5) , doc_sunat VARCHAR(2) , nro_docu_iden varchar(15) , CODI_TIPO_SUSP_LABO_SUNAT CHAR(2) , nro_citt varchar(16) ,  FEC_INI varchar(10) , FEC_FIN varchar(10))

--PASO 1 : COGER TODOS LOS REGISTROS QUE SE HAYAN DADO En EL PERIODO ACTUAL OSEA ESTE AÑO Y MES
insert into #personal_dias_subsidiados_trabajados (CODI_PERS , doc_sunat  , nro_docu_iden , CODI_TIPO_SUSP_LABO_SUNAT , nro_citt , FEC_INI , FEC_FIN )
SELECT P.CODI_PERS, cast (TDI.Codi_Sunat as varchar(2))DOC_SUNAT  , P.nro_docu_iden , S.Codi_Tipo_Susp_Labo_Sunat  ,
	nro_citt , convert(char(10), L.FECH_INIC ,103) , convert(char(10), L.FECH_TERM ,103)
FROM dbo.PERSONAL P (nolock) JOIN dbo.Tipo_Docu_Iden TDI (nolock) ON  P.Codi_Tipo_Docu_Iden =TDI.Codi_Tipo_Docu_Iden
INNER JOIN dbo.LICENCIAS_POR_PERSONAL L (nolock) ON P.CODI_PERS=L.CODI_PERS
LEFT JOIN dbo.TIPO_SUSPENSION S (nolock) ON L.CODI_TIPO_SUSP_LABO=S.CODI_TIPO_SUSP_LABO
where YEAR(L.FECH_INIC)=@ANIO AND MONTH(L.FECH_INIC)=@MES --and p.esta_acti=1
	AND l.CODI_TIPO_LICE IN ('004')

--PASO 2 : COGER TODOS LOS REGISTROS QUE SU FECHA FINAL ESTE DENTRO DE ESTE PERIODO ACTUAL OSEA ESTE AÑO Y MES

insert into #personal_dias_subsidiados_trabajados (CODI_PERS , doc_sunat  , nro_docu_iden , CODI_TIPO_SUSP_LABO_SUNAT , nro_citt , FEC_INI , FEC_FIN )
SELECT P.CODI_PERS, cast (TDI.Codi_Sunat as varchar(2))DOC_SUNAT  , P.nro_docu_iden ,  S.Codi_Tipo_Susp_Labo_Sunat  ,
	nro_citt , convert(char(10), L.FECH_INIC ,103) , convert(char(10), L.FECH_TERM ,103)
FROM dbo.PERSONAL P (nolock) JOIN dbo.Tipo_Docu_Iden TDI (nolock) ON  P.Codi_Tipo_Docu_Iden =TDI.Codi_Tipo_Docu_Iden
	JOIN dbo.LICENCIAS_POR_PERSONAL L (nolock) ON P.CODI_PERS=L.CODI_PERS
	LEFT JOIN dbo.TIPO_SUSPENSION S (nolock) ON L.CODI_TIPO_SUSP_LABO=S.CODI_TIPO_SUSP_LABO
where YEAR(L.FECH_TERM)=@ANIO AND MONTH(L.FECH_TERM)>=@MES --and p.esta_acti=1
	AND l.CODI_TIPO_LICE IN ('004')

----FIN DE CASO DE LOS PESMISOS----------

select isnull(DOC_SUNAT,'') + '|' +
	nro_docu_iden + '|' +
	isnull(CODI_TIPO_SUSP_LABO_SUNAT ,'') + '|' + isnull(nro_citt,'') + '|' +
	isnull(FEC_INI,'') + '|' +
	isnull(FEC_FIN,'') + '|' 
from #personal_dias_subsidiados_trabajados

drop table #personal_dias_subsidiados_trabajados
----------------------------------
GO
