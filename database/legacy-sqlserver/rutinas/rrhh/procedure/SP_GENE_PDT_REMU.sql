CREATE PROCEDURE [dbo].[SP_GENE_PDT_REMU]
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
Declare @codi_tipo_docu_auxi char(5)
Declare @codi_tipo_pers char(4)
Declare @nro_dias decimal (9,0)
Declare @nro_dias_vaca decimal (9,0)
Declare @tota_ingr_ies decimal (9,2)
Declare @tota_ingr_pens decimal (9,2)
Declare @tota_ingr_todo decimal (9,2)
Declare @tota_trib decimal (9,2)
Declare @fech_term_mes datetime
Declare @fech_INIC_mes datetime
Declare @indi_inic_term char(1)
Declare @TIPO_TRAB char(2)
Declare @cont_inic_vaca integer
Declare @cont_term_vaca integer
Declare @fech_inic_vaca datetime
Declare @fech_term_vaca datetime

set @fech_INIC_mes = convert( datetime ,('01/' + (cast(@mes as char(2))) + '/' + (cast(@anio as char(4))) ) , 103)	
set @fech_term_mes = DATEADD ( month , 1, @fech_INIC_mes ) 
set @fech_term_mes = DATEADD ( day , -1, @fech_term_mes ) 

Create Table #Pers_auxi (codi_pers char (5) null , apel_1 varchar(30) null , apel_2 varchar(30)  null , nomb_1 varchar(30) null , nomb_2 varchar(30) null , tipo_trab char(2) null )
Create Table #pdt (codi_pers char (5) null , codi_docu char(2) null , nro_docu char(15) null , dias_trab decimal(9,0) null , remu_ies decimal (12,2)  null , remu_pens decimal (12,2) null , 
		remu_sa_ag decimal (12,2) null , remu_arti decimal (12,2)  null , remu_quin decimal (12,2) null , remu_trib decimal (12,2) null  )

DECLARE  curs_carg_trab_empl cursor for 
Select distinct P.codi_pers, P.apel_1, p.apel_2, p.nomb_1, p.nomb_2 From Personal P, Planilla_de_empleados PE
where p.codi_pers = pe.codi_pers and pe.anio = @anio and pe.mes = @mes and pe.indi_tiem = 'M'
order by P.apel_1, p.apel_2, p.nomb_1, p.nomb_2;
Open curs_carg_trab_empl;
Fetch Next From Curs_CARG_TRAB_empl into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2
WHILE @@FETCH_STATUS = 0
Begin
	Insert Into #pers_auxi (codi_pers, apel_1, apel_2, nomb_1, nomb_2, tipo_trab) Values (@codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, '01')
	
	Fetch Next From Curs_CARG_TRAB_empl into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2
End
close curs_carg_trab_empl;
Deallocate curs_carg_trab_empl;

DECLARE  curs_carg_trab_obre cursor for 
Select distinct P.codi_pers, P.apel_1, p.apel_2, p.nomb_1, p.nomb_2 From Personal P, Planilla_de_obreros PE
where p.codi_pers = pe.codi_pers and pe.anio = @anio and pe.mes = @mes and pe.indi_tiem = 'M'
order by P.apel_1, p.apel_2, p.nomb_1, p.nomb_2;
Open curs_carg_trab_obre;
Fetch Next From Curs_CARG_TRAB_obre into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2
WHILE @@FETCH_STATUS = 0
Begin
	--Insert Into #pers_auxi (codi_pers) Values (@codi_pers_auxi)	
	Insert Into #pers_auxi (codi_pers, apel_1, apel_2, nomb_1, nomb_2, tipo_trab) Values (@codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, '02')
	Fetch Next From Curs_CARG_trab_obre into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2
End
close curs_carg_trab_obre;
Deallocate curs_carg_trab_obre;

