CREATE PROCEDURE [dbo].[SP_Repo_quin_cate_anual_jcr]
	@sema_inic [int],
	@sema_fina [int],
	@mes [int],
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
--declare @sema_inic integer , @sema_fina integer, @mes integer, @anio char(4)
--select @sema_inic =1, @sema_fina =53, @mes =3, @anio ='2022'
Begin

set nocount on 

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
Declare @tota_ingr_grat_e decimal (15,2) 
Declare @tota_ingr_vaca_e decimal (15,2) 
Declare @tota_ingr_grat_o decimal (15,2) 
Declare @tota_ingr_vaca_o decimal (15,2) 
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
declare @tota_rent_rete_util decimal (15,2) 

declare  @dife_rent decimal (15,2) 
Declare @dias_trip integer
Declare @dias_suel integer
Declare @dias_sala integer
Declare @dias_vaca integer
Declare @dias_tota integer
declare @grup varchar(50)
declare @nro_docu varchar(20)
declare @tipo_pers char(2)
declare @dire_pers varchar(150)
declare @codi_carg_pers char(4)
declare @carg_pers varchar(150)
declare @rs_empr varchar(150)
declare @ruc_empr varchar(15)
declare @dire_empr varchar(250)
declare @repr_empr varchar(150)
declare @dni_repr_empr varchar(15)
declare @cont_para integer

declare @base_impo_auxi decimal (15,2)
declare @base_impo_1 decimal (15,2) 
declare @base_impo_2 decimal (15,2) 
declare @base_impo_3 decimal (15,2) 
declare @base_impo_4 decimal (15,2) 
declare @base_impo_5 decimal (15,2) 

declare @impo_para_1 decimal (15,2) 
declare @impo_para_2 decimal (15,2) 
declare @impo_para_3 decimal (15,2) 
declare @impo_para_4 decimal (15,2) 
declare @impo_para_5 decimal (15,2)
 
declare @mont_para_1 decimal (15,2) 
declare @mont_para_2 decimal (15,2) 
declare @mont_para_3 decimal (15,2) 
declare @mont_para_4 decimal (15,2) 
declare @mont_para_5 decimal (15,2)

declare @nro_uit_1 varchar(40)
declare @nro_uit_2 varchar(40)
declare @nro_uit_3 varchar(40)
declare @nro_uit_4 varchar(40)
declare @nro_uit_5 varchar(40)

declare @tota_comi numeric(12,2)
declare @tota_otras_rentas numeric(12,2)

Select @grup = upper(grupo), @rs_empr = razon_social, @ruc_empr = ruc, @dire_empr = isnull(direccion, ''), 
	@repr_empr = isnull(NOM_BOLE ,'') , @dni_repr_empr = isnull(docu_bole, '')
from empresa

