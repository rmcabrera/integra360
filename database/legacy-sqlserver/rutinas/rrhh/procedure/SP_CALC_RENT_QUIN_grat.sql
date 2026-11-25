CREATE PROCEDURE [dbo].[SP_CALC_RENT_QUIN_grat]
	@codi_pers [char](5),
	@MES [char](2),
	@ANIO [char](4),
	@CODI_TIPO_TRAB [char](2),
	@TOTA_INGR [decimal](9, 2),
	@tota_incr [decimal](9, 2),
	@tota_asig_fami [decimal](9, 2),
	@suel_basi [decimal](9, 2),
	@fech_ingr [datetime],
	@fech_term_mes [datetime],
	@FECH_INIC_GRATI [datetime],
	@FECH_INIC_ANIO [datetime],
	@renta_quinta [decimal](9, 2) OUTPUT
WITH EXECUTE AS CALLER
AS
Declare @tota_ingr_mes decimal(9,2)
Declare @tota_ingr_ante decimal(9,2)
Declare @tota_ingr_auxi decimal(9,2)
Declare @tota_rent_quin_auxi decimal(9,2)
Declare @tota_rent_quin_rete decimal(9,2)
Declare @tota_grat_1 decimal(9,2)
Declare @tota_grat_2 decimal(9,2)
Declare @remu_proy decimal(9,2)
Declare @tota_util decimal(9,2)
Declare @tota_util_auxi  decimal(9,2)
Declare @tota_ingr_comp decimal(9,2)
Declare @remu_brut_trab decimal(9,2)
Declare @factor decimal(9,2)
declare @valo_uit decimal(9,2)
Declare @valo_rent_quin decimal(9,2)
Declare @VALO_nro_uit decimal(9,2)
Declare @nro_mini_uit decimal(9,2)
Declare @nro_maxi_uit decimal(9,2)
Declare @porcentaje decimal(9,2)
Declare @valo_desc_auxi decimal(9,2)
Declare @valo_desc_rent_quin decimal(9,2)
Declare @codi_plan char(10)
Declare @TIPO_VALO_uit integer
Declare @tipo_Valo_rent_quin integer
Declare @tipo_Valo_nro_uit integer


set @tota_ingr_ante = 0
set @tota_ingr_mes = 0
set @tota_ingr_auxi = 0
Set @tota_grat_1 = 0
Set @tota_grat_2 = 0
set @tota_util_auxi = 0
set @tota_util = 0
set @tota_rent_quin_rete  = 0
set @tota_rent_quin_auxi = 0
set @remu_brut_trab = 0

create table #Rent_Quin (rent_quin decimal (9,2))

Set @tota_ingr_mes = @TOTA_INGR
Set @remu_brut_trab = (Select isnull(suel_basi,0) From Personal Where codi_pers = @codi_pers)
--SELECCIONAR EL PORCENTAJE DE RENTA DE QUINTA CATEGORÍA
Set @Valo_RENT_QUIN = (Select isnull(Valor,0) From Valores_Unitarios_Anuales Where Codi_Valo_Unit = 8 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin >= @FECH_TERM_MES)
Set @tipo_Valo_rent_quin = (Select isnull(tipo_Valo,0) From Valores_Unitarios_Anuales Where Codi_Valo_Unit = 8 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin >= @FECH_TERM_MES)
IF @TIPO_VALO_rent_quin = 0 
begin
	SET @VALO_rent_quin = @valo_rent_quin / 100
end
ELSE
begin
	SET @VALO_rent_quin = @valo_rent_quin
END
--FIN SELECCIONAR EL PORCENTAJE DE RENTA DE QUINTA CATEGORÍA

--SELECCIONAR EL VALOR DEL MONTO DE UIT
Set @Valo_uit = (Select isnull(Valor,0) From Valores_Unitarios_Anuales Where Codi_Valo_Unit = 1 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin >= @FECH_TERM_MES)
Set @tipo_Valo_uit = (Select isnull(tipo_Valo,0) From Valores_Unitarios_Anuales Where Codi_Valo_Unit = 1 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin >= @FECH_TERM_MES)

