create view [dbo].[v_planilla_conceptos] 
as 
select anio, mes, CODI_PERS,
		(select apel_1+ ISNULL(' ' +apel_2,'') + ISNULL(' ' +nomb_1,'')+ ISNULL(' ' +nomb_2,'')
			from personal P where p.CODI_PERS=A.CODI_PERS) as Nombres,
			CODI_CONC, 
			(select desc_conc from CONCEPTOS C where c.CODI_CONC=B.CODI_CONC) As Concepto,
			valor
from PLANILLA_DE_EMPLEADOS A
join PLANILLA_EMPLEADO_CONCEPTOS B
on A.CODI_PLAN_EMPL=B.CODI_PLAN_EMPL
where A.ANIO in ('2014','2015') and LEFT(codi_conc,1) in ('1','2','3')
GO
