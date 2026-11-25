CREATE PROCEDURE [dbo].[SP_Repo_quin_cate_anual]
	@sema_inic [int],
	@sema_fina [int],
	@mes [int],
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
Begin
Declare @codi_pers char(5) 
Declare @codi_unid_oper char(5) 
Declare @apel_1 varchar(30) 
Declare @apel_2 varchar(30) 
Declare @nomb_1 varchar(30) 
Declare @nomb_2 varchar(30) 
Declare @trabajador varchar(120) 
Declare @remu_tota decimal (15,2)  
Declare @rete_quin decimal (15,2)  
Declare @trib_quin decimal (15,2)  
Declare @dife_quin decimal (15,2)  
Declare @codi_pers_auxi char(5)
Declare @tota_ingr_pesc decimal (15,2) 
Declare @tota_ingr_boni_moto decimal (15,2) 
Declare @tota_ingr_boni_trip decimal (15,2) 
Declare @tota_ingr_subs decimal (15,2) 
Declare @tota_ingr_grat decimal (15,2) 
Declare @tota_ingr_vaca decimal (15,2) 
Declare @tota_ingr_vacab decimal (15,2) 
Declare @tota_ingr_gratb decimal (15,2) 
Declare @tota_ingr_grata decimal (15,2) 
Declare @tota_ingr_vacaa decimal (15,2)
Declare @tota_ingr_grat_o decimal (15,2) 
Declare @tota_ingr_grat_e decimal (15,2) 
Declare @tota_ingr_vaca_o decimal (15,2) 
Declare @tota_ingr_vaca_e decimal (15,2) 
Declare @tota_suel decimal (15,2)
Declare @tota_sala decimal (15,2)
Declare @tota_dev5ta_pesc decimal (15,2) 
Declare @tota_dev5ta_boni_moto decimal (15,2) 
Declare @tota_dev5ta_boni_trip decimal (15,2) 
Declare @tota_dev5ta_suel decimal (15,2) 
Declare @tota_dev5ta_sala decimal (15,2) 
Declare @tota_dev5ta_tota decimal (15,2) 
Declare @tota_util decimal (15,2) 
Declare @tota_ingr decimal (15,2) 
Declare @tota_ingr_con_devo decimal (15,2) 
Declare @tota_ingr_calc_util decimal (15,2) 
Declare @tota_quin_pesc decimal (15,2) 
Declare @tota_quin_boni_moto decimal (15,2) 
Declare @tota_quin_boni_trip decimal (15,2) 
Declare @tota_quin_subs decimal (15,2) 
Declare @tota_quin_grat decimal (15,2) 
Declare @tota_quin_vaca decimal (15,2) 
Declare @tota_quin_suel decimal (15,2)
Declare @tota_quin_sala decimal (15,2)
Declare @tota_quin_rete decimal (15,2) 
Declare @codi_uit smallint
Declare @tipo_valo smallint
declare @mont_uit decimal (15,2) 
declare @mont_dedu decimal (15,2) 
declare  @base_impo decimal (15,2) 
declare  @nro_mini_uit decimal (15,2) 
declare  @nro_maxi_uit decimal (15,2) 
declare  @porcentaje decimal (15,2) 
declare  @valo_desc_auxi decimal (15,2) 
declare  @valo_desc_rent_quin decimal (15,2) 
declare  @dife_rent decimal (15,2) 
Declare @dias_trip integer
Declare @dias_suel integer
Declare @dias_sala integer
Declare @dias_vaca integer
Declare @dias_tota integer
Declare @cont integer
Declare @dias_moto integer
Declare @dias_moto_tota integer
Declare @dias_trip_tota integer
Declare @dias_trip_moto_tota integer
declare @cargo char(4)
Declare @cont_carg_moto integer
Declare @cont_carg_trip integer