Create Table #Rela_quin_trip( codi_pers char(5) NULL, apel_1 varchar(30) NULL, apel_2 varchar(30) NULL, nomb_1 varchar(30) NULL, nomb_2 varchar(30) NULL, trabajador varchar(120) NULL, 
		tota_ingre decimal (15,2)  NULl, base_impo decimal (15,2)  NULL, impo_rent_quin decimal (15,2)  NULL, tota_rete decimal (15,2)  NULL, dife_rent decimal (15,2)  NULL,
		UITS decimal (15,2)  null , tota_trip decimal (15,2)  NULL, tota_boni decimal (15,2)  NULL, tota_grat decimal (15,2)  NULL, tota_vaca decimal (15,2)  NULL, 
		otros  decimal (15,2)  NULL, DIAS_TRAB integer null , tota_ingr_con_devo decimal( 15, 2 ) NULL, devo_quin decimal ( 15,2) NULL, tota_ingr_calc_util decimal (9,2) NULL,
		codi_unid_oper char(5) NULL, nro_docu varchar(20) null, codi_tipo_pers char(2) null, 
		rs_empr varchar(150) null, ruc_empr varchar(15) null, dire_empr varchar(250) null, repr_empr varchar(150) null, dni_repr varchar(15) null, 
		dire_pers varchar(250) null, carg_pers varchar(100) null , utilidades decimal( 15, 2 ) NULL, impo_para_1 decimal( 15, 2 ) NULL, impo_para_2 decimal( 15, 2 ) NULL,
		impo_para_3 decimal( 15, 2 ) NULL, impo_para_4 decimal( 15, 2 ) NULL, impo_para_5 decimal( 15, 2 ) NULL, mont_para_1 decimal( 15, 2 ) NULL,
		mont_para_2 decimal( 15, 2 ) NULL, mont_para_3 decimal( 15, 2 ) NULL, mont_para_4 decimal( 15, 2 ) NULL, mont_para_5 decimal( 15, 2 ) NULL,
		base_impo_1 decimal( 15, 2) null, base_impo_2 decimal( 15, 2) null, base_impo_3 decimal( 15, 2) null, base_impo_4 decimal( 15, 2) null, base_impo_5 decimal( 15, 2) null,
		nro_uit_1 varchar(40) null, nro_uit_2 varchar(40) null, nro_uit_3 varchar(40) null , nro_uit_4 varchar(40) null, nro_uit_5 varchar(40) null,
		comisiones decimal(12,2) null, otras_rentas decimal(12,2) null)
		
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
	isnull( p.apel_1,'') + ' ' + isnull( p.apel_2,'') + ' ' + isnull( p.nomb_1,'') + ' ' + isnull( p.nomb_2,'') as trabajador, isnull(direccion, '') , isnull(codi_carg , '')  