IF @TIPO_VALO_uit = 0 
begin
	SET @VALO_uit = @valo_uit / 100
end
ELSE
begin
	SET @VALO_uit = @valo_uit
END

--FIN SELECCIONAR EL VALOR DEL MONTO DE UIT

--SELECCIONAR EL nro de uit para renta quinta categoría
Set @Valo_nro_uit = (Select isnull(Valor,0) From Valores_Unitarios_Anuales Where Codi_Valo_Unit = 9 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin >= @FECH_TERM_MES)
Set @tipo_Valo_nro_uit = (Select isnull(tipo_Valo,0) From Valores_Unitarios_Anuales Where Codi_Valo_Unit = 9 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin >= @FECH_TERM_MES)

IF @TIPO_VALO_nro_uit = 0 
begin
	SET @VALO_nro_uit = @valo_nro_uit / 100
end
ELSE
begin
	SET @VALO_nro_uit = @valo_nro_uit
END

--FIN SELECCIONAR EL nro de uit para renta quinta categoría

-- Cargar Renta Retenida en el año 
if @codi_tipo_trab = '01' 
Begin
	Declare Curs_Carg_codi_plan_rent Cursor For
	Select CODI_PLAN_EMPL
	From PLANILLA_DE_EMPLEADOS
	WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes < @mes) and (indi_tiem = 'M' ) 
		and ((codi_tipo_plan >= '01' and codi_tipo_plan <= '03') or (codi_tipo_plan = '05') or (codi_tipo_plan = '10'));

end
if @codi_tipo_trab = '02' 
Begin
	Declare Curs_Carg_codi_plan_rent Cursor For
	Select Codi_plan_OBRE
	From PLANILLA_DE_OBREROS
	WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes < @mes) and (indi_tiem = 'M' ) 
		and ((codi_tipo_plan >= '01' and codi_tipo_plan <= '03') or (codi_tipo_plan = '05') or (codi_tipo_plan = '10'));
End
OPEN Curs_Carg_codi_plan_rent;
fetch next from Curs_Carg_codi_plan_rent into @codi_plan;
While @@fetch_status = 0
begin
	if @codi_tipo_trab = '01' 
	begin
		Set @tota_rent_quin_auxi = (Select isnull(valor,0) From PLANILLA_EMPLEADO_CONCEPTOS WHERE codi_plan_empl = @codi_plan and (codi_conc = '200040' or codi_conc = '200041'))
	end
	if @codi_tipo_trab = '02' 
	begin
		Set @tota_rent_quin_auxi = (Select isnull(valor,0) From PLANILLA_OBRERO_CONCEPTOS WHERE codi_plan_obre = @codi_plan and (codi_conc = '200040' or codi_conc = '200041'))
	end
--	print @tota_rent_quin_auxi
	set @tota_rent_quin_rete = @tota_rent_quin_rete + isnull(@tota_rent_quin_auxi,0)
	
	fetch next from Curs_Carg_codi_plan_rent into @codi_plan;
end

close Curs_Carg_codi_plan_rent;
Deallocate Curs_Carg_codi_plan_rent;
-- Fin Cargar Renta Retenida en el año 
--print @tota_rent_quin_rete
-- Cargar Ingresos Anteriores en el año 
if @codi_tipo_trab = '01' 
Begin
	Declare Curs_Carg_codi_plan Cursor For
	Select CODI_PLAN_EMPL
	From PLANILLA_DE_EMPLEADOS
	WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes < @mes) and (indi_tiem = 'M' ) 
		and ((codi_tipo_plan >= '01' and codi_tipo_plan <= '03') or (codi_tipo_plan = '05') or (codi_tipo_plan = '10'));

end
if @codi_tipo_trab = '02' 
Begin
	Declare Curs_Carg_codi_plan Cursor For
	Select Codi_plan_OBRE
	From PLANILLA_DE_OBREROS
	WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes < @mes) and (indi_tiem = 'M' ) 
		and ((codi_tipo_plan >= '01' and codi_tipo_plan <= '03') or (codi_tipo_plan = '05') or (codi_tipo_plan = '10'));