/*Create Table #Rela_quin_trip( codi_pers char(5) NULL, apel_1 varchar(30) NULL, apel_2 varchar(30) NULL, nomb_1 varchar(30) NULL, nomb_2 varchar(30) NULL, trabajador varchar(120) NULL, 
		tota_ingre decimal (15,2)  NULl, base_impo decimal (15,2)  NULL, impo_rent_quin decimal (15,2)  NULL, tota_rete decimal (15,2)  NULL, dife_rent decimal (15,2)  NULL,
		UITS decimal (15,2)  null , tota_trip decimal (15,2)  NULL, tota_boni decimal (15,2)  NULL, tota_grat decimal (15,2)  NULL, tota_vaca decimal (15,2)  NULL, 
		otros  decimal (15,2)  NULL, DIAS_TRAB integer null , tota_ingr_con_devo decimal( 15, 2 ) NULL , devo_quin decimal ( 15,2) null, tota_ingr_calc_util decimal (9,2) null,
		codi_unid_oper char(5) NULL )
*/

Create Table #Rela_quin_trip( codi_pers char(5) NULL, apel_1 varchar(30) NULL, apel_2 varchar(30) NULL, nomb_1 varchar(30) NULL, nomb_2 varchar(30) NULL, trabajador varchar(120) NULL, 
		tota_ingre decimal (15,2)  NULl, base_impo decimal (15,2)  NULL, impo_rent_quin decimal (15,2)  NULL, tota_rete decimal (15,2)  NULL, dife_rent decimal (15,2)  NULL,
		UITS decimal (15,2)  null , tota_trip decimal (15,2)  NULL, tota_boni decimal (15,2)  NULL, tota_grat decimal (15,2)  NULL, tota_vaca decimal (15,2)  NULL, 
		otros  decimal (15,2)  NULL, DIAS_TRAB integer null , tota_ingr_con_devo decimal( 15, 2 ) NULL, devo_quin decimal ( 15,2) NULL, tota_ingr_calc_util decimal (9,2) NULL,
		codi_unid_oper char(5) NULL )

Select @codi_uit = codi_valo_unit from valores_unitarios where desc_valo_unit like 'UIT%';
Select @mont_uit = isnull(valor, 0 ) , @tipo_valo = isnull( tipo_valo , 0 ) from valores_unitarios_anuales 
where codi_valo_unit = @codi_uit and datepart( year, fech_asig) = cast( @anio as integer );
if @tipo_valo  = 0
begin
	set @mont_uit = @mont_uit / 100
end

set @mont_dedu  = @mont_uit * 7 


Declare curs_carg_trab_trip cursor for 
Select distinct plani.codi_pers, p.apel_1, isnull( p.apel_2, '' ) as apel_2, p.nomb_1, isnull( p.nomb_2, '') as nomb_2, 
	isnull( p.apel_1,'') + ' ' + isnull( p.apel_2,'') + ' ' + isnull( p.nomb_1,'') + ' ' + isnull( p.nomb_2,'') as trabajador  from
(	Select distinct pe.codi_pers From Planilla_de_tripulantes PE, semana se
	where se.codi_sema = pe.codi_Sema and substring(se.aniomes , 1,4 ) = @anio and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina
union
	Select distinct Pe.codi_pers From Planilla_boni_moto PE
	where cast( substring( pe.mesanio , 1,2 ) as smallint ) <= @mes and substring( pe.mesanio , 3,4 ) = @anio
union
	Select distinct pe.codi_pers From Planilla_Boni_tripu PE, semana se
	where se.codi_sema = pe.codi_Sema and substring(se.aniomes , 1,4 ) = @anio and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina
union
	Select distinct Pe.codi_pers From Planilla_subsidio PE
	where cast ( substring( pe.mesanio , 1,2 ) as smallint ) <= @mes and substring( pe.mesanio , 3,4 ) = @anio
Union 	
	Select distinct Pe.codi_pers From Planilla_de_empleados PE
	where pe.anio  = @anio and cast( pe.mes as smallint ) <= @mes
Union 	
	Select distinct Pe.codi_pers From Planilla_de_obreros PE
	where pe.anio  = @anio and cast( pe.mes as smallint ) <= @mes
) as Plani, personal P
where plani.codi_pers = p.codi_pers
order by p.apel_1, p.apel_2, p.nomb_1, p.nomb_2;
Open curs_carg_trab_trip;
Fetch next from curs_carg_trab_trip into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador;
while @@fetch_status = 0
begin
	set @codi_unid_oper = (Select codi_unid_oper from personal where codi_pers = @codi_pers_auxi)
	set @tota_ingr_pesc = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_trip = pec.codi_plan_trip
		and pec.codi_conc = '199998' and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio  )

	set @tota_ingr_subs = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_subsidio PE, Planilla_subs_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 )  as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_subs = pec.codi_plan_subs and pec.codi_conc = '199998' )
