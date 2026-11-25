CREATE PROCEDURE [dbo].[sp_carg_prom_hora_extr]
	@MES [int],
	@ANIO [int],
	@codi_pers [char](5),
	@codi_tipo_pers [char](2),
	@prom_he25 [decimal](9, 2) OUTPUT,
	@prom_he35 [decimal](9, 2) OUTPUT,
	@prom_dol [decimal](9, 2) OUTPUT,
	@prom_fel [decimal](9, 2) OUTPUT,
	@prom_boni [decimal](9, 2) OUTPUT,
	@nro_mese [int] OUTPUT,
	@nro_dias [int] OUTPUT,
	@fech_inic_cts [datetime] OUTPUT
WITH EXECUTE AS CALLER
AS
/*
declare @prom_he25 decimal(9,2) , @prom_he35 decimal(9,2) , @prom_dol decimal(9,2) ,@prom_fel decimal(9,2),@prom_boni decimal(9,2) , 
	 @nro_mese INT , @nro_dias INT , @fech_inic_cts datetime 
declare @MES integer,  @ANIO integer, @codi_pers char(5) ,  @codi_tipo_pers char(2) 
select  @MES =11 ,  @ANIO =2023, @codi_pers ='00003' ,  @codi_tipo_pers ='01'
*/
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
Declare @prom_dol_auxi decimal(9,2)
Declare @prom_fel_auxi decimal(9,2)
Declare @prom_boni_auxi decimal(9,2)

declare @fech_ingr datetime
declare @fech_cese datetime
declare @fech_maxi_auxi datetime
declare @fech_inic_auxi datetime
Declare @fech_mes_sigu datetime
declare @fech_auxi datetime,  @fech_ante datetime
declare @fech_term_auxi datetime
declare @fech_inic datetime
declare @fech_lice datetime
declare @fech_vaca datetime
DECLARE @dias_suel smallint
DECLARE @dias_sala smallint
DECLARE @dias_vaca smallint
DECLARE @dias_vaca_tota smallint
DECLARE @dias_lice smallint
DECLARE @dias_lice_auxi smallint
DECLARE @cont_dias_lice smallint
DECLARE @dias_tota smallint
DECLARE @dias_cts smallint
DECLARE @mese_cts smallint
DECLARE @dias smallint
DECLARE @dias_MES smallint
declare @cont_vaca_febr smallint
declare @cont_vaca smallint
declare @cont_vaca_1 smallint
declare @cont_vaca_2 smallint

Create Table #Pers_Temp (Codi_pers char(5), PROM_HE25 DECIMAL(9,2), PROM_HE35 DECIMAL(9,2) , PROM_DOL DECIMAL(9,2),PROM_FEL DECIMAL(9,2),
			PROM_BONI DECIMAL(9,2), nro_mese INT null, nro_dias INT null, fech_inic datetime null)
set @codi_pers_auxi = @codi_pers
set @cont_plan_vaca = 0
if @cont_plan_vaca <= 0 
begin

	set @fech_ingr = (select max(fech_inicio) from personal_periodo pp(nolock) where pp.codi_pers_categ in
							(select pc.codi_pers_categ from personal_categoria pc(nolock) where pc.codi_pers=@codi_pers))
	
	--set @fech_ingr = (Select max(fech_ingre) from personal where codi_pers = @codi_pers_auxi)
	set @fech_cese = (Select fech_cese from personal where codi_pers = @codi_pers_auxi)
--	print '01/' 
--	print cast( @mes as char(2)) + '/' 
--	print cast( @anio as char(4)) 
--	print '01/' + cast( @mes as char(2)) + '/' + cast( @anio as char(4)) 
	SET @Fech_Inic = cast( '01/' + cast( @mes as char(2)) + '/' + cast( @anio as char(4))  as datetime ) 

	SET @Fech_Inic = isnull(@fech_cese ,cast( '01/' + cast( @mes as char(2)) + '/' + cast( @anio as char(4))  as datetime ) )
	
--	set @fech_inic_AUXI = dateadd( month, -6, @fech_inic ) 
	
	if month(@fech_inic) > 5 and month(@fech_inic) <=11  set @fech_inic_AUXI =cast( '01/05/' + cast( @anio as char(4))  as datetime )
	if month(@fech_inic) <= 5  set @fech_inic_AUXI =cast( '01/11/' + cast( @anio - 1  as char(4))  as datetime )
	if month(@fech_inic) > 11  set @fech_inic_AUXI =cast( '01/11/' + cast( @anio  as char(4))  as datetime )
	
