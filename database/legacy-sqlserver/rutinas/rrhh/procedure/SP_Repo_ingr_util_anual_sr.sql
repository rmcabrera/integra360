CREATE PROCEDURE [dbo].[SP_Repo_ingr_util_anual_sr]
	@sema_inic [int],
	@sema_fina [int],
	@mes [int],
	@anio [char](4),
	@importe_tota_repa [decimal](18, 2)
WITH EXECUTE AS CALLER
AS
--declare @sema_inic integer , @sema_fina integer, @mes integer, @anio char(4), @importe_tota_repa decimal(18,2) 
--select @sema_inic =1 , @sema_fina =53, @mes =12, @anio ='2009', @importe_tota_repa =100000

set nocount on 
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
declare  @mont_tota decimal (15,2) 
declare  @nro_tota_dias decimal (15,0) 
declare  @tota_desc decimal (15,2) 
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
DECLARE @grupo varchar(30)
declare @cont_util integer
declare @codi_juic char(10)
declare @tipo_desc integer
declare @mont_desc decimal(18,2)
declare @tope decimal(18,2)
declare @saldo decimal(18,2)
declare @apli_tope integer
declare @nro_pago integer
declare @cont_conc  integer 
declare @cont_pres_empr integer 
declare @cont_pres_baza integer 
declare @cont_pres_banc integer 
declare @codi_conc  char(7)
declare @fecha datetime
declare @fech_term datetime
declare @tipo_pres varchar(20)
DECLARE @mesc char(2)
declare @tipo_trab char(2)
declare @anioa char(4)
declare @anion integer 
declare @esta_acti smallint
declare @cont_moto as integer
declare @domi_feri as integer
set @mesc = cast( month(getdate() ) as char)
if cast( @mesc as numeric ) < 10 begin set @mesc = '0' + @mesc end
set @anion = cast ( @anio as integer) + 1 
set @anioa = cast ( @anion as char ) 
set @fecha = getdate()
set @fech_term = cast( '01/' + @mesc + '/' + @anio as datetime )
set @fech_term = dateadd( month, 1, @fech_term )
set @fech_term = dateadd( day,  -1, @fech_term )

Select @grupo = upper(grupo ) from empresa;

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Rela_quin_trip]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
	drop table [dbo].[Rela_quin_trip] 
end


Create Table Rela_quin_trip( codi_pers char(5) NULL, apel_1 varchar(30) NULL, apel_2 varchar(30) NULL, nomb_1 varchar(30) NULL, nomb_2 varchar(30) NULL, trabajador varchar(120) NULL, 
		tota_ingre decimal (15,2)  NULl, tota_trip decimal (15,2)  NULL, tota_boni decimal (15,2)  NULL, tota_grat decimal (15,2)  NULL, tota_vaca decimal (15,2)  NULL, 
		otros  decimal (15,2)  NULL, DIAS_TRAB integer null , tota_ingr_con_devo decimal( 15, 2 ) NULL , devo_quin decimal ( 15,2) null, tota_ingr_calc_util decimal (9,2) null,
		codi_unid_oper char(5) NULL, factor_dias decimal( 15, 8 ) NULL , factor_remu decimal( 15, 8 ) NULL, util_dias decimal( 15, 2 ) NULL, util_remu decimal( 15, 2 ) NULL, 
		ANIO char(10) null)
Select @codi_uit = codi_valo_unit from valores_unitarios where desc_valo_unit like 'UIT%';
Select @mont_uit = isnull(valor, 0 ) , @tipo_valo = isnull( tipo_valo , 0 ) from valores_unitarios_anuales 
where codi_valo_unit = @codi_uit and datepart( year, fech_asig) = cast( @anio as integer );

delete  from Rela_quin_trip;

