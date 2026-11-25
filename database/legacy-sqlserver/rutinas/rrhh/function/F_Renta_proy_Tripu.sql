CREATE FUNCTION [dbo].[F_Renta_proy_Tripu](@persona [char](5), @fecha [datetime], @sem [char](8))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
begin

	Declare @F1 datetime
	Declare @F2 datetime			
	Declare @S1 numeric(12,2)  -- para 1 mes anterior
	Declare @S2 numeric(12,2) -- para 2 meses antes
	Declare @S3 numeric(12,2)
	Declare @S1M numeric(12,2)  -- para 1 mes anterior
	Declare @S2M numeric(12,2) -- para 2 meses antes
	Declare @S3M numeric(12,2)
	Declare @S1S numeric(12,2)  -- para 1 mes anterior
	Declare @S2S numeric(12,2) -- para 2 meses antes
	Declare @S3S numeric(12,2)
	Declare @Prom numeric(12,2)
	Declare @Proy numeric(12,2)
	Declare @ProyS numeric(12,2)
	DEclare @montoacum numeric(12,2)
	DEclare @real numeric(12,2)
	DEclare @impureal numeric(12,2)
	DEclare @renreal numeric(12,2)

	Declare @Ns smallint
	Declare @TS smallint

	set @F1 =DATEADD ( month , -1, @fecha ) 
	set @F2 =DATEADD ( month , -2, @fecha ) 

--------------------------- Calculo de los ingresos por bonificaciones
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------2 Meses atras
	SELECT @S1M = isnull(SUM(isnull(VALOR,0)),0) FROM PLANILLA_BONI_MOTO, PLANILLA_BONI_CONCEPTO WHERE PLANILLA_BONI_MOTO.TIPO='M' 
		AND PLANILLA_BONI_MOTO.CODI_PLAN_BONI= PLANILLA_BONI_CONCEPTO.CODI_PLAN_BONI AND CODI_CONC='199998' AND CODI_PERS=@PERSONA	
		AND LEFT(MESANIO,2)=month(@F1) and RIGHT(MESANIO,4)=year(@f1)
	IF (@S1M IS NULL) SET @S1M=0
	-------------------1 Mes Atras
	SELECT @S2M = isnull(SUM(isnull(VALOR,0)),0) FROM PLANILLA_BONI_MOTO, PLANILLA_BONI_CONCEPTO WHERE PLANILLA_BONI_MOTO.TIPO='M' 
		AND PLANILLA_BONI_MOTO.CODI_PLAN_BONI= PLANILLA_BONI_CONCEPTO.CODI_PLAN_BONI AND CODI_CONC='199998' AND CODI_PERS=@PERSONA	
		AND LEFT(MESANIO,2)=month(@F2) and RIGHT(MESANIO,4)=year(@f2)
	IF (@S2M IS NULL) SET @S2M=0
	--------------- Mes Actual
	SELECT @S3M = isnull(SUM(isnull(VALOR,0)),0) FROM PLANILLA_BONI_MOTO, PLANILLA_BONI_CONCEPTO WHERE PLANILLA_BONI_MOTO.TIPO='M' 
		AND PLANILLA_BONI_MOTO.CODI_PLAN_BONI= PLANILLA_BONI_CONCEPTO.CODI_PLAN_BONI AND CODI_CONC='199998' AND CODI_PERS=@PERSONA	
		AND LEFT(MESANIO,2)=month(@Fecha) and RIGHT(MESANIO,4)=year(@fECHA) 
	IF (@S3M IS NULL) SET @S3M=0
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
--------------------------- Calculo de los ingresos por planilla de Pesca
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	select @S1=isnull(SUM(isnull(VALOR,0)),0) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
		and codi_conc='199998' and codi_pers=@persona and RIGHT(MESANIO,2)=month(@F1) 	and LEFT(MESANIO,4)=year(@f1)
	if (@S1 is null) set @S1=0

	select @S2=isnull(SUM(isnull(VALOR,0)),0) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
		and codi_conc='199998' and codi_pers=@persona and RIGHT(MESANIO,2)=month(@F2) 	and LEFT(MESANIO,4)=year(@f2)
	if (@S2 is null) set @S2=0
	
	select @S3=isnull(SUM(isnull(VALOR,0)),0) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
		and codi_conc='199998' and codi_pers=@persona and RIGHT(MESANIO,2)=month(@Fecha)   and LEFT(MESANIO,4)=year(@fecha) and codi_sema<=@sem

	if (@S3 is null) set @S3=0

	Select @Ns=count(nro_sema) from semana where 
		aniomes in (select aniomes from semana where @FECHA between fech_inic and fech_term)
		and
		nro_sema <= (select nro_sema from semana where @FECHA between fech_inic and fech_term)


	Select @Ts=count(nro_sema) from semana where 	aniomes in (select aniomes from semana where @fecha between fech_inic and fech_term)
	
