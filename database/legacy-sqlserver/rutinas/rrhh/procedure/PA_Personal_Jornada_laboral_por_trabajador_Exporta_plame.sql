CREATE PROCEDURE [dbo].[PA_Personal_Jornada_laboral_por_trabajador_Exporta_plame]
	@anio [int],
	@mes [int],
	@codi_plan [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4) , @mes char(2) , @codi_plan char(2)         
--select @anio ='2010' , @mes ='01', @codi_plan ='01'        
        
set nocount on        
        
--- PARA EMPLEADOS ------        
create table #personal_dias_horas_lab        
 (doc_sunat int , nro_doc_iden varchar(20) , CODI_PLAN_EMPL char(10) , codi_pers varchar(5), dias_trab int , horas_ordina int , horas_sobre int)        
        
declare @codi_perso varchar(5)        
declare @CODI_PLAN_EMPL char(10)        
        
declare @dias_trab int        
declare @horas_ordina int        
declare @cantidad_domingos int        
        
declare @horas_trab_feriados int        
declare @horas_trab_domingo int        
declare @horas_sobre_norm_25 int        
declare @horas_sobre_domingo_25 int        
declare @horas_sobre_feria_25 int        
        
declare @horas_sobre_norm_35 int        
declare @horas_sobre_domingo_35 int        
declare @horas_sobre_feria_35 int        
        
declare @doc_sunat int        
declare @nro_doc_iden varchar(20)        
        
declare C1 cursor         
for select distinct TDI.Codi_Sunat , P.nro_docu_iden ,  pe.CODI_PLAN_EMPL , pe.codi_pers        
 from Personal P(nolock)        
 inner join Tipo_Docu_Iden TDI (nolock)on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden         
 inner join planilla_de_empleados pe (nolock)on p.codi_pers=pe.codi_pers         
where pe.anio=@anio and pe.mes=@mes and pe.indi_tiem='M' and pe.codi_tipo_plan=@codi_plan         
        
open C1        
fetch C1 into @doc_sunat , @nro_doc_iden ,  @CODI_PLAN_EMPL , @codi_perso        
WHILE @@FETCH_STATUS = 0        
 begin        
           
  set @dias_trab   =0;         
  set @horas_ordina   =0;        
  set @horas_trab_domingo  =0;         
  set @horas_trab_feriados  =0;          
  set  @horas_sobre_norm_25 =0;        
  set  @horas_sobre_domingo_25 =0;        
  set  @horas_sobre_feria_25 =0;        
  set  @horas_sobre_norm_35 =0;        
  set  @horas_sobre_domingo_35 =0;        
  set  @horas_sobre_feria_35 =0;        
        
  insert into #personal_dias_horas_lab        
  (doc_sunat , nro_doc_iden ,  CODI_PLAN_EMPL , codi_pers , dias_trab , horas_ordina , horas_sobre )        
  values(@doc_sunat , @nro_doc_iden ,  @CODI_PLAN_EMPL , @codi_perso,0,0,0);        
        
  select @dias_trab = isnull(VALOR ,0) from PLANILLA_EMPLEADO_CONCEPTOS(nolock) where CODI_PLAN_EMPL=@CODI_PLAN_EMPL  and codi_conc='500000';        
  select @horas_ordina = isnull(VALOR ,0) from PLANILLA_EMPLEADO_CONCEPTOS(nolock) where CODI_PLAN_EMPL=@CODI_PLAN_EMPL and codi_conc='500010' ;        
        
  --horas sobretiempos        
  select @horas_trab_domingo  = isnull(VALOR ,0) from PLANILLA_EMPLEADO_CONCEPTOS(nolock) where CODI_PLAN_EMPL=@CODI_PLAN_EMPL and codi_conc='500011' ;          
  select @horas_trab_feriados  = isnull(VALOR ,0) from PLANILLA_EMPLEADO_CONCEPTOS (nolock)where CODI_PLAN_EMPL=@CODI_PLAN_EMPL and codi_conc='500012' ;            
        
  select @horas_sobre_norm_25  = isnull(VALOR ,0) from PLANILLA_EMPLEADO_CONCEPTOS (nolock)where CODI_PLAN_EMPL=@CODI_PLAN_EMPL and codi_conc='500020' ;        
  select @horas_sobre_domingo_25 = isnull(VALOR ,0) from PLANILLA_EMPLEADO_CONCEPTOS (nolock)where CODI_PLAN_EMPL=@CODI_PLAN_EMPL and codi_conc='500021';        
  select @horas_sobre_feria_25  = isnull(VALOR ,0) from PLANILLA_EMPLEADO_CONCEPTOS (nolock)where CODI_PLAN_EMPL=@CODI_PLAN_EMPL and codi_conc='500022';        
        
  select @horas_sobre_norm_35  = isnull(VALOR ,0) from PLANILLA_EMPLEADO_CONCEPTOS(nolock) where CODI_PLAN_EMPL=@CODI_PLAN_EMPL and codi_conc='500030';        
  select @horas_sobre_domingo_35 = isnull(VALOR ,0) from PLANILLA_EMPLEADO_CONCEPTOS(nolock) where CODI_PLAN_EMPL=@CODI_PLAN_EMPL and codi_conc='500031';        
  select @horas_sobre_feria_35  = isnull(VALOR ,0) from PLANILLA_EMPLEADO_CONCEPTOS (nolock)where CODI_PLAN_EMPL=@CODI_PLAN_EMPL and codi_conc='500032';        
             
  update  #personal_dias_horas_lab         
  set dias_trab=@dias_trab,  horas_ordina=@horas_ordina ,        
         horas_sobre=@horas_sobre_norm_25 +@horas_sobre_domingo_25 + @horas_trab_feriados + @horas_sobre_feria_25 +        
      @horas_sobre_norm_35 + @horas_sobre_domingo_35+@horas_sobre_feria_35 + @horas_trab_domingo        
  where CODI_PLAN_EMPL= @CODI_PLAN_EMPL;        
        
  fetch C1 into @doc_sunat , @nro_doc_iden ,  @CODI_PLAN_EMPL , @codi_perso        
 end        
        