Declare curs_carg_dato_plan Cursor  For
Select codi_pers From #pers_auxi ;
Open curs_carg_dato_plan;
Fetch next from curs_carg_dato_plan into @codi_pers_auxi 
WHILE @@FETCH_STATUS = 0
Begin
	set @codi_tipo_docu_auxi = (Select isnull(codi_tipo_docu ,'0034' ) From Personal where codi_pers = @codi_pers_auxi )
	set @nro_docu = (Select isnull(nro_docu_iden , '') From Personal where codi_pers = @codi_pers_auxi )
	set @codi_tipo_pers = (Select isnull(codi_tipo_pers , '01' ) from Personal_por_tipo_trabajador where codi_pers = @codi_pers_auxi)
	set @cont_inic_vaca = ( Select isnull( count(fech_inic) , 0 ) From Vacaciones where datepart(month , fech_inic) = cast(@mes as integer) and datepart(year , fech_inic) = cast(@anio as integer) 
		 		AND codi_pers = @codi_pers_auxi and codi_tipo_vaca = '01' )
	set @nro_dias_vaca = 0
	IF @CONT_INIC_VACA > 0 
	BEGIN
		set @fech_inic_vaca = ( Select MIN(fech_inic )From Vacaciones where datepart(month , fech_inic) = cast(@mes as integer) and datepart(year , fech_inic) = cast(@anio as integer) 
		 		AND codi_pers = @codi_pers_auxi  and codi_tipo_vaca = '01' )		
		set @fech_term_vaca = ( Select fech_term From Vacaciones where fech_inic = @fech_inic_vaca AND codi_pers = @codi_pers_auxi )
		if (datepart( month, @fech_term_vaca ) =  datepart( month, @fech_inic_vaca ) ) and  (datepart( year, @fech_term_vaca ) =  datepart( year, @fech_inic_vaca ) ) 
		begin
			set @nro_dias_vaca = ISNULL( datediff(day, @fech_inic_vaca, @fech_term_vaca ) , 0)
		end
		else
		begin	
			set @nro_dias_vaca = ISNULL(  datediff(day, @fech_inic_vaca, @fech_term_mes ) , 0 )
		end
	END
	else
	begin		set @cont_term_vaca = ( Select isnull( count(fech_term) , 0 ) From Vacaciones where datepart(month , fech_term) = cast(@mes as integer) and datepart(year , fech_term) = cast(@anio as integer) 
		 			AND codi_pers = @codi_pers_auxi and codi_tipo_vaca = '01' )
		IF @cont_term_vaca > 0 
		BEGIN
			set @fech_term_vaca = ( Select fech_term From Vacaciones where datepart(month , fech_term) = cast(@mes as integer) and datepart(year , fech_term) = cast(@anio as integer) 
						AND codi_pers = @codi_pers_auxi and codi_tipo_vaca = '01' ) 
			set @nro_dias_vaca = ISNULL( datediff(day, @fech_inic_mes, @fech_term_vaca )  , 0 )
		END
	end
	
	if @codi_tipo_pers = '01' 
	begin
		set @nro_dias = (Select isnull( Sum( round(valor , 0 )) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and ( pec.codi_conc = '500000' or  pec.codi_conc = '500006' or  pec.codi_conc = '500007' ))
		set @tota_ingr_ies = (Select isnull( Sum(valor) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and ( pe.codi_tipo_plan = '01' or pe.codi_tipo_plan = '03'  or pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '05' ) )
		set @tota_ingr_todo = (Select isnull( Sum(valor) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) ))
		set @tota_trib = (Select isnull( Sum(valor) , 0 ) From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_empl = pec.codi_plan_empl and pe.indi_tiem = 'M'  and pec.codi_conc = '200040' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) ))
	end
	if @codi_tipo_pers = '02' 
	begin
		set @nro_dias = (Select isnull( Sum(valor) , 0 ) From Planilla_de_Obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and (pec.codi_conc = '500000' or  pec.codi_conc = '500006' or  pec.codi_conc = '500007' ))
		set @tota_ingr_ies = (Select isnull( Sum(valor) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and (pe.codi_tipo_plan = '01' or pe.codi_tipo_plan = '03'  or pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '05' ))
		set @tota_ingr_todo = (Select isnull( Sum(valor) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '199998' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) ))
		set @tota_trib = (Select isnull( Sum(valor) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC where pe.codi_pers = @codi_pers_auxi and pe.mes = @mes
			and pe.anio = @anio and pe.codi_plan_obre = pec.codi_plan_obre and pe.indi_tiem = 'M'  and pec.codi_conc = '200040' and ( ( pe.codi_tipo_plan >= '01' and pe.codi_tipo_plan <= '03' ) or ( pe.codi_tipo_plan = '11' or pe.codi_tipo_plan = '12' or pe.codi_tipo_plan = '05' ) ))
	end
	SET @NRO_DIAS = @nro_dias + cast(@nro_dias_vaca as decimal (9,0) )
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
	if @codi_sist_pens = '01' 
	begin
		set @tota_ingr_pens = @tota_ingr_todo
	end
	else
	begin
		set @tota_ingr_pens = 0
	end

	if @codi_tipo_pers = '01' 	 or @codi_tipo_pers = '02' 
	begin
		Insert Into #pdt (codi_pers, codi_docu , nro_docu , dias_trab , remu_ies , remu_pens , remu_sa_ag , remu_arti , remu_quin , remu_trib ) 
		Values ( @codi_pers_auxi, @codi_tipo_docu, @nro_docu, @nro_dias, @tota_ingr_ies, @tota_ingr_pens, @tota_ingr_todo, 0, @tota_ingr_todo, @tota_trib)
	end
	Fetch next from curs_carg_dato_plan into @codi_pers_auxi 
end
Close curs_carg_dato_plan;
Deallocate curs_carg_dato_plan;

select * from #pdt
GO
