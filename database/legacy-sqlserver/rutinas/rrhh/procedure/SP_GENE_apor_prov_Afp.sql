CREATE PROCEDURE [dbo].[SP_GENE_apor_prov_Afp]
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
Declare @tota_ingr_pens decimal (9,2)
Declare @tota_ingr_todo decimal (9,2)
Declare @tota_ingr_todo1 decimal (9,2)
Declare @tota_ingr_todo2 decimal (9,2)
Declare @tota_ingr_todo3 decimal (9,2)
Declare @tota_trib decimal (9,2)
Declare @tota_trib1 decimal (9,2)
Declare @tota_trib2 decimal (9,2)
Declare @tota_trib3 decimal (9,2)
Declare @fech_term_mes datetime
Declare @fech_INIC_mes datetime
Declare @indi_inic_term char(1)
Declare @TIPO_TRAB char(2)
Declare @cont_inic_vaca integer
Declare @cont_term_vaca integer
Declare @fech_inic_vaca datetime
Declare @fech_term_vaca datetime
Declare @remu_subs decimal (9,2) 
set @fech_INIC_mes = convert( datetime ,('01/' + (cast(@mes as char(2))) + '/' + (cast(@anio as char(4))) ) , 103)	
set @fech_term_mes = DATEADD ( month , 1, @fech_INIC_mes ) 
set @fech_term_mes = DATEADD ( day , -1, @fech_term_mes ) 

Create Table #Pers_auxi (codi_pers char (5) null , apel_1 varchar(30) null , apel_2 varchar(30)  null , nomb_1 varchar(30) null , nomb_2 varchar(30) null , tipo_trab char(2) null )

Create Table #pdt (codi_pers char (5) null , nro_cupss varchar(20), tipo_movi_pers char(2),   )


Declare curs_carg_trab cursor for
Select distinct P.codi_pers, P.apel_1, p.apel_2, isnull( p.nomb_1, '') , isnull(p.nomb_2 , '') , pt.codi_tipo_pers From Personal P, personal_por_tipo_trabajador pt
WHERE   (pt.codi_pers = p.codi_pers) and ( pt.codi_tipo_pers = '01' or pt.codi_tipo_pers = '02' )
	and ( ( ( P.FECH_CESE >= @fech_INIC_mes AND P.FECH_CESE <= @fech_TERM_mes ) and p.fech_ingre <= @fech_TERM_mes) 
	or ( p.fech_cese >= @fech_term_mes  and p.fech_ingre <= @fech_TERM_mes ) or ( P.FECH_CESE IS NULL and p.fech_ingre <= @fech_TERM_mes ) 
	) ; 
open curs_carg_trab;
Fetch Next From curs_carg_trab into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @codi_tipo_pers
WHILE @@FETCH_STATUS = 0
Begin
	Insert Into #pers_auxi (codi_pers, apel_1, apel_2, nomb_1, nomb_2, tipo_trab) Values (@codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @codi_tipo_pers )
	Fetch Next From curs_carg_trab into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @codi_tipo_pers
end
CLOSE curs_carg_trab;
Deallocate curs_carg_trab;

Declare curs_carg_dato_plan Cursor  For
Select codi_pers , tipo_trab, apel_1, apel_2, nomb_1, nomb_2 From #pers_auxi order by tipo_trab, apel_1, apel_2, nomb_1, nomb_2;
Open curs_carg_dato_plan;
Fetch next from curs_carg_dato_plan into @codi_pers_auxi , @codi_tipo_pers, @apel_1, @apel_2, @nomb_1, @nomb_2
WHILE @@FETCH_STATUS = 0
Begin
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
	
	if @codi_tipo_pers = '01' 
	begin
		set @nro_dias = (Select isnull( Sum( round(valor , 0 )) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and ( pec.codi_conc = '500000' or  pec.codi_conc = '500006' or  pec.codi_conc = '500007' ))
		set @tota_ingr_ies = (Select isnull( Sum(valor) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and ( pe.codi_tipo_plan = '01' or pe.codi_tipo_plan = '03'  or pe.codi_tipo_plan = '11'  or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) )
		set @remu_subs = (Select isnull( Sum(valor) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '100202' and ( pe.codi_tipo_plan = '01' or pe.codi_tipo_plan = '03'  or pe.codi_tipo_plan = '11'  or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) )
		set @tota_ingr_todo = (Select isnull( Sum(valor) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) ))
		set @tota_trib = (Select isnull( Sum(valor) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '200040' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) ))
		SET @NRO_DIAS = @nro_dias -- + @nro_dias_vaca 
	end
	if @codi_tipo_pers = '02' 
	begin
		set @nro_dias = (Select isnull( Sum(valor) , 0 ) From Planilla_de_Obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and (pec.codi_conc = '500000' or  pec.codi_conc = '500006' or  pec.codi_conc = '500007' ))
		set @tota_ingr_ies = (Select isnull( Sum(valor) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and (pe.codi_tipo_plan = '01' or pe.codi_tipo_plan = '03'  or pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ))
		set @remu_subs = (Select isnull( Sum(valor) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '100202' and (pe.codi_tipo_plan = '01' or pe.codi_tipo_plan = '03'  or pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ))
		set @tota_ingr_todo = (Select isnull( Sum(valor) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) ))
		set @tota_trib = (Select isnull( Sum(valor) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '200040' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) ))
		SET @NRO_DIAS = @nro_dias -- + @nro_dias_vaca 
	
	end
	
	if @codi_tipo_docu_auxi = '0034' 
	begin
		set @codi_tipo_docu  = '01'
	end
	if @codi_tipo_docu_auxi = '0035' 
	begin
		set @codi_tipo_docu  = '04'
	end
	set @codi_sist_pens = '00'
	set @codi_sist_pens = (Select codi_sist_pens From Personal where codi_pers = @codi_pers_auxi) 
	if @codi_sist_pens = '01'  and @codi_tipo_pers <> '03' 
	begin
		set @tota_ingr_pens = @tota_ingr_todo
	end
	else
	begin
		set @tota_ingr_pens = 0
	end

	--if @codi_tipo_pers = '01' 	 or @codi_tipo_pers = '02'  
	--begin
		--Insert Into #pdt (codi_pers, codi_docu , nro_docu , dias_trab , remu_ies , remu_pens , remu_sa_ag , remu_arti , remu_quin , remu_trib ) 
		--Values ( @codi_pers_auxi, @codi_tipo_docu, @nro_docu, @nro_dias, @tota_ingr_ies - @remu_subs, @tota_ingr_pens, @tota_ingr_todo, 0, @tota_ingr_todo, @tota_trib)
	--end	
	Fetch next from curs_carg_dato_plan into @codi_pers_auxi , @codi_tipo_pers, @apel_1, @apel_2, @nomb_1, @nomb_2
end
Close curs_carg_dato_plan;
Deallocate curs_carg_dato_plan;

--select * from #pdt
GO
