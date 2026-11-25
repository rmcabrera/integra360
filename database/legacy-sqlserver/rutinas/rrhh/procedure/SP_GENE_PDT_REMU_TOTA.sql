CREATE PROCEDURE [dbo].[SP_GENE_PDT_REMU_TOTA]
	@mes [char](2),
	@anio [char](4),
	@CODI_PERS [char](5) OUTPUT,
	@codi_tipo_docu [char](2) OUTPUT,
	@nro_docu [char](15) OUTPUT,
	@dias_trab [decimal](9, 0) OUTPUT,
	@remu_ies [decimal](9, 2) OUTPUT,
	@remu_pens [decimal](9, 2) OUTPUT,
	@remu_salu_agra [decimal](9, 2) OUTPUT,
	@remu_arti [decimal](9, 2) OUTPUT,
	@remu_quin [decimal](9, 2) OUTPUT,
	@trib_quin [decimal](9, 2) OUTPUT
WITH EXECUTE AS CALLER
AS
set nocount on
Declare @codi_pers_auxi char(5)
declare @apel_1 char(30)
declare @apel_2 char(30)
declare @nomb_1 char(30)
declare @nomb_2 char(30)
Declare @codi_sist_pens char(2)
Declare @codi_carg char(5)
Declare @codi_tipo_docu_auxi char(5)
Declare @codi_tipo_pers char(4)
Declare @nro_dias decimal (9,0)
Declare @nro_dias_vaca decimal (9,0)
Declare @nro_dias_vaca_tota decimal (9,0)
Declare @tota_ingr_ies decimal (9,2)
Declare @tota_ingr_ies1 decimal (9,2)
Declare @tota_ingr_ies2 decimal (9,2)
Declare @tota_ingr_ies3 decimal (9,2)
Declare @tota_ingr_ies4 decimal (9,2)
Declare @tota_ingr_ies5 decimal (9,2)
Declare @tota_ingr_pens decimal (9,2)
Declare @tota_ingr_todo decimal (9,2)
Declare @tota_ingr_todo1 decimal (9,2)
Declare @tota_ingr_todo2 decimal (9,2)
Declare @tota_ingr_todo3 decimal (9,2)
Declare @tota_trib decimal (9,2)
Declare @tota_trib1 decimal (9,2)
Declare @tota_trib2 decimal (9,2)
Declare @tota_trib3 decimal (9,2)
Declare @tota_trib4 decimal (9,2)
Declare @tota_trib5 decimal (9,2)
Declare @fech_term_mes datetime
Declare @fech_INIC_mes datetime
Declare @indi_inic_term char(1)
Declare @TIPO_TRAB char(2)
Declare @cont_inic_vaca integer
Declare @cont_term_vaca integer
Declare @fech_inic_vaca datetime
Declare @fech_term_vaca datetime
Declare @remu_subs decimal (9,2) 
Declare @remu_UTIL decimal (9,2) 
declare @quin_util decimal (9,2) 
Declare @grupo varchar(30)

Select @grupo = upper(grupo) from empresa;
set @fech_INIC_mes = convert( datetime ,('01/' + (cast(@mes as char(2))) + '/' + (cast(@anio as char(4))) ) , 103)	
set @fech_term_mes = DATEADD ( month , 1, @fech_INIC_mes ) 
set @fech_term_mes = DATEADD ( day , -1, @fech_term_mes ) 


Create Table #Pers_auxi (codi_pers char (5) null , apel_1 varchar(30) null , apel_2 varchar(30)  null , nomb_1 varchar(30) null , nomb_2 varchar(30) null , tipo_trab char(2) null )
Create Table #pdt (codi_pers char (5) null , codi_docu char(2) null , nro_docu char(15) null , dias_trab decimal(9,0) null , remu_ies decimal (12,2)  null , remu_pens decimal (12,2) null , 
		remu_sa_ag decimal (12,2) null , remu_arti decimal (12,2)  null , remu_quin decimal (12,2) null , remu_trib decimal (12,2) null, quintautil decimal (12,2) null )

