CREATE PROCEDURE [dbo].[usp_reporte_remun_plan]
	@Anio1 [int],
	@mes1 [int],
	@anio2 [int],
	@mes2 [int],
	@Tipo [char](2)
WITH EXECUTE AS CALLER
AS
--declare @Anio1 int ,@mes1 int, @anio2 int , @mes2 int , @Tipo char(2)--, @bco char(2)    
--select @anio1=2011 , @mes1=11, @anio2=2012, @mes2=4, @Tipo='01'    
    
set nocount on     
    
declare @ms int     
    
declare @tx table (anio int , mes int )    
if @anio1 = @anio2    
begin    
 set @ms=@mes1    
 while @ms<=@mes2    
 begin    
  insert @Tx     
  select @anio1, @ms    
  set @ms = @ms+1    
 end    
end    
else    
begin    
 ---------------- primero terminamos el año 1    
 set @ms=@mes1    
 while @ms<=12    
 begin    
  insert @Tx     
  select @anio1, @ms    
  set @ms = @ms+1      
 end    
    
 --------------- terminamos con el año 2    
 set @ms=1    
 while @ms<=@mes2    
 begin    
  insert @Tx     
  select @anio2, @ms    
  set @ms = @ms+1      
 end    
    
end    
    
  
if @Tipo='01'    
    
 select A.anio, CASE (A.mes) WHEN '01' THEN '01-ENERO'  
    WHEN '02' THEN '02-FEBRERO'  
    WHEN '03' THEN '03-MARZO'  
    WHEN '04' THEN '04-ABRIL'  
    WHEN '05' THEN '05-MAYO'  
    WHEN '06' THEN '06-JUNIO'  
    WHEN '07' THEN '07-JULIO'  
    WHEN '08' THEN '08-AGOSTO'  
    WHEN '09' THEN '09-SEPTIEMBRE'  
    WHEN '10' THEN '10-OCTUBRE'  
    WHEN '11' THEN '11-NOVIEMBRE'  
    WHEN '12' THEN '12-DICIEMBRE'  
END  
, A.codi_pers, nro_docu_iden, apel_1 + isnull(' ' +apel_2,'')+ isnull( ' ' + nomb_1, '' )+     
   isnull( ' ' + nomb_2, '' ) Nombres ,     
   (select top 1 nro_cta_Cte from cta_cte_personal Z (nolock)where Z.tipo_cta_Cte='01' and z.codi_pers=A.codi_pers) Cta,    
   (select top 1 codi_mone from cta_cte_personal Z (nolock)where Z.tipo_cta_Cte='01' and z.codi_pers=A.codi_pers) Moneda,    
   valor,    
   /*(select desc_banc from bancos B(nolock) where B.codi_banc in*/    
    (select top 1 codi_banc from cta_cte_personal Z (nolock) where Z.tipo_cta_Cte='01' and z.codi_pers=A.codi_pers) Banco    
 from planilla_de_empleados A (nolock)    
 join planilla_empleado_conceptos B (nolock)    
 on A.codi_plan_Empl= B.codi_plan_empl    
 join @TX C    
 on A.anio=C.anio and A.mes=C.mes    
 join personal D    
 on A.codi_pers=D.codi_pers    
 where codi_tipo_plan in ('01','03') and indi_tiem='M' and     
   codi_conc='199998' and d.esta_acti='1'    
 order by A.anio, A.mes, 5    
    
if @Tipo='02'    
 select A.anio, CASE (A.mes) WHEN '01' THEN '01-ENERO'  
    WHEN '02' THEN '02-FEBRERO' 
    WHEN '03' THEN '03-MARZO'  
    WHEN '04' THEN '04-ABRIL'  
    WHEN '05' THEN '05-MAYO'  
    WHEN '06' THEN '06-JUNIO'  
    WHEN '07' THEN '07-JULIO'  
    WHEN '08' THEN '08-AGOSTO'  
    WHEN '09' THEN '09-SEPTIEMBRE'  
    WHEN '10' THEN '10-OCTUBRE'  
    WHEN '11' THEN '11-NOVIEMBRE'  
    WHEN '12' THEN '12-DICIEMBRE'  
END , A.codi_pers, nro_docu_iden, apel_1 + isnull(' ' +apel_2,'')+ isnull( ' ' + nomb_1, '' )+     
   isnull( ' ' + nomb_2, '' ) Nombres ,     
   (select top 1 nro_cta_Cte from cta_cte_personal Z (nolock)where Z.tipo_cta_Cte='01' and z.codi_pers=A.codi_pers) Cta,    
   (select top 1 codi_mone from cta_cte_personal Z (nolock)where Z.tipo_cta_Cte='01' and z.codi_pers=A.codi_pers) Moneda,    
   valor,    
   /*(select desc_banc from bancos B(nolock) where B.codi_banc in*/    
    (select top 1 codi_banc from cta_cte_personal Z (nolock) where Z.tipo_cta_Cte='01' and z.codi_pers=A.codi_pers)  Banco    
 from planilla_de_obreros A (nolock)    
 join planilla_obrero_conceptos B (nolock)    
 on A.codi_plan_obre= B.codi_plan_obre    
 join @TX C    
 on A.anio=C.anio and A.mes=C.mes    
 join personal D    
 on A.codi_pers=D.codi_pers    
 where codi_tipo_plan in ('01','03') and indi_tiem='M' and     
   codi_conc='199998' and d.esta_acti='1'    
 order by A.anio, A.mes, 5
GO
