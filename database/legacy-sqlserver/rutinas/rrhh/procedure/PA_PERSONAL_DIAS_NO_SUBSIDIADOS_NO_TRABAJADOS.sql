CREATE PROCEDURE [dbo].[PA_PERSONAL_DIAS_NO_SUBSIDIADOS_NO_TRABAJADOS]
	@ANIO [char](4),
	@MES [varchar](2)
WITH EXECUTE AS CALLER
AS
--declare @ANIO CHAR(4) , @MES VARCHAR(2)   
--select @ANIO ='2008', @MES ='10'  
--PARA LOS DIAS SUBSIDIADOS SOLO SEGUN SUNAT SON DE DOS TIPOS:  
---21 - INCAPACIDAD TEMPORAL (INVALIDEZ, ACCIDENTE, ETC)  
---22 - S.I MATERNIDAD DURANTE EL DESCANSO PRE Y POST NATAL  
-----------------------------------------------------------------------  
-----------------------------------------------------------------------  
--CASO DE LOS DIAS NO SUBSIDIADOS Y NO TRABAJADOS CON O SIN GOCE  
-- HAY QUE TENER EN CUENTA EL TIPO DE SUSPENSION SEGUN SUNAT - ESTO PODRIA VERSE CON EL CAMPO GOCE   
------  
set nocount on  
DECLARE @CODI_PERS CHAR(5)  
  
--- COLOCADO ESTE ARTIFICIO.. PARA EVALUAR FECH TERM  
declare @Fecha_AUX datetime  
set @FEcha_Aux = cast( cast( dbo.f_nro_dias_mes(@anio,@mes) as char(2)) + '/'+ @mes + '/' + @anio as datetime)  
  
create table #personal_dias_no_trabajados  
 (CODI_PERS CHAR(5) , doc_sunat VARCHAR(2) , nro_docu_iden varchar(15) , CODI_TIPO_SUSP_LABO_SUNAT CHAR(2) , FEC_INI varchar(10) , FEC_FIN varchar(10))  
  
----------CASO DE LOS PERMISOS----------------  
--PASO 1 : COGER TODOS LOS REGISTROS QUE SE HAYAN DADO En EL PERIODO ACTUAL OSEA ESTE AÑO Y MES  
insert into #personal_dias_no_trabajados (CODI_PERS , doc_sunat  , nro_docu_iden , CODI_TIPO_SUSP_LABO_SUNAT , FEC_INI , FEC_FIN )  
SELECT P.CODI_PERS, cast (TDI.Codi_Sunat as varchar(2))DOC_SUNAT  , P.nro_docu_iden , isnull(S.Codi_Tipo_Susp_Labo_Sunat,'')  ,  
 convert(char(10), L.FECH_INIC ,103) ,   
 (case when L.FECH_TERM>@Fecha_AUX then convert( char(10) ,@Fecha_AUX,103) else convert(char(10), L.FECH_TERM ,103) end )  
FROM dbo.PERSONAL P (nolock) JOIN dbo.Tipo_Docu_Iden TDI (nolock) ON  P.Codi_Tipo_Docu_Iden =TDI.Codi_Tipo_Docu_Iden  
 JOIN dbo.LICENCIAS_POR_PERSONAL L (nolock) ON P.CODI_PERS=L.CODI_PERS  
 LEFT JOIN dbo.TIPO_SUSPENSION S (nolock) ON L.CODI_TIPO_SUSP_LABO=S.CODI_TIPO_SUSP_LABO  
where YEAR(L.FECH_INIC)=@ANIO AND MONTH(L.FECH_INIC)=@MES  and len(Rtrim(S.codi_tipo_susp_labo_sunat))=2  
 AND l.CODI_TIPO_LICE NOT IN ('004')  
  
--PASO 2 : COGER TODOS LOS REGISTROS QUE SU FECHA FINAL ESTE DENTRO DE ESTE PERIODO ACTUAL OSEA ESTE AÑO Y MES  
  