Declare curs_carg_trab cursor for
Select distinct P.codi_pers, P.apel_1, p.apel_2, p.nomb_1, p.nomb_2 
From Personal P,  
/*	(sELECT  distinct codi_pers, codi_tipo_pers from planilla_de_empleados where ( DATEPART( MONTH,  fech_inic ) = @mes or  mes = @mes ) and anio = @anio
	 union
	 sELECT  distinct codi_pers, codi_tipo_pers from planilla_de_obreros where ( DATEPART( MONTH,  fech_inic ) = @mes or  mes = @mes ) and anio = @anio
	 union
	 sELECT  distinct codi_pers, '03' as codi_tipo_pers from planilla_de_tripulantes 
	 union
	 sELECT  distinct codi_pers, '03' as codi_tipo_pers from planilla_boni_moto
	 union
	 sELECT  distinct codi_pers, '03' as codi_tipo_pers from PLANILLA_SUBSIDIO 
	 union
	 sELECT  '70163' as codi_pers, '03' as codi_tipo_pers from personal where codi_pers = '70163' */
	(sELECT  distinct codi_pers from planilla_de_empleados where ( DATEPART( MONTH,  fech_inic ) = @mes or  mes = @mes ) and anio = @anio
	 union
	 sELECT  distinct codi_pers from planilla_de_obreros where ( DATEPART( MONTH,  fech_inic ) = @mes or  mes = @mes ) and anio = @anio
	 union
	 sELECT  distinct codi_pers from planilla_de_tripulantes 
	 union
	 sELECT  distinct codi_pers from planilla_boni_moto
	 union
	 sELECT  distinct codi_pers from PLANILLA_SUBSIDIO 
	) R
WHERE   r.codi_pers = p.codi_pers 
	and ( ( ( P.FECH_CESE >= @fech_INIC_mes AND P.FECH_CESE <= @fech_TERM_mes ) and p.fech_ingre <= @fech_TERM_mes) 
	or ( p.fech_cese >= @fech_term_mes  and p.fech_ingre <= @fech_TERM_mes ) or ( P.FECH_CESE IS NULL and p.fech_ingre <= @fech_TERM_mes ) 
	) ; 
open curs_carg_trab;
Fetch Next From curs_carg_trab into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2--, @codi_tipo_pers
WHILE @@FETCH_STATUS = 0
Begin
--	Insert Into #pers_auxi (codi_pers, apel_1, apel_2, nomb_1, nomb_2, tipo_trab) Values (@codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @codi_tipo_pers )
	Insert Into #pers_auxi (codi_pers, apel_1, apel_2, nomb_1, nomb_2 ) Values (@codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2 )
	Fetch Next From curs_carg_trab into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2--, @codi_tipo_pers
end
CLOSE curs_carg_trab;
Deallocate curs_carg_trab;