--	set @prom=@S3/@Ns
--	set @Proy = @S3 + @Prom*(@Ts - @Ns)		

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
--------------------------- Calculo de los ingresos por Subsidios
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	select @S1S=isnull(SUM(isnull(VALOR,0)),0) from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
		and codi_conc='199998' and codi_pers=@persona and left(mesanio,2)=month(@F1) and  right(mesanio,4)= year(@f1)
	if (@S1S is null) set @S1S=0

	select @S2S=isnull(SUM(isnull(VALOR,0)),0) from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
		and codi_conc='199998' and codi_pers=@persona and left(mesanio,2)=month(@F2) and  right(mesanio,4)= year(@f2)
	if (@S2S is null) set @S2S=0

	select @S3S=isnull(SUM(isnull(VALOR,0)),0) from planilla_subsidio, planilla_subs_concepto where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
		and codi_conc='199998' and codi_pers=@persona and left(mesanio,2)=month(@Fecha) and  right(mesanio,4)= year(@fecha) and codi_sema<=@sem
	if (@S3S is null) set @S3S=0

--	Select @Ns=count(nro_sema) from semana where 
--		aniomes in (select aniomes from semana where @FECHA between fech_inic and fech_term)
--		and
--		nro_sema <= (select nro_sema from semana where @FECHA between fech_inic and fech_term)

--	Select @Ts=count(nro_sema) from semana where 	aniomes in (select aniomes from semana where @fecha between fech_inic and fech_term)
	
--	set @prom=0
--	set @prom=@S3S/@Ns
--	set @ProyS = @S3S + @Prom*(@Ts - @Ns)		

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------Calculo de la Renta de 5
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	set @montoacum =0
	set @montoacum  = isnull((SELECT isnull(SUM(isnull(VALOR,0)),0) FROM PLANILLA_BONI_MOTO, PLANILLA_BONI_CONCEPTO 
			WHERE PLANILLA_BONI_MOTO.TIPO='M' 	AND PLANILLA_BONI_MOTO.CODI_PLAN_BONI= PLANILLA_BONI_CONCEPTO.CODI_PLAN_BONI 
			AND CODI_CONC='199998' AND CODI_PERS= @persona AND LEFT(MESANIO,2)<=month(@fecha) and RIGHT(MESANIO,4)=year(@fecha) ) ,0) + 
			isnull((select isnull(SUM(isnull(VALOR,0)),0) from planilla_de_tripulantes, planilla_tripulante_conceptos 
			where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
				and codi_conc='199998' and codi_pers=@persona  and 	RIGHT(MESANIO,2)<=month(@fecha) and LEFT(MESANIO,4)=year(@fecha)   and codi_sema<=@sem ) ,0) +
			isnull((select isnull(SUM(isnull(VALOR,0)),0) from planilla_subsidio, planilla_subs_concepto 
			where planilla_subsidio.codi_plan_subs= planilla_subs_concepto.codi_plan_subs
			and codi_conc='199998' and codi_pers=@persona and left(MESANIO,2)<=month(@fecha) and right(MESANIO,4)=year(@fecha) and codi_sema<=@sem),0) 

	
	Declare @Sub numeric(12,2)
	Declare @Annio numeric(12,2)
	Declare @partuti numeric(12,2)
	----------sub es la suma de los ingresos q obtiene el trabajador por planilla de pesca, bonificaciones y subsidios
