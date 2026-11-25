CREATE PROCEDURE [dbo].[sp_carg_trab_plan_vaca]
	@codi_tipo_pers [char](2),
	@orde_por [char](1),
	@MES [int],
	@ANIO [int],
	@codi_pers [char](5) OUTPUT,
	@prom_he25 [decimal](9, 2) OUTPUT,
	@prom_he35 [decimal](9, 2) OUTPUT,
	@nro_mese [int] OUTPUT,
	@nro_dias [int] OUTPUT,
	@fech_inic [datetime] OUTPUT,
	@fech_term [datetime] OUTPUT,
	@otros_ingr [numeric](12, 2) OUTPUT
WITH EXECUTE AS CALLER
AS
/*
declare @codi_tipo_pers char(2), @orde_por char(1),@MES integer, @ANIO integer
declare  @codi_pers char(5) , @prom_he25 decimal(9,2) ,	@prom_he35 decimal(9,2), @prom_dol decimal(9,2) , @prom_fel decimal(9,2) ,
		@nro_mese integer , @nro_dias integer , @fech_inic datetime , @fech_term datetime 
select @codi_tipo_pers ='01', @orde_por ='' , @MES =02, @ANIO =2017

*/

set nocount on 

DECLARE @CODI_PERS_AUXI CHAR(5)
DECLARE @CODI_tipo_PERS_AUXI CHAR(5)
Declare @ls_indi_grab char(1)
DECLARE @cont_plan_vaca integer
DECLARE @MES_INIC smallint
DECLARE @ANIO_INIC smallint
DECLARE @Cont smallint
DECLARE @Cont_he smallint
DECLARE @Cont_he_segu smallint
DECLARE @nro_dias_vaca smallint
Declare @indi_sali bit
Declare @indi_he bit
Declare @indi_he_auxi bit
Declare @prom_he25_auxi decimal(9,2)
Declare @prom_he35_auxi decimal(9,2)
Declare @prom_OTROS decimal(9,2)
Declare @prom_OTROS_auxi decimal(9,2)
declare @fech_ingr datetime
declare @fech_maxi_auxi datetime
declare @fech_inic_auxi datetime
declare @fech_auxi datetime
declare @fech_term_auxi datetime



Create Table #Pers_Temp (Codi_pers char(5), PROM_HE25 DECIMAL(9,2), PROM_HE35 DECIMAL(9,2), NRO_MESE SMALLINT, NRO_DIAS SMALLINT,
			    fech_inic datetime, fech_term datetime, OTROS_INGR numeric(12,2))

set @cont_plan_vaca = 0
if upper(@orde_por) = 'C' 
BEGIN
	if @codi_tipo_pers = '00' 
	begin
		Declare Curs_CARG_TRAB Cursor for 
		Select P.CODI_PERS
		From PERSONAL P, vacaciones V
		WHERE P.ESTA_ACTI = 1 and v.codi_pers = p.codi_pers
		and cast(v.mes as integer) = @mes and cast(v.anio as integer) = @anio;
	end
	else
	begin
		Declare Curs_CARG_TRAB Cursor for 
		Select P.CODI_PERS
		From PERSONAL P, personal_por_tipo_trabajador PT, vacaciones V
		WHERE P.ESTA_ACTI = 1 and P.codi_pers = PT.codi_pers and V.codi_pers = P.codi_pers
		and cast(V.mes as integer) = @mes and cast(V.anio as integer) = @anio AND PT.CODI_TIPO_PERS = @CODI_TIPO_PERS;
	end

