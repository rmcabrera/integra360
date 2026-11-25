CREATE FUNCTION [dbo].[F_Renta_Quinta_fija_calc](@codi_pers [char](5), @MES [char](2), @ANIO [char](4), @CODI_TIPO_TRAB [char](2), @TOTA_INGR [decimal](9, 2), @tota_incr [decimal](9, 2), @tota_asig_fami [decimal](9, 2), @suel_basi [decimal](9, 2), @fech_ingr [datetime], @fech_term_mes [datetime], @FECH_INIC_GRATI [datetime], @FECH_INIC_ANIO [datetime], @tipo_plan [char](2))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
begin
/*
declare @codi_pers char(5), @MES char(2), @ANIO char(4), @CODI_TIPO_TRAB CHAR(2),
	@TOTA_INGR DECIMAL(9,2), @tota_incr DECIMAL(9,2), @tota_asig_fami DECIMAL(9,2), @suel_basi DECIMAL(9,2), 
	@fech_ingr datetime, @fech_term_mes datetime, @FECH_INIC_GRATI datetime, @FECH_INIC_ANIO datetime, @tipo_plan char(2)
	
select @codi_pers='00016', @MES='01', @ANIO='2023', @CODI_TIPO_TRAB ='01',
	@TOTA_INGR =7415, @tota_incr =0, @tota_asig_fami =0, @suel_basi =1025, 
	@fech_ingr ='01/08/2010', @fech_term_mes ='31/01/2023', @FECH_INIC_GRATI ='01/07/2023', @FECH_INIC_ANIO ='01/01/2023', @tipo_plan ='01'
*/
Declare @tota_ingr_mes decimal(9,2)
Declare @tota_ingr_mes_otros decimal(9,2)
Declare @tota_ingr_mes_op decimal(9,2)
Declare @tota_ingr_ante decimal(9,2)
Declare @tota_ingr_ante_otros decimal(9,2)
Declare @tota_ingr_auxi decimal(9,2)
Declare @tota_rent_quin_auxi decimal(9,2)
Declare @tota_rent_quin_rete decimal(9,2)
declare @tota_rent_quin_mes_op decimal(9,2)
Declare @tota_grat_1 decimal(9,2)
Declare @tota_grat_2 decimal(9,2)
Declare @tota_grat_1_otros decimal(9,2)
Declare @tota_grat_2_otros decimal(9,2)
Declare @remu_proy decimal(9,2)
Declare @remu_proy_otros decimal(9,2)
Declare @tota_util decimal(9,2)
Declare @tota_quin_util decimal(9,2)
Declare @tota_util_auxi  decimal(9,2)
Declare @tota_ingr_comp decimal(9,2)
Declare @tota_ingr_comp_otros decimal(9,2)
Declare @tota_rent_rete_grat_1 decimal(9,2)
Declare @tota_rent_rete_grat_2 decimal(9,2)
Declare @remu_brut_trab decimal(9,2)
Declare @remu_brut_trab_otros decimal(9,2)
Declare @factor decimal(9,2)
declare @valo_uit decimal(9,2)
Declare @valo_rent_quin decimal(9,2)
Declare @VALO_nro_uit decimal(9,2)
Declare @nro_mini_uit decimal(9,2)
Declare @nro_maxi_uit decimal(9,2)
Declare @porcentaje decimal(9,2)
Declare @renta_quinta decimal(11,2)

Declare @valo_desc_auxi decimal(9,2)
Declare @valo_desc_rent_quin decimal(9,2)
Declare @codi_plan char(10)
Declare @codi_plan_grat_1 char(10)
Declare @codi_plan_grat_2 char(10)
Declare @TIPO_VALO_uit integer
Declare @tipo_Valo_rent_quin integer
Declare @tipo_Valo_nro_uit integer
Declare @nro_grati integer
Declare @grupo varchar(20)

set @tota_ingr_ante = 0
set @tota_ingr_ante_otros = 0
set @tota_ingr_mes = 0
set @tota_ingr_mes_otros = 0
set @tota_ingr_mes_op = 0
set @tota_ingr_auxi = 0
Set @tota_grat_1 = 0
Set @tota_grat_2 = 0
Set @tota_grat_1_otros = 0
Set @tota_grat_2_otros = 0
set @tota_util_auxi = 0
set @tota_util = 0
set @tota_quin_util = 0
set @tota_rent_quin_rete  = 0
set @tota_rent_quin_auxi = 0
set @remu_brut_trab = 0
set @remu_brut_trab_otros = 0
set @tota_rent_quin_mes_op = 0
IF DATEPART(DAY, @FECH_TERM_MES ) = 15
BEGIN
	Set @tota_ingr_mes = @TOTA_INGR * 2
