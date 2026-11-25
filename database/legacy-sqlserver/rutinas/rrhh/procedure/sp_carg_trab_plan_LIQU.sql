CREATE PROCEDURE [dbo].[sp_carg_trab_plan_LIQU]
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
	@codi_tipo_plan [char](2) OUTPUT,
	@otros_ingr [numeric](12, 2) OUTPUT
WITH EXECUTE AS CALLER
AS
/*
declare @codi_tipo_pers char(2),  @orde_por char(1), @MES integer, @ANIO integer, @codi_pers char(5) , @prom_he25 decimal(9,2) , @prom_he35 decimal(9,2) ,
		@prom_dol decimal(9,2) , @prom_fel decimal(9,2), 
        @nro_mese integer , @nro_dias integer , @fech_inic datetime , @fech_term datetime ,
		@otros_ingr decimal(9,2)

select @codi_tipo_pers ='01',  @orde_por ='C', @MES =11, @ANIO =2023		 
*/

DECLARE @CODI_PERS_AUXI CHAR(5)
DECLARE @CODI_TIPO_PLAN_AUXI CHAR(2)
DECLARE @CODI_TIPO_PLAN_vaca CHAR(2)
DECLARE @CODI_TIPO_PLAN_grat CHAR(2)
DECLARE @CODI_tipo_PERS_AUXI CHAR(5)
Declare @ls_indi_grab char(1)
DECLARE @cont_plan_vaca integer
DECLARE @cont_Cts integer
DECLARE @MES_INIC smallint
DECLARE @ANIO_INIC smallint
DECLARE @MES_AUXI smallint
DECLARE @ANIO_AUXI smallint
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

Declare @fech_sali datetime
Declare @fech_inic_auxi datetime
Declare @fech_fin_auxi datetime
Declare @fech_auxi datetime
Declare @fech_ingr datetime
Declare @fech_maxi_auxi datetime
Declare @fech_term_plan_maxi datetime
Declare @fech_inic_plan_mini datetime

/*declare @codi_tipo_pers char(2), @orde_por char(1),@MES integer, @ANIO integer
declare  @codi_pers char(5) , @prom_he25 decimal(9,2) ,	@prom_he35 decimal(9,2), @prom_dol decimal(9,2) , @prom_fel decimal(9,2) ,
	@nro_mese integer , @nro_dias integer , @fech_inic datetime , @fech_term datetime , @otros_ingr numeric(12,2) 
select @codi_tipo_pers ='01', @orde_por ='' , @MES =01, @ANIO =2011*/

Create Table #Pers_Temp (Codi_pers char(5), PROM_HE25 DECIMAL(9,2), 
PROM_HE35 DECIMAL(9,2), NRO_MESE SMALLINT, NRO_DIAS SMALLINT, fech_inic datetime, fech_term datetime, codi_tipo_plan char(2),OTROS_INGR numeric(12,2) )

SET @CODI_TIPO_PLAN_vaca = ( Select codi_tipo_plan From Tipos_planillas where upper(desc_tipo_plan) = 'VACACIÓN' or upper(desc_tipo_plan) = 'VACACIONES' )
SET @CODI_TIPO_PLAN_grat = ( Select codi_tipo_plan From Tipos_planillas where upper(desc_tipo_plan) = 'GRATIFICACIÓN' or upper(desc_tipo_plan) = 'GRATIFICACIONES' )

set @cont_plan_vaca = 0
if upper(@orde_por) = 'C'
BEGIN
	if @codi_tipo_pers = '00'
	begin
		Declare Curs_CARG_TRAB Cursor for
		Select P.CODI_PERS, p.fech_cese, p.fech_ingre
		From PERSONAL P (nolock)
		WHERE P.ESTA_ACTI = 1 and DATEPART(MONTH, p.FECH_cese) = @mes and DATEPART(YEAR, p.fech_cese) = @anio;
	end
	else
	begin
		Declare Curs_CARG_TRAB Cursor for
		Select P.CODI_PERS,p.fech_cese, p.fech_ingre
		From PERSONAL P (nolock), PERSONAL_POR_TIPO_TRABAJADOR PT (nolock)
		WHERE P.ESTA_ACTI = 1 and  DATEPART(MONTH, p.FECH_cese) = @mes and DATEPART(YEAR, p.FECH_cese ) = @anio 
		AND PT.CODI_TIPO_PERS = @CODI_TIPO_PERS and p.codi_pers = pt.codi_pers;
	end

