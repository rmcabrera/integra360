CREATE PROCEDURE [dbo].[PA_Personal_Jornada_laboral_por_trabajador_Exporta]
	@anio [char](4),
	@mes [char](2),
	@codi_plan [char](2)
WITH EXECUTE AS CALLER
AS
set nocount on 
--- PARA EMPLEADOS ------
create table #personal_dias_horas_lab
 (doc_sunat int , nro_doc_iden varchar(20) , CODI_PLAN_EMPL char(10) , codi_pers varchar(5), dias_trab int , horas_ordina int , horas_sobre int)

insert into #personal_dias_horas_lab (doc_sunat , nro_doc_iden ,  CODI_PLAN_EMPL , codi_pers , dias_trab , horas_ordina , horas_sobre )
select distinct TDI.Codi_Sunat , P.nro_docu_iden ,  pe.CODI_PLAN_EMPL , pe.codi_pers,
	isnull((select sum(VALOR) from dbo.PLANILLA_EMPLEADO_CONCEPTOS D (nolock) where D.CODI_PLAN_EMPL=pe.CODI_PLAN_EMPL  and codi_conc='500000' ),0),
	isnull((select sum(VALOR) from dbo.PLANILLA_EMPLEADO_CONCEPTOS D (nolock) where D.CODI_PLAN_EMPL=pe.CODI_PLAN_EMPL  and codi_conc='500010' ),0),
	isnull((select sum(VALOR) from dbo.PLANILLA_EMPLEADO_CONCEPTOS D (nolock) 
		where D.CODI_PLAN_EMPL=pe.CODI_PLAN_EMPL  and codi_conc in ('500011','500020','500021','500022','500030','500031','500032') ),0)
 from dbo.Personal P (nolock)
	join dbo.Tipo_Docu_Iden TDI (nolock) on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden 
	join dbo.planilla_de_empleados pe (nolock)on p.codi_pers=pe.codi_pers 
where pe.anio=@anio and pe.mes=@mes and pe.indi_tiem='M' and pe.codi_tipo_plan=@codi_plan -- and p.esta_acti=1		

---- FIN DE PARA EMPLEADOS

---- PARA LOS OBREROS
insert into #personal_dias_horas_lab (doc_sunat , nro_doc_iden ,  CODI_PLAN_EMPL , codi_pers , dias_trab , horas_ordina , horas_sobre )
select distinct TDI.Codi_Sunat , P.nro_docu_iden ,  po.CODI_PLAN_OBRE , po.codi_pers,
	isnull((select sum(VALOR) from dbo.PLANILLA_obrero_CONCEPTOS D (nolock) where D.CODI_PLAN_obre=po.CODI_PLAN_OBRE  and codi_conc='500000' ),0),
	isnull((select sum(VALOR) from dbo.PLANILLA_obrero_CONCEPTOS D (nolock) where D.CODI_PLAN_obre=po.CODI_PLAN_OBRE  and codi_conc='500010' ),0),
	isnull((select sum(VALOR) from dbo.PLANILLA_obrero_CONCEPTOS D (nolock) 
		where D.CODI_PLAN_obre=po.CODI_PLAN_OBRE  and codi_conc in ('500011','500020','500021','500022','500030','500031','500032') ),0)
from dbo.Personal P (nolock)
	join dbo.Tipo_Docu_Iden TDI (nolock) on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden 
	join dbo.planilla_de_obreros po (nolock) on p.codi_pers=po.codi_pers 
where po.anio=@anio and po.mes=@mes and po.indi_tiem='M' and po.codi_tipo_plan=@codi_plan -- and p.esta_acti=1

---- FIN PARA LOS OBREROS 

select 	cast(doc_sunat as varchar(2)) + '|'+
	cast(nro_doc_iden as varchar(15)) + '|' +
	cast( horas_ordina as varchar(3)) + '|0|'+
	cast(horas_sobre as varchar(3)) + '|0|' as Personal_Jornada_laboral
 from   #personal_dias_horas_lab

drop table #personal_dias_horas_lab
GO