END
ELSE
BEGIN
	Set @tota_ingr_mes = @TOTA_INGR
	Set @tota_ingr_mes_otros = (Select isnull(sum(monto),0) From INGRESOS_QUINTA_CATEG (nolock) Where año=@anio and mes='01' and codi_pers = @codi_pers)
END

Select @grupo = upper( grupo ) from empresa
Set @remu_brut_trab = (Select isnull(suel_basi,0) From Personal (nolock) Where codi_pers = @codi_pers)
Set @remu_brut_trab_otros = (Select isnull(sum(monto),0) From INGRESOS_QUINTA_CATEG (nolock) Where año=@anio and mes='01' and codi_pers = @codi_pers)

--SELECCIONAR EL PORCENTAJE DE RENTA DE QUINTA CATEGORÍA
Set @Valo_RENT_QUIN = (Select isnull(Valor,0) From Valores_Unitarios_Anuales  (nolock)
Where Codi_Valo_Unit = 8 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin  >= @FECH_TERM_MES)
Set @tipo_Valo_rent_quin = (Select isnull(tipo_Valo,0) From Valores_Unitarios_Anuales (nolock) Where Codi_Valo_Unit = 8 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin >= @FECH_TERM_MES)
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
Set @Valo_uit = (Select isnull(Valor,0) From Valores_Unitarios_Anuales (nolock) Where Codi_Valo_Unit = 1 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin >= @FECH_TERM_MES)
Set @tipo_Valo_uit = (Select isnull(tipo_Valo,0) From Valores_Unitarios_Anuales (nolock) Where Codi_Valo_Unit = 1 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin >= @FECH_TERM_MES)
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
Set @Valo_nro_uit = (Select isnull(Valor,0) From Valores_Unitarios_Anuales (nolock) Where Codi_Valo_Unit = 9 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin  >= @FECH_TERM_MES)
Set @tipo_Valo_nro_uit = (Select isnull(tipo_Valo,0) From Valores_Unitarios_Anuales (nolock) Where Codi_Valo_Unit = 9 And Fech_Asig <= @FECH_TERM_MES And Fech_Asig_Fin >= @FECH_TERM_MES)
IF @TIPO_VALO_nro_uit = 0
begin
	SET @VALO_nro_uit = @valo_nro_uit / 100
end
ELSE
begin
	SET @VALO_nro_uit = @valo_nro_uit
END
--FIN SELECCIONAR EL nro de uit para renta quinta categoría

--return  @TIPO_VALO_uit 

-- Cargar Renta Retenida en el año
declare @MesSunat char(2)
if @Mes in ('01','02','03') 	set @MesSunat ='00'
if @Mes in ('04') 		set @MesSunat ='03'
if @Mes in ('05','06','07') 	set @MesSunat ='04'
if @Mes in ('08') 		set @MesSunat ='07'
if @Mes in ('09','10','11') 	set @MesSunat ='08'
if @Mes in ('12') 		set @MesSunat ='11'

if @codi_tipo_trab = '01' or @codi_tipo_trab = '08'
Begin
	Set @tota_rent_quin_auxi = (Select isnull (sum(isnull(valor,0) ) , 0 ) From PLANILLA_EMPLEADO_CONCEPTOS  (nolock)
		WHERE (codi_conc = '200040' or codi_conc = '200041') 
		and codi_plan_empl in ( Select codi_plan_empl from PLANILLA_DE_EMPLEADOS (nolock)
			WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes <= @MesSunat) and (indi_tiem = 'M' ) 
				and ( (codi_tipo_plan >= '01' and codi_tipo_plan <= '03') or (codi_tipo_plan = '05') or (codi_tipo_plan = '10') ) 
			) )

	/*Set @tota_rent_quin_mes_op = (Select isnull (sum(isnull(valor,0) ) , 0 ) From PLANILLA_EMPLEADO_CONCEPTOS  (nolock)
		WHERE (codi_conc = '200040' or codi_conc = '200041') 
		and codi_plan_empl in ( Select codi_plan_empl from PLANILLA_DE_EMPLEADOS (nolock)
			WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes = @mes) and (indi_tiem = 'M' ) 
				and ( codi_tipo_plan <> @tipo_plan ) 
			) )*/