Declare curs_carg_conc_util cursor for
Select codi_conc, isnull(valor, 0 ) , codi_auxi, isnull( nro_pago, 0 ) 
From calc_util_deta 
where anio = @anio and not codi_auxi is null and codi_auxi <> '';
open curs_carg_conc_util ;
fetch next from curs_carg_conc_util into @codi_conc, @valo_desc_auxi, @codi_juic, @nro_pago
while @@fetch_status = 0
begin
	if @codi_conc >= '200011' and  @codi_conc <= '200019' 
	begin
		Delete from pagos_juicios where codi_juic = @codi_juic and nro_pago = @nro_pago
		Select @apli_tope = isnull( apli_tope , 0) from juicios where codi_juic = @codi_juic		
		if @apli_tope = 1
		begin
			update juicios 
			set saldo = isnull( saldo , 0 ) + @valo_desc_auxi
			where codi_juic = @codi_juic
		end
	end
	if ( @codi_conc >= '200001' and  @codi_conc <= '200009' ) or ( @codi_conc >= '200091' and  @codi_conc <= '200099' ) or ( @codi_conc >= '200121' and  @codi_conc <= '200129' ) 
	begin
		Delete from pagos_prestamos where codi_pres = @codi_juic and nro_pago = @nro_pago
		update prestamos 
		set saldo = isnull( saldo , 0 ) + @valo_desc_auxi
		where codi_pres = @codi_juic
	end

	fetch next from curs_carg_conc_util into @codi_conc, @valo_desc_auxi, @codi_juic, @nro_pago
end
close curs_carg_conc_util 
deallocate curs_carg_conc_util 

set @codi_conc = ''
set @valo_desc_auxi = 0
set @codi_juic = ''
set @nro_pago = 0

Delete from calc_util_pers 
where anio = @anio;
Delete from calc_util_deta 
where anio = @anio;


if @tipo_valo  = 0
begin
	set @mont_uit = @mont_uit / 100
end

set @mont_dedu  = @mont_uit * 7 

set @domi_feri = ( Select top 1 dbo.F_DIAS_FER_DOM( @anio ) from personal  )

Declare curs_carg_trab_trip cursor for 
Select distinct plani.codi_pers, p.apel_1, isnull( p.apel_2, '' ) as apel_2, p.nomb_1, isnull( p.nomb_2, '') as nomb_2, 
	isnull( p.apel_1,'') + ' ' + isnull( p.apel_2,'') + ' ' + isnull( p.nomb_1,'') + ' ' + isnull( p.nomb_2,'') as trabajador  from
