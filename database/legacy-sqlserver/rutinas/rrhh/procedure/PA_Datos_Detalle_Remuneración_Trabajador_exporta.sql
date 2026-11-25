CREATE PROCEDURE [dbo].[PA_Datos_Detalle_Remuneración_Trabajador_exporta]
	@anio [char](4),
	@mes [char](2),
	@tipo_plan [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4) , @mes char(2) , @tipo_plan char(2)  
--select @anio ='2009' , @mes ='07', @tipo_plan ='01'  
-- RECUPERAMOS A LOS DE QUINTA CATEGORIA  
set nocount on   
create table #personal_x_quinta_categ (CODI_TIPO_DOC_SUNAT varchar(2)  , nro_docu_iden varchar(15), codi_pers char(5) )  
  
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
  
declare @suma numeric(7,2)  
declare @codi_tipo_doc_sunat varchar(2)  
declare @nro_docu_iden varchar(15)  
declare @CODI_PLAN_EMPL varchar(10)  
declare @codi_pers char(5)  
  
----  RECUPERAMOS A TODOS QUE SEAN DE EMPLEADOS ---------------------  
  
declare C1 cursor FOR   
SELECT CAST( TDI.Codi_Sunat  AS varCHAR(2)), CAST (P.nro_docu_iden  AS varCHAR(15)), PE.CODI_PLAN_EMPL , p.codi_pers  
FROM dbo.PERSONAL P (nolock) , dbo.Tipo_Docu_Iden TDI (nolock) , dbo.PLANILLA_DE_EMPLEADOS PE (nolock)    
WHERE TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden AND   
 ( Pe.CODI_PERS = P.CODI_PERS ) and ( Pe.ANIO =@anio ) AND    
 ( Pe.MES = @mes) AND ( Pe.INDI_TIEM = 'M' )       
  
OPEN C1  
fetch C1 into @codi_tipo_doc_sunat , @nro_docu_iden , @CODI_PLAN_EMPL , @codi_pers  
  
WHILE @@FETCH_STATUS = 0  
 begin  
 set @suma=0  
 select @suma=isnull(sum(pec.valor),0) from dbo.PLANILLA_EMPLEADO_CONCEPTOS  pec (nolock)  
 join dbo.conceptos c (nolock)    
 on pec.codi_conc=c.codi_conc and  
  pec.codi_plan_empl=@CODI_PLAN_EMPL and (c.codi_sub_concep_sunat in ('605'))  
 group by c.codi_sub_concep_sunat  
  
 if @suma=0  
   begin  
  insert into #personal_x_quinta_categ(CODI_TIPO_DOC_SUNAT  , nro_docu_iden , codi_pers )  
  values(@CODI_TIPO_DOC_SUNAT , @nro_docu_iden , @codi_pers)    
   end  
  fetch C1 into @codi_tipo_doc_sunat , @nro_docu_iden , @CODI_PLAN_EMPL , @codi_pers  
 end   
  
close C1  
deallocate C1  
  
-----------OBREROS--------------------------------------------   
SET @codi_tipo_doc_sunat=''  
SET @nro_docu_iden=''  
SET @CODI_PLAN_EMPL=''  
  
declare C2 cursor FOR   
SELECT   CAST( TDI.Codi_Sunat  AS varCHAR(2)) , CAST (  P.nro_docu_iden  AS varCHAR(15))  , PO.CODI_PLAN_obre , p.codi_pers  
FROM dbo.PERSONAL P (nolock) , dbo.Tipo_Docu_Iden TDI (nolock) ,    
 dbo.PLANILLA_DE_OBREROS PO (nolock)  
WHERE TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden AND   
 ( PO.CODI_PERS = P.CODI_PERS ) and ( PO.ANIO =@anio ) AND    
 ( PO.MES = @mes) AND ( PO.INDI_TIEM = 'M' )       
  
OPEN C2  
fetch C2 into @codi_tipo_doc_sunat , @nro_docu_iden , @CODI_PLAN_EMPL , @codi_pers  
  