--- COLOCADO ESTE ARTIFICIO.. PARA EVALUAR FECH INICI  
set @FEcha_Aux = cast( '01/'+ @mes + '/' + @anio as datetime)  
  
insert into #personal_dias_no_trabajados(CODI_PERS , doc_sunat  , nro_docu_iden , CODI_TIPO_SUSP_LABO_SUNAT , FEC_INI , FEC_FIN )  
SELECT P.CODI_PERS, cast (TDI.Codi_Sunat as varchar(2))DOC_SUNAT  , P.nro_docu_iden , isnull(S.Codi_Tipo_Susp_Labo_Sunat,'')  ,  
 (case when L.FECH_INIC<@Fecha_AUX then convert( char(10) ,@Fecha_AUX,103) else convert(char(10), L.FECH_INIC ,103) end ),  
 convert(char(10), L.FECH_TERM ,103)  
FROM dbo.PERSONAL P (nolock) JOIN dbo.Tipo_Docu_Iden TDI (nolock) ON  P.Codi_Tipo_Docu_Iden =TDI.Codi_Tipo_Docu_Iden  
 JOIN dbo.LICENCIAS_POR_PERSONAL L (nolock) ON P.CODI_PERS=L.CODI_PERS  
 LEFT JOIN dbo.TIPO_SUSPENSION S  (nolock) ON L.CODI_TIPO_SUSP_LABO=S.CODI_TIPO_SUSP_LABO  
where YEAR(L.FECH_TERM)=@ANIO AND MONTH(L.FECH_TERM)=@MES  and len(Rtrim(S.codi_tipo_susp_labo_sunat))=2  
 AND l.CODI_TIPO_LICE NOT IN ('004')  
   
----FIN DE CASO DE LOS PESMISOS----------  
  
----CASO DE LA VACACIONES----------------  
set @FEcha_Aux = cast( cast( dbo.f_nro_dias_mes(@anio,@mes) as char(2)) + '/'+ @mes + '/' + @anio as datetime)  
  
insert into #personal_dias_no_trabajados (CODI_PERS , doc_sunat  , nro_docu_iden , CODI_TIPO_SUSP_LABO_SUNAT , FEC_INI , FEC_FIN )  
SELECT P.CODI_PERS, cast (TDI.Codi_Sunat as varchar(2))DOC_SUNAT  , P.nro_docu_iden , '23' AS CODI_SUSP_LABO_SUNAT ,  
 convert(char(10), V.FECH_INIC ,103) ,   
 (case when V.FECH_TERM>@Fecha_AUX then convert( char(10) ,@Fecha_AUX,103) else convert(char(10), V.FECH_TERM ,103) end )  
FROM dbo.PERSONAL P (nolock) JOIN dbo.Tipo_Docu_Iden TDI (nolock) ON  P.Codi_Tipo_Docu_Iden =TDI.Codi_Tipo_Docu_Iden  
 JOIN dbo.VACACIONES V (nolock) ON P.CODI_PERS=V.CODI_PERS  where YEAR(V.FECH_INIC)=@ANIO AND MONTH(V.FECH_INIC)=@MES --and p.esta_acti=1  
  
  
--PASO 2 : COGER TODOS LOS REGISTROS QUE SU FECHA FINAL ESTE DENTRO DE ESTE PERIODO ACTUAL OSEA ESTE AÑO Y MES  
---------- PARA SABER CUANDOS DIAS PARA ATRAS NO HAN TRABAJADO RESPECTO AL PERIODO  
  