(	Select distinct pe.codi_pers From Planilla_de_tripulantes PE, semana se
	where se.codi_sema = pe.codi_Sema and (substring(se.aniomes , 1,4 ) = @anio or substring(se.aniomes , 3,4 ) = @anio  ) 
		and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina
union
	Select distinct Pe.codi_pers From Planilla_boni_moto PE
	where ( ( cast( substring( pe.mesanio , 1,2 ) as smallint ) <= @mes and substring( pe.mesanio , 3,4 ) = @anio )
		or ( cast( substring( pe.mesanio , 5,2 ) as smallint ) <= @mes and substring( pe.mesanio , 1,4 ) = @anio ) 	)
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
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and pe.codi_plan_trip = pec.codi_plan_trip
		and pec.codi_conc = '199998' and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and ( ( substring( pe.mesanio ,1,4 ) = @anio and substring( pe.mesanio ,5,2 ) <= @mes ) 
			or ( substring( pe.mesanio ,3,4 ) = @anio and substring( pe.mesanio , 1,2 ) <= @mes ) ) 
		)

	set @tota_ingr_boni_trip = (Select isnull( Sum( isnull( valor, 0 )  ) , 0 ) From Planilla_Boni_tripu PE, Planilla_BoniTri_Conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema  and pe.codi_plan_btri = pec.codi_plan_btri -- and substring( pe.mesanio ,1,4 ) = @anio
		and pec.codi_conc = '199998' and pe.codi_tipo_plan = '15' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio )

	set @tota_ingr_boni_moto = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_boni = pec.codi_plan_boni and pec.codi_conc = '199998'  
		and ( (cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio  )  or 
			(cast( substring( pe.mesanio ,5,2 ) as smallint ) <= @mes and substring( pe.mesanio ,1,4 ) = @anio  ) )
		and pe.tipo = 'M' )

	set @tota_ingr_subs = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_subsidio PE, Planilla_subs_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 )  as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_subs = pec.codi_plan_subs and pec.codi_conc = '199998' )	
	set @tota_ingr_grat = 0--(Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
	--	where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,1,2 ) <= @mes and substring( pe.mesanio_prov ,3,4)  = @anio and pe.codi_tipo_plan = '02' and pe.codi_conc = '199998')

	set @tota_util = (Select isnull( importe, 0 )  from UTIL_PERS_ANUAL where codi_pers = @Codi_pers_auxi and periodo = @anio )

	
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


	set @tota_dev5ta_pesc = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema  and pe.codi_plan_trip = pec.codi_plan_trip 
		and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070' ) and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and ( ( substring( pe.mesanio , 1,4 ) = @anio and substring( pe.mesanio , 5,2 ) <= @mes ) 
			or (substring( pe.mesanio , 3,4 ) = @anio and substring( pe.mesanio , 1,2 ) <= @mes )      )
			 )

	set @tota_dev5ta_boni_trip = (Select isnull( Sum( isnull( valor, 0 )  ) , 0 ) From Planilla_Boni_tripu PE, Planilla_BoniTri_Conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and pe.codi_plan_btri = pec.codi_plan_btri
		and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070' ) and pe.codi_tipo_plan = '15' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and ( substring(Pe.mesanio , 1,4 ) = @anio and substring( pe.mesanio , 5, 2 ) <= @mes ) 
			or ( substring(Pe.mesanio , 3,4 ) = @anio and substring( pe.mesanio , 1, 2 ) <= @mes ) 	)

	set @tota_dev5ta_boni_moto = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_boni = pec.codi_plan_boni and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070'  ) 
			and pe.tipo = 'M' 
			and ( ( cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio ) 
				or ( cast( substring( pe.mesanio ,5,2 ) as smallint ) <= @mes and substring( pe.mesanio ,1,4 ) = @anio ) 	)
			)

	set @tota_dev5ta_suel = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and  pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070' ) and pe.codi_tipo_pers = '01' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' or  pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' )  )

	set @tota_dev5ta_sala = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio and cast( pe.mes as integer ) <= @mes 
				and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070' ) and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M'
				and (  pe.codi_tipo_plan = '01' or  pe.codi_tipo_plan = '02' or  pe.codi_tipo_plan = '03' or  pe.codi_tipo_plan = '11' or  pe.codi_tipo_plan = '12' )  )

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
		select distinct u.codi_carg from 
		( select distinct codi_carg from asistencia_tripulantes_pesca atp, semana se
		where atp.codi_pers = @codi_pers_auxi and atp.codi_sema = se.codi_sema and cast( RIGHT(se.aniomes, 2)  as integer) = @cont 
			and left(se.aniomes, 4)  = @anio 
		union
		select distinct codi_carg from ASISTENCIA_MOTORISTA atp
		where atp.codi_pers = @codi_pers_auxi 
			and ( (  cast( left( mesanio, 2)  as integer) = @cont and right( mesanio , 4)  = @anio )
				or (  cast( left( mesanio, 4)  as integer) = @anio and right( mesanio , 2)  = @cont )	)
		)  U
		open curs_carg_carg_mens;
		fetch next from curs_carg_carg_mens into @cargo
		while @@fetch_status = 0
		begin	
			Select @cont_moto = count(codi_pers) From asistencia_motorista 
			where codi_pers = @codi_pers_auxi and @cargo in (Select distinct codi_carg from asistencia_motorista ) 
			and ( (right(mesanio , 4) = @anio and cast( left( mesanio, 2)  as integer) = @cont ) 
				or (right(mesanio , 2) = @cont and cast( left( mesanio, 4)  as integer) = @anio ) ) 

			select @dias_moto = isnull( dias_traba_mens, 0 ) from asistencia_motorista 
			where codi_pers = @codi_pers_auxi 
				and ( (right(mesanio , 4) = @anio and cast( left( mesanio, 2)  as integer) = @cont )
					or (right(mesanio , 2) = @cont and cast( left( mesanio, 4)  as integer) = @anio )	) ;

			if @cont_moto > 0 
			begin
				IF @cont_carg_moto = 0 BEGIN set @cont_carg_moto = @cont_carg_moto + 1 end
			
			end
			else
			begin
				set @cont_carg_moto = @cont_carg_moto 
			end

			fetch next from curs_carg_carg_mens into @cargo
		end
		close curs_carg_carg_mens;
		deallocate curs_carg_carg_mens;
		select @dias_trip = isnull( sum(cast( isnull( jueves, 0 )  as numeric)+cast( isnull( viernes , 0 ) as numeric) + cast( isnull( sabado , 0 ) as  numeric) 
				+ cast( isnull( domingo , 0 ) as numeric) + cast( isnull( lunes, 0 )  as numeric) + cast( isnull( martes, 0 )  as numeric) + cast( isnull( miercoles, 0 ) as numeric) ) , 0 ) 
			from asistencia_tripulantes_pesca, semana where 	semana.codi_sema=asistencia_tripulantes_pesca.codi_sema 
			and ( (left(semana.aniomes,4) =@anio and cast( right(semana.aniomes,2) as integer) = @cont ) 
				or ( left(semana.aniomes,2) =@cont and cast( right(semana.aniomes, 4) as integer) = @anio )  )
			and asistencia_tripulantes_pesca.codi_pers = @codi_pers_auxi
		set @dias_trip = isnull( @dias_trip , 0 )
		set @dias_moto = isnull( @dias_moto , 0 )
		if @cont_carg_moto = 1
		begin
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
				if @dias_moto > 0 
				begin
					set @dias_trip_moto_tota = @dias_trip_moto_tota + @dias_moto
				end
				else
				begin
					set @dias_trip_moto_tota = @dias_trip_moto_tota + @dias_trip
				end
			end	
		end
		else
		begin
			set @dias_trip_moto_tota = @dias_trip_moto_tota + @dias_trip			
		end		
	end
	set @dias_suel = ( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_empleados PE, planilla_empleado_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_empl = pec.codi_plan_empl and pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and ( pec.codi_conc in ( '500000'  , '500001'  , '500002' , '500800',  '500810', '500820' ) )
				and pe.codi_tipo_pers = '01' and pe.indi_tiem = 'M' and (  pe.codi_tipo_plan = '01' ) )
	set @dias_sala =( Select isnull( Sum(isnull( valor, 0 )) , 0 ) From Planilla_de_obreros PE, planilla_obrero_conceptos pec
			where pe.codi_pers = @codi_pers_auxi and pe.codi_plan_obre = pec.codi_plan_obre and pe.anio  = @anio and cast( pe.mes as integer )  <= @mes 
				and ( pec.codi_conc in ( '500000'  , '500001'  , '500002' , '500800',  '500810', '500820' ) )
				and pe.codi_tipo_pers = '02' and pe.indi_tiem = 'M' and (  pe.codi_tipo_plan = '01' ) )

	set @dias_vaca = (Select ISNULL( sum( isnull( nro_dias , 0) ) , 0 ) from vacaciones 
				where cast( anio as integer ) = @anio and cast( mes as integer ) <= @mes and codi_pers = @codi_pers_auxi and codi_tipo_vaca <> '02' )

	set @dias_tota = isnull( @dias_trip_moto_tota , 0 ) + isnull( @dias_suel , 0 )  + isnull( @dias_sala , 0 )  + isnull( @dias_vaca , 0 )  -- isnull( @dias_trip , 0 ) + isnull( @dias_suel , 0 )  + isnull( @dias_sala , 0 )  + isnull( @dias_vaca , 0 ) 

	if @dias_tota > ( 365 - @domi_feri ) begin set @dias_tota =  ( 365 - @domi_feri )  end		
	set @valo_desc_rent_quin = 0
	set @dife_rent = @valo_desc_rent_quin - @tota_quin_rete

	Insert Into Rela_quin_trip ( codi_pers , apel_1 , apel_2 , nomb_1 , nomb_2 , trabajador , tota_ingre, tota_trip, tota_boni,
					tota_grat, tota_vaca, otros, DIAS_TRAB, tota_ingr_con_devo, devo_quin, tota_ingr_calc_util , codi_unid_oper, anio ) 
	Values (@codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador, @tota_ingr, 
		@tota_ingr_pesc + @tota_suel + @tota_sala, @tota_ingr_boni_trip + @tota_ingr_boni_moto,  @tota_ingr_grat, @tota_ingr_vaca, @tota_util + @tota_ingr_subs, 
		@DIAS_TOTA , @tota_ingr_con_devo, @tota_dev5ta_tota, @tota_ingr_calc_util , @codi_unid_oper, @anio )
	
	Insert into CALC_UTIL_PERS ( Anio, codi_pers, apellidos, nombres, remu_perc, dias_labo, liq_remu_perc, liq_dias_labo, liq_tota )
	Values( @anio, @codi_pers_auxi, @trabajador, @codi_unid_oper, @tota_ingr_calc_util, @DIAS_TOTA, 0, 0, 0 )

	Fetch next from curs_carg_trab_trip into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador	
