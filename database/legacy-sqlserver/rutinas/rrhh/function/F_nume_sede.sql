CREATE FUNCTION [dbo].[F_nume_sede](@anio [char](4), @mes [char](2), @codi_pers [char](5))
RETURNS [numeric](5, 0) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @nume_sede numeric(5,0)
	Declare @cont_1 numeric(5,0)
	Declare @cont_2 numeric(5,0)
	Declare @cont_3 numeric(5,0)
	Declare @cont_4 numeric(5,0)
	Declare @cont_auxi numeric(5,0)
	
	set @nume_sede = 0
	set @cont_1 = 0
	set @cont_2 = 0
	set @cont_3 = 0
	set @cont_4 = 0

	SELECT @cont_1 = isnull( count( distinct pc.codi_conc)  , 0)
	From planilla_de_empleados pl, planilla_empleado_conceptos PC
	where pl.codi_plan_empl = pc.codi_plan_empl and pl.indi_tiem = 'M' and pl.mes = @mes and pl.anio = @anio and pl.codi_pers = @codi_pers
		and ( pc.codi_conc = '300020' or pc.codi_conc = '300021') 

	SELECT @cont_2 = isnull( count( distinct pc.codi_conc)  , 0)
	From planilla_de_obreros pl, planilla_obrero_conceptos PC
	where pl.codi_plan_obre = pc.codi_plan_obre and pl.indi_tiem = 'M' and pl.mes = @mes and pl.anio = @anio and pl.codi_pers = @codi_pers
		and ( pc.codi_conc = '300020' or pc.codi_conc = '300021') 

	SELECT @cont_3 = isnull( count( distinct pc.codi_conc)  , 0)
	From planilla_de_tripulantes pl, planilla_tripulante_conceptos PC
	where pl.codi_plan_trip = pc.codi_plan_trip and substring( pl.mesanio , 5,2 ) = @mes and substring( pl.mesanio ,1,4) = @anio and pl.codi_pers = @codi_pers
		and ( pc.codi_conc = '300020' or pc.codi_conc = '300021') 

	SELECT @cont_4 = isnull( count( distinct pc.codi_conc)  , 0)
	From planilla_boni_moto pl, planilla_boni_concepto PC
	where pl.codi_plan_boni = pc.codi_plan_boni and substring( pl.mesanio , 1,2 ) = @mes and substring( pl.mesanio ,3,4) = @anio and pl.codi_pers = @codi_pers
		and ( pc.codi_conc = '300020' or pc.codi_conc = '300021') 
	
	if @cont_1 > @nume_sede
	begin
		set @nume_Sede = @cont_1
	end
	if @cont_2 > @nume_sede
	begin
		set @nume_Sede = @cont_2
	end
	if @cont_3 > @nume_sede
	begin
		set @nume_Sede = @cont_3
	end
	if @cont_4 > @nume_sede
	begin
		set @nume_Sede = @cont_4
	end

	
	return @nume_sede
	
END
GO