Declare curs_carg_dato_plan Cursor  For
Select codi_pers , tipo_trab, apel_1, apel_2, nomb_1, nomb_2 From #pers_auxi order by tipo_trab, apel_1, apel_2, nomb_1, nomb_2;
Open curs_carg_dato_plan;
Fetch next from curs_carg_dato_plan into @codi_pers_auxi , @codi_tipo_pers, @apel_1, @apel_2, @nomb_1, @nomb_2
WHILE @@FETCH_STATUS = 0
Begin

	set @codi_tipo_pers =  ( Select top 1 R.codi_tipo_pers 
	From 	(sELECT  distinct codi_tipo_pers from planilla_de_empleados 
			where ( DATEPART( MONTH,  fech_inic ) = @mes or  mes = @mes ) and anio = @anio and codi_pers = @codi_pers_auxi
		 union
		 sELECT  distinct codi_tipo_pers from planilla_de_obreros 
			where ( DATEPART( MONTH,  fech_inic ) = @mes or  mes = @mes ) and anio = @anio  and codi_pers = @codi_pers_auxi
		 union
		 sELECT  distinct '03' as codi_tipo_pers from planilla_de_tripulantes   where codi_pers = @codi_pers_auxi
		 union
		 sELECT  distinct '03' as codi_tipo_pers from planilla_boni_moto  where codi_pers = @codi_pers_auxi
		 union
		 sELECT  distinct '03' as codi_tipo_pers from PLANILLA_SUBSIDIO  where codi_pers = @codi_pers_auxi
		) R ) ; 

	set @codi_tipo_docu_auxi = (Select isnull(codi_tipo_docu ,'0034' ) From Personal where codi_pers = @codi_pers_auxi )
	set @nro_docu = (Select isnull(nro_docu_iden , '') From Personal where codi_pers = @codi_pers_auxi )
	set @codi_carg = (Select isnull(codi_carg , '') From Personal where codi_pers = @codi_pers_auxi )

	--set @codi_tipo_pers = (Select isnull(codi_tipo_pers , '01' ) from Personal_por_tipo_trabajador where codi_pers = @codi_pers_auxi)
	set @cont_inic_vaca = ( Select isnull( count(fech_inic) , 0 ) From Vacaciones where datepart(month , fech_inic) = cast(@mes as integer) and datepart(year , fech_inic) = cast(@anio as integer) 
		 		AND codi_pers = @codi_pers_auxi and codi_tipo_vaca = '01' )
	set @nro_dias = 0
	set @nro_dias_vaca = 0
	set @nro_dias_vaca_tota = 0
	IF @CONT_INIC_VACA > 0 
	BEGIN
		Declare Curs_carg_vaca_inic Cursor for
		Select Fech_inic From Vacaciones where datepart(month , fech_inic) = cast(@mes as integer) and datepart(year , fech_inic) = cast(@anio as integer) 
		 		AND codi_pers = @codi_pers_auxi  and codi_tipo_vaca = '01' ;
		Open Curs_carg_vaca_inic;
		Fetch next from Curs_carg_vaca_inic into @fech_inic_vaca ;
		while @@fetch_status = 0
		begin
			set @fech_term_vaca = ( Select fech_term From Vacaciones where fech_inic = @fech_inic_vaca AND codi_pers = @codi_pers_auxi )
			if (datepart( month, @fech_term_vaca ) =  datepart( month, @fech_inic_vaca ) ) and  (datepart( year, @fech_term_vaca ) =  datepart( year, @fech_inic_vaca ) ) 
			begin
				set @nro_dias_vaca = ISNULL( datediff(day, @fech_inic_vaca, @fech_term_vaca ) , 0)
			end
			else
			begin	
				set @nro_dias_vaca = ISNULL(  datediff(day, @fech_inic_vaca, @fech_term_mes ) , 0 )
			end
			set @nro_dias_vaca_tota = @nro_dias_vaca_tota + @nro_dias_vaca	
			Fetch next from Curs_carg_vaca_inic into @fech_inic_vaca ;
		end
		Close Curs_carg_vaca_inic;
		Deallocate Curs_carg_vaca_inic;
	END
	else
	begin		set @cont_term_vaca = ( Select isnull( count(fech_term) , 0 ) From Vacaciones where datepart(month , fech_term) = cast(@mes as integer) and datepart(year , fech_term) = cast(@anio as integer) 
		 			AND codi_pers = @codi_pers_auxi and codi_tipo_vaca = '01' )
		IF @cont_term_vaca > 0 
		BEGIN
			Declare Curs_carg_vaca_term Cursor for
			Select Fech_term From Vacaciones where datepart(month , fech_term) = cast(@mes as integer) and datepart(year , fech_term) = cast(@anio as integer) 
		 			AND codi_pers = @codi_pers_auxi and codi_tipo_vaca = '01'  ;
			Open Curs_carg_vaca_term;
			Fetch next from Curs_carg_vaca_term into @fech_term_vaca ;
			while @@fetch_status = 0
			begin
				set @fech_inic_vaca = ( Select fech_inic From Vacaciones where fech_term = @fech_term_vaca AND codi_pers = @codi_pers_auxi )
				if (datepart( month, @fech_term_vaca ) =  datepart( month, @fech_inic_vaca ) ) and  (datepart( year, @fech_term_vaca ) =  datepart( year, @fech_inic_vaca ) ) 
				begin
					set @nro_dias_vaca = ISNULL( datediff(day, @fech_inic_vaca, @fech_term_vaca ) , 0)					
				end
				else
				begin
					set @nro_dias_vaca = ISNULL(  datediff(day, @fech_inic_mes, @fech_term_vaca ) , 0 )
				end
				set @nro_dias_vaca_tota = @nro_dias_vaca_tota + @nro_dias_vaca	
				Fetch next from Curs_carg_vaca_term into @fech_inic_vaca ;
			end			
			Close Curs_carg_vaca_term;
			Deallocate Curs_carg_vaca_term;
		
		END
	end
	SET @remu_UTIL =  0
	set @tota_trib =  0

	Select @remu_UTIL = isnull(liq_remu_perc, 0) + isnull(liq_dias_labo, 0) from calc_util_pers where codi_pers = @codi_pers_auxi 
		and cast( anio as integer )= cast( @anio as integer) - 1 and mes = @mes;

	SET @quin_util  =  0
	Select  @quin_util = isnull(valor, 0) from calc_util_deta cud
	where cud.codi_conc = '200040' and  cast( cud.anio as integer )= cast( @anio as integer) - 1 and cud.codi_pers in (Select codi_pers From calc_util_pers cup
		where cast( cup.anio as integer )= cast( @anio as integer) - 1 and cup.mes = @mes and cup.codi_pers = @codi_pers_auxi )