--- COLOCADO ESTE ARTIFICIO.. PARA EVALUAR FECH INICI  
set @FEcha_Aux = cast( '01/'+ @mes + '/' + @anio as datetime)  
  
  
insert into #personal_dias_no_trabajados(CODI_PERS , doc_sunat  , nro_docu_iden , CODI_TIPO_SUSP_LABO_SUNAT , FEC_INI , FEC_FIN )  
SELECT P.CODI_PERS, cast (TDI.Codi_Sunat as varchar(2))DOC_SUNAT  , P.nro_docu_iden , '23' AS CODI_SUSP_LABO_SUNAT ,  
 (case when V.FECH_INIC<@Fecha_AUX then convert( char(10) ,@Fecha_AUX,103) else convert(char(10), V.FECH_INIC ,103) end ),  
  convert(char(10), V.FECH_TERM ,103)  
FROM dbo.PERSONAL P (nolock) JOIN dbo.Tipo_Docu_Iden TDI (nolock) ON  P.Codi_Tipo_Docu_Iden =TDI.Codi_Tipo_Docu_Iden  
 JOIN dbo.VACACIONES V (nolock) ON P.CODI_PERS=V.CODI_PERS  
where YEAR(V.FECH_TERM)=@ANIO AND MONTH(V.FECH_TERM)=@MES --and p.esta_acti=1  
  
----FIN DE CASO DE LAS VACACIONES--------  
  
--**************************************************************************************************************  
---- VEMOS QUIENES TIENEN FALTAS :: SOLO PARA EMPLEADOS Y OBREROS ---------------  
  
CREATE TABLE #FALTAS ( CODI_PERS CHAR(5) COLLATE SQL_Latin1_General_CP1_CI_AS , DIA VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CI_AS)  
  
DECLARE @ANIO_INT INT  
DECLARE @MES_INT INT  
  
SET @ANIO_INT=CAST(@ANIO AS INT)  
SET @MES_INT=CAST(@MES AS INT)  
  
DECLARE @D_01 CHAR(1)  
DECLARE @D_02 CHAR(1)  
DECLARE @D_03 CHAR(1)  
DECLARE @D_04 CHAR(1)  
DECLARE @D_05 CHAR(1)  
DECLARE @D_06 CHAR(1)  
DECLARE @D_07 CHAR(1)  
DECLARE @D_08 CHAR(1)  
DECLARE @D_09 CHAR(1)  
DECLARE @D_10 CHAR(1)  
DECLARE @D_11 CHAR(1)  
DECLARE @D_12 CHAR(1)  
DECLARE @D_13 CHAR(1)  
DECLARE @D_14 CHAR(1)  
DECLARE @D_15 CHAR(1)  
DECLARE @D_16 CHAR(1)  
DECLARE @D_17 CHAR(1)  
DECLARE @D_18 CHAR(1)  
DECLARE @D_19 CHAR(1)  
DECLARE @D_20 CHAR(1)  
DECLARE @D_21 CHAR(1)  
DECLARE @D_22 CHAR(1)  
DECLARE @D_23 CHAR(1)  
DECLARE @D_24 CHAR(1)  
DECLARE @D_25 CHAR(1)  
DECLARE @D_26 CHAR(1)  
DECLARE @D_27 CHAR(1)  
DECLARE @D_28 CHAR(1)  
DECLARE @D_29 CHAR(1)  
DECLARE @D_30 CHAR(1)  
DECLARE @D_31 CHAR(1)  
DECLARE @FECHA VARCHAR(10)  
  