END
ELSE
BEGIN
	if @codi_tipo_pers = '00'
	begin
		Declare Curs_CARG_TRAB Cursor for
		Select P.CODI_PERS, p.fech_cese, p.fech_ingre
		From PERSONAL P (nolock)
		WHERE P.ESTA_ACTI = 1 and DATEPART(MONTH, p.fech_cese ) = @mes and DATEPART(YEAR, p.FECH_cese ) = @anio
		ORDER BY APEL_1, APEL_2, NOMB_1, NOMB_2;
	end
	else
	begin
		Declare Curs_CARG_TRAB Cursor for
		Select P.CODI_PERS, p.fech_cese, p.fech_ingre
		From PERSONAL P (nolock), PERSONAL_POR_TIPO_TRABAJADOR PT (nolock)
		WHERE P.ESTA_ACTI = 1 and DATEPART(MONTH, p.FECH_cese ) = @mes and DATEPART(YEAR, p.FECH_cese ) = @anio 
		AND PT.CODI_TIPO_PERS = @CODI_TIPO_PERS and p.codi_pers = pt.codi_pers
		ORDER BY APEL_1, APEL_2, NOMB_1, NOMB_2;
	end
END

Open Curs_CARG_TRAB;
Fetch Next From Curs_CARG_TRAB into @CODI_PERS_AUXI, @fech_auxi, @fech_ingr
WHILE @@FETCH_STATUS = 0
	Begin
		set @codi_tipo_pers_auxi = (Select codi_tipo_pers From Personal_por_tipo_trabajador (nolock) where codi_pers = @codi_pers_auxi)
--		LIQUIDACIONES
--		print @codi_tipo_pers_auxi
		SET @CODI_TIPO_PLAN_AUXI = ( Select codi_tipo_plan From Tipos_planillas where upper(desc_tipo_plan) = 'LIQUIDACIÓN' or upper(desc_tipo_plan) = 'LIQUIDACIONES' )
		if @codi_tipo_pers_auxi = '01'
		begin
			set @cont_plan_vaca = (Select count(codi_pers) From Planilla_de_empleados (nolock) where codi_pers = @codi_pers_auxi
						and cast(anio as integer)= @anio and cast(mes as integer) = @mes and codi_tipo_plan = @CODI_TIPO_PLAN_AUXI	)
			set @fech_term_plan_maxi = (Select isnull( max (fech_term) , @fech_ingr ) From Planilla_de_empleados (nolock) Where codi_pers = @codi_pers_auxi and indi_tiem = 'M' and codi_tipo_plan = '01')
		end
		if @codi_tipo_pers_auxi = '02'
		begin
			set @cont_plan_vaca = (Select count(codi_pers) From Planilla_de_obreros (nolock) where codi_pers = @codi_pers_auxi and cast(anio as integer)= @anio and cast(mes as integer) = @mes and codi_tipo_plan = @CODI_TIPO_PLAN_AUXI)
			set @fech_term_plan_maxi = (Select isnull( max (fech_term) , @fech_ingr ) From Planilla_de_obreros (nolock) Where codi_pers = @codi_pers_auxi and indi_tiem = 'M' and codi_tipo_plan = '01')
		end
		set @fech_inic_plan_mini = dateadd( month, -6 , @fech_term_plan_maxi)
		if @cont_plan_vaca <= 0
		begin
			--crear cts de Liquidación
			Set @fech_maxi_auxi = (Select isnull ( max( Fech_term) ,  @fech_ingr)  From Datos_Cts (nolock) where codi_pers = @codi_pers_auxi )
			if @fech_maxi_auxi > @fech_ingr begin set @fech_maxi_auxi = dateadd(day, 1, @fech_maxi_auxi ) end
			set @fech_inic = @fech_maxi_auxi
			set @fech_term = @fech_AUXI
			set @nro_dias_vaca = datediff(day, @Fech_Inic , @Fech_term )
			SET @NRO_MESE = 0 --round(datediff(MONTH, @Fech_Inic , @Fech_term ) ,0)
			SET @NRO_DIAS = 0
			set @prom_he25 = 0
			set @prom_he35 = 0
			SET @prom_OTROS =0

			Insert Into #Pers_Temp(codi_pers, PROM_HE25, PROM_HE35, NRO_MESE, NRO_DIAS, fech_inic, fech_term, codi_tipo_plan, OTROS_INGR )
			Values (@codi_pers_auxi, @PROM_HE25, @PROM_HE35, @NRO_MESE, @NRO_DIAS, @fech_inic, @fech_term, @codi_tipo_plan_auxi, @otros_ingr )
			--Fin Crear Cursor Para CTS de Liquidación
		end