--	if @codi_tipo_pers = '01' 
--	begin
		set @nro_dias = isnull( (Select isnull( Sum( round(isnull(valor , 0 ) , 0 )) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and ( pec.codi_conc = '500000' or  pec.codi_conc = '500006' or  pec.codi_conc = '500007' )), 0 )
		set @tota_ingr_ies = isnull( (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and ( pe.codi_tipo_plan = '01' or pe.codi_tipo_plan = '03'  or pe.codi_tipo_plan = '11'  or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) ) , 0 )
		set @remu_subs = isnull( (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '100202' and ( pe.codi_tipo_plan = '01' or pe.codi_tipo_plan = '03'  or pe.codi_tipo_plan = '11'  or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) ) , 0 )
		set @tota_ingr_todo = isnull( (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) )) , 0 )
		set @tota_trib = isnull( (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '200040' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) )) , 0 )
--		SET @NRO_DIAS = @nro_dias -- + @nro_dias_vaca 
--	end


--	if @codi_tipo_pers = '02' 
--	begin
		set @nro_dias = @nro_dias + isnull( (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_de_Obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and (pec.codi_conc = '500000' or  pec.codi_conc = '500006' or  pec.codi_conc = '500007' )) , 0 )
		set @tota_ingr_ies = @tota_ingr_ies + isnull( (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and (pe.codi_tipo_plan = '01' or pe.codi_tipo_plan = '03'  or pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' )) , 0 )
		set @remu_subs = @remu_subs + isnull(  (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '100202' and (pe.codi_tipo_plan = '01' or pe.codi_tipo_plan = '03'  or pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' )) , 0 )
		set @tota_ingr_todo = @tota_ingr_todo +  isnull(  (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) )) , 0 )
		set @tota_trib = @tota_trib + isnull( (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '200040' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) )) , 0 )
--		SET @NRO_DIAS = @nro_dias -- + @nro_dias_vaca 
	
--	end


--	if @codi_tipo_pers = '03' 
--	begin

		set @tota_ingr_ies1 = isnull( (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC 
			where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio ,5,2 ) = @mes and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_trip = pec.codi_plan_trip -- and pe.nro_asis = '1'
			and pec.codi_conc = '199998' and (pe.codi_tipo_plan = '08' ) ) , 0  )
		if @grupo = 'BARAKA' 
		begin
			set @tota_ingr_ies2 = isnull(  (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
				where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio ,5,2 ) = @mes and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_boni = pec.codi_plan_boni
				 and pec.codi_conc = '199998'  and pe.tipo = 'M' ) , 0  )
		end
		else
		begin
			set @tota_ingr_ies2 = isnull( (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
				where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio ,1,2 ) = @mes and substring( pe.mesanio ,3,4 ) = @anio and pe.codi_plan_boni = pec.codi_plan_boni
				 and pec.codi_conc = '199998'  and pe.tipo = 'M' ) , 0  )
		end

		set @tota_ingr_ies3 = isnull( (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_subsidio PE, Planilla_subs_concepto PEC 
			where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio ,1,2 ) = @mes and substring( pe.mesanio ,3,4 ) = @anio and pe.codi_plan_subs = pec.codi_plan_subs
			 and pec.codi_conc = '199998' ) , 0  )

