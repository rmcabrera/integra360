CREATE FUNCTION [dbo].[F_suel_basi_mens](@codi_pers [char](5), @tipo_plan [char](2), @anio [char](4), @mes [char](2), @tipo_trab [char](2))
RETURNS [decimal](15, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @suel_basi_mes decimal (15,2)
	declare @TPE CHAR(2)
	declare @TPO CHAR(2)
	declare @TPT CHAR(2)


	Set @tpe = (Select codi_tipo_pers From Tipo_trabajador where upper( desc_tipo_pers ) = 'EMPLEADOS'  OR upper( desc_tipo_pers ) = 'EMPLEADO' )
	Set @tpo = (Select codi_tipo_pers From Tipo_trabajador where upper( desc_tipo_pers ) = 'OBREROS'  OR upper( desc_tipo_pers ) = 'OBRERO' )
	Set @tpt = (Select codi_tipo_pers From Tipo_trabajador where upper( desc_tipo_pers ) = 'TRIPULANTES'  OR upper( desc_tipo_pers ) = 'TRIPULANTE' )

	if @tipo_trab = @tpe 
	begin
		set @suel_basi_mes = (Select isnull( Sum(valor) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC 
					where pe.codi_pers = @codi_pers and pe.mes = @mes and pe.anio = @anio 
					and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '100000' 
					and pe.codi_tipo_plan = @tipo_plan  )
	end
	if @tipo_trab = @tpo
	begin
		set @suel_basi_mes = (Select isnull( Sum(valor) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC 
					where pe.codi_pers = @codi_pers and pe.mes = @mes and pe.anio = @anio 
					and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '100000' 
					and pe.codi_tipo_plan = @tipo_plan  )
	end


	
	return @suel_basi_mes
END
GO