END
ELSE
BEGIN
	if @codi_tipo_pers = '00' 
	begin
		Declare Curs_CARG_TRAB Cursor for 
		Select P.CODI_PERS
		From PERSONAL P, vacaciones V
		WHERE P.ESTA_ACTI = 1 and V.codi_pers = P.codi_pers
		and cast(V.mes as integer) = @mes and cast(V.anio as integer) = @anio
		ORDER BY APEL_1, APEL_2, NOMB_1, NOMB_2;
	end
	else
	begin
		Declare Curs_CARG_TRAB Cursor for 
		Select P.CODI_PERS
		From PERSONAL P, personal_por_tipo_trabajador PT, vacaciones V
		WHERE P.ESTA_ACTI = 1 and P.codi_pers = PT.codi_pers and V.codi_pers = P.codi_pers
		and cast(V.mes as integer) = @mes and cast(V.anio as integer) = @anio and PT.codi_tipo_pers = @codi_tipo_pers
			--and p.codi_pers=11
		ORDER BY APEL_1, APEL_2, NOMB_1, NOMB_2;
	end	
END

Open Curs_CARG_TRAB;
Fetch Next From Curs_CARG_TRAB into @CODI_PERS_AUXI

--select @CODI_PERS_AUXI

WHILE @@FETCH_STATUS = 0
	Begin
--		print @codi_tipo_pers_auxi
		set @codi_tipo_pers_auxi = (Select codi_tipo_pers From Personal_por_tipo_trabajador where codi_pers = @codi_pers_auxi)

		if @codi_tipo_pers_auxi = '01' 
		begin
			set @cont_plan_vaca = (Select count(codi_pers) From Planilla_de_empleados where codi_pers = @codi_pers_auxi
						and cast(anio as integer)= @anio and cast(mes as integer) = @mes and codi_tipo_plan = '03')
--			set @cont_plan_vaca=0
		end

		if @codi_tipo_pers_auxi = '02' 
		begin
			set @cont_plan_vaca = (Select count(codi_pers) From Planilla_de_obreros where codi_pers = @codi_pers_auxi
						and cast(anio as integer)= @anio and cast(mes as integer) = @mes and codi_tipo_plan = '03')
		end