WHILE @@FETCH_STATUS = 0  
 begin  
 set @suma=0  
 select @suma=isnull(sum(poc.valor),0) from dbo.PLANILLA_OBRERO_CONCEPTOS poc (nolock)  
  join dbo.conceptos c (nolock)    
 on poc.codi_conc=c.codi_conc and  
  poc.codi_plan_obre=@CODI_PLAN_EMPL and (c.codi_sub_concep_sunat in ('605'))  
 group by c.codi_sub_concep_sunat  
  
 if @suma=0  
   begin  
  insert into #personal_x_quinta_categ(CODI_TIPO_DOC_SUNAT  , nro_docu_iden , codi_pers)  
  values(@CODI_TIPO_DOC_SUNAT , @nro_docu_iden , @codi_pers)    
   end  
  fetch C2 into @codi_tipo_doc_sunat , @nro_docu_iden , @CODI_PLAN_EMPL , @codi_pers  
 end   
  
close C2  
deallocate C2  
  
------------  FIN DE QUINTA CATEGORIA PARA EMPLEADOS Y OBREROS -------------------  
SELECT distinct  (CODI_TIPO_DOC_SUNAT+ '|'+  cast ( nro_docu_iden as varchar(15))+ '|605|0|0|')  COLLATE SQL_Latin1_General_CP1_CI_AS  
FROM #personal_x_quinta_categ  
  
UNION ALL  
---ESTO DEBE SER DE PLANILLAS DE EMPLEADOS Y DE OBREROS  
---CASO DE EMPLEADOS-------------  
---REMUNERACIONES Y OTROS NORMAL  
select c1 +   c2 + '|'+  cast(sum(c3) as varchar(12)) + '|'+  cast(sum(c4) as varchar(12))+ '|'  
  