close C1        
deallocate C1        
        
---- FIN DE PARA EMPLEADOS        
        
---- PARA LOS OBREROS        
declare C2 cursor         
for select distinct TDI.Codi_Sunat , P.nro_docu_iden ,  po.CODI_PLAN_OBRE , po.codi_pers        
 from Personal P(nolock)        
 inner join Tipo_Docu_Iden TDI (nolock)on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden         
 inner join planilla_de_obreros po(nolock) on p.codi_pers=po.codi_pers         
where po.anio=@anio and po.mes=@mes and po.indi_tiem='M' and po.codi_tipo_plan=@codi_plan         
        
open C2        
fetch C2 into @doc_sunat , @nro_doc_iden ,  @CODI_PLAN_EMPL , @codi_perso        
WHILE @@FETCH_STATUS = 0        
 begin        
        
  set @dias_trab  =0;         
  set @horas_ordina  =0;        
  set  @horas_trab_domingo =0;        
  set  @horas_sobre_norm_25 =0;   set @horas_trab_feriados =0;        
  set  @horas_sobre_domingo_25 =0;        
  set  @horas_sobre_feria_25 =0;        
  set  @horas_sobre_norm_35 =0;        
  set  @horas_sobre_domingo_35 =0;        
  set  @horas_sobre_feria_35 =0;        
        
  insert into #personal_dias_horas_lab        
  (doc_sunat , nro_doc_iden ,  CODI_PLAN_EMPL , codi_pers , dias_trab , horas_ordina , horas_sobre )        
  values(@doc_sunat , @nro_doc_iden ,  @CODI_PLAN_EMPL , @codi_perso,0,0,0);        
        
  select @dias_trab = isnull(VALOR ,0) from PLANILLA_obrero_CONCEPTOS(nolock) where CODI_PLAN_obre=@CODI_PLAN_EMPL  and codi_conc='500000';        
  select @horas_ordina = isnull(VALOR ,0) from PLANILLA_obrero_CONCEPTOS(nolock) where CODI_PLAN_obre=@CODI_PLAN_EMPL and codi_conc='500010' ;        
        
  --horas sobretiempos        
  select @horas_trab_domingo = isnull(VALOR ,0) from PLANILLA_Obrero_CONCEPTOS(nolock) where CODI_PLAN_Obre=@CODI_PLAN_EMPL and codi_conc='500011' ;          
  select @horas_trab_feriados = isnull(VALOR ,0) from PLANILLA_Obrero_CONCEPTOS(nolock) where CODI_PLAN_Obre=@CODI_PLAN_EMPL and codi_conc='500012' ;            
  select @horas_sobre_norm_25 = isnull(VALOR ,0) from PLANILLA_obrero_CONCEPTOS(nolock) where CODI_PLAN_obre=@CODI_PLAN_EMPL and codi_conc='500020' ;        
  select @horas_sobre_domingo_25 = isnull(VALOR ,0) from PLANILLA_obrero_CONCEPTOS(nolock) where CODI_PLAN_obre=@CODI_PLAN_EMPL and codi_conc='500021';        
  select @horas_sobre_feria_25 = isnull(VALOR ,0) from PLANILLA_obrero_CONCEPTOS(nolock) where CODI_PLAN_obre=@CODI_PLAN_EMPL and codi_conc='500022';        
        
  select @horas_sobre_norm_35 = isnull(VALOR ,0) from PLANILLA_obrero_CONCEPTOS (nolock)where CODI_PLAN_obre=@CODI_PLAN_EMPL and codi_conc='500030';        
  select @horas_sobre_domingo_35 = isnull(VALOR ,0) from PLANILLA_obrero_CONCEPTOS (nolock)where CODI_PLAN_obre=@CODI_PLAN_EMPL and codi_conc='500031';        
  select @horas_sobre_feria_35 = isnull(VALOR ,0) from PLANILLA_obrero_CONCEPTOS (nolock)where CODI_PLAN_obre=@CODI_PLAN_EMPL and codi_conc='500032';        
             
  update  #personal_dias_horas_lab         
  set dias_trab=@dias_trab,  horas_ordina=@horas_ordina ,        
         horas_sobre=@horas_sobre_norm_25 +@horas_sobre_domingo_25 + @horas_sobre_feria_25 + @horas_trab_feriados +        
      @horas_sobre_norm_35 + @horas_sobre_domingo_35+@horas_sobre_feria_35 + @horas_trab_domingo        
  where CODI_PLAN_EMPL= @CODI_PLAN_EMPL;        
        
  fetch C2 into @doc_sunat , @nro_doc_iden ,  @CODI_PLAN_EMPL , @codi_perso        
 end        
        