End
OPEN Curs_Carg_codi_plan;
fetch next from Curs_Carg_codi_plan into @codi_plan;
While @@fetch_status = 0
begin
	if @codi_tipo_trab = '01' 
	begin
		Set @tota_ingr_auxi = (Select isnull(valor,0) From PLANILLA_EMPLEADO_CONCEPTOS WHERE codi_plan_empl = @codi_plan and (codi_conc = '199998' or codi_conc = '101000') )
	end
	if @codi_tipo_trab = '02' 
	begin
		Set @tota_ingr_auxi = (Select isnull(valor,0) From PLANILLA_OBRERO_CONCEPTOS WHERE codi_plan_obre = @codi_plan and (codi_conc = '199998' or codi_conc = '101000') )
	end
--	PRINT @tota_ingr_auxi
	set @tota_ingr_ante = @tota_ingr_ante + ISNULL(@tota_ingr_auxi,0)
	
	fetch next from Curs_Carg_codi_plan into @codi_plan;
end

close Curs_Carg_codi_plan;
Deallocate Curs_Carg_codi_plan;
--PRINT @tota_ingr_ante
-- Fin Cargar Ingresos Anteriores en el año
-- Cargar Gratificaciones Proyectadas
if @mes < '07' 
begin
	set @factor = datediff(dd, @fech_ingr, @FECH_INIC_GRATI) / datediff(dd, @fech_inic_anio, @FECH_INIC_GRATI) 
	if @factor > 1 
	begin
		set @factor = 1
	end	
	set @tota_grat_1 = (@remu_brut_trab + @tota_incr + @tota_asig_fami) * @factor
	set @tota_grat_2 = (@remu_brut_trab + @tota_incr + @tota_asig_fami)
end
else
begin
	if @mes < '12' 
	begin
		if @mes = '07' 
		begin
			set @factor = datediff(dd, @fech_ingr, @FECH_INIC_GRATI) / datediff(dd, @fech_inic_anio, @FECH_INIC_GRATI) 
			if @factor > 1 
			begin
				set @factor = 1
			end	
			set @tota_grat_1 = @tota_ingr
			set @tota_grat_2 = (@remu_brut_trab + @tota_incr + @tota_asig_fami)
		end		
		else	
		begin
			set @fech_inic_anio = dateadd(mm, 6, @fech_inic_anio) 
			set @fech_inic_grati = dateadd(mm, 5, @fech_inic_grati) 
			set @factor = datediff(dd, @fech_ingr, @FECH_INIC_GRATI) / datediff(dd, @fech_inic_anio, @FECH_INIC_GRATI) 
			if @factor > 1 
			begin
				set @factor = 1
			end	
			set @tota_grat_1 = 0
			set @tota_grat_2 = (@remu_brut_trab + @tota_incr + @tota_asig_fami) * @factor
		end
	end
	else
	begin
		set @tota_grat_1 = 0
		set @tota_grat_2 = @tota_ingr
	end
end

--Fin Cargar Gratificaciones Proyectadas
--print @tota_grat_1
--print @tota_grat_2
--PRINT @remu_brut_trab
--PRINT @TOTA_INCR
--PRINT @tota_asig_fami
-- Calcular Remuneración Proyectada
	set @remu_proy = (@remu_brut_trab + @tota_incr + @tota_asig_fami) * (12 - convert(integer, @mes))	
-- Fin Calcular Remuneración Proyectada