--		print @codi_pers_auxi
--		print @cont_plan_vaca
		if @cont_plan_vaca <= 0 
		begin
			set @fech_ingr = (Select fech_ingre from personal where codi_pers = @codi_pers_auxi)

			SET @Fech_Inic = (SELECT TOP 1 FECH_INIC FROM VACACIONES WHERE CODI_PERS = @CODI_PERS_AUXI and mes = @mes and anio  = @anio)
			SET @Fech_Term = (SELECT TOP 1 FECH_Term FROM VACACIONES WHERE CODI_PERS = @CODI_PERS_AUXI and mes = @mes and anio = @anio)
			set @nro_dias_vaca = datediff(day, @Fech_Inic , @Fech_term ) + 1
			set @fech_inic_AUXI = dateadd( month, -6, @fech_inic )
			if @fech_inic_AUXI < @fech_ingr 
			begin 
				set @fech_inic_AUXI = @fech_ingr 
			end
			set @cont_he = 0
			SET @NRO_MESE = 0
			SET @NRO_DIAS = 0
			set @prom_he25 = 0
			set @prom_he35 = 0			
			set @indi_sali = 0
			SET @prom_OTROS =0
			set @cont = 1
			set @cont_he = 0
			set @cont_he_segu = 0
			set @indi_he  = 0

			while @fech_inic_auxi < @Fech_Inic
			begin		
				set @mes_inic = datepart(month, @fech_inic_auxi)
				set @anio_inic = datepart(year, @fech_inic_auxi)				
				set @prom_he25_auxi = 0
				set @prom_he35_auxi = 0		
				SET @prom_OTROS_auxi  =0
				if @codi_tipo_pers_auxi = '01' 
				begin
					set @prom_he25_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P, Planilla_empleado_conceptos PC
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100060' and PC.codi_conc < '100065'))
							--or codi_tipo_plan = '03'
					set @prom_he35_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P, Planilla_empleado_conceptos PC
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100065' and PC.codi_conc < '100070'))
					
					set @prom_otros_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P(nolock), Planilla_empleado_conceptos PC(nolock)
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc = '100020')) 
				end
				if @codi_tipo_pers_auxi = '02' 
				begin
					set @prom_he25_auxi = (Select isnull(sum(valor),0) From Planilla_de_Obreros P, Planilla_obrero_conceptos PC
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100060' and PC.codi_conc < '100065'))
					set @prom_he35_auxi = (Select isnull(sum(valor),0) From Planilla_de_obreros P, Planilla_obrero_conceptos PC
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100065' and PC.codi_conc < '100070'))
					set @prom_otros_auxi = (Select isnull(sum(valor),0) From Planilla_de_Obreros P(nolock), Planilla_obrero_conceptos PC(nolock)
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc = '100020'))
				end			
	
				if @prom_he25_auxi > 0 or @prom_he35_auxi > 0 
				begin
					set @cont_he = @cont_he + 1
					set @indi_he_auxi = 1
				end
				else
				begin
					set @indi_he_auxi = 0
				end

--				print @mes_inic
--				print @anio_inic
--				print @prom_he25_auxi
--				print @prom_he35_auxi
				
				if @cont = 1 
				begin	
					set @INDI_HE = @indi_he_auxi 
					if @prom_he25_auxi > 0 or @prom_he35_auxi > 0 
					begin
						set @cont_he_segu = 1
					end		
					else
					begin
						set @cont_he_segu = 0
					end													
				end
				else
				begin
					if (@indi_he = @indi_he_auxi)
					begin
						if @prom_he25_auxi > 0 or @prom_he35_auxi > 0 
						begin
							set @cont_he_segu =  @cont_he_segu + 1
						end						
					end
					else
					begin
						set @indi_he = @indi_he_auxi
					end
				end	

--				print 'MES '
--				print @MES_INIC

				set @mes_inic = @mes_inic + 1 
				if @mes_inic > 12 
				begin
					set @mes_inic = @mes_inic - 12
					set @anio_inic = @anio_inic + 1
				end	
				set @prom_he25 = @prom_he25 + @prom_he25_auxi
				set @prom_he35 = @prom_he35 + @prom_he35_auxi
				--select @prom_otros_auxi
				set @prom_otros = @prom_otros + @prom_otros_auxi
				set @cont = @cont + 1

/*				print 'indi_he '
				print @indi_he
				print '@prom_he25_auxi '
				print @prom_he25_auxi
				print '@prom_he35_auxi '
				print @prom_he35_auxi
				print '@cont_he '
				print @cont_he
				print '@cont_he_segu '
				print @cont_he_segu 
				print '@nro dias vaca '
				print @nro_dias_vaca  */

				set @fech_inic_AUXI = dateadd( month, 1, @fech_inic_AUXI )
			end
			
--			print '@prom_he25'
--			print @prom_he25
--			print '@prom_he35'
--			print @prom_he35

			--select @codi_pers_auxi, @prom_otros
			if (@cont_he_segu > 2) or (@cont_he >= 3)
			begin				
				set @prom_he25 = (@prom_he25 / 6) 
				set @prom_he35 = (@prom_he35 / 6) 
			end
			else
			begin
				set @prom_he25 = 0
				set @prom_he35 = 0
			end

			set @prom_otros = (@prom_otros / 6)

			Insert Into #Pers_Temp(codi_pers, PROM_HE25, PROM_HE35, NRO_MESE, NRO_DIAS, fech_inic, fech_term, otros_ingr) 
			Values (@codi_pers_auxi, @PROM_HE25, @PROM_HE35, @NRO_MESE, @NRO_DIAS, @fech_inic, @fech_term, @prom_otros )
		end		
		Fetch Next From Curs_CARG_TRAB into @CODI_PERS_AUXI
	End
Close Curs_CARG_TRAB;
Deallocate Curs_CARG_TRAB;

Select codi_pers, PROM_HE25, PROM_HE35, NRO_MESE, NRO_DIAS, fech_inic, fech_term, OTROS_INGR
From #Pers_Temp

drop table #Pers_Temp
GO