close C2        
deallocate C2        
        
---- FIN PARA LOS OBREROS         
        
        
---- PARA LOS OBREROS SEMANAL        
declare C21 cursor         
for select distinct TDI.Codi_Sunat , P.nro_docu_iden , po.codi_pers        
 from Personal P(nolock)        
 join personal_por_tipo_trabajador T (nolock) on P.codi_pers=T.codi_pers         
 inner join Tipo_Docu_Iden TDI (nolock)on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden         
 inner join planilla_de_obreros po(nolock) on p.codi_pers=po.codi_pers         
where po.anio=@anio and po.mes=@mes and po.indi_tiem='S'         
 and t.codi_tipo_pers<>'04'        
open C21        
fetch C21 into @doc_sunat , @nro_doc_iden , @codi_perso        
WHILE @@FETCH_STATUS = 0        
 begin        
        
  set @dias_trab   =0;         
  set @horas_ordina   =0;        
        
  set  @horas_trab_domingo  =0;        
  set  @horas_sobre_norm_25 =0;   set @horas_trab_feriados  =0;        
  set  @horas_sobre_domingo_25 =0;        
  set  @horas_sobre_feria_25 =0;        
  set  @horas_sobre_norm_35 =0;        
  set  @horas_sobre_domingo_35 =0;        
  set  @horas_sobre_feria_35 =0;        
        
        
  set @dias_trab = isnull((select isnull(sum(VALOR),0)         
     from PLANILLA_de_obreroS Po (nolock)         
     join PLANILLA_obrero_CONCEPTOS PC (nolock)         
     on PO.CODI_PLAN_obre= PC.CODI_PLAN_OBRE          
     where po.anio=@anio and po.mes=@mes and po.codi_pers=@codi_perso and codi_conc='500000'),0)         
        
  set @horas_ordina = isnull((select isnull(sum(VALOR) ,0)         
     from PLANILLA_de_obreroS Po (nolock)         
     join PLANILLA_obrero_CONCEPTOS PC (nolock)         
     on PO.CODI_PLAN_obre= PC.CODI_PLAN_OBRE          
     where po.anio=@anio and po.mes=@mes and po.codi_pers=@codi_perso and codi_conc ='500010' ),0)         
        
        
  set @horas_sobre_domingo_35 = isnull((select isnull(sum(VALOR) ,0)*8         
     from PLANILLA_de_obreroS Po (nolock)         
     join PLANILLA_obrero_CONCEPTOS PC (nolock)         
     on PO.CODI_PLAN_obre= PC.CODI_PLAN_OBRE          
     where po.anio=@anio and po.mes=@mes and po.codi_pers=@codi_perso and codi_conc ='500050' ),0)         
        
        
  set @horas_sobre_norm_25 = isnull((select isnull(sum(VALOR) ,0)         
     from PLANILLA_de_obreroS Po (nolock)         
     join PLANILLA_obrero_CONCEPTOS PC (nolock)         
     on PO.CODI_PLAN_obre= PC.CODI_PLAN_OBRE          
     where po.anio=@anio and po.mes=@mes and po.codi_pers=@codi_perso   and         
     codi_conc in ('500011','500012','500020','500021','500022','500030','500031','500032') ),0)         
        
        
  insert into #personal_dias_horas_lab        
   (doc_sunat , nro_doc_iden ,  codi_pers , dias_trab , horas_ordina , horas_sobre )        
  values(@doc_sunat , @nro_doc_iden ,  @codi_perso, @dias_trab , @horas_ordina +@horas_sobre_domingo_35, @horas_sobre_norm_25 )         
        
        
        
  fetch C21 into @doc_sunat , @nro_doc_iden  , @codi_perso        
 end        
        
