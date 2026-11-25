CREATE FUNCTION [dbo].[f_grat_neto_pers](@Codi [char](5), @SI [char](8), @SF [char](8))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	DECLARE @RT numeric(12,2)
	set @rt =( select sum(tot) from 
(select 1 Id, sum(case when codi_conc='300034' then valor else 0 end) as tot
	from planilla_de_tripulantes as Pt,planilla_tripulante_conceptos PC
	where PT.codi_plan_trip=Pc.codi_plan_trip and (codi_conc='199998' or  codi_conc='300034') and 
		codi_pers=@codi and (codi_sema>=@si and codi_sema<=@sf)
union ALL
select 2, -1*(case when  tipo_desc =0 then mont_desc/100*(select  sum(case when codi_conc='300034' then valor else 0 end) as tot
	from planilla_de_tripulantes as Pt,planilla_tripulante_conceptos PC
	where PT.codi_plan_trip=Pc.codi_plan_trip and (codi_conc='199998' or  codi_conc='300034') and 
		codi_pers=juicios.codi_pers and (codi_sema>=@si and codi_sema<=@sf )) else mont_desc end) as Monto
	from juicios where codi_pers=@codi and esta_acti='1' ) as S )


	RETURN @rt
END
GO