DECLARE C10 CURSOR FOR   
SELECT CODI_PERS, D_01 , D_02, D_03 , D_04, D_05 , D_06, D_07 , D_08, D_09 , D_10, D_11 , D_12, D_13 , D_14 ,   
D_15 , D_16, D_17 , D_18, D_19 , D_20, D_21 , D_22, D_23 , D_24, D_25 , D_26, D_27 , D_28 , D_29, D_30 , D_31  
FROM   
(  SELECT HL.CODI_PERS,     
          HL.FECH_INIC,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_01,dateadd(day,0,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM) AS D_01   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_02,dateadd(day,1,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_02   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_03,dateadd(day,2,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_03   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_04,dateadd(day,3,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_04   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_05,dateadd(day,4,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_05   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_06,dateadd(day,5,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_06  ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_07,dateadd(day,6,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_07   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_08,dateadd(day,7,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_08   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_09,dateadd(day,8,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_09   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_10,dateadd(day,9,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_10   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_11,dateadd(day,10,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_11   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_12,dateadd(day,11,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_12   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_13,dateadd(day,12,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_13   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_14,dateadd(day,13,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_14   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_15,dateadd(day,14,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_15   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_16,dateadd(day,15,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_16   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_17,dateadd(day,16,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_17   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_18,dateadd(day,17,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_18   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_19,dateadd(day,18,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_19   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_20,dateadd(day,19,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_20   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_21,dateadd(day,20,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_21   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_22,dateadd(day,21,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_22   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_23,dateadd(day,22,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_23   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_24,dateadd(day,23,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_24   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_25,dateadd(day,24,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_25   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_26,dateadd(day,25,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_26   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_27,dateadd(day,26,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_27  ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_28,dateadd(day,27,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_28   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_29,dateadd(day,28,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_29   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_30,dateadd(day,29,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_30   ,     
     DBO.F_ESTADO_TRABAJADOR(HL.CODI_PERS, HL.D_31,dateadd(day,30,FECH_INIC), MONTH(FECH_INIC), HL.INDI_TIEM)    AS D_31        
    
  FROM dbo.HORAS_LABORADAS HL (nolock),   dbo.PERSONAL (nolock),      
  dbo.PERSONAL_POR_TIPO_TRABAJADOR (nolock), dbo.TIPO_TRABAJADOR (nolock)  
  WHERE ( PERSONAL.CODI_PERS = HL.CODI_PERS ) and    
           ( PERSONAL.CODI_PERS = PERSONAL_POR_TIPO_TRABAJADOR.CODI_PERS ) and    
           ( TIPO_TRABAJADOR.CODI_TIPO_PERS = PERSONAL_POR_TIPO_TRABAJADOR.CODI_TIPO_PERS )      
             and (year(HL.fech_inic)=@ANIO_INT and month(HL.fech_inic)=@MES_INT  and HL.INDI_TIEM='M') ) HORAS  
WHERE D_01='F' OR D_02='F' OR D_03='F' OR D_04='F' OR D_05='F' OR D_06='F' OR D_07='F' OR D_08='F' OR D_09='F' OR D_10='F'   
                  OR D_11='F' OR D_12='F' OR D_15='F' OR D_16='F' OR  D_17='F' OR D_18='F' OR D_19='F' OR D_20='F' OR D_21='F' OR D_22='F' OR D_23='F' OR D_24='F' OR D_25='F' OR D_26='F' OR D_27='F' OR D_28='F' OR D_29='F' OR D_30='F' OR D_31='F'  
  
OPEN C10  
  
FETCH C10 INTO @CODI_PERS , @D_01 , @D_02, @D_03 , @D_04, @D_05 , @D_06, @D_07 , @D_08, @D_09 , @D_10, @D_11 , @D_12, @D_13 , @D_14 ,   
                     @D_15 , @D_16, @D_17 , @D_18, @D_19 , @D_20, @D_21 , @D_22, @D_23 , @D_24, @D_25 , @D_26, @D_27 , @D_28 , @D_29, @D_30 , @D_31  
  
WHILE @@FETCH_STATUS = 0  
 begin  
   
 if @D_01='F'   
 BEGIN    
  SET @FECHA='01/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_02='F'   
 BEGIN       SET @FECHA='02/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_03='F'   
 BEGIN     
  SET @FECHA='03/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_04='F'   
 BEGIN     
  SET @FECHA='04/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_05='F'   
 BEGIN     
  SET @FECHA='05/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_06='F'   
 BEGIN     
  SET @FECHA='06/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END   
  
 if @D_07='F'   
 BEGIN     
  SET @FECHA='07/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_08='F'   
 BEGIN     
  SET @FECHA='08/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_09='F'   
 BEGIN     
  SET @FECHA='09/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_10='F'   
 BEGIN     
  SET @FECHA='10/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_11='F'   
 BEGIN     
  SET @FECHA='11/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_12='F'   
 BEGIN     
  SET @FECHA='12/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END   
  
 if @D_13='F'   
 BEGIN    
  SET @FECHA='13/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_14='F'   
 BEGIN     
  SET @FECHA='14/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_15='F'   
 BEGIN     
  SET @FECHA='15/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_16='F'   
 BEGIN     
  SET @FECHA='16/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_17='F'   
 BEGIN     
  SET @FECHA='17/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_18='F'   
 BEGIN     
  SET @FECHA='18/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END   
  
 if @D_19='F'   
 BEGIN     
  SET @FECHA='19/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_20='F'   
 BEGIN     
  SET @FECHA='20/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_21='F'   
 BEGIN     
  SET @FECHA='21/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_22='F'   
 BEGIN     
  SET @FECHA='22/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_23='F'   
 BEGIN     
  SET @FECHA='23/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_24='F'   
 BEGIN     
  SET @FECHA='24/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END   
  
 if @D_25='F'   
 BEGIN     
  SET @FECHA='25/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_26='F'   
 BEGIN     
  SET @FECHA='26/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_27='F'   
 BEGIN     
  SET @FECHA='27/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_28='F'   
 BEGIN     
  SET @FECHA='28/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END  
 if @D_29='F'   
 BEGIN     
  SET @FECHA='29/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END   
  
 if @D_30='F'   
 BEGIN     
  SET @FECHA='30/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END   
  
 if @D_31='F'   
 BEGIN     
  SET @FECHA='31/' + @mes + '/' + cast(@anio as char(4))   
  insert into #FALTAS (CODI_PERS , DIA  ) Values (@CODI_PERS ,@FECHA)  
 END   
  
 FETCH C10 INTO @CODI_PERS , @D_01 , @D_02, @D_03 , @D_04, @D_05 , @D_06, @D_07 , @D_08, @D_09 , @D_10, @D_11 , @D_12, @D_13 , @D_14 ,   
 @D_15 , @D_16, @D_17 , @D_18, @D_19 , @D_20, @D_21 , @D_22, @D_23 , @D_24, @D_25 , @D_26, @D_27 , @D_28 , @D_29, @D_30 , @D_31  
end  
  
close C10  
deallocate C10    
  
-------------------------------------------------------------------------------------------------------------------------------------------  
select DOC_SUNAT + '|' +  
 nro_docu_iden + '|' +  
 isnull(CODI_TIPO_SUSP_LABO_SUNAT,'') + '|' +  
 FEC_INI + '|' +  
 FEC_FIN + '|'   
  
from #personal_dias_no_trabajados  
  
UNION ALL  --- LOS EMPLEADOS Y OBREROS QUE FALTARON HA TRABAJAR  
  
select cast (TDI.Codi_Sunat as varchar(2)) +  '|' +  cast (P.NRO_DOCU_IDEN as varchar(15))  
+ '|07|' +  CAST(F.dia AS VARCHAR(10)) + '|' + CAST(F.dia AS VARCHAR(10)) collate sql_latin1_general_cp1_ci_as + '|'   
from dbo.PERSONAL P (nolock) JOIN dbo.Tipo_Docu_Iden TDI (nolock) ON  P.Codi_Tipo_Docu_Iden =TDI.Codi_Tipo_Docu_Iden  
INNER JOIN #FALTAS F ON P.CODI_PERS=F.CODI_PERS  
  
---eliminamos las tablas temporales  
  
drop table #FALTAS   
drop table #personal_dias_no_trabajados  
  
----------------------------------
GO