from
(	Select distinct pe.codi_pers From Planilla_de_tripulantes PE, semana se
	where se.codi_sema = pe.codi_Sema and substring(se.aniomes , 1,4 ) = @anio and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina
union
	Select distinct Pe.codi_pers From Planilla_boni_moto PE
	where cast( substring( pe.mesanio , 1,2 ) as smallint ) <= @mes and substring( pe.mesanio , 3,4 ) = @anio
union
	Select distinct Pe.codi_pers From Planilla_boni_moto PE
	where cast( substring( pe.mesanio , 5,2 ) as smallint ) <= @mes and substring( pe.mesanio , 1,4 ) = @anio
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
Fetch next from curs_carg_trab_trip into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador, @dire_pers, @codi_carg_pers;
while @@fetch_status = 0
begin
	set @tota_ingr_pesc  = 0
	set @tota_ingr_boni_trip  = 0
	set @tota_ingr_boni_moto  = 0
	set @tota_ingr_subs  = 0
	set @tota_ingr_grat  = 0
	set @tota_ingr_vaca  = 0
	set @tota_util  = 0
	set @tota_suel  = 0
	set @tota_sala  = 0
	set @tota_dev5ta_pesc  = 0
	set @tota_dev5ta_boni_trip  = 0
	set @tota_ingr_calc_util  = 0
	set @tota_dev5ta_boni_moto  = 0
	set @tota_dev5ta_suel  = 0
	set @tota_dev5ta_sala  = 0
	set @tota_dev5ta_tota  = 0
	set @tota_dev5ta_pesc  = 0

	set @tota_quin_rete = 0
	set @tota_quin_pesc = 0 
	set @tota_quin_boni_trip = 0 
	set @tota_quin_boni_moto = 0 
	set @tota_quin_subs = 0 
	set @tota_quin_suel = 0 
	set @tota_quin_sala = 0 
	set @tota_quin_grat = 0 
	set @tota_quin_vaca = 0
	set @tota_rent_rete_util = 0

	--print @codi_pers_auxi
	Select  @codi_unid_oper = codi_unid_oper, @nro_docu = nro_docu_iden from personal where codi_pers = @codi_pers_auxi;
	Select @carg_pers = desc_cargo from cargos where codi_carg = @codi_carg_pers;

	set @tota_ingr_pesc = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_trip = pec.codi_plan_trip
		and pec.codi_conc = '199998' and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio  )
	--print @tota_ingr_pesc
	set @tota_ingr_grat = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_trip = pec.codi_plan_trip
		and pec.codi_conc = '101902' and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio  )
	set @tota_ingr_vaca = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_trip = pec.codi_plan_trip
		and pec.codi_conc = '101901' and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio )
	SET @tota_ingr_pesc = @tota_ingr_pesc - @tota_ingr_grat - @tota_ingr_vaca
	set @tota_ingr_boni_trip = 0

	set @tota_ingr_boni_moto = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_boni = pec.codi_plan_boni and pec.codi_conc = '199998'  and pe.tipo = 'M' )

	set @tota_ingr_gratb = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_boni = pec.codi_plan_boni and pec.codi_conc = '101902'  and pe.tipo = 'M' )

	set @tota_ingr_vacab = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_boni = pec.codi_plan_boni and pec.codi_conc = '101901'  and pe.tipo = 'M' )	

	set @tota_ingr_boni_moto = @tota_ingr_boni_moto - ISNULL( @tota_ingr_gratb , 0 ) - ISNULL( @tota_ingr_vacab , 0 ) 

	set @tota_ingr_subs = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_subsidio PE, Planilla_subs_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_subs = pec.codi_plan_subs and pec.codi_conc = '199999' )
	--print @tota_ingr_subs

	set @tota_ingr_grata = 0 /* (Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,3,4 ) = @anio and pe.codi_tipo_plan = '02' and pe.codi_conc = '199998'
		and cast(  pe.anio  as integer ) = cast( @anio as integer ) - 1  ) */

	set @tota_ingr_vacaa =  0 /*(Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,3,4 ) = @anio and pe.codi_tipo_plan = '03' and pe.codi_conc = '199998'
		and cast( pe.anio as integer ) = cast( @anio as integer ) - 1  )
		-- and substring( pe.mesanio_prov ,1,2 ) <= @mes */

	set @tota_util = 0
	set Select @tota_util = isnull(liq_remu_perc, 0) + isnull(liq_dias_labo, 0) from calc_util_pers where codi_pers = @codi_pers_auxi 
		and cast( anio as integer )= cast( @anio as integer) - 1 ;

	SET @tota_util  = ISNULL(@tota_util , 0)
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

	set @tota_comi = isnull(( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and pec.codi_conc = '100020' and pe.codi_tipo_pers ='01' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' )),0)   + 
				
				isnull(( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio and cast( pe.mes as integer ) <= @mes 
				and pec.codi_conc = '100020' and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' )),0)


	set @tota_otras_rentas= isnull((select sum(monto) from INGRESOS_QUINTA_CATEG (nolock) where año=@anio and mes<=@mes and codi_pers=@codi_pers_auxi),0)

	set @tota_ingr_grat_o  = isnull( @tota_ingr_grat_o , 0 )
	set @tota_ingr_vaca_o  = isnull( @tota_ingr_vaca_o , 0 )

--	set @tota_ingr = @tota_ingr_pesc + @tota_ingr_boni_trip + @tota_ingr_boni_moto + @tota_ingr_subs + @tota_ingr_grat + @tota_ingr_vaca + @tota_util + @tota_suel + @tota_sala
--	set @tota_ingr = @tota_ingr - @tota_dev5ta_pesc - @tota_dev5ta_boni_trip - @tota_dev5ta_boni_moto
	set @tota_ingr_pesc  = isnull( @tota_ingr_pesc , 0 )
	set @tota_ingr_boni_trip  = isnull( @tota_ingr_boni_trip , 0 )
	set @tota_ingr_boni_moto  = isnull( @tota_ingr_boni_moto , 0 )
	set @tota_ingr_subs  = isnull( @tota_ingr_subs , 0 )
	set @tota_ingr_grat  = isnull( @tota_ingr_grat , 0 ) + isnull( @tota_ingr_gratb , 0 ) 
	set @tota_ingr_vaca  = isnull( @tota_ingr_vaca , 0 ) + isnull( @tota_ingr_vacab , 0 )
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

	set @tota_ingr =  @tota_ingr_pesc  + @tota_ingr_boni_trip + @tota_ingr_boni_moto +  @tota_ingr_subs + @tota_ingr_grat + @tota_ingr_vaca +  @tota_ingr_grata + @tota_ingr_vacaa 
	set @tota_ingr =  @tota_ingr + @tota_util + @tota_suel + @tota_sala + @tota_ingr_grat_e + @tota_ingr_grat_o + @tota_ingr_vaca_e + @tota_ingr_vaca_o +  @tota_otras_rentas 
/*	if @codi_pers_auxi = '60548'
	begin
		print @tota_ingr
	end*/
	set @tota_ingr_con_devo = @tota_ingr 
	set @tota_ingr_calc_util = @tota_ingr - isnull( @tota_util , 0 ) - isnull( @tota_ingr_subs  , 0 ) - isnull( @tota_dev5ta_pesc , 0 ) - isnull( @tota_dev5ta_boni_trip , 0 ) 
	set @tota_ingr_calc_util = @tota_ingr_calc_util - isnull( @tota_dev5ta_boni_moto , 0 ) - isnull( @tota_dev5ta_suel , 0 ) - isnull( @tota_dev5ta_sala, 0 ) 
	set @tota_dev5ta_tota = isnull( @tota_dev5ta_pesc , 0 ) + isnull( @tota_dev5ta_boni_trip , 0 ) + isnull( @tota_dev5ta_boni_moto , 0 ) + isnull( @tota_dev5ta_suel , 0 ) + isnull( @tota_dev5ta_sala, 0 ) 
	set @tota_ingr = @tota_ingr - ( isnull( @tota_dev5ta_pesc , 0 ) + isnull( @tota_dev5ta_boni_trip , 0 ) + isnull( @tota_dev5ta_boni_moto , 0 ) + isnull( @tota_dev5ta_suel , 0 ) + isnull( @tota_dev5ta_sala, 0 ) )
/*	if @codi_pers_auxi = '60548'
	begin
		print @tota_ingr
	end
*/
	set @tota_quin_pesc = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_trip = pec.codi_plan_trip
		and pec.codi_conc = '200040' and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio  )
	set @tota_quin_boni_trip = 0

	set @tota_quin_boni_moto = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_boni = pec.codi_plan_boni and pec.codi_conc = '200040'  and pe.tipo = 'M' )

	set @tota_quin_subs = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_subsidio PE, Planilla_subs_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 )  as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_subs = pec.codi_plan_subs and pec.codi_conc = '200040' )

	set @tota_quin_suel = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and pec.codi_conc = '200040' and pe.codi_tipo_pers = '01' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' or  pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' ) )

	set @tota_quin_sala = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio and cast( pe.mes as integer ) <= @mes 
				and pec.codi_conc = '200040' and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M' 
				and (  pe.codi_tipo_plan = '01' or  pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' )  )

	set @tota_quin_grat = (Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,3,4 ) = @anio and pe.codi_tipo_plan = '02' and pe.codi_conc = '200040'
		and cast(  pe.anio  as integer ) = cast( @anio as integer ) - 1  )

	set @tota_quin_vaca = (Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,3,4 ) = @anio and pe.codi_tipo_plan = '03' and pe.codi_conc = '200040'
		and cast( pe.anio as integer ) = cast( @anio as integer ) - 1  )

	set @tota_rent_rete_util = ( Select isnull( valor, 0 ) from calc_util_deta
	where ( cast( anio as integer) = cast( @anio as integer) - 1 ) and codi_pers = @codi_pers_auxi and codi_conc = '200040' ); 

	set @tota_rent_rete_util = isnull( @tota_rent_rete_util, 0 )
	
	set @tota_quin_rete = @tota_quin_pesc + @tota_quin_boni_trip + @tota_quin_boni_moto + @tota_quin_subs + @tota_quin_suel + @tota_quin_sala + @tota_quin_grat + @tota_quin_vaca + @tota_rent_rete_util
				+ isnull((select sum(renta_reten) from INGRESOS_QUINTA_CATEG O (nolock) where O.año=@anio and mes<=@mes and o.codi_pers=@codi_pers_auxi),0)	
				