--		set @tota_ingr_ies4 = (Select isnull( Sum( isnull(valor , 0 ) ) , 0 ) From GRAT_TRIP_DETA_CONC PE
--			where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,1,2 ) = @mes and substring( pe.mesanio_prov ,3,4 ) = @anio and codi_tipo_plan = '02'
--			 and pe.codi_conc = '199998' )
--		set @tota_ingr_ies5 = (Select isnull( Sum( isnull(valor , 0 ) ) , 0 ) From GRAT_TRIP_DETA_CONC PE
--			where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,1,2 ) = @mes and  substring( pe.mesanio_prov ,3,4 )  = @anio and codi_tipo_plan = '03'
--			 and pe.codi_conc = '199998' )	
		set @tota_ingr_ies1 = isnull( @tota_ingr_ies1 , 0 )
		set @tota_ingr_ies2 = isnull( @tota_ingr_ies2 , 0 )
		set @tota_ingr_ies3 = isnull( @tota_ingr_ies3 , 0 )
		set @tota_ingr_ies4 = isnull( @tota_ingr_ies4 , 0 )
		set @tota_ingr_ies5 = isnull( @tota_ingr_ies5 , 0 )

		set @remu_subs = @remu_subs + @tota_ingr_ies3
		set @tota_ingr_todo = @tota_ingr_todo +  @tota_ingr_ies1 + @tota_ingr_ies2 + @tota_ingr_ies3 + @tota_ingr_ies4 + @tota_ingr_ies5
		set @tota_ingr_ies = @tota_ingr_ies +  @tota_ingr_ies1 + @tota_ingr_ies2 - @tota_ingr_ies3 + @tota_ingr_ies4 + @tota_ingr_ies5

		set @tota_trib1 =  (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC 
			where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio ,5,2 ) = @mes and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_trip = pec.codi_plan_trip -- and pe.nro_asis = '1'
			and pec.codi_conc = '200040' and (pe.codi_tipo_plan = '08' ) )
		if @grupo = 'BARAKA' 
		begin
			set @tota_trib2 = (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
				where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio ,5,2 ) = @mes and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_boni = pec.codi_plan_boni
				 and pec.codi_conc = '200040'  and pe.tipo = 'M' )
		end
		else
		begin
			set @tota_trib2 = (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
				where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio ,1,2 ) = @mes and substring( pe.mesanio ,3,4 ) = @anio and pe.codi_plan_boni = pec.codi_plan_boni
				 and pec.codi_conc = '200040'  and pe.tipo = 'M' )
		end

		set @tota_trib3 = (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From Planilla_subsidio PE, Planilla_subs_concepto PEC 
			where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio ,1,2 ) = @mes and substring( pe.mesanio ,3,4 ) = @anio and pe.codi_plan_subs = pec.codi_plan_subs
			 and pec.codi_conc = '200040' )