--	set @fech_inic_AUXI = dateadd( month, -6, @fech_inic ) 
--	print @fech_inic_AUXI
	--select @fech_inic_AUXI , @fech_ingr
	
	if @fech_inic_AUXI < @fech_ingr
	begin 
		set @fech_inic_AUXI = @fech_ingr
	end
	
	set @fech_ante =  (select max(fech_term) from datos_Cts where codi_pers=@codi_pers)
	
	if @fech_ante is not null 
	begin
		set @fech_ante = dateadd(dd,1,@fech_ante)
		if @fech_ante>@fech_inic_AUXI set @fech_inic_AUXI = @fech_ante
	end

	set @fech_inic_cts = @fech_inic_AUXI
	set @cont_he = 0
	set @prom_he25 = 0
	set @prom_he35 = 0	
	set @prom_BONI  =0
	set @prom_dol = 0
	set @prom_fel = 0		

	set @indi_sali = 0
	set @cont = 1
	set @cont_he = 0
	set @cont_he_segu = 0
	set @indi_he  = 0
	set @dias_tota = 0
	set @dias_cts = 0
	set @mese_cts = 0
	set @cont_vaca_febr = 0 
	SET @dias_MES = 0
	set @dias_vaca_tota = 0
	if @fech_cese is null or year( @fech_cese ) = 1900 begin set @fech_cese =   dateadd( DAY, 1, @Fech_Inic ) end
--			select @fech_inic_auxi ,@Fech_Inic , @fech_inic_auxi ,@fech_cese

	while @fech_inic_auxi < @Fech_Inic and @fech_inic_auxi <= @fech_cese
	begin		

		set @mes_inic = datepart(month, @fech_inic_auxi)
		set @anio_inic = datepart(year, @fech_inic_auxi)				
		set @fech_mes_sigu = dateadd( month, 1, @fech_inic_AUXI )
		set @fech_mes_sigu = cast( '01/' + cast( month ( @fech_mes_sigu ) as char(2) ) + '/' + cast( year ( @fech_mes_sigu ) as char(4) )  as datetime )
		set @fech_mes_sigu = dateadd( DAY, -1, @fech_mes_sigu )

		SET @dias_mes = datepart(DAY, @fech_mes_sigu)
