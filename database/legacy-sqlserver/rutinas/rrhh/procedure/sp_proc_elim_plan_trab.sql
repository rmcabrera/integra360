CREATE PROCEDURE [dbo].[sp_proc_elim_plan_trab]
	@codi_pers [char](5),
	@mes [smallint],
	@anio [int],
	@TIPO_PERS [char](2),
	@codi_tipo_plan [char](2),
	@indi_tiem [char](1),
	@TIPO_ELIM [char](2)
WITH EXECUTE AS CALLER
AS
DECLARE @codi_auxi char(10)

--@TIPO_ELIM ( SP = SOLO PLANILLA ;  SH = SOLO HORAS; HP = HORAS Y PLANILLA )

if @tipo_pers = '01' 
begin
	set @codi_auxi = (select isnull(codi_plan_EMPL ,'') From PLANILLA_DE_EMPLEADOS where (codi_pers = @codi_pers) and (cast(mes as integer) = @mes) and (cast(anio as integer) = @anio) and (codi_tipo_plan = @codi_tipo_plan) and (indi_tiem = @indi_tiem))
--	PRINT @CODI_AUXI
	IF @CODI_AUXI <>'' 
	BEGIN
		Delete From Plan_conc_desc where codi_plan_conc = @codi_auxi		
		Delete From Planilla_empleado_conceptos where codi_plan_empl = @codi_auxi
		Delete From Planilla_de_empleados where codi_plan_empl = @codi_auxi
	END
	--PRINT  @ADEL_QUIN
end
if @tipo_pers = '02' 
begin
	set @codi_auxi = (select isnull(codi_plan_obre, '' ) From PLANILLA_DE_OBREROS where (codi_pers = @codi_pers) and (cast(mes as integer) = @mes) and (cast(anio as integer) = @anio) and (codi_tipo_plan = @codi_tipo_plan ) and (indi_tiem = @indi_tiem))
	IF @CODI_AUXI <>'' 
	BEGIN
		Delete From Plan_conc_desc where codi_plan_conc = @codi_auxi		
		Delete From Planilla_obrero_conceptos where codi_plan_obre = @codi_auxi
		Delete From Planilla_de_obreros where codi_plan_obre = @codi_auxi
	END
end

IF UPPER(@TIPO_ELIM) = 'SH' or Upper(@tipo_elim) = 'HP'
begin
	Delete From Horas_laboradas where datepart(month, Fech_inic) = @mes and  datepart(year, Fech_inic) = @anio and codi_pers = @codi_pers
end
GO