from (  
 SELECT  cast (TDI.Codi_Sunat as varchar(2))+ '|'+ P.nro_docu_iden + '|' as c1,  
 cast( cs.Codi_Sub_Concep as varchar(4)) as c2,   
 sum(PLANILLA_EMPLEADO_CONCEPTOS.VALOR)  as c3,  
 sum(PLANILLA_EMPLEADO_CONCEPTOS.VALOR) as c4  
    FROM dbo.PERSONAL P (nolock) , dbo.Tipo_Docu_Iden TDI (nolock), dbo.PLANILLA_DE_EMPLEADOS (nolock),     
 dbo.PLANILLA_EMPLEADO_CONCEPTOS (nolock) , dbo.PERSONAL_POR_TIPO_TRABAJADOR (nolock), dbo.conceptos (nolock),   
 dbo.sub_concepto_sunat CS (nolock)  
   WHERE TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden AND   
 ( PLANILLA_DE_EMPLEADOS.CODI_PERS = P.CODI_PERS ) and    
 ( PLANILLA_EMPLEADO_CONCEPTOS.CODI_PLAN_EMPL = PLANILLA_DE_EMPLEADOS.CODI_PLAN_EMPL ) and    
 ( PLANILLA_DE_EMPLEADOS.CODI_PERS = PERSONAL_POR_TIPO_TRABAJADOR.CODI_PERS )  and    
 ( CONCEPTOS.CODI_CONC=PLANILLA_EMPLEADO_CONCEPTOS.CODI_CONC) AND  
 ( CONCEPTOS.Codi_Sub_Concep_Sunat=CS.CODI_SUB_CONCEP) AND  
 ( ( PLANILLA_DE_EMPLEADOS.ANIO =@anio ) AND    
  ( PLANILLA_DE_EMPLEADOS.MES = @mes) AND    
 ( PLANILLA_DE_EMPLEADOS.CODI_TIPO_PLAN in  ( '01',  '04' ) ) AND    
 ( PLANILLA_DE_EMPLEADOS.INDI_TIEM = 'M' ) )      
 and   PLANILLA_EMPLEADO_CONCEPTOS.CODI_CONC not in ('999990')   
 and cs.Codi_Sub_Concep not in ('603','604','607','610','802','808' ,'806','804')  
group by TDI.Codi_Sunat , P.nro_docu_iden , cs.Codi_Sub_Concep  
--FIN DE REMUNERACIONES Y OTROS  
----------------GRatificaciones y truncos  
UNION ALL  
 SELECT cast (TDI.Codi_Sunat as varchar(2))+ '|'+ P.nro_docu_iden + '|' as c1,  
 cast( cs.Codi_Sub_Concep as varchar(4)) as c2,  
 sum(SQL.VALOR)  as C3,  
 sum(SQL.VALOR)  as C4   
    FROM PERSONAL P (nolock) ,            
 Tipo_Docu_Iden TDI (nolock),  
 PERSONAL_POR_TIPO_TRABAJADOR (nolock),  
 conceptos (nolock),  
 sub_concepto_sunat CS (nolock),  
 (select Pe.codi_plan_empl , pe.codi_pers,   
  case when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='02' then '100160'   
   when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='12' then '100161'   
   else D.codi_conc end codi_conc , sum(valor) valor   
 FROM  PLANILLA_DE_EMPLEADOS PE (nolock),     
        PLANILLA_EMPLEADO_CONCEPTOS D (nolock),  
  conceptos (nolock),  
  sub_concepto_sunat CS (nolock)  
   WHERE PE.CODI_PLAN_EMPL = D.CODI_PLAN_EMPL and  
  ( CONCEPTOS.CODI_CONC=D.CODI_CONC) AND  
  ( CONCEPTOS.Codi_Sub_Concep_Sunat=CS.CODI_SUB_CONCEP) AND  
  PE.ANIO =@anio  AND    
         PE.MES = @mes AND    
  PE.CODI_TIPO_PLAN in  ( '02',  '12')  AND    
         PE.INDI_TIEM = 'M'    and     
  D.CODI_CONC not in ('999990')  and   
  cs.Codi_Sub_Concep not in ('603','604','607','610','802','808' ,'806','804')   
  group by pe.codi_plan_empl, pe.codi_pers,  
   case when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='02' then '100160'  
   when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='12' then '100161'  
   else D.codi_conc end ) SQL  
 where TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden AND   
 ( SQL.CODI_PERS = P.CODI_PERS ) and    
 ( SQL.CODI_PERS = PERSONAL_POR_TIPO_TRABAJADOR.CODI_PERS )  and   
 ( CONCEPTOS.CODI_CONC=SQL.CODI_CONC) AND  
 ( CONCEPTOS.Codi_Sub_Concep_Sunat=CS.CODI_SUB_CONCEP)   
 group by TDI.Codi_Sunat , P.nro_docu_iden , cs.Codi_Sub_Concep  
--- FIN DE GRATIFICACIONES TRUNCAS  
UNION ALL  
--VACACIONES y truncos --  
 SELECT cast (TDI.Codi_Sunat as varchar(2))+ '|'+ P.nro_docu_iden + '|' as c1,  
 cast( cs.Codi_Sub_Concep as varchar(4)) as c2,  
 sum(SQL.VALOR)  as C3,  
 sum(SQL.VALOR)  as C4   
    FROM PERSONAL P (nolock) ,            
 Tipo_Docu_Iden TDI (nolock),  
 PERSONAL_POR_TIPO_TRABAJADOR (nolock),  
 conceptos (nolock),  
 sub_concepto_sunat CS (nolock),  
 (select Pe.codi_plan_empl , pe.codi_pers,   
  case when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='03' then '100170'   
   when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='11' then '100171'   
   else D.codi_conc end codi_conc , sum(valor) valor   
 FROM  PLANILLA_DE_EMPLEADOS PE (nolock),     
        PLANILLA_EMPLEADO_CONCEPTOS D (nolock),  
  conceptos (nolock),  
  sub_concepto_sunat CS (nolock)  
   WHERE PE.CODI_PLAN_EMPL = D.CODI_PLAN_EMPL and  
  ( CONCEPTOS.CODI_CONC=D.CODI_CONC) AND  
  ( CONCEPTOS.Codi_Sub_Concep_Sunat=CS.CODI_SUB_CONCEP) AND  
  PE.ANIO =@anio  AND    
         PE.MES = @mes AND    
  PE.CODI_TIPO_PLAN in  ( '03',  '11')  AND    
         PE.INDI_TIEM = 'M'    and     
  D.CODI_CONC not in ('999990')  and   
  cs.Codi_Sub_Concep not in ('603','604','607','610','802','808' ,'806','804')   
  group by pe.codi_plan_empl, pe.codi_pers,  
   case when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='03' then '100170'  
   when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='11' then '100171'  
   else D.codi_conc end ) SQL  
 where TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden AND   
 ( SQL.CODI_PERS = P.CODI_PERS ) and    
 ( SQL.CODI_PERS = PERSONAL_POR_TIPO_TRABAJADOR.CODI_PERS )  and   
 ( CONCEPTOS.CODI_CONC=SQL.CODI_CONC) AND  
 ( CONCEPTOS.Codi_Sub_Concep_Sunat=CS.CODI_SUB_CONCEP)   
 group by TDI.Codi_Sunat , P.nro_docu_iden , cs.Codi_Sub_Concep  
  
---- * * * * *  * * *--------- FIN DE EMPLEADOS - * * * * * ** * * - -  
UNION ALL  
-- * * ** * * * * * * ** * * * ---  CASO DE PLANILLAS DE OBREROS -- * * * * * * * * * * * * * * ---  
--- REMUNERACIONES Y OTROS ----------  
SELECT  cast (TDI.Codi_Sunat as varchar(2))+ '|'+ P.nro_docu_iden + '|' as c1,   
 cast( cs.Codi_Sub_Concep as varchar(4)) as c2,   
 sum(PLANILLA_OBRERO_CONCEPTOS.VALOR) as c3 ,   
 sum(PLANILLA_OBRERO_CONCEPTOS.VALOR) as c4  
   FROM dbo.PERSONAL P (nolock) , dbo.Tipo_Docu_Iden TDI (nolock) , dbo.PLANILLA_DE_OBREROS (nolock) ,     
  dbo.PLANILLA_OBRERO_CONCEPTOS (nolock) , dbo.PERSONAL_POR_TIPO_TRABAJADOR (nolock) ,   
  dbo.conceptos (nolock) , dbo.sub_concepto_sunat CS (nolock)   
   WHERE TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden AND   
  ( PLANILLA_DE_OBREROS.CODI_PERS = P.CODI_PERS ) and    
  ( PLANILLA_OBRERO_CONCEPTOS.CODI_PLAN_OBRE = PLANILLA_DE_OBREROS.CODI_PLAN_OBRE ) and    
  ( PLANILLA_DE_OBREROS.CODI_PERS = PERSONAL_POR_TIPO_TRABAJADOR.CODI_PERS )  and    
  ( CONCEPTOS.CODI_CONC=PLANILLA_Obrero_CONCEPTOS.CODI_CONC) AND  
  ( CONCEPTOS.Codi_Sub_Concep_Sunat=CS.CODI_SUB_CONCEP)AND  
  ( PLANILLA_DE_ObreroS.ANIO = @anio ) AND    
  ( PLANILLA_DE_ObreroS.MES  = @MES ) AND    
  ( PLANILLA_DE_ObreroS.CODI_TIPO_PLAN  in  ( '01', '04' ) ) AND         
  ( PLANILLA_DE_ObreroS.INDI_TIEM = 'M' )       
 and   PLANILLA_obrero_CONCEPTOS.CODI_CONC not in ('999990')   
 and cs.Codi_Sub_Concep not in ('603','604','607','610','802','808' ,'806','804')  
-- and left(conceptos.codi_conc,3)<>'100'  
 group by TDI.Codi_Sunat , P.nro_docu_iden ,  cs.Codi_Sub_Concep  
---FIN DE REMUNERACIONES---  
union all ---------------------- Se une las gratificaciones de obreros  
 SELECT cast (TDI.Codi_Sunat as varchar(2))+ '|'+ P.nro_docu_iden + '|' as c1,  
 cast( cs.Codi_Sub_Concep as varchar(4)) as c2,  
 sum(SQL.VALOR)  as C3,  
 sum(SQL.VALOR)  as C4   
     FROM PERSONAL P (nolock) ,            
 Tipo_Docu_Iden TDI (nolock),  
 PERSONAL_POR_TIPO_TRABAJADOR (nolock),  
 conceptos (nolock),  
 sub_concepto_sunat CS (nolock),  
 (select Pe.CODI_PLAN_OBRE , pe.codi_pers,   
  case when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='02' then '100160'  
   when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='12' then '100161'  
    else D.codi_conc end codi_conc ,   
   sum(valor) valor   
 FROM  PLANILLA_DE_OBREROS PE (nolock),     
        PLANILLA_OBRERO_CONCEPTOS D (nolock),  
  conceptos (nolock),  
  sub_concepto_sunat CS (nolock)  
   WHERE PE.CODI_PLAN_OBRE = D.CODI_PLAN_OBRE and  
  ( CONCEPTOS.CODI_CONC=D.CODI_CONC) AND  
  ( CONCEPTOS.Codi_Sub_Concep_Sunat=CS.CODI_SUB_CONCEP) AND  
  PE.ANIO =@anio  AND    
         PE.MES = @mes AND    
  PE.CODI_TIPO_PLAN in  ( '02',  '12')  AND    
         PE.INDI_TIEM = 'M'    and     
  D.CODI_CONC not in ('999990')  and   
  cs.Codi_Sub_Concep not in ('603','604','607','610','802','808' ,'806','804')   
  group by pe.CODI_PLAN_OBRE, pe.codi_pers,   
  case when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='02' then '100160'   
   when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='12' then '100161'   
   else D.codi_conc end ) SQL  
 where TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden AND   
 ( SQL.CODI_PERS = P.CODI_PERS ) and    
 ( SQL.CODI_PERS = PERSONAL_POR_TIPO_TRABAJADOR.CODI_PERS )  and   
 ( CONCEPTOS.CODI_CONC=SQL.CODI_CONC) AND  
 ( CONCEPTOS.Codi_Sub_Concep_Sunat=CS.CODI_SUB_CONCEP)   
 group by TDI.Codi_Sunat , P.nro_docu_iden , cs.Codi_Sub_Concep  
union all  
--- VACACIONES y truncos obreros----------  
 SELECT cast (TDI.Codi_Sunat as varchar(2))+ '|'+ P.nro_docu_iden + '|' as c1,  
 cast( cs.Codi_Sub_Concep as varchar(4)) as c2,  
 sum(SQL.VALOR)  as C3,  
 sum(SQL.VALOR)  as C4   
     FROM PERSONAL P (nolock) ,            
 Tipo_Docu_Iden TDI (nolock),  
 PERSONAL_POR_TIPO_TRABAJADOR (nolock),  
 conceptos (nolock),  
 sub_concepto_sunat CS (nolock),  
 (select Pe.CODI_PLAN_OBRE , pe.codi_pers,   
  case when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='03' then '100170'  
   when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='11' then '100171'  
    else D.codi_conc end codi_conc ,   
   sum(valor) valor   
 FROM  PLANILLA_DE_OBREROS PE (nolock),     
        PLANILLA_OBRERO_CONCEPTOS D (nolock),  
  conceptos (nolock),  
  sub_concepto_sunat CS (nolock)  
   WHERE PE.CODI_PLAN_OBRE = D.CODI_PLAN_OBRE and  
  ( CONCEPTOS.CODI_CONC=D.CODI_CONC) AND  
  ( CONCEPTOS.Codi_Sub_Concep_Sunat=CS.CODI_SUB_CONCEP) AND  
  PE.ANIO =@anio  AND    
         PE.MES = @mes AND    
  PE.CODI_TIPO_PLAN in  ( '03',  '11')  AND    
         PE.INDI_TIEM = 'M'    and     
  D.CODI_CONC not in ('999990')  and   
  cs.Codi_Sub_Concep not in ('603','604','607','610','802','808' ,'806','804')   
  group by pe.CODI_PLAN_OBRE, pe.codi_pers,   
  case when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='03' then '100170'   
   when left(conceptos.codi_conc,3)='100' and codi_tipo_plan='11' then '100171'   
   else D.codi_conc end ) SQL  
 where TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden AND   
 ( SQL.CODI_PERS = P.CODI_PERS ) and    
 ( SQL.CODI_PERS = PERSONAL_POR_TIPO_TRABAJADOR.CODI_PERS )  and   
 ( CONCEPTOS.CODI_CONC=SQL.CODI_CONC) AND  
 ( CONCEPTOS.Codi_Sub_Concep_Sunat=CS.CODI_SUB_CONCEP)   
 group by TDI.Codi_Sunat , P.nro_docu_iden , cs.Codi_Sub_Concep  
 ) as R  
  
group by c1, c2  
-- * * * * * ** * * * *  - FIN DE OBREROS - * * * * ** * * * * * ----  
  
drop table  #personal_x_quinta_categ
GO