/*	set @tota_ingr_grat = (Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,1,2 ) <= @mes and pe.anio = @anio 
		and pe.codi_tipo_plan = '02' and pe.codi_conc = '199998')
*/

	set @tota_ingr_grat = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_trip = pec.codi_plan_trip
		and pec.codi_conc = '101902' and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio  )

	set @tota_ingr_vaca = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_trip = pec.codi_plan_trip
		and pec.codi_conc = '101901' and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio )

	SET @tota_ingr_pesc = @tota_ingr_pesc - @tota_ingr_grat - @tota_ingr_vaca	

	set @tota_ingr_boni_trip = (Select isnull( Sum( isnull( valor, 0 )  ) , 0 ) From Planilla_Boni_tripu PE, Planilla_BoniTri_Conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema  and pe.codi_plan_btri = pec.codi_plan_btri -- and substring( pe.mesanio ,1,4 ) = @anio
		and pec.codi_conc = '199998' and pe.codi_tipo_plan = '15' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio )
	
	set @tota_ingr_boni_moto = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_boni = pec.codi_plan_boni and pec.codi_conc = '199998'  and pe.tipo = 'M' )


	set @tota_ingr_gratb = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_boni = pec.codi_plan_boni and pec.codi_conc = '101902'  and pe.tipo = 'M' )

	set @tota_ingr_vacab = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_boni = pec.codi_plan_boni and pec.codi_conc = '101901'  and pe.tipo = 'M' )
	

	set @tota_ingr_grata = (Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,3,4 ) = @anio and pe.codi_tipo_plan = '02' and pe.codi_conc = '199998'
		and cast(  pe.anio  as integer ) = cast( @anio as integer ) - 1  )

	set @tota_ingr_vacaa = (Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,3,4 ) = @anio and pe.codi_tipo_plan = '03' and pe.codi_conc = '199998'
		and cast( pe.anio as integer ) = cast( @anio as integer ) - 1  )


/*	set @tota_ingr_vaca = (Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,1,2 ) <= @mes and pe.anio = @anio and pe.codi_tipo_plan = '03' and pe.codi_conc = '199998' )
*/

/*	if @tota_ingr_vaca >0 
	begin
		print @codi_pers_auxi
		print @tota_ingr_vaca
	end */
	set @tota_util = (Select isnull( importe, 0 )  from UTIL_PERS_ANUAL where codi_pers = @Codi_pers_auxi 
		and periodo = @anio ) 

	set Select @tota_util = isnull(liq_remu_perc, 0) + isnull(liq_dias_labo, 0) from calc_util_pers where codi_pers = @codi_pers_auxi 
		and cast( anio as integer )= cast( @anio as integer) - 1;
	
	set @tota_suel = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and pec.codi_conc = '199998' and pe.codi_tipo_pers = '01' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' )) --or  pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' )  )
	set @tota_ingr_grat_e  = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and pec.codi_conc = '199998' and pe.codi_tipo_pers = '01' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '12' )  )
	set @tota_ingr_vaca_e  = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and pec.codi_conc = '199998' and pe.codi_tipo_pers = '01' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' )  )
	set @tota_ingr_grat_e  = isnull( @tota_ingr_grat_e , 0 )
	set @tota_ingr_vaca_e  = isnull( @tota_ingr_vaca_e , 0 )