close C21        
deallocate C21        
        
---- FIN PARA LOS OBREROS SEMANAL        
        
---************* CASO DE LOS TRIPULANTES --***************************        
create table #personal_no_pesca ( personal_datos char(5)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL )        
create table #personal_aux ( personal_datos char(5)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL , horas_ordina int null)        
        
declare @codi_pers char(5)        
declare @horas int         
        
------- REMUNERACIONES------------------        
declare C3 cursor FOR         
select distinct codi_pers from        
 (SELECT distinct p.codi_pers        
  FROM PERSONAL P(nolock) , PLANILLA_DE_TRIPULANTES PT(nolock)        
  WHERE (PT.CODI_PERS = P.CODI_PERS ) and   LEFT(PT.MESANIO,4) = @anio  AND   ( RIGHT(PT.MESANIO,2) =@mes ) AND  ( PT.CODI_TIPO_PLAN = '08' )         
 union all        
  SELECT DISTINCT p.codi_pers        
  FROM PERSONAL P(nolock) , planilla_boni_moto pb(nolock)        
  WHERE (PB.CODI_PERS = P.CODI_PERS ) and   RIGHT(PB.MESANIO,4) = @anio  AND   ( LEFT(PB.MESANIO,2) =@mes )         
 union all        
  SELECT  p.codi_pers        
  FROM PERSONAL P (nolock) , PLANILLA_SUBSIDIO PS(nolock)        
  WHERE ( PS.CODI_PERS = P.CODI_PERS ) and RIGHT(PS.MESANIO,4) = @anio  AND   ( LEFT(PS.MESANIO,2) =@mes ))  SQL        
        
        
OPEN C3        
fetch C3 into @codi_pers        
        
WHILE @@FETCH_STATUS = 0        
 begin        
  set @horas = dbo.F_DIAS_SALIDA(@anio,  @codi_pers , '1' , @mes )        
  if @horas>30 set @horas=30        
  set @horas = @horas * 8         
        
  insert into #personal_aux(personal_datos, horas_ordina)        
  values(@codi_pers,  @horas )        
        
  fetch C3 into @codi_pers        
 end         
        