end
set @mont_tota = 0
set @nro_tota_dias = 0

Select @nro_tota_dias = sum( isnull( DIAS_TRAB , 0 ))
from Rela_quin_trip;

Select @mont_tota = sum( isnull( tota_ingr_calc_util , 0 ))
from Rela_quin_trip;

Update Rela_quin_trip
set factor_dias = DIAS_TRAB / @nro_tota_dias, factor_remu = tota_ingr_calc_util / @mont_tota ;

Update Rela_quin_trip set util_DIAS = factor_dias * @importe_tota_repa / 2, util_remu = factor_remu * @importe_tota_repa / 2;

update cu 
set cu.liq_remu_perc = rt.util_remu, cu.liq_dias_labo = rt.util_DIAS, liq_tota = isnull( rt.util_remu , 0) + isnull( rt.util_dias , 0) 
from calc_util_pers cu, Rela_quin_trip rt
where cu.anio = rt.anio and rt.codi_pers = cu.codi_pers 

close curs_carg_trab_trip;
deallocate curs_carg_trab_trip;

Declare @ValorPorce numeric(12,2) 

select top 1 @ValorPorce = valor from valores_unitarios_anuales (nolock) 
where codi_valo_unit=53  and @anio between year(fech_asig) and year(fech_asig_fin)