--	Set @sub = (@proy + @s1 + @S2 + @S1M + @S2M + @S3M + @S1S+ @S2S + @ProyS)/3
	Set @sub = (@s1 + @S2 + @S3+ @S1M + @S2M + @S3M + @S1S+ @S2S + @S3S)/3

	-------------------- luego se proyecto al año
	set @partuti = 0
	set @partuti = isnull((select liq_remu_perc+liq_dias_labo from calc_util_pers where codi_pers=@persona and anio=(year(@fecha) -1 )),0)

	Set @annio=@partuti + @montoacum +  @sub * (12 - month(@fecha))
	set @real = @partuti + @montoacum

	Declare @UIT numeric(4)
	Declare @BaseUIT numeric(12,2)
	Declare @NUIT smallint
	Declare @Ren numeric(12,2)
	Declare @ImpAnu numeric(12,2)
	Declare @Exec	numeric(12,2)
	Declare @Dif numeric(12,2)
	Select @UIT=valor from valores_unitarios_anuales where esta_acti='1' and @fecha between fech_asig and fech_asig_fin and codi_valo_unit='1'
	Select @NUIT=valor from valores_unitarios_anuales where esta_acti='1' and @fecha between fech_asig and fech_asig_fin and codi_valo_unit='9'
	
	---------- se calcula la base UIT
	set @baseuit= @uit* @nuit

	------------------- a la poryeccion del año se le resta la base UIT		
	set @ren = @annio  - @baseuit
	set @renreal = @real - @baseuit

	if (@ren<=0) set @ren=0
	if (@renreal <=0) set @renreal=0
	Declare @MFR datetime
	Declare @Nmin1 smallint
	Declare @Nmax1 smallint
	Declare @Porc1 numeric(12,2)
	Declare @Nmin2 smallint
	Declare @Nmax2 smallint
	Declare @Porc2 numeric(12,2)
	Declare @Nmin3 smallint
	Declare @Nmax3 smallint
	Declare @Porc3 numeric(12,2)
	Select @MFR = Max(fech_para) from parametros_quinta


	select @Nmin1=nro_mini_uit, @Nmax1=nro_maxi_uit, @porc1= porcentaje from parametros_quinta where nro_para=1 and fech_para=@mfr
	select @Nmin2=nro_mini_uit, @Nmax2=nro_maxi_uit, @porc2= porcentaje from parametros_quinta where nro_para=2 and fech_para=@mfr
	select @Nmin3=nro_mini_uit, @Nmax3=nro_maxi_uit, @porc3= porcentaje from parametros_quinta where nro_para=3 and fech_para=@mfr
	
	Set @impanu=0
	Set @impureal=0
	-------------------------- se ve q porcentaje se le va aplicar a la diferencia obtenida anteriormente

	if(@ren >=(@Nmin1*@uit) and @ren<=(@Nmax1* @Uit)) set @Impanu=@Ren * @Porc1/100
	if(@ren >(@Nmin2*@uit) and @ren<=(@Nmax2* @Uit)) 
	begin
		set @Exec = @Ren - @Nmax1* @Uit
		set @Impanu=@Nmax1* @Uit * @Porc1 /100 +  @Exec * @Porc2/100
	end
	if(@ren >(@Nmin3*@uit) and @ren<=(@Nmax3* @Uit)) 
	begin
		set @Exec = @Ren - @Nmax2* @Uit
		set @Dif=@Nmax2* @Uit - @Nmin2* @Uit
		set @Impanu=@Nmax1* @Uit *@Porc1 /100 + @Dif * @Porc2/100 +  @Exec * @Porc3/100
	end
	----------------------------------


	if(@renreal >=(@Nmin1*@uit) and @renreal<=(@Nmax1* @Uit)) set @Impureal=@Renreal * @Porc1/100
	if(@renreal >(@Nmin2*@uit) and @renreal<=(@Nmax2* @Uit)) 
	begin
		set @Exec = @Renreal - @Nmax1* @Uit
		set @Impureal=@Nmax1* @Uit * @Porc1 /100 +  @Exec * @Porc2/100
	end
	if(@renreal >(@Nmin3*@uit) and @renreal<=(@Nmax3* @Uit)) 
	begin
		set @Exec = @Renreal - @Nmax2* @Uit
		set @Dif=@Nmax2* @Uit - @Nmin2* @Uit
		set @Impureal=@Nmax1* @Uit *@Porc1 /100 + @Dif * @Porc2/100 +  @Exec * @Porc3/100
	end
	------------------------------------------------------------------------------------------------


	Declare @RenMen numeric(12,2)
	Declare @RenAcu numeric(12,2)		
	Declare @MenReal numeric(12,2)		

	----------------------------Se calcula la renta acumulado de acuerdo al mes actual y se obtiene la Renta Mensual
	set @RenAcu = (select isnull(sum(valor),0) from planilla_de_tripulantes, planilla_tripulante_conceptos where planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip		and codi_conc='200040' and codi_pers=@persona and RIGHT(MESANIO,2)<=month(@fecha)  and LEFT(MESANIO,4)=year(@fecha) 	and codi_sema<@sem )+ 
		 (select isnull(sum(valor),0) from planilla_boni_moto PB, planilla_boni_concepto PBC where 
			PB.codi_plan_boni= PBC.codi_plan_boni and codi_conc='200040' and codi_pers=@persona and left(MESANIO,2)<=month(@fecha)  and right(MESANIO,4)=year(@fecha))+ 
		 (select isnull(sum(valor),0) from planilla_subsidio PS, planilla_subs_concepto PSC where 
			PS.codi_plan_subs= PSC.codi_plan_subs and codi_conc='200040' and codi_pers=@persona and left(MESANIO,2)<=month(@fecha)  and right(MESANIO,4)=year(@fecha))+ 
			(select isnull(sum(valor),0) from calc_util_deta where codi_pers=@persona  and anio=(year(@fecha)-1) and codi_conc='200040') 

	if (@renacu is null) set @renacu=0

	if (month(@Fecha)=1 or month(@Fecha)=2 or month(@Fecha)=3)	set @RenMen =  (@Impanu - @RenAcu)/(12 - month(@fecha)+1)
	if (month(@Fecha)=4 )	set @RenMen = (@Impanu - @RenAcu)/(12 - month(@fecha)+1)
	if (month(@Fecha)=5 or month(@Fecha)=6 or month(@Fecha)=7 )	set @RenMen = (@Impanu - @RenAcu)/(12 - month(@fecha)+1)
	if (month(@Fecha)=8)	set @RenMen = (@Impanu - @RenAcu)/(12 - month(@fecha)+1)
	if (month(@Fecha)=9 or month(@Fecha)=10 or month(@Fecha)=11) set @RenMen = (@Impanu - @RenAcu)/(12 - month(@fecha)+1)
	if (month(@Fecha)=12 )	set @RenMen = (@Impanu - @RenAcu)

	if (month(@Fecha)=1 or month(@Fecha)=2 or month(@Fecha)=3)	set @menreal =  (@Impureal - @RenAcu)/(12 - month(@fecha)+1)
	if (month(@Fecha)=4 )	set @menreal = (@Impureal - @RenAcu)/(12 - month(@fecha)+1)
	if (month(@Fecha)=5 or month(@Fecha)=6 or month(@Fecha)=7 )	set @menreal = (@Impureal - @RenAcu)/(12 - month(@fecha)+1)
	if (month(@Fecha)=8)	set @menreal = (@Impureal - @RenAcu)/(12 - month(@fecha)+1)
	if (month(@Fecha)=9 or month(@Fecha)=10 or month(@Fecha)=11) set @menreal = (@Impureal - @RenAcu)/(12 - month(@fecha)+1)
	if (month(@Fecha)=12 )	set @menreal = (@Impureal - @RenAcu)
	
---------------------------------------------------------------------------------------------------	
----------------- Se calcula la Renta Semanal
	Declare @RenSem numeric(12,2)
	
	--set @RenSem = @RenMen/(@TS - @NS+1)

	return @RenMen
	
END
GO