close C3        
deallocate C3        
------- REMUNERACIONES------------------        
        
---RECUPERAMOS A TODOS AQUELLOS NO HAN PESCADO        
        
declare @mes_aux int        
declare @anio_aux int        
        
if @mes='12'         
begin        
 set @mes_aux=1         
 set @anio_aux=cast(@anio as int) + 1        
end        
else        
begin        
 set @mes_aux=cast(@mes as int) + 1         
 set @anio_aux= cast(@anio as int)        
end        
        
insert into #personal_no_pesca (personal_datos)        
SELECT DISTINCT p.CODI_PERS         
FROM PERSONAL P (nolock),  PERSONAL_POR_TIPO_TRABAJADOR PP (nolock)        
WHERE ( PP.CODI_PERS = P.CODI_PERS ) and pp.codi_tipo_pers='07' and p.esta_acti=1        
 and p.codi_pers  not in (select codi_pers from personal  (nolock)        
                 where esta_acti=1 and year(fech_ingre)=@anio_aux and month(fech_ingre)=@mes_aux)         
 and p.codi_pers  not in (select DISTINCT personal_datos FROM #personal_aux)        
 and p.codi_pers not in (select codi_pers from LICENCIAS_POR_PERSONAL L (nolock)        
     where month(L.fech_inic)=@mes  and year(L.fech_inic)=@anio )        
        
        
insert into #personal_no_pesca (personal_datos)         
SELECT DISTINCT p.CODI_PERS FROM PERSONAL P (nolock),  PERSONAL_POR_TIPO_TRABAJADOR PP (nolock)        
WHERE ( PP.CODI_PERS = P.CODI_PERS ) and pp.codi_tipo_pers='03' and p.esta_acti=1        
 and p.codi_pers not in (select codi_pers from personal  (nolock)        
                 where esta_acti=1 and year(fech_ingre)=@anio_aux and month(fech_ingre)=@mes_aux)         
 and p.codi_pers not in (select DISTINCT personal_datos FROM #personal_aux)        
 and p.codi_pers not in (select codi_pers from LICENCIAS_POR_PERSONAL L (nolock)        
     where month(L.fech_inic)=@mes  and year(L.fech_inic)=@anio )        
----        
        
----PERSONAL QUE PESCO        
        
select  (right('00'+cast(TDI.Codi_Sunat  as varchar(2)),2) + '|'+ cast( P.nro_docu_iden as varchar(15))   + '|' + cast(horas_ordina as varchar(3)) + '|0|0|0|' )  COLLATE SQL_Latin1_General_CP1_CI_AS        
from Personal P(nolock)        
 inner join Tipo_Docu_Iden TDI (nolock)on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden         
 inner join (select DISTINCT personal_datos , horas_ordina FROM #personal_AUX) pesca        
 on pesca.personal_datos = p.codi_pers        
        
union all        
        
----PERSONAL QUE NO PESCO        
select   ( right('00'+cast(TDI.Codi_Sunat as varchar(2)),2)  + '|'+ cast(P.nro_docu_iden as varchar(15))  + '|0|0|0|0|' )  COLLATE SQL_Latin1_General_CP1_CI_AS        
from Personal P(nolock)        
 inner join Tipo_Docu_Iden TDI(nolock) on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden         
 inner join (select DISTINCT personal_datos FROM #personal_no_pesca) pesca        
 on pesca.personal_datos = p.codi_pers        
        
union all        
        
select  ( right('00'+cast(doc_sunat as varchar(2)),2) + '|'+        
 cast(nro_doc_iden as varchar(15)) + '|' +        
 cast( horas_ordina as varchar(3)) + '|0|'+        
 cast(horas_sobre as varchar(3)) + '|0|' )  COLLATE SQL_Latin1_General_CP1_CI_AS -- as Personal_Jornada_laboral        
 from   #personal_dias_horas_lab     
         
drop table #personal_dias_horas_lab        
drop table #personal_aux        
drop table #personal_no_pesca
GO