if isnull(@ValorPorce,0)<=0 set @ValorPorce=10

--Select * from Rela_quin_trip order by apel_1, apel_2, nomb_1, nomb_2 ;
--Select * from calc_util_pers order by apellidos;
drop table Rela_quin_trip
Select @cont_util = count(anio) from calc_util_tota where anio = @anio
if  @cont_util <= 0 
begin
	Insert into calc_util_tota (anio, renta_neta, participacion, remu_perc_tota, dias_labo_tota)
	Values ( @anio,  @importe_tota_repa * 100/@ValorPorce , @importe_tota_repa, @mont_tota,  @nro_tota_dias );
end 
else
begin
	Update  calc_util_tota 
	set renta_neta =  @importe_tota_repa * 100/ @ValorPorce , participacion = @importe_tota_repa, remu_perc_tota = @mont_tota, dias_labo_tota = @nro_tota_dias 
	where anio = @anio;
end 
set @nro_pago = 0
set @codi_pers_auxi = ''
set @tota_ingr = 0
set @cont_conc = 0
Declare Curs_carg_util_anua cursor for
Select codi_pers, isnull( liq_tota , 0 ) 
from calc_util_pers where anio = @anio;
open Curs_carg_util_anua ;
Fetch next from Curs_carg_util_anua into @codi_pers_auxi, @tota_ingr
while @@fetch_status = 0
begin
	Insert Into calc_util_deta (codi_pers, anio, codi_conc, valor, monto, codi_auxi)
	Values ( @codi_pers_auxi, @anio, '199998', @tota_ingr, 0, '' )

	set @tipo_trab = (Select top 1 codi_tipo_pers from personal_por_tipo_trabajador where codi_pers = @codi_pers_auxi )
	set Select @esta_acti = esta_acti from personal where codi_pers = @codi_pers_auxi;
	set @rete_quin = 0
	set @codi_conc = '200040'
	if @esta_acti = 1
	begin