--		set @tota_trib4 = (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
--			where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,1,2 ) = @mes and substring( pe.mesanio_prov ,3,4 ) = @anio and codi_tipo_plan = '02'
--			 and pe.codi_conc = '200040' )
--		set @tota_trib5 = (Select isnull( Sum(isnull(valor , 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
--			where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,1,2 ) = @mes and substring( pe.mesanio_prov ,3,4 ) = @anio and codi_tipo_plan = '03'
--			 and pe.codi_conc = '200040' ) 
		set @tota_trib1 = isnull( @tota_trib1 , 0 )
		set @tota_trib2 = isnull( @tota_trib2 , 0 )
		set @tota_trib3 = isnull( @tota_trib3 , 0 )
		set @tota_trib4 = isnull( @tota_trib4 , 0 )
		set @tota_trib5 = isnull( @tota_trib5 , 0 )
		
		set @tota_trib = @tota_trib +  @tota_trib1 + @tota_trib2 + @tota_trib3 + @tota_trib4 + @tota_trib5
		set @nro_dias = @nro_dias +  (select dbo. F_DIAS_LABO_MENS_PESC( @anio, @mes , @codi_pers_auxi  ) )
--		SET @NRO_DIAS = @nro_dias -- + @nro_dias_vaca 
--	end
	
	set @tota_trib = isnull ( @tota_trib, 0 ) + isnull ( @quin_util, 0 ) 
	if @codi_tipo_docu_auxi = '0034' 
	begin
		set @codi_tipo_docu  = '01'
	end
	if @codi_tipo_docu_auxi = '0035' 
	begin
		set @codi_tipo_docu  = '04'
	end
	set @codi_sist_pens = '00'
	if @codi_tipo_pers = '01' 
	begin
		set @codi_sist_pens = (Select top 1 codi_sist_pens From planilla_de_empleados 
					where codi_pers = @codi_pers_auxi and mes = @mes AND ANIO = @anio and indi_tiem = 'M') 
	end
	else
	begin
		set @codi_sist_pens = (Select top 1 codi_sist_pens From planilla_de_obreros
					where codi_pers = @codi_pers_auxi and mes = @mes AND ANIO = @anio and indi_tiem = 'M') 
	end

	if @codi_sist_pens = '01'  and @codi_tipo_pers <> '03' 
	begin
		set @tota_ingr_pens = @tota_ingr_todo
	end
	else
	begin
		set @tota_ingr_pens = 0
	end
--	set @tota_ingr_pens  = @tota_ingr_pens  + isnull(@remu_UTIL, 0)
	set @tota_ingr_todo  = @tota_ingr_todo  + isnull(@remu_UTIL, 0)

	if @codi_tipo_pers = '01' 	 or @codi_tipo_pers = '02'  or @codi_tipo_pers = '03' 
	begin
		Insert Into #pdt (codi_pers, codi_docu , nro_docu , dias_trab , remu_ies , remu_pens , remu_sa_ag , remu_arti , remu_quin , remu_trib, quintautil ) 
		Values ( @codi_pers_auxi, @codi_tipo_docu, @nro_docu, @nro_dias, 0 , @tota_ingr_pens, @tota_ingr_todo - isnull( @remu_UTIL, 0) ,
		0, @tota_ingr_todo , @tota_trib, @quin_util)
	end	
	Fetch next from curs_carg_dato_plan into @codi_pers_auxi , @codi_tipo_pers, @apel_1, @apel_2, @nomb_1, @nomb_2
end
Close curs_carg_dato_plan;
Deallocate curs_carg_dato_plan;

select * from #pdt
order by codi_pers
GO