--		print @fech_mes_sigu
		set @prom_he25_auxi = 0
		set @prom_he35_auxi = 0	
		set @prom_dol_auxi = 0
		set @prom_fel_auxi = 0
		set @prom_boni_auxi =0

		if @codi_tipo_pers = '01'
		begin
			Select @codi_tipo_pers_auxi = isnull( codi_tipo_pers , '') from planilla_de_empleados
			where cast( mes as integer) = @mes_inic and cast( anio as integer) = @anio_inic and codi_pers = @codi_pers_auxi and indi_tiem = 'M'
		end
		if @codi_tipo_pers = '02' 
		begin
			Select @codi_tipo_pers_auxi = isnull( codi_tipo_pers , '') from planilla_de_obreros
			where cast( mes as integer) = @mes_inic and cast( anio as integer) = @anio_inic and codi_pers = @codi_pers_auxi and indi_tiem = 'M'
		end
		if @codi_tipo_pers_auxi = '01' 
		begin
			set @prom_he25_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P, Planilla_empleado_conceptos PC
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
					and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100060' and PC.codi_conc < '100065'))
					--or codi_tipo_plan = '03'
			set @prom_he35_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P, Planilla_empleado_conceptos PC
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
					and (P.codi_tipo_plan  in ('01','03')) and P.indi_tiem = 'M' and ( (PC.codi_conc >= '100065' and PC.codi_conc < '100070') or PC.codi_conc ='100116')  ) 
			set @prom_dol_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P(nolock), Planilla_empleado_conceptos PC(nolock)
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
					and (P.codi_tipo_plan  in ('01')) and P.indi_tiem = 'M' and (PC.codi_conc in ('100042','100111')))

			set @prom_fel_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P(nolock), Planilla_empleado_conceptos PC(nolock)
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
					and (P.codi_tipo_plan  in ('01')) and P.indi_tiem = 'M' and (PC.codi_conc in ('100046','100112')))

			set @prom_boni_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P(nolock), Planilla_empleado_conceptos PC(nolock)
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
					and (P.codi_tipo_plan  in ('01')) and P.indi_tiem = 'M' and (PC.codi_conc='100020'))

		end
		if @codi_tipo_pers_auxi = '02' 
		begin
			set @prom_he25_auxi = (Select isnull(sum(valor),0) From Planilla_de_Obreros P, Planilla_obrero_conceptos PC
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
					and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100060' and PC.codi_conc < '100065'))
			set @prom_he35_auxi = (Select isnull(sum(valor),0) From Planilla_de_obreros P, Planilla_obrero_conceptos PC
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
					and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100065' and PC.codi_conc < '100070'))

			set @prom_dol_auxi = (Select isnull(sum(valor),0) From Planilla_de_obreros P(nolock), Planilla_obrero_conceptos PC(nolock)
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
					and (P.codi_tipo_plan  in ('01')) and P.indi_tiem = 'M' and (PC.codi_conc in ('100042','100111')))
			set @prom_fel_auxi = (Select isnull(sum(valor),0) From Planilla_de_obreros P(nolock), Planilla_obrero_conceptos PC(nolock)
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
					and (P.codi_tipo_plan  in ('01')) and P.indi_tiem = 'M' and (PC.codi_conc in ('100046','100112')))
			set @prom_boni_auxi = (Select isnull(sum(valor),0) From Planilla_de_obreros P(nolock), Planilla_obrero_conceptos PC(nolock)
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
					and (P.codi_tipo_plan  in ('01')) and P.indi_tiem = 'M' and (PC.codi_conc='100020'))

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
		set @dias_suel = 0
		set @dias_sala = 0
		set @dias_vaca = 0
		set @cont_vaca =  0
		SET @dias = 0
		set @dias_suel = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and pe.anio  = @anio_inic and cast( pe.mes as integer )  = @mes_inic 
				and ( pec.codi_conc in( '500000', '500001', '500002', '500006', '500007', '500510', '500610' , '500800' , '500810', '500820') )
				and pe.codi_tipo_pers = '01' and pe.indi_tiem = 'M' and (  pe.codi_tipo_plan = '01' ) )
		set @dias_sala =( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio_inic and cast( pe.mes as integer )  = @mes_inic 
				and ( pec.codi_conc in( '500000', '500001', '500002', '500006', '500007', '500510', '500610' , '500800' , '500810', '500820') )
				and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M' and (  pe.codi_tipo_plan = '01' ) ) 

		set @dias_vaca = 0
		set @cont_vaca_1  = (Select  count( codi_pers)   from vacaciones
		where codi_pers = @codi_pers_auxi and codi_tipo_vaca <> '02'
		and ( fech_inic between @fech_inic_auxi  and @fech_mes_sigu  or fech_term between @fech_inic_auxi  and @fech_mes_sigu  )  )
		if @cont_vaca_1 > 0 
		begin
			set @cont_vaca_2 = 0 
			set @cont_vaca_2 = (Select  count( codi_pers)   from vacaciones
			where codi_pers = @codi_pers_auxi and codi_tipo_vaca <> '02'
			and ( fech_inic between @fech_inic_auxi  and @fech_mes_sigu  and fech_term between @fech_inic_auxi  and @fech_mes_sigu  )  )
			if @cont_vaca_2 > 0
			begin
				set @dias_vaca = (Select  sum(isnull( datediff( day, fech_inic , fech_term ) + 1 ,0 ))   from vacaciones
				where codi_pers = @codi_pers_auxi and codi_tipo_vaca <> '02'
				and ( fech_inic between @fech_inic_auxi  and @fech_mes_sigu  and fech_term between @fech_inic_auxi  and @fech_mes_sigu  )  )
--				print '00'
--				print @dias_vaca
			end
			else
			begin				
				set @cont_vaca_2 = 0 
				set @cont_vaca_2 = (Select  count( codi_pers)   from vacaciones (nolock)
				where codi_pers = @codi_pers_auxi and codi_tipo_vaca <> '02'
				and ( fech_inic between @fech_inic_auxi  and @fech_mes_sigu  )  ) 
				if @cont_vaca_2 > 0
				begin
					set @fech_vaca = (Select  fech_inic  from vacaciones (nolock)
					where codi_pers = @codi_pers_auxi  and codi_tipo_vaca <> '02'
					and ( fech_inic between @fech_inic_auxi  and @fech_mes_sigu  )  ) 

					set @dias_vaca = datediff( day, @fech_vaca , @fech_mes_sigu ) + 1
--					print '01'
--					print @dias_vaca
				end
				else
				begin
					set @fech_vaca = (Select  fech_term  from vacaciones (nolock)
					where codi_pers = @codi_pers_auxi and codi_tipo_vaca <> '02'
					and ( fech_term between @fech_inic_auxi  and @fech_mes_sigu  )  ) 

					set @dias_vaca = datediff( day, @fech_inic_auxi, @fech_vaca ) + 1
--					print '02'
--					print @dias_vaca
				end

			end

		end
/*
		set @cont_dias_lice = (Select  count( codi_pers)   from licencias_por_personal
		where codi_pers = @codi_pers_auxi and goce_habe = 1 
		and ( fech_inic between @fech_inic_auxi  and @fech_mes_sigu  or fech_term between @fech_inic_auxi  and @fech_mes_sigu  )  )
		set @dias_lice = 0 
		if @cont_dias_lice > 0 
		begin
			set @dias_lice_auxi = 0 
			Select  @cont_dias_lice = count( codi_pers)
			From licencias_por_personal
			where codi_pers = @codi_pers_auxi and goce_habe = 1 
			and ( fech_inic between @fech_inic_auxi  and @fech_mes_sigu  ) and ( fech_term between @fech_inic_auxi  and @fech_mes_sigu  ) 
			if @cont_dias_lice > 0
			begin
				Select  @dias_lice_auxi = nro_dias_remu
				From licencias_por_personal
				where codi_pers = @codi_pers_auxi and goce_habe = 1 
				and ( fech_inic between @fech_inic_auxi  and @fech_mes_sigu  ) and ( fech_term between @fech_inic_auxi  and @fech_mes_sigu  ) 

			end
			else
			begin				
				set @cont_dias_lice = (Select  count( codi_pers) from licencias_por_personal
				where codi_pers = @codi_pers_auxi and goce_habe = 1 
				and not codi_tipo_lice in ( SELECT CODI_TIPO_LICE FROM TIPOS_LICENCIAS
						WHERE UPPER(DESC_LICE ) LIKE 'ENFERMEDAD%' OR UPPER(DESC_LICE ) LIKE 'SUBSIDIO%' 
						OR UPPER(DESC_LICE ) LIKE 'COMISI%'
					 )
				and ( fech_inic between @fech_inic_auxi  and @fech_mes_sigu  )  ) 
				if @cont_dias_lice > 0
				begin
					set @fech_lice = (Select  fech_inic  from licencias_por_personal
					where codi_pers = @codi_pers_auxi and goce_habe = 1 
					and not codi_tipo_lice in ( SELECT CODI_TIPO_LICE FROM TIPOS_LICENCIAS
						WHERE UPPER(DESC_LICE ) LIKE 'ENFERMEDAD%' OR UPPER(DESC_LICE ) LIKE 'SUBSIDIO%' 
						OR UPPER(DESC_LICE ) LIKE 'COMISI%'
					 )
					and ( fech_inic between @fech_inic_auxi  and @fech_mes_sigu  )  ) 
					set @dias_lice_auxi = datediff( day, @fech_inic_auxi , @fech_lice ) + 1
				end
				else
				begin
					set @fech_lice = (Select  fech_term  from licencias_por_personal
					where codi_pers = @codi_pers_auxi and goce_habe = 1 
					and not codi_tipo_lice in ( SELECT CODI_TIPO_LICE FROM TIPOS_LICENCIAS
						WHERE UPPER(DESC_LICE ) LIKE 'ENFERMEDAD%' OR UPPER(DESC_LICE ) LIKE 'SUBSIDIO%' 
						OR UPPER(DESC_LICE ) LIKE 'COMISI%'
					 )
					and ( fech_term between @fech_inic_auxi  and @fech_mes_sigu  )  ) 
					set @dias_lice_auxi = datediff( day, @fech_inic_auxi, @fech_lice ) + 1
				end
			end
			print @fech_inic_auxi
			print @dias_lice_auxi
		end
*/
		set @dias_lice_auxi = 0
		set @dias = isnull( @dias_suel , 0 )  + isnull( @dias_sala , 0 )  + isnull( @dias_vaca , 0 )  + isnull(@dias_lice_auxi, 0)
		set @dias_tota = @dias_tota + isnull( @dias_suel , 0 )  + isnull( @dias_sala , 0 )  + isnull( @dias_vaca , 0 )    + isnull(@dias_lice_auxi, 0 )
/*
		print '-----------'
		print @mes_inic
		print @dias_mes 
		print @dias_suel 
		print @dias_sala 
		print @dias_vaca 
		print @dias_lice_auxi 
		print '@nro dias TOTA ' + CAST( @dias AS VARCHAR)
		print '***************'  
*/
		if @mes_inic = 2 
		begin			
			if @dias >= 28 
			begin
				set @dias = 30
				set @mese_cts = @mese_cts + 1			
			end
			else
			begin
				set @dias_cts = @dias_cts + @dias				
			end		
			if @dias_vaca > 0 begin set @cont_vaca_febr = 1 end
		end	
		else
		begin
			if @cont_vaca_febr  = 1 and @dias < 30  begin set @dias = @dias + 2 end
			if @dias >= @dias_mes 
			begin
				set @dias = @dias_mes
				set @mese_cts = @mese_cts + 1
			end			
			else
			begin
				if @dias > 30 begin set @dias = 30 end
				set @dias_cts = @dias_cts + @dias				
			end			
		end
/*		print ' aaaa '
		print ' DIAS CTS '  + CAST( @dias_CTS AS VARCHAR)
		print ' MESES CTS '  + CAST( @mese_cts AS VARCHAR) 
*/
		IF @DIAS_VACA > 0 
		BEGIN
			if isnull( @dias_suel , 0 )  + isnull( @dias_sala , 0 )  + isnull( @dias_vaca , 0 )  + isnull(@dias_lice_auxi, 0)  > @dias_mes
			begin
				set @dias_cts = @dias_cts + ( isnull( @dias_suel , 0 )  + isnull( @dias_sala , 0 )  + isnull( @dias_vaca , 0 ) + isnull(@dias_lice_auxi, 0)  - @dias_mes )
			end			
		END		
/*
		print ' aaaa 222222222222'
		print ' DIAS CTS '  + CAST( @dias_CTS AS VARCHAR)
		print ' MESES CTS '  + CAST( @mese_cts AS VARCHAR) 
*/
		set @mes_inic = @mes_inic + 1 
		if @mes_inic > 12 
		begin
			set @mes_inic = @mes_inic - 12
			set @anio_inic = @anio_inic + 1
		end	
		set @prom_he25 = @prom_he25 + @prom_he25_auxi
		set @prom_he35 = @prom_he35 + @prom_he35_auxi

		set @prom_dol   = @prom_dol   + @prom_dol_auxi
		set @prom_fel   = @prom_fel   + @prom_fel_auxi
		set @prom_BONI   = @prom_BONI  + @prom_BONI_auxi

		set @cont = @cont + 1

		set @fech_inic_AUXI = dateadd( month, 1, @fech_inic_AUXI )
	end
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
/*	print '  CERRAR PERIODO vvv'
	print ' DIAS CTS '  + CAST( @dias_CTS AS VARCHAR)
	print ' MESES CTS '  + CAST( @mese_cts AS VARCHAR) 
*/	
	set @prom_dol = (@prom_dol / 6) 
	set @prom_fel = (@prom_fel / 6) 
	set @prom_boni = (@prom_BONI / 6)

	if @PROM_BONI is null set @PROM_BONI=0

	if @dias_cts >= 30 
	begin
		set @mese_cts = @mese_cts + round( @dias_cts / 30 , 0, 1 )
		set @dias_cts = @dias_cts - ( round( @dias_cts / 30 , 0, 1 ) ) * 30		
	end
/*	print '   FINAL xxxxxxxxxxxxvvv'
	print @dias_CTS
	print @mese_cts
*/
	if @mese_cts = 6 begin set @dias_cts = 0 end
	if datediff(month, @fech_inic_cts, @fech_inic) >= 1 or (datediff(day, @fech_inic_cts, @fech_inic) + 1)>=30
	begin
		Insert Into #Pers_Temp(codi_pers, PROM_HE25, PROM_HE35, PROM_DOL, PROM_FEL, PROM_BONI, nro_mese, nro_dias, fech_inic) 
		Values (@codi_pers_auxi, @PROM_HE25, @PROM_HE35, @PROM_DOL, @PROM_FEL, @PROM_BONI, @mese_cts, @dias_cts, @fech_inic_cts )
	end
end		
Select  PROM_HE25, PROM_HE35, PROM_DOL, PROM_FEL, PROM_BONI, nro_mese, nro_dias, fech_inic
From #Pers_Temp

drop table #Pers_Temp
GO