/*		if @tipo_trab = '03' 
		begin
			set @rete_quin = ( Select dbo.F_Renta_Quinta_Tripu ( @codi_pers_auxi, @fecha, 
							(Select codi_sema from semana where nro_sema = @sema_fina and left( aniomes, 4 )  = @anio)	) 
						From personal where codi_pers = @codi_pers_auxi )
		end
		else
		begin*/
			if @tipo_trab = '01'  or @tipo_trab = '02'
			begin
				set @rete_quin = ( Select dbo.F_Renta_Quinta_fija (@codi_pers_auxi , @mesc , @anioa , @tota_ingr, '07', @fech_term ) 
					From personal where codi_pers = @codi_pers_auxi )
			end

		--end
	end
	set @rete_quin = isnull( @rete_quin, 0 )
	if @rete_quin > @tota_ingr 
	begin
		set @rete_quin = @tota_ingr / 2
	end
	if @rete_quin > 0 
	begin
		Insert Into calc_util_deta (codi_pers, anio, codi_conc, valor, monto, codi_auxi, nro_pago)
		Values ( @codi_pers_auxi, @anio, @codi_conc, @rete_quin, 0, '', 0 )
	end	

	set @cont_conc = 0
	Declare Curs_carg_juic cursor for
	Select codi_juic, tipo_desc, isnull( mont_desc , 0 ) , isnull( apli_tope, 0 ) , isnull( tope, 0 ) , isnull( saldo, 0 )
	from juicios where codi_pers = @codi_pers_Auxi and esta_acti = 1 AND tipo_desc = 0
	open Curs_carg_juic;
	fetch next from Curs_carg_juic into @codi_juic, @tipo_desc, @mont_desc, @apli_tope, @tope, @saldo
	while @@fetch_status = 0 
	begin
		set @cont_conc = @cont_conc  + 1
		set @valo_desc_auxi = 0
		set @valo_desc_auxi = @mont_desc 
		if @tipo_Desc = 0 
		begin
			set @valo_desc_auxi = @tota_ingr * @mont_desc / 100
		end
		if @apli_tope = 1
		begin
			if @tope < @saldo + @valo_desc_auxi
			begin
				set @valo_desc_auxi = @tope - @saldo
			end
		end
		Select @nro_pago = max( cast( isnull( nro_pago, 0) as integer ) )  from pagos_juicios where codi_juic = @codi_juic
		set @nro_pago = isnull( @nro_pago , 0 ) + 1
		IF @valo_desc_auxi > 0 
		Begin
			set @codi_conc = '20001' + cast(@cont_conc as char(1))	
	
			Insert Into calc_util_deta (codi_pers, anio, codi_conc, valor, monto, codi_auxi, nro_pago)
			Values ( @codi_pers_auxi, @anio, @codi_conc, @valo_desc_auxi, @mont_desc, @codi_juic, @nro_pago )
			
			Insert into pagos_juicios ( codi_juic, nro_pago, fech_pago, codi_mone, monto, observacion )
			values ( @codi_juic, @nro_pago, @fecha, '01',  @valo_desc_auxi, 'PAGO POR PLANILLA UTILIDADES')
			if @apli_tope = 1
			begin
				update juicios 
				set saldo = isnull( saldo , 0 ) - @valo_desc_auxi
				where codi_juic = @codi_juic
			end
		END

		fetch next from Curs_carg_juic into @codi_juic, @tipo_desc, @mont_desc, @apli_tope, @tope, @saldo
	end
	close Curs_carg_juic;
	deallocate Curs_carg_juic;

	set @cont_pres_baza = 0
	set @cont_pres_banc = 0
	set @cont_pres_empr = 0

	Declare Curs_carg_pres cursor for
	Select codi_pres, tipo_desc, isnull( mont_desc , 0 ) , codi_tipo_pres , isnull( saldo, 0 )
	from prestamos where codi_pers = @codi_pers_Auxi and esta_acti = 1 AND SALDO > 0
	open Curs_carg_pres;
	fetch next from Curs_carg_pres into @codi_juic, @tipo_desc, @mont_desc, @tipo_pres, @saldo
	while @@fetch_status = 0 
	begin
		IF LEFT( @tipo_pres, 4 ) = '01' 
		BEGIN 
			set @cont_pres_empr = @cont_pres_empr  + 1 
			set @codi_conc = '20000' + cast( @cont_pres_empr as char(1))	
		END
		IF LEFT( @tipo_pres, 4 ) = '02' 
		BEGIN 
			set @cont_pres_BANC = @cont_pres_BANC + 1 
			set @codi_conc = '20009' + cast( @cont_pres_banc as char(1))	
		END
		IF LEFT( @tipo_pres, 4 ) = '03' 
		BEGIN 
			set @cont_pres_baza = @cont_pres_baza  + 1 
			set @codi_conc = '20012' + cast( @cont_pres_baza as char(1))	
			set @mont_desc = 0
		End	
		set @valo_desc_auxi = 0
		set @valo_desc_auxi = @mont_desc 
		if @tipo_Desc = 0 
		begin
			set @valo_desc_auxi = @tota_ingr * @mont_desc / 100
		end
		if @saldo < @valo_desc_auxi
		begin
			set @valo_desc_auxi = @saldo
		end

		Select @nro_pago = max( cast( isnull( nro_pago, 0) as integer ) )  from pagos_prestamos where codi_pres = @codi_juic
		set @nro_pago = isnull( @nro_pago , 0 ) + 1