--	print @tota_suel
	set @tota_sala = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio and cast( pe.mes as integer ) <= @mes 
				and pec.codi_conc = '199998' and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' )) --or  pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' )  )
	set @tota_ingr_grat_o = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio and cast( pe.mes as integer ) <= @mes 
				and pec.codi_conc = '199998' and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M'
				and (pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '12' )  )
	set @tota_ingr_vaca_o = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio and cast( pe.mes as integer ) <= @mes 
				and pec.codi_conc = '199998' and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' )  )
	set @tota_ingr_grat_o  = isnull( @tota_ingr_grat_o , 0 )
	set @tota_ingr_vaca_o  = isnull( @tota_ingr_vaca_o , 0 )


	set @tota_dev5ta_pesc = 0 /* (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema  and pe.codi_plan_trip = pec.codi_plan_trip -- and substring( pe.mesanio ,1,4 ) = @anio
		and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070' ) and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio  )  */

	set @tota_dev5ta_boni_trip = 0 /*(Select isnull( Sum( isnull( valor, 0 )  ) , 0 ) From Planilla_Boni_tripu PE, Planilla_BoniTri_Conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_btri = pec.codi_plan_btri
		and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070' ) and pe.codi_tipo_plan = '15' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio )  */

	set @tota_dev5ta_boni_moto = 0 /* (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_boni = pec.codi_plan_boni and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070'  ) and pe.tipo = 'M' ) */

	set @tota_dev5ta_suel = 0 /*( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and  pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070' ) and pe.codi_tipo_pers = '01' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' or  pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' )  ) */

	set @tota_dev5ta_sala = 0 /* ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio and cast( pe.mes as integer ) <= @mes 
				and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070' ) and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' or  pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' )  )  */

	set @tota_ingr_pesc  = isnull( @tota_ingr_pesc , 0 )
	set @tota_ingr_boni_trip  = isnull( @tota_ingr_boni_trip , 0 )
	set @tota_ingr_boni_moto  = isnull( @tota_ingr_boni_moto , 0 )
	set @tota_ingr_grat  = isnull( @tota_ingr_grat , 0 )
	set @tota_ingr_vaca  = isnull( @tota_ingr_vaca , 0 )
	set @tota_util  = isnull( @tota_util , 0 )
	set @tota_suel  = isnull( @tota_suel , 0 )
	set @tota_sala  = isnull( @tota_sala , 0 )
	set @tota_dev5ta_pesc  = isnull( @tota_dev5ta_pesc , 0 )
	set @tota_dev5ta_boni_trip  = isnull( @tota_dev5ta_boni_trip , 0 )

	set @tota_ingr_calc_util  = isnull( @tota_ingr_calc_util , 0 )
	set @tota_dev5ta_boni_moto  = isnull( @tota_dev5ta_boni_moto , 0 )
	set @tota_dev5ta_suel  = isnull( @tota_dev5ta_suel , 0 )
	set @tota_dev5ta_sala  = isnull( @tota_dev5ta_sala , 0 )
	set @tota_dev5ta_tota  = isnull( @tota_dev5ta_tota , 0 )
	set @tota_dev5ta_pesc  = isnull( @tota_dev5ta_pesc , 0 )


	set @tota_ingr = ISNULL( @tota_ingr_pesc , 0 ) + ISNULL( @tota_ingr_boni_trip , 0 ) + isnull( @tota_ingr_boni_moto , 0 ) + isnull( @tota_ingr_subs , 0 ) 
	set @tota_ingr =  @tota_ingr + @tota_ingr_grat + @tota_ingr_vaca  + @tota_util + @tota_suel + @tota_sala + @tota_ingr_grat_e + @tota_ingr_grat_o + @tota_ingr_vaca_e + @tota_ingr_vaca_o
	set @tota_ingr_con_devo = @tota_ingr 
	set @tota_ingr_calc_util = @tota_ingr - isnull( @tota_util , 0 ) - isnull( @tota_ingr_subs  , 0 ) - isnull( @tota_dev5ta_pesc , 0 ) - isnull( @tota_dev5ta_boni_trip , 0 ) 
	set @tota_ingr_calc_util = @tota_ingr_calc_util - isnull( @tota_dev5ta_boni_moto , 0 ) - isnull( @tota_dev5ta_suel , 0 ) - isnull( @tota_dev5ta_sala, 0 ) 
	set @tota_dev5ta_tota = isnull( @tota_dev5ta_pesc , 0 ) + isnull( @tota_dev5ta_boni_trip , 0 ) + isnull( @tota_dev5ta_boni_moto , 0 ) + isnull( @tota_dev5ta_suel , 0 ) + isnull( @tota_dev5ta_sala, 0 ) 
	set @tota_ingr = @tota_ingr - ( isnull( @tota_dev5ta_pesc , 0 ) + isnull( @tota_dev5ta_boni_trip , 0 ) + isnull( @tota_dev5ta_boni_moto , 0 ) + isnull( @tota_dev5ta_suel , 0 ) + isnull( @tota_dev5ta_sala, 0 ) )


	set @tota_quin_pesc = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_trip = pec.codi_plan_trip
		and pec.codi_conc = '200040' and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio  )

	set @tota_quin_boni_trip = (Select isnull( Sum( isnull( valor, 0 )  ) , 0 ) From Planilla_Boni_tripu PE, Planilla_BoniTri_Conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and pe.codi_plan_btri = pec.codi_plan_btri -- and substring( pe.mesanio ,1,4 ) = @anio 
		and pec.codi_conc = '200040' and pe.codi_tipo_plan = '15' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio )

	set @tota_quin_boni_moto = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_boni = pec.codi_plan_boni and pec.codi_conc = '200040'  and pe.tipo = 'M' )

	set @tota_quin_subs = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_subsidio PE, Planilla_subs_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 )  as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_subs = pec.codi_plan_subs and pec.codi_conc = '200040' )

	set @tota_quin_suel = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and  pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and pec.codi_conc = '200040' and pe.codi_tipo_pers = '01' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' or  pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' )  )

	set @tota_quin_sala = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio and cast( pe.mes as integer ) <= @mes 
				and pec.codi_conc = '200040' and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M' 
				and (  pe.codi_tipo_plan = '01' or  pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' )  )
	
	set @tota_quin_grat = (Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,1,2 ) <= @mes and substring( pe.mesanio_prov ,3,4 ) = @anio and pe.codi_tipo_plan = '02' and pe.codi_conc = '200040')	

	set @tota_quin_vaca = (Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,1,2 ) <= @mes and substring( pe.mesanio_prov ,3,4 ) = @anio and pe.codi_tipo_plan = '03' and pe.codi_conc = '200040')	

	set @tota_quin_rete = isnull( @tota_quin_pesc , 0 ) + isnull( @tota_quin_boni_trip , 0 ) + isnull( @tota_quin_boni_moto , 0 ) + isnull( @tota_quin_subs , 0 ) 
	set @tota_quin_rete = isnull( @tota_quin_rete , 0 ) + isnull( @tota_quin_suel , 0 ) + isnull( @tota_quin_sala , 0 ) + isnull( @tota_quin_grat , 0 ) + isnull( @tota_quin_vaca , 0 )
	set @cont = 0
	set @dias_trip_moto_tota = 0
	while @cont <  @mes 
	Begin
		set @cont = @cont + 1
		set @cont_carg_moto = 0
		set @cont_carg_trip = 0
		set @dias_moto = 0
		set @dias_trip = 0
		declare curs_carg_carg_mens cursor for
		select distinct codi_carg from asistencia_tripulantes_pesca atp, semana se
		where atp.codi_pers = @codi_pers_auxi and atp.codi_sema = se.codi_sema and cast( RIGHT(se.aniomes, 2)  as integer) = @cont and 
		left(se.aniomes, 4)  = @anio ;
		open curs_carg_carg_mens;
		fetch next from curs_carg_carg_mens into @cargo
		while @@fetch_status = 0
		begin			
			if @cargo = '1104' or @cargo = '1105' or @cargo = '1106'  or @cargo = '1107' 
			begin
				set @cont_carg_moto = @cont_carg_moto + 1
				select @dias_moto = isnull( dias_traba_mens, 0 ) from asistencia_motorista where codi_pers = @codi_pers_auxi and right(mesanio , 4) = @anio
							and cast( left( mesanio, 2)  as integer) = @cont;
			end
			else
			begin
				set @cont_carg_trip = @cont_carg_trip + 1
			end
			fetch next from curs_carg_carg_mens into @cargo
		end
		close curs_carg_carg_mens;
		deallocate curs_carg_carg_mens;
		select @dias_trip = isnull( sum(cast(jueves as numeric)+cast(viernes as numeric) + cast(sabado as  numeric) + cast(domingo as numeric)+
						cast(lunes as numeric) + cast(martes as numeric) + cast(miercoles as numeric) )  , 0 ) 
			from asistencia_tripulantes_pesca, semana where 	semana.codi_sema=asistencia_tripulantes_pesca.codi_sema and left(semana.aniomes,4) =@anio 
				and cast( right(semana.aniomes,2) as integer) = @cont and asistencia_tripulantes_pesca.codi_pers = @codi_pers_auxi
		set @dias_trip = isnull( @dias_trip , 0 )
		set @dias_moto = isnull( @dias_moto , 0 )
		if @cont_carg_moto = 1
		begin
			/*print @cont
			print @codi_pers_auxi
			print @dias_moto		
			print @dias_trip */
			
			if @cont_carg_trip = 1
			begin
				if @dias_trip > @dias_moto
				begin
					set @dias_trip_moto_tota = @dias_trip_moto_tota + @dias_trip
				end
				else
				begin
					set @dias_trip_moto_tota = @dias_trip_moto_tota + @dias_moto
				end
			end
			else
			begin
				set @dias_trip_moto_tota = @dias_trip_moto_tota + @dias_moto
			end	
			/*print @dias_trip_moto_tota	
			print ' - - - - ' */
		end
		else
		begin
			set @dias_trip_moto_tota = @dias_trip_moto_tota + @dias_trip
			
		end		
	end
	set @dias_suel = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and ( pec.codi_conc = '500001' or pec.codi_conc = '500002' or pec.codi_conc = '500000'  ) and pe.codi_tipo_pers = '01' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' ) )

	set @dias_sala =( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and ( pec.codi_conc = '500001' or pec.codi_conc = '500002' or pec.codi_conc = '500000'  ) and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' ) )

	set @dias_vaca = (Select ISNULL( sum( isnull( nro_dias , 0) ) , 0 ) from vacaciones where cast( anio as integer ) = @anio and cast( mes as integer ) <= @mes and codi_pers = @codi_pers_auxi )

	set @dias_tota = isnull( @dias_trip_moto_tota , 0 ) + isnull( @dias_suel , 0 )  + isnull( @dias_sala , 0 )  + isnull( @dias_vaca , 0 )  -- isnull( @dias_trip , 0 ) + isnull( @dias_suel , 0 )  + isnull( @dias_sala , 0 )  + isnull( @dias_vaca , 0 ) 
	if @dias_tota > 306 begin set @dias_tota = 306 end
	set @base_impo = @tota_ingr - @mont_dedu
	set @valo_desc_rent_quin = 0
	IF @BASE_IMPO > 0 
	begin		
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
			if  ( @base_impo > ( @nro_mini_uit * @mont_uit) ) AND ( @base_impo <= ( @nro_maxi_uit * @mont_uit) )
			begin	
				set @valo_desc_auxi = @valo_desc_auxi + ( @base_impo -  ( @nro_mini_uit * @mont_uit)  ) *  @PORCENTAJE / 100
			end
			ELSE
			BEGIN
				if  ( @base_impo - ( @nro_maxi_uit * @mont_uit)  ) > 0 
				begin
					set @valo_desc_auxi = @valo_desc_auxi + ( @nro_maxi_uit * @mont_uit ) * @PORCENTAJE / 100 
				end
			END
			SET @valo_desc_rent_quin = isnull( @valo_desc_rent_quin , 0 ) + ISNULL(@valo_desc_auxi,0)
			fetch next from Curs_Carg_para_rent_quin_2 into @nro_mini_uit, @nro_maxi_uit, @porcentaje;
		end
		Close Curs_Carg_para_rent_quin_2;
		Deallocate Curs_Carg_para_rent_quin_2;
		set @valo_desc_rent_quin = isnull( @valo_desc_rent_quin, 0 )	
	end
	else
	begin
		--set @base_impo = 0
		set @valo_desc_rent_quin = 0
	end
	set @dife_rent = @valo_desc_rent_quin - @tota_quin_rete

/*	if @codi_pers_auxi = 'R5216' 
	begin 
		print  @tota_util 
		print  @tota_ingr_subs 
		print  @tota_ingr_vacaa 
		print  @tota_ingr_grata 
		PRINT @tota_ingr_calc_util  
	end
*/
	Insert Into #Rela_quin_trip ( codi_pers , apel_1 , apel_2 , nomb_1 , nomb_2 , trabajador , tota_ingre , base_impo , impo_rent_quin, tota_rete , dife_rent , 
		uits, tota_trip, tota_boni, tota_grat, 
		tota_vaca, otros, DIAS_TRAB, 
		tota_ingr_con_devo, devo_quin, tota_ingr_calc_util  , codi_unid_oper )  
	Values (@codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador, @tota_ingr, @base_impo, @valo_desc_rent_quin , @tota_quin_rete, @dife_rent , 
		@mont_dedu, @tota_ingr_pesc + @tota_suel + @tota_sala, @tota_ingr_boni_trip + @tota_ingr_boni_moto,  @tota_ingr_grat + @tota_ingr_grat_e + @tota_ingr_grat_o, 
		@tota_ingr_vaca + @tota_ingr_vaca_e + @tota_ingr_vaca_o, @tota_util + @tota_ingr_subs + @tota_ingr_vacaa + @tota_ingr_grata - @tota_dev5ta_tota , @DIAS_TOTA , 
		@tota_ingr_con_devo, @tota_dev5ta_tota, @tota_ingr_calc_util , @codi_unid_oper )
/*
	Insert Into #Rela_quin_trip ( codi_pers , apel_1 , apel_2 , nomb_1 , nomb_2 , trabajador , tota_ingre , base_impo , impo_rent_quin, tota_rete , dife_rent , uits, tota_trip, tota_boni,
					tota_grat, tota_vaca, otros, DIAS_TRAB, tota_ingr_con_devo, devo_quin, tota_ingr_calc_util , codi_unid_oper ) 
	Values (@codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador, @tota_ingr, @base_impo, @valo_desc_rent_quin , @tota_quin_rete, @dife_rent , @mont_dedu,
		@tota_ingr_pesc + @tota_suel + @tota_sala, @tota_ingr_boni_trip + @tota_ingr_boni_moto,  @tota_ingr_grat, @tota_ingr_vaca, @tota_util + @tota_ingr_subs, 
		@DIAS_TOTA , @tota_ingr_con_devo, @tota_dev5ta_tota, @tota_ingr_calc_util , @codi_unid_oper )
*/
	Fetch next from curs_carg_trab_trip into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador	
end

close curs_carg_trab_trip;
deallocate curs_carg_trab_trip;

Select * from #Rela_quin_trip order by apel_1, apel_2, nomb_1, nomb_2 ;

End
GO