--print @remu_proy
-- Remuneración de Utilidades
	/*if @codi_tipo_trab = '01'
	Begin
		Declare Curs_Carg_codi_plan_util Cursor For
		Select CODI_PLAN_EMPL
		From PLANILLA_DE_EMPLEADOS
		WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes <= @mes) and (indi_tiem = 'M' ) and (codi_tipo_plan = '04');
	end
	if @codi_tipo_trab = '02'
	Begin
		Declare Curs_Carg_codi_plan_util Cursor For
		Select Codi_plan_OBRE
		From PLANILLA_DE_OBREROS
		WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes <= @mes) and (indi_tiem = 'M' ) and (codi_tipo_plan = '04' );
	End
	OPEN Curs_Carg_codi_plan_util;
	fetch next from Curs_Carg_codi_plan_util into @codi_plan;
	While @@fetch_status = 0
	begin
		if @codi_tipo_trab = '01'
		begin
			Set @tota_util_auxi = (Select isnull(valor,0) From PLANILLA_EMPLEADO_CONCEPTOS WHERE codi_plan_empl = @codi_plan and codi_conc = '199998')
		end
		if @codi_tipo_trab = '02'
		begin
			Set @tota_util_auxi = (Select isnull(valor,0) From PLANILLA_OBRERO_CONCEPTOS WHERE codi_plan_obre = @codi_plan and codi_conc = '199998')
		end
		Set @tota_util = @tota_util + @tota_util_auxi
		fetch next from Curs_Carg_codi_plan_util into @codi_plan;
	end
	Close Curs_Carg_codi_plan_util;
	Deallocate Curs_Carg_codi_plan_util; */
	set Select @tota_util = isnull( liq_remu_perc , 0 ) + isnull( liq_dias_labo , 0 ) from calc_util_pers 
		where ( cast( anio as integer) = cast( @anio as integer) - 1 ) 
		and codi_pers = @codi_pers;
	
-- Fin Remuneración de Utilidades
--print @tota_util
set @tota_ingr_comp = @tota_ingr_mes + @tota_ingr_ante + @tota_grat_1 +  @tota_grat_2 + @remu_proy + @tota_util
--print @tota_ingr_comp
set @tota_ingr_comp =  @tota_ingr_comp  - (@VALO_uit * @VALO_nro_uit)
set @valo_desc_rent_quin = 0
--print @tota_ingr_comp
if @tota_ingr_comp > 0 
begin
	--PRINT @VALO_rent_quin
	Declare Curs_Carg_para_rent_quin_2 Cursor For
	Select nro_mini_uit, nro_maxi_uit, porcentaje
	From Parametros_quinta
	where esta_para = 1
	order by nro_para;
	Open Curs_Carg_para_rent_quin_2;
	fetch next from Curs_Carg_para_rent_quin_2 into @nro_mini_uit, @nro_maxi_uit, @porcentaje;
	While @@fetch_status = 0
	begin
		set @valo_desc_auxi = 0
		if  ( @tota_ingr_comp > ( @nro_mini_uit * @valo_uit ) ) AND ( @tota_ingr_comp <= ( @nro_maxi_uit * @valo_uit) )
		begin	
			set @valo_desc_auxi = @valo_desc_auxi + ( @tota_ingr_comp -  ( @nro_mini_uit * @valo_uit)  ) *  @PORCENTAJE / 100
		end
		ELSE
		BEGIN
			if  ( @tota_ingr_comp - ( @nro_maxi_uit * @valo_uit)  ) > 0 
			begin
				set @valo_desc_auxi = @valo_desc_auxi + ( @nro_maxi_uit * @valo_uit ) * @PORCENTAJE / 100 
			end
		END
		SET @valo_desc_rent_quin = @valo_desc_rent_quin + ISNULL(@valo_desc_auxi,0)
		fetch next from Curs_Carg_para_rent_quin_2 into @nro_mini_uit, @nro_maxi_uit, @porcentaje;	
	end
	Close Curs_Carg_para_rent_quin_2;
	Deallocate Curs_Carg_para_rent_quin_2;
--	PRINT @valo_desc_rent_quin
	set @tota_ingr_comp =  @valo_desc_rent_quin - @tota_rent_quin_rete
--	PRINT @tota_ingr_comp
	--PRINT convert(integer, @mes)
	set @tota_ingr_comp =  @tota_ingr_comp / (12 + 1 - convert(integer, @mes))	
	--PRINT @tota_ingr_comp
	set @renta_quinta =  @tota_ingr_comp
end
else
begin
	set @renta_quinta =  0
end
--PRINT @renta_quinta
insert into #Rent_Quin (rent_quin) Values (@renta_quinta)

Select isnull(rent_quin,0) From #Rent_Quin
GO