--		GRATIFICACIONES TRUNCAS
--		print @codi_tipo_pers_auxi
		SET @CODI_TIPO_PLAN_AUXI = ( Select codi_tipo_plan From Tipos_planillas (nolock) where upper(desc_tipo_plan) = 'GRATIFICACIÓN TRUNCA' or upper(desc_tipo_plan) = 'GRATIFICACIONES TRUNCAS' )
		if @codi_tipo_pers_auxi = '01'
		begin
			set @cont_plan_vaca = (Select count(codi_pers) From Planilla_de_empleados (nolock) where codi_pers = @codi_pers_auxi and cast(anio as integer)= @anio and cast(mes as integer) = @mes and  codi_tipo_plan = @CODI_TIPO_PLAN_AUXI)
		end
		if @codi_tipo_pers_auxi = '02'
		begin
			set @cont_plan_vaca = (Select count(codi_pers) From Planilla_de_obreros (nolock) where codi_pers = @codi_pers_auxi and cast(anio as integer)= @anio and cast(mes as integer) = @mes and codi_tipo_plan = @CODI_TIPO_PLAN_AUXI)
		end
		if @cont_plan_vaca <= 0
		begin
			--Crear Datos Gratificaciones Truncas
			if @codi_tipo_pers_auxi = '01'
			begin
				set @fech_maxi_auxi  = (Select --isnull ( max( Fech_term) ,  @fech_ingr)  
						case when isnull ( max( Fech_term) ,  @fech_ingr) <=@fech_ingr then @fech_ingr else max(fech_Term) end 
						From Planilla_de_empleados (nolock) where codi_pers = @codi_pers_auxi
							and ( codi_tipo_plan = @CODI_TIPO_PLAN_grat	OR codi_tipo_plan = @CODI_TIPO_PLAN_AUXI ) )
			end
			if @codi_tipo_pers_auxi = '02'
			begin
				set @fech_maxi_auxi  = (Select --isnull ( max( Fech_term) ,  @fech_ingr)  
						case when isnull ( max( Fech_term) ,  @fech_ingr) <=@fech_ingr then @fech_ingr else max(fech_Term) end 
						From Planilla_de_obreros (nolock) where codi_pers = @codi_pers_auxi
							and ( codi_tipo_plan = @CODI_TIPO_PLAN_grat	OR codi_tipo_plan = @CODI_TIPO_PLAN_AUXI ) )
				
			end
			/*if @fech_maxi_auxi < @fech_ingr begin set @fech_maxi_auxi = @fech_ingr end
			if year(@fech_maxi_auxi ) = 1900 begin set @fech_maxi_auxi = @fech_ingr end
			if @fech_maxi_auxi > @fech_ingr begin set @fech_maxi_auxi = dateadd(day, 1, @fech_maxi_auxi ) end
			IF DATEPART(MONTH, @fech_maxi_auxi ) <> 1 BEGIN SET @fech_maxi_auxi = DATEADD( MONTH, -1 , @fech_maxi_auxi) END*/
			
			IF DATEdiff(month, @fech_maxi_auxi, @fech_AUXI ) >= 12
			BEGIN
				SET @fech_maxi_auxi = DATEADD( MONTH, -12 , @fech_auxi)
				SET @fech_maxi_auxi = DATEADD( day, 1 , @fech_maxi_auxi )
			END
			
			set @fech_inic =dateadd(d,1,@fech_maxi_auxi)
			set @fech_term = @fech_AUXI

			set @nro_dias_vaca = 0 --datediff(day, @Fech_Inic , @Fech_term )

			set @cont_he = 0
			SET @NRO_MESE = 0
			SET @NRO_DIAS = 0
			set @prom_he25 = 0
			set @prom_he35 = 0	
			SET @prom_OTROS =0		
			set @mes_inic = datepart(month, @fech_inic)
			set @anio_inic = datepart(year, @fech_inic)
			set @indi_sali = 0
			set @cont = 1
			set @cont_he = 0
			set @cont_he_segu = 0
			set @indi_he  = 0
			while @mes_inic < @mes
			begin		
				set @prom_he25_auxi = 0
				set @prom_he35_auxi = 0		
				SET @prom_OTROS_auxi  =0
				if @codi_tipo_pers_auxi = '01' 
				begin
					set @prom_he25_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P (nolock), Planilla_empleado_conceptos PC (nolock)
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100060' and PC.codi_conc < '100065'))
							--or codi_tipo_plan = '03'
					set @prom_he35_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P (nolock), Planilla_empleado_conceptos PC (nolock)
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100065' and PC.codi_conc < '100070'))

					set @prom_otros_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P(nolock), Planilla_empleado_conceptos PC(nolock)
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc = '100020')) 
				end
				if @codi_tipo_pers_auxi = '02' 
				begin
					set @prom_he25_auxi = (Select isnull(sum(valor),0) From Planilla_de_Obreros P (nolock), Planilla_obrero_conceptos PC (nolock)
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100060' and PC.codi_conc < '100065'))
					set @prom_he35_auxi = (Select isnull(sum(valor),0) From Planilla_de_obreros P (nolock), Planilla_obrero_conceptos PC (nolock)
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
			end
/*			print '@prom_he25'
			print @prom_he25
			print '@prom_he35'
			print @prom_he35 */
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

			Insert Into #Pers_Temp(codi_pers, PROM_HE25, PROM_HE35, NRO_MESE, NRO_DIAS, fech_inic, fech_term, codi_tipo_plan, otros_ingr)
			Values (@codi_pers_auxi, @PROM_HE25, @PROM_HE35, @NRO_MESE, @NRO_DIAS, 	@fech_inic, @fech_term, @codi_tipo_plan_auxi, @prom_otros)
			--Fin Crear Cursor Para CTS de Liquidación
		end
--		VACACIONES TRUNCAS
		SET @CODI_TIPO_PLAN_AUXI = ( Select codi_tipo_plan From Tipos_planillas (nolock) where upper(desc_tipo_plan) = 'VACACIÓN TRUNCA' or upper(desc_tipo_plan) = 'VACACIONES TRUNCAS' )
		if @codi_tipo_pers_auxi = '01'
		begin
			set @cont_plan_vaca = (Select count(codi_pers) From Planilla_de_empleados (nolock) where codi_pers = @codi_pers_auxi and cast(anio as integer)= @anio and cast(mes as integer) = @mes and  codi_tipo_plan = @CODI_TIPO_PLAN_AUXI  )
		end
		if @codi_tipo_pers_auxi = '02'
		begin
			set @cont_plan_vaca = (Select count(codi_pers) From Planilla_de_obreros (nolock) where codi_pers = @codi_pers_auxi
						and cast(anio as integer)= @anio and cast(mes as integer) = @mes and codi_tipo_plan = @CODI_TIPO_PLAN_AUXI)
		end
		if @cont_plan_vaca <= 0
		begin
			
			declare @ld_fech_ingr datetime, @ld_fech_inic_peri datetime , @ld_fech_inic_peri_xxx datetime
		   --Crear Datos Vacaciones Truncas      
			declare @Fxv datetime, @Fv datetime, @fech_cese datetime
			declare @CtPv int, @Rv int, @DiasVaca int, @ctp int 
			set @CtPv=0
			set @fech_cese = @fech_auxi
			set @fech_inic = @fech_ingr
			set @fech_term = @fech_cese      
			set @FxV = @fech_inic
			
			---------------- determinar Número de periodos
			while @FxV<@Fech_cese
			begin
				set @CtPv = @CtPv + 1 
				set @Fxv = dateadd(yy,1,@Fxv)		
				if @Fxv>@Fech_cese set @Fv =dateadd(yy,-1,@Fxv)
			end
			
		   set @diasvaca= isnull((select sum(nro_dias) from vacaciones (nolock) where codi_pers=@codi_pers_auxi and fech_inic>=@fech_ingr  and codi_tipo_vaca<>'03'),0)
		   
		   set @Rv= isnull(@diasvaca/30,0)

		--select @CtPv , @Rv, @Fv,@Fxv    
			----------------------------------Fin periodos

			set @FxV = @fech_ingr
			set @ctp =1
			
			while @ctp <=@Rv
			begin
				set @ctp=@ctp + 1 
				set @Fxv = dateadd(yy,1,@Fxv)		
			end
			-- select @CtPv , @Rv, @Fv,@Fxv    
		   if @Fxv<>@fech_ingr 
				set @Fech_inic=dateadd(d,1,@Fxv)
		   else
				set @Fech_inic=@Fxv
				
		   set @fech_inic_AUXI =@Fech_inic
			
			/*--Crear Datos Vacaciones Truncas
			if @codi_tipo_pers_auxi = '01'
			begin
				set @fech_maxi_auxi  = (Select isnull ( max( Fech_term) ,  @fech_ingr)  From Planilla_de_empleados (nolock) where codi_pers = @codi_pers_auxi
							and ( codi_tipo_plan = @CODI_TIPO_PLAN_vaca OR codi_tipo_plan = @CODI_TIPO_PLAN_AUXI ) )
			end
			if @codi_tipo_pers_auxi = '02'
			begin
				set @fech_maxi_auxi  = (Select isnull ( max( Fech_term) ,  @fech_ingr)  From Planilla_de_obreros (nolock) where codi_pers = @codi_pers_auxi
							and ( codi_tipo_plan = @CODI_TIPO_PLAN_vaca OR codi_tipo_plan = @CODI_TIPO_PLAN_AUXI ) )
			end
			if @fech_maxi_auxi < @fech_ingr begin set @fech_maxi_auxi = @fech_ingr end
			if @fech_maxi_auxi > @fech_ingr begin set @fech_maxi_auxi = dateadd(day, 1, @fech_maxi_auxi ) end
			IF DATEdiff(month, @fech_maxi_auxi, @fech_AUXI ) >= 12
			BEGIN
				SET @fech_maxi_auxi = DATEADD( MONTH, -12 , @fech_auxi)
				SET @fech_maxi_auxi = DATEADD( day, 1 , @fech_maxi_auxi )
			END
			set @fech_inic = @fech_maxi_auxi
			set @fech_term = @fech_AUXI
			*/
			
			set @nro_dias_vaca = 0 --datediff(day, @Fech_Inic , @Fech_term )

			set @cont_he = 0
			SET @NRO_MESE = 0
			SET @NRO_DIAS = 0
			set @prom_he25 = 0
			set @prom_he35 = 0
			SET @prom_OTROS =0			
			set @mes_inic = datepart(month, @fech_inic)
			set @anio_inic = datepart(year, @fech_inic)
			set @indi_sali = 0
			set @cont = 1
			set @cont_he = 0
			set @cont_he_segu = 0
			set @indi_he  = 0
			while @mes_inic < @mes
			begin		
				set @prom_he25_auxi = 0
				set @prom_he35_auxi = 0	
				SET @prom_OTROS_auxi  =0		
				if @codi_tipo_pers_auxi = '01' 
				begin
					set @prom_he25_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P (nolock), Planilla_empleado_conceptos PC (nolock)
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100060' and PC.codi_conc < '100065'))
							--or codi_tipo_plan = '03'
					set @prom_he35_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P (nolock), Planilla_empleado_conceptos PC (nolock)
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100065' and PC.codi_conc < '100070'))
					set @prom_otros_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P(nolock), Planilla_empleado_conceptos PC(nolock)
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc = '100020')) 
				end
				if @codi_tipo_pers_auxi = '02' 
				begin
					set @prom_he25_auxi = (Select isnull(sum(valor),0) From Planilla_de_Obreros P (nolock), Planilla_obrero_conceptos PC (nolock)
							where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
							and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100060' and PC.codi_conc < '100065'))
					set @prom_he35_auxi = (Select isnull(sum(valor),0) From Planilla_de_obreros P (nolock), Planilla_obrero_conceptos PC (nolock)
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
				set @prom_otros = @prom_otros + @prom_otros_auxi
				set @cont = @cont + 1

/*			print 'indi_he '
			print @indi_he
			print '@prom_he25_auxi '
			print @prom_he25_auxi
			print '@prom_he35_auxi '
			print @prom_he35_auxi */

			end

/*			print '@cont_he '
			print @cont_he
			print '@cont_he_segu '
			print @cont_he_segu 
			print '@nro dias vaca '
			print @nro_dias_vaca  
			print '@prom_he25'
			print @prom_he25
			print '@prom_he35'
			print @prom_he35 */
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
/*			print '@prom_he25'
			print @prom_he25
			print '@prom_he35'
			print @prom_he35*/
			Insert Into #Pers_Temp(codi_pers, PROM_HE25, PROM_HE35, NRO_MESE, NRO_DIAS, fech_inic, fech_term, codi_tipo_plan, otros_ingr)
			Values (@codi_pers_auxi, @PROM_HE25, @PROM_HE35, @NRO_MESE, @NRO_DIAS, @fech_inic, @fech_term, @codi_tipo_plan_auxi, @prom_otros)

			--Fin Crear Cursor Para CTS de Liquidación
		end

		Fetch Next From Curs_CARG_TRAB into @CODI_PERS_AUXI, @fech_auxi, @fech_ingr
	End
Close Curs_CARG_TRAB;
Deallocate Curs_CARG_TRAB;

Select codi_pers, PROM_HE25, PROM_HE35, NRO_MESE, NRO_DIAS, fech_inic, fech_term, CODI_TIPO_PLAN, isnull(OTROS_INGR,0) OTROS_INGR
From #Pers_Temp

drop table #Pers_Temp
GO