--	set @tota_quin_rete = @tota_rent_rete_util
	select @dias_trip = isnull( sum(cast(jueves as numeric)+cast(viernes as numeric) + cast(sabado as  numeric) + cast(domingo as numeric)+
					cast(lunes as numeric) + cast(martes as numeric) + cast(miercoles as numeric) )  , 0 ) 
			from asistencia_tripulantes_pesca, semana where 	semana.codi_sema=asistencia_tripulantes_pesca.codi_sema and 
				left( asistencia_tripulantes_pesca.mesANIO,4) =@anio and CAST( right( asistencia_tripulantes_pesca.mesANIO,2)  AS INTEGER) <= @mes  
				and asistencia_tripulantes_pesca.codi_pers = @codi_pers_auxi
	
	set @dias_suel = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and ( pec.codi_conc = '500001' or pec.codi_conc = '500002' or pec.codi_conc = '500000'  ) and pe.codi_tipo_pers = '01' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' ) )

	set @dias_sala =( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and ( pec.codi_conc = '500001' or pec.codi_conc = '500002' or pec.codi_conc = '500000'  ) and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' ) )

	set @dias_vaca = (Select sum( isnull( nro_dias , 0) ) from vacaciones where cast( anio as integer ) = @anio and cast( mes as integer ) <= @mes and codi_pers = @codi_pers_auxi )

	set @dias_tota = isnull( @dias_trip , 0 ) + isnull( @dias_suel , 0 )  + isnull( @dias_sala , 0 )  + isnull( @dias_vaca , 0 ) 

	set @tipo_pers = (Select top 1 codi_tipo_pers from PERSONAL_POR_TIPO_TRABAJADOR where codi_pers = @codi_pers_auxi)
--select @tota_otras_rentas 
	set @base_impo = @tota_ingr - @mont_dedu 
	set @valo_desc_rent_quin = 0
	set @cont_para = 0
	set @impo_para_1 = 0
	set @impo_para_2 = 0
	set @impo_para_3 = 0
	set @impo_para_4 = 0
	set @impo_para_5 = 0
	set @mont_para_1 = 0
	set @mont_para_2 = 0
	set @mont_para_3 = 0
	set @mont_para_4 = 0
	set @mont_para_5 = 0

	set @base_impo_auxi = 0
	set @base_impo_1 = 0
	set @base_impo_2 = 0
	set @base_impo_3 = 0
	set @base_impo_4 = 0
	set @base_impo_5 = 0

	set @nro_uit_1 = ''
	set @nro_uit_2 = ''
	set @nro_uit_3 = ''
	set @nro_uit_4 = ''
	set @nro_uit_5 = ''

	IF @BASE_IMPO > 0 
	begin		
		Declare Curs_Carg_para_rent_quin_2 Cursor For
		Select nro_mini_uit, nro_maxi_uit, porcentaje
		From Parametros_quinta (nolock)
		--where esta_para = 1
		where fech_para in (
			Select max(fech_para)
				From Parametros_quinta (nolock) where fech_para<'31/12/'+@anio)
		order by nro_para;
		Open Curs_Carg_para_rent_quin_2;
		fetch next from Curs_Carg_para_rent_quin_2 into @nro_mini_uit, @nro_maxi_uit, @porcentaje;
		While @@fetch_status = 0
		begin
			set @cont_para = @cont_para + 1
			set @valo_desc_auxi = 0
			if  ( @base_impo > ( @nro_mini_uit * @mont_uit ) ) AND ( @base_impo <= ( @nro_maxi_uit * @mont_uit) )
			begin	
				set @valo_desc_auxi = ( @base_impo -  ( @nro_mini_uit * @mont_uit)  ) *  @PORCENTAJE / 100
				set @base_impo_auxi = @base_impo -  ( @nro_mini_uit * @mont_uit) 
			end
			ELSE
			BEGIN
				if  ( @base_impo - ( @nro_maxi_uit * @mont_uit )  ) > 0 
				begin
					set @valo_desc_auxi = ( ( @nro_maxi_uit - @nro_mini_uit ) * @mont_uit ) * @PORCENTAJE / 100 
					set @base_impo_auxi = ( @nro_maxi_uit - @nro_mini_uit ) * @mont_uit 
				end
			end
			if @cont_para = 1 
			begin 
				set @impo_para_1 = @valo_desc_auxi
				set @mont_para_1 = @PORCENTAJE / 100 
				set @base_impo_1 = @base_impo_auxi
				if @nro_maxi_uit < 1000
				begin
					set @nro_uit_1 = 'de ' + cast( cast( @nro_mini_uit as numeric(12,0) ) as varchar  ) + ' U.I.T.  a ' + cast( cast( @nro_maxi_uit as numeric(12,0) ) as varchar ) + ' U.I.T.'
				end
				else
				begin
					set @nro_uit_1 = 'de ' + cast( cast( @nro_mini_uit as numeric(12,0) ) as varchar  )  + '  U.I.T.   a  más '
				end
			end
			if @cont_para = 2
			begin 
				set @impo_para_2 = @valo_desc_auxi
				set @mont_para_2 = @PORCENTAJE / 100 
				set @base_impo_2 = @base_impo_auxi
				if @nro_maxi_uit < 1000
				begin
					set @nro_uit_2 =  'de ' + cast( cast( @nro_mini_uit as numeric(12,0) ) as varchar  ) + ' U.I.T.  a ' + cast( cast( @nro_maxi_uit as numeric(12,0) ) as varchar ) + ' U.I.T.'
				end
				else
				begin
					set @nro_uit_2 = 'de ' + cast( cast( @nro_mini_uit as numeric(12,0) ) as varchar  )  + '  U.I.T.   a  más '
				end
			end
			if @cont_para = 3 
			begin 
				set @impo_para_3 = @valo_desc_auxi
				set @mont_para_3 = @PORCENTAJE / 100 
				set @base_impo_3 = @base_impo_auxi
				if @nro_maxi_uit < 1000
				begin
					set @nro_uit_3 =  'de ' + cast( cast( @nro_mini_uit as numeric(12,0) ) as varchar  ) + ' U.I.T.  a ' + cast( cast( @nro_maxi_uit as numeric(12,0) ) as varchar ) + ' U.I.T.'
				end
				else
				begin
					set @nro_uit_3 = 'de ' + cast( cast( @nro_mini_uit as numeric(12,0) ) as varchar  )  + '  U.I.T.   a  más '
				end
			end
			if @cont_para = 4
			begin 
				set @impo_para_4 = @valo_desc_auxi
				set @mont_para_4 = @PORCENTAJE / 100 
				set @base_impo_4 = @base_impo_auxi
				if @nro_maxi_uit < 1000
				begin
					set @nro_uit_4 =  'de ' + cast( cast( @nro_mini_uit as numeric(12,0) ) as varchar  ) + ' U.I.T.  a ' + cast( cast( @nro_maxi_uit as numeric(12,0) ) as varchar ) + ' U.I.T.'
				end
				else
				begin
					set @nro_uit_4 = 'de ' + cast( cast( @nro_mini_uit as numeric(12,0) ) as varchar  )  + '  U.I.T.   a  más '
				end
			end
			if @cont_para = 5
			begin 
				set @impo_para_5 = @valo_desc_auxi
				set @mont_para_5 = @PORCENTAJE / 100 
				set @base_impo_5 = @base_impo_auxi
				if @nro_maxi_uit < 1000
				begin
					set @nro_uit_5 =  'de ' + cast( cast( @nro_mini_uit as numeric(12,0) ) as varchar  ) + ' U.I.T.  a ' + cast( cast( @nro_maxi_uit as numeric(12,0) ) as varchar ) + ' U.I.T.'
				end
				else
				begin
					set @nro_uit_5 = 'de ' + cast( cast( @nro_mini_uit as numeric(12,0) ) as varchar  )  + '  U.I.T.   a  más '
				end
			end

			SET @valo_desc_rent_quin = isnull( @valo_desc_rent_quin , 0 ) + ISNULL(@valo_desc_auxi,0)

			fetch next from Curs_Carg_para_rent_quin_2 into @nro_mini_uit, @nro_maxi_uit, @porcentaje;	
		end
		Close Curs_Carg_para_rent_quin_2;
		Deallocate Curs_Carg_para_rent_quin_2;
		set @valo_desc_rent_quin = isnull( @valo_desc_rent_quin, 0 )	
	end
	else
	begin
		set @valo_desc_rent_quin = 0
	end
	set @dife_rent = @valo_desc_rent_quin - @tota_quin_rete
	if ABS(@dife_rent ) <= 0.01 
	begin
		set @dife_rent = 0
		set @valo_desc_rent_quin = @tota_quin_rete		
	end

	Insert Into #Rela_quin_trip ( codi_pers , apel_1 , apel_2 , nomb_1 , nomb_2 , trabajador , tota_ingre , base_impo , impo_rent_quin, tota_rete , dife_rent , 
		uits, tota_trip, tota_boni, tota_grat, 
		tota_vaca, otros, DIAS_TRAB, 
		tota_ingr_con_devo, devo_quin, tota_ingr_calc_util  , codi_unid_oper, nro_docu, codi_tipo_pers, 
		rs_empr , ruc_empr, dire_empr, repr_empr, dni_repr, dire_pers, carg_pers, utilidades, impo_para_1, impo_para_2, impo_para_3, impo_para_4, impo_para_5,
		mont_para_1, mont_para_2, mont_para_3, mont_para_4, mont_para_5, base_impo_1, base_impo_2, base_impo_3, base_impo_4, base_impo_5,
		nro_uit_1, nro_uit_2, nro_uit_3, nro_uit_4, nro_uit_5 , comisiones, otras_rentas)
	Values (@codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador, @tota_ingr , @base_impo, @valo_desc_rent_quin , @tota_quin_rete, @dife_rent , 
		@mont_dedu, @tota_ingr_pesc + @tota_suel + @tota_sala - @tota_comi , @tota_ingr_boni_trip + @tota_ingr_boni_moto ,  @tota_ingr_grat + @tota_ingr_grat_e + @tota_ingr_grat_o, 
		@tota_ingr_vaca + @tota_ingr_vaca_e + @tota_ingr_vaca_o, @tota_ingr_subs + @tota_ingr_vacaa + @tota_ingr_grata - @tota_dev5ta_tota , @DIAS_TOTA , 
		@tota_ingr_con_devo, @tota_dev5ta_tota, @tota_ingr_calc_util, @codi_unid_oper, @nro_docu, @tipo_pers,
		@rs_empr, @ruc_empr, @dire_empr, @repr_empr, @dni_repr_empr, @dire_pers, @carg_pers, @tota_util, @impo_para_1, @impo_para_2, @impo_para_3, 
		@impo_para_4, @impo_para_5, @mont_para_1, @mont_para_2, @mont_para_3, @mont_para_4, @mont_para_5, @base_impo_1, @base_impo_2,
		@base_impo_3, @base_impo_4, @base_impo_5, @nro_uit_1, @nro_uit_2, @nro_uit_3, @nro_uit_4, @nro_uit_5 ,@tota_comi ,@tota_otras_rentas )

	Fetch next from curs_carg_trab_trip into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador, @dire_pers, @codi_carg_pers;