end
if @codi_tipo_trab = '02'
Begin
	Set @tota_rent_quin_auxi = (Select isnull (sum(isnull(valor,0) ) , 0 ) From PLANILLA_obrero_CONCEPTOS  (nolock)
		WHERE (codi_conc = '200040' or codi_conc = '200041') 
		and codi_plan_obre in ( Select codi_plan_obre from PLANILLA_DE_obreros (nolock)
			WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes <= @MesSunat) and (indi_tiem = 'M' ) 
				and ( (codi_tipo_plan >= '01' and codi_tipo_plan <= '03') or (codi_tipo_plan = '05') or (codi_tipo_plan = '10') ) 
			) )

	/*Set @tota_rent_quin_mes_op = (Select isnull (sum(isnull(valor,0) ) , 0 ) From PLANILLA_obrero_CONCEPTOS  (nolock)
		WHERE (codi_conc = '200040' or codi_conc = '200041') 
		and codi_plan_obre in ( Select codi_plan_obre from PLANILLA_DE_obreros (nolock)
			WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes = @mes) and (indi_tiem = 'M' ) 
				and ( codi_tipo_plan <> @tipo_plan ) 
			) )*/

end
set @tota_rent_quin_rete = isnull( @tota_rent_quin_auxi, 0 ) + isnull ( @tota_rent_quin_mes_op, 0 ) 

declare @MxUtil char(2)
set @MxUtil = isnull((select mes from CALC_UTIL_PERS (nolock) where codi_pers = @codi_pers and cast ( anio as integer ) = @anio - 1 ),'')

if @MxUtil <= @MesSunat
	Select @tota_quin_util = isnull( valor , 0 ) from calc_util_deta (nolock)
	where codi_pers = @codi_pers and codi_conc = '200040' and cast ( anio as integer ) = @anio - 1 

set @tota_rent_quin_rete = isnull(@tota_rent_quin_rete, 0) + isnull( @tota_rent_rete_grat_1 , 0 ) + isnull( @tota_rent_rete_grat_2 , 0 ) + isnull(@tota_quin_util , 0 ) + 
			isnull( (select sum(renta_reten) from INGRESOS_QUINTA_CATEG R (nolock) where R.codi_pers=@codi_pers and año=@anio and mes<=@mes),0)

-- Fin Cargar Renta Retenida en el año

-- Cargar Ingresos del año

if @codi_tipo_trab = '01' or @codi_tipo_trab = '08'
Begin
	Set @tota_ingr_ante = (Select isnull (sum(isnull(valor,0) ) , 0 ) From PLANILLA_EMPLEADO_CONCEPTOS  (nolock)
		WHERE (codi_conc = '199998' ) 
		and codi_plan_empl in ( Select codi_plan_empl from PLANILLA_DE_EMPLEADOS (nolock)
			WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes < @mes) and (indi_tiem = 'M' ) 
				and ( (codi_tipo_plan >= '01' and codi_tipo_plan <= '03') or (codi_tipo_plan = '05') or (codi_tipo_plan = '10') ) 
			) )
		
	Set @tota_ingr_mes_op = (Select isnull (sum(isnull(valor,0) ) , 0 ) From PLANILLA_EMPLEADO_CONCEPTOS  (nolock)
		WHERE (codi_conc = '199998' ) 
		and codi_plan_empl in ( Select codi_plan_empl from PLANILLA_DE_EMPLEADOS (nolock)
			WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes = @mes) and (indi_tiem = 'M' ) 
				and ( codi_tipo_plan <> @tipo_plan ) 
			) )
			
	Set @tota_ingr_ante_otros = (Select isnull (sum(isnull(monto,0) ) , 0 ) From INGRESOS_QUINTA_CATEG (nolock)
		WHERE ( año = @anio ) and ( mes < @mes ) and ( codi_pers = @codi_pers ) )		

end
if @codi_tipo_trab = '02'
Begin
	Set @tota_ingr_ante = (Select isnull (sum(isnull(valor,0) ) , 0 ) From PLANILLA_obrero_CONCEPTOS  (nolock)
		WHERE (codi_conc = '199998' ) 
		and codi_plan_obre in ( Select codi_plan_obre from PLANILLA_DE_obreros (nolock)
			WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes < @mes) and (indi_tiem = 'M' ) 
				and ( (codi_tipo_plan >= '01' and codi_tipo_plan <= '03') or (codi_tipo_plan = '05') or (codi_tipo_plan = '10') ) 
			) )

	Set @tota_ingr_mes_op = (Select isnull (sum(isnull(valor,0) ) , 0 ) From PLANILLA_obrero_CONCEPTOS  (nolock)
		WHERE (codi_conc = '199998' ) 
		and codi_plan_obre in ( Select codi_plan_obre from PLANILLA_DE_obreros (nolock)
			WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes = @mes) and (indi_tiem = 'M' ) 
				and ( codi_tipo_plan <> @tipo_plan ) 
			) )
			
	Set @tota_ingr_ante_otros = (Select isnull (sum(isnull(monto,0) ) , 0 ) From INGRESOS_QUINTA_CATEG (nolock)
		WHERE ( año = @anio ) and ( mes < @mes ) and ( codi_pers = @codi_pers ) )		

