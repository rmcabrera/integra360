CREATE PROCEDURE [dbo].[sp_carg_Adel_Quin]
	@codi_pers [char](5),
	@mes [smallint],
	@anio [smallint],
	@TIPO_PERS [char](2),
	@adel_quin [decimal](9, 2) OUTPUT
WITH EXECUTE AS CALLER
AS
DECLARE @codi_auxi char(10)


Create Table #Adel_quin (Adel_quin decimal(9,2))

if @tipo_pers = '01' 
begin
	set @codi_auxi = (select codi_plan_EMPL From PLANILLA_DE_EMPLEADOS where (codi_pers = @codi_pers) and (cast(mes as integer) = @mes) and (cast(anio as integer) = @anio) and (codi_tipo_plan = '01') and (indi_tiem = 'Q'))
--	PRINT @CODI_AUXI
	IF @CODI_AUXI <>'' 
	BEGIN
		SET @ADEL_QUIN = (Select isnull(valor,0) From PLANILLA_EMPLEADO_CONCEPTOS Where (CODI_PLAN_EMPL = @codi_auxi) and (codi_conc = '999990'))
	END
	--PRINT  @ADEL_QUIN
end
if @tipo_pers = '02' 
begin
	set @codi_auxi = (select codi_plan_obre From PLANILLA_DE_OBREROS where (codi_pers = @codi_pers) and (cast(mes as integer) = @mes) and (cast(anio as integer) = @anio) and (codi_tipo_plan = '01') and (indi_tiem = 'Q'))
	IF @CODI_AUXI <>'' 
	BEGIN
		SET @ADEL_QUIN = (Select isnull(valor,0) From PLANILLA_OBRERO_CONCEPTOS Where (CODI_PLAN_OBRE = @codi_auxi) and (codi_conc = '999990'))
	END
end

INSERT INTO #Adel_quin (ADEL_QUIN) VALUES (@ADEL_QUIN)

--print @codi_auxi
--PRINT @ADEL_QUIN

Select * from #Adel_quin
GO