end

close curs_carg_trab_trip;
deallocate curs_carg_trab_trip;

Select codi_pers , apel_1 , apel_2 , nomb_1 , nomb_2 , trabajador , tota_ingre , base_impo , impo_rent_quin , tota_rete , dife_rent ,
		UITS , tota_trip , tota_boni , tota_grat , tota_vaca , 	otros  , DIAS_TRAB , tota_ingr_con_devo , devo_quin , tota_ingr_calc_util ,
		codi_unid_oper , nro_docu , codi_tipo_pers , 
		rs_empr , ruc_empr , dire_empr , repr_empr , dni_repr , 
		dire_pers , carg_pers , utilidades ,
		impo_para_1 , impo_para_2 ,
		impo_para_3 , impo_para_4 , impo_para_5 , mont_para_1 ,
		mont_para_2 , mont_para_3 , mont_para_4 , mont_para_5 ,
		base_impo_1 , base_impo_2 , base_impo_3 , base_impo_4 , base_impo_5 ,
		nro_uit_1 , nro_uit_2 , nro_uit_3 , nro_uit_4 , nro_uit_5 , comisiones , otras_rentas 
from #Rela_quin_trip 
--where codi_pers=00016
order by apel_1, apel_2, nomb_1, nomb_2 ;

drop table #Rela_quin_trip
End
GO