--		IF @valo_desc_auxi > 0 
--		begin
--			Insert Into calc_util_deta (codi_pers, anio, codi_conc, valor, monto, codi_auxi, nro_pago)
--			Values ( @codi_pers_auxi, @anio, @codi_conc, @valo_desc_auxi, @mont_desc, @codi_juic, @nro_pago )
	
--			Insert into pagos_prestamos ( codi_pres, nro_pago, fech_pago, codi_mone, monto, observacion )
--			values ( @codi_juic, @nro_pago, @fecha, '01',  @valo_desc_auxi, 'PAGO POR PLANILLA UTILIDADES')

--			update prestamos 
--			set saldo = isnull( saldo , 0 ) - @valo_desc_auxi
--			where codi_pres = @codi_juic
--		END 
		fetch next from Curs_carg_pres into @codi_juic, @tipo_desc, @mont_desc, @tipo_pres, @saldo
	end
	close Curs_carg_pres;
	deallocate Curs_carg_pres;

	Select @tota_desc = isnull( sum( isnull( valor , 0 ) ) , 0 ) from calc_util_deta
	where codi_pers = @codi_pers_auxi and anio = @anio and left(codi_conc,1) = '2';
	
	Insert Into calc_util_deta (codi_pers, anio, codi_conc, valor, monto, codi_auxi)
	Values ( @codi_pers_auxi, @anio, '299999', @tota_desc, 0, '' )

	Insert Into calc_util_deta (codi_pers, anio, codi_conc, valor, monto, codi_auxi)
	Values ( @codi_pers_auxi, @anio, '999990', isnull( @tota_ingr , 0 ) - isnull( @tota_desc, 0 ) , 0, '' )
	
	Fetch next from Curs_carg_util_anua into @codi_pers_auxi, @tota_ingr

end
Select * from calc_util_pers where anio = @anio;
Select * from calc_util_deta where anio = @anio;

Close Curs_carg_util_anua ;
Deallocate Curs_carg_util_anua ;

End
GO
