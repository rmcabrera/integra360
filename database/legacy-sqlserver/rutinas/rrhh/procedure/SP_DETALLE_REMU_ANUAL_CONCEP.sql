CREATE PROCEDURE [dbo].[SP_DETALLE_REMU_ANUAL_CONCEP]
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
Begin

	select codi_conc, (select desc_conc from conceptos c  where c.codi_conc=Ms.codi_conc ),
		 sum(Enero) as Enero, Sum(febrero) as Febrero, sum (marzo) Marzo, sum(abril) as Abril,
		sum(mayo) as Mayo, Sum(junio) as Junio, sum (julio) Julio, sum(agosto) as Agosto,
		sum(setiembre) as Setiembre, Sum(octubre) as Octubre, sum (noviembre) Noviembre, sum(diciembre) as Diciembre
	from
	( select codi_conc, case when mes ='01' then sum(mont) else 0 end as Enero,
		case when mes ='02' then sum(mont) else 0 end  as Febrero,
		case when mes ='03' then sum(mont) else 0 end  as Marzo,
		case when mes ='04' then sum(mont) else 0 end  as Abril,
		case when mes ='05' then sum(mont) else 0 end  as Mayo,
		case when mes ='06' then sum(mont) else 0 end  as junio,
		case when mes ='07' then sum(mont) else 0 end  as Julio,
		case when mes ='08' then sum(mont) else 0 end  as Agosto,
		case when mes ='09' then sum(mont) else 0 end  as Setiembre,
		case when mes ='10' then sum(mont) else 0 end  as Octubre,
		case when mes ='11' then sum(mont) else 0 end  as Noviembre,
		case when mes ='12' then sum(mont) else 0 end  as Diciembre
	from 
	(
	select 2 id, right(mesanio,2) mes , codi_conc, isnull(sum(valor),0) mont  from planilla_boni_moto , planilla_boni_concepto
			where planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni and  left(mesanio,4)=@anio
			and left(codi_conc,1) in ( '1', '3') and tipo='M' group by codi_conc, right(mesanio,2)
	union
	select  3,right(mesanio,2), codi_conc, isnull(sum(valor),0)  from planilla_subsidio , planilla_subs_concepto
				where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs and  left(mesanio,4)=@anio
				and left(codi_conc,1) in ( '1', '3') group by codi_conc, right(mesanio,2)
	union
	select  5,right(mesanio,2), codi_conc, isnull(sum(valor),0) from planilla_de_tripulantes , planilla_tripulante_conceptos
			where  planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip and left(planilla_de_tripulantes.mesanio,4)=@anio
			and left(codi_conc,1) in ( '1', '3') group by codi_conc,right(mesanio,2)  )as S 
		 group by codi_conc, Mes ) as Ms group by codi_conc


End
GO