end

--Fin Cargar Ingresos Anteriores en el año

--Cargar Gratificaciones Proyectadas
declare @BoniExtr numeric(12,2)
if @mes < '07'
begin
	set @factor = datediff(dd, @fech_ingr, @FECH_INIC_GRATI) 
	set @factor = @factor / datediff(dd, @fech_inic_anio, @FECH_INIC_GRATI)
--	set @factor = datediff(dd, @fech_ingr, @FECH_INIC_GRATI) / datediff(dd, @fech_inic_anio, @FECH_INIC_GRATI)
	if @factor > 1
	begin
		set @factor = 1
	end
	set @tota_grat_1 = (@remu_brut_trab + @tota_incr + @tota_asig_fami) * @factor
	set @tota_grat_2 = (@remu_brut_trab + @tota_incr + @tota_asig_fami + isnull(@BoniExtr,0))
	
	set @tota_grat_1_otros = (@remu_brut_trab_otros /*+ @tota_incr + @tota_asig_fami*/) * @factor
	set @tota_grat_2_otros = (@remu_brut_trab_otros /*+ @tota_incr + @tota_asig_fami + isnull(@BoniExtr,0)*/)
	
	if @anio between '2009' and '2014'
	begin
		set @tota_grat_1 =  @tota_grat_1  + @tota_grat_1*0.09
		set @tota_grat_2 =  @tota_grat_2  + @tota_grat_2*0.09	
		
		set @tota_grat_1_otros =  @tota_grat_1_otros  + @tota_grat_1_otros*0.09
		set @tota_grat_2_otros =  @tota_grat_2_otros  + @tota_grat_2_otros*0.09	
	end
end
else
begin
	if @mes < '12'
	begin
		set @fech_inic_anio = dateadd(mm, 6, @fech_inic_anio)
		set @fech_inic_grati = dateadd(mm, 5, @fech_inic_grati)
		set @factor = datediff(dd, @fech_ingr, @FECH_INIC_GRATI)
		set @factor = @factor / datediff(dd, @fech_inic_anio, @FECH_INIC_GRATI)
		if @factor > 1
		begin
			set @factor = 1
		end
		set @tota_grat_1 = 0

		/*Set @BoniExtr = isnull((Select isnull (sum(isnull(valor,0) ) , 0 ) From PLANILLA_EMPLEADO_CONCEPTOS  (nolock)
			WHERE (codi_conc = '101903' ) 
			and codi_plan_empl in ( Select codi_plan_empl from PLANILLA_DE_EMPLEADOS (nolock)
				WHERE (codi_pers = @codi_pers) and (anio = @anio) and (mes = @mes) and (indi_tiem = 'M' ) 
					and ( codi_tipo_plan ='02' ) 
				) ),0)*/

		set @tota_grat_2 = (@remu_brut_trab + @tota_incr + @tota_asig_fami/*+isnull(@BoniExtr,0)*/) * @factor
		
		set @tota_grat_2_otros = (@remu_brut_trab_otros /*+ @tota_incr + @tota_asig_fami + isnull(@BoniExtr,0)*/) * @factor

		if @anio between '2009' and '2014'
			set @tota_grat_2 =  @tota_grat_2  + @tota_grat_2*0.09	
			
			set @tota_grat_2_otros =  @tota_grat_2_otros  + @tota_grat_2_otros*0.09	
	end
end
--Fin Cargar Gratificaciones Proyectadas
--return @factor
-- Calcular Remuneración Proyectada
set @remu_proy = ( @remu_brut_trab + @tota_incr + @tota_asig_fami) * (12 - convert(integer, @mes))

set @remu_proy_otros = ( @remu_brut_trab_otros ) * (12 - convert(integer, @mes))
-- Fin Calcular Remuneración Proyectada

Select @tota_util = isnull( valor , 0 ) from calc_util_deta
where codi_pers = @codi_pers and codi_conc = '199998' and cast ( anio as integer ) = @anio - 1 

set @tota_ingr_comp = isnull(@tota_ingr_mes , 0 ) + isnull( @tota_ingr_mes_op, 0 )+ isnull( @tota_ingr_ante , 0 ) + isnull( @tota_grat_1 , 0 ) +  isnull( @tota_grat_2 , 0 ) 

set @tota_ingr_comp_otros = isnull(@tota_ingr_mes_otros,0) + isnull(@remu_proy_otros,0) + isnull(@tota_grat_1_otros,0) +  isnull(@tota_grat_2_otros,0) + isnull(@tota_ingr_ante_otros,0)

set @tota_ingr_comp = @tota_ingr_comp + isnull( @remu_proy , 0 ) + isnull( @tota_util, 0 ) + @tota_ingr_comp_otros
			--isnull( (select sum(monto) from INGRESOS_QUINTA_CATEG R (nolock) where R.codi_pers=@codi_pers and año=@anio and mes<=@mes),0)

set @tota_ingr_auxi = @tota_ingr_comp

set @tota_ingr_comp =  @tota_ingr_comp  - (@VALO_uit * @VALO_nro_uit)

set @valo_desc_rent_quin = 0

if @tota_ingr_comp > 0
begin
	--PRINT @VALO_rent_quin
	Declare Curs_Carg_para_rent_quin_2 Cursor For
		Select nro_mini_uit, nro_maxi_uit, porcentaje
		From Parametros_quinta (nolock)
		--where esta_para = 1
		where fech_para in (
			Select max(fech_para)
				From Parametros_quinta (nolock) where fech_para<@fech_term_mes)
		order by nro_para;
	Open Curs_Carg_para_rent_quin_2;
	fetch next from Curs_Carg_para_rent_quin_2 into @nro_mini_uit, @nro_maxi_uit, @porcentaje;
	While @@fetch_status = 0
	begin
		set @valo_desc_auxi = 0
		if  ( @tota_ingr_comp > ( @nro_mini_uit * @valo_uit ) ) AND ( @tota_ingr_comp <= ( @nro_maxi_uit * @valo_uit) )
		begin	
			set @valo_desc_auxi = ( @tota_ingr_comp -  ( @nro_mini_uit * @valo_uit)  ) *  @PORCENTAJE / 100
		end
		ELSE
		BEGIN
			if  ( @tota_ingr_comp - ( @nro_maxi_uit * @valo_uit)  ) > 0 
			begin
				set @valo_desc_auxi = ( ( @nro_maxi_uit - @nro_mini_uit ) * @valo_uit ) * @PORCENTAJE / 100 
			end
		END		
		SET @valo_desc_rent_quin = @valo_desc_rent_quin + ISNULL(@valo_desc_auxi,0)

		fetch next from Curs_Carg_para_rent_quin_2 into @nro_mini_uit, @nro_maxi_uit, @porcentaje;
	end
	Close Curs_Carg_para_rent_quin_2;
	Deallocate Curs_Carg_para_rent_quin_2;

	
/*	-----------Código Original
	set @tota_ingr_comp =  @valo_desc_rent_quin - @tota_rent_quin_rete
	set @tota_ingr_comp =  @tota_ingr_comp / ( 12 + 1 - convert(integer, @mes) )
*/	
	-----------Según SUNAT
	set @tota_ingr_comp =  @valo_desc_rent_quin - @tota_rent_quin_rete

	if @mes in ('01','02','03') 	set @tota_ingr_comp =  @tota_ingr_comp / 12
	if @mes in ('04') 		set @tota_ingr_comp =  @tota_ingr_comp / 9
	if @mes in ('05','06','07') 	set @tota_ingr_comp =  @tota_ingr_comp / 8
	if @mes in ('08') 		set @tota_ingr_comp =  @tota_ingr_comp / 5
	if @mes in ('09','10','11') 	set @tota_ingr_comp =  @tota_ingr_comp / 4
	if @mes in ('12') 		set @tota_ingr_comp =  @tota_ingr_comp / 1

	set @renta_quinta =  @tota_ingr_comp
	
	IF DATEPART(DAY, @FECH_TERM_MES ) = 15
	BEGIN
		Set @renta_quinta = @renta_quinta / 2
	END
	ELSE
	BEGIN
		Set @renta_quinta = @renta_quinta
	END
end
else
begin
	set @renta_quinta =  0
end

return isnull(@renta_quinta,0) 
--return  @tota_ingr_ante

END
GO
