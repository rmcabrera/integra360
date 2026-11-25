CREATE PROCEDURE [dbo].[SP_Tota_ingr_quin_trip]
	@sema_inic [int],
	@sema_fina [int],
	@mes [int],
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
Begin
Declare @codi_pers char(5) 
Declare @apel_1 varchar(30) 
Declare @apel_2 varchar(30) 
Declare @nomb_1 varchar(30) 
Declare @nomb_2 varchar(30) 
Declare @trabajador varchar(120) 
Declare @remu_tota decimal (9,2) 
Declare @rete_quin decimal (9,2) 
Declare @trib_quin decimal (9,2) 
Declare @dife_quin decimal (9,2) 
Declare @codi_pers_auxi char(5)
Declare @tota_ingr_pesc decimal (9,2)
Declare @tota_ingr_boni_moto decimal (9,2)
Declare @tota_ingr_boni_trip decimal (9,2)
Declare @tota_ingr_subs decimal (9,2)
Declare @tota_ingr_grat decimal (9,2)
Declare @tota_ingr_vaca decimal (9,2)
Declare @tota_dev5ta_pesc decimal (9,2)
Declare @tota_dev5ta_boni_moto decimal (9,2)
Declare @tota_dev5ta_boni_trip decimal (9,2)
Declare @tota_util decimal (9,2)
Declare @tota_ingr decimal (9,2)
Declare @tota_quin_pesc decimal (9,2)
Declare @tota_quin_boni_moto decimal (9,2)
Declare @tota_quin_boni_trip decimal (9,2)
Declare @tota_quin_subs decimal (9,2)
Declare @tota_quin_grat decimal (9,2)
Declare @tota_quin_vaca decimal (9,2)
Declare @tota_quin_rete decimal (9,2)
Declare @codi_uit smallint
Declare @tipo_valo smallint
declare @mont_uit decimal(9,2)
declare @mont_dedu decimal(9,2)
declare  @base_impo decimal(9,2)
declare  @nro_mini_uit decimal(9,2)
declare  @nro_maxi_uit decimal(9,2)
declare  @porcentaje decimal(9,2)
declare  @valo_desc_auxi decimal(9,2)
declare  @valo_desc_rent_quin decimal(9,2)
declare  @dife_rent decimal(9,2)

Create Table #Rela_quin_trip( codi_pers char(5) NULL, apel_1 varchar(30) NULL, apel_2 varchar(30) NULL, nomb_1 varchar(30) NULL, nomb_2 varchar(30) NULL, trabajador varchar(120) NULL, 
		tota_ingre decimal(9,2) NULL, base_impo decimal(9,2) NULL, impo_rent_quin decimal (9,2) NULL, tota_rete decimal(9,2) NULL, dife_rent decimal(9,2) NULL )

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

) as Plani, personal P
where plani.codi_pers = p.codi_pers
order by p.apel_1, p.apel_2, p.nomb_1, p.nomb_2;
Open curs_carg_trab_trip;
Fetch next from curs_carg_trab_trip into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador;
while @@fetch_status = 0
begin
	set @tota_ingr_pesc = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_trip = pec.codi_plan_trip
		and pec.codi_conc = '199998' and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio  )

	set @tota_ingr_boni_trip = (Select isnull( Sum( isnull( valor, 0 )  ) , 0 ) From Planilla_Boni_tripu PE, Planilla_BoniTri_Conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema  and pe.codi_plan_btri = pec.codi_plan_btri -- and substring( pe.mesanio ,1,4 ) = @anio
		and pec.codi_conc = '199998' and pe.codi_tipo_plan = '15' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio )
	
	set @tota_ingr_boni_moto = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_boni = pec.codi_plan_boni and pec.codi_conc = '199998'  and pe.tipo = 'M' )

	set @tota_ingr_subs = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_subsidio PE, Planilla_subs_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 )  as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_subs = pec.codi_plan_subs and pec.codi_conc = '199998' )
	
	set @tota_ingr_grat = (Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,1,2 ) <= @mes and pe.anio = @anio and pe.codi_tipo_plan = '02' and pe.codi_conc = '199998')
/*	if @tota_ingr_grat >0 
	begin
		print @codi_pers_auxi
		print @tota_ingr_grat
	end*/
	set @tota_ingr_vaca = (Select isnull( Sum(isnull( valor, 0 )) , 0 ) From GRAT_TRIP_DETA_CONC PE
		where pe.codi_pers = @codi_pers_auxi and substring( pe.mesanio_prov ,1,2 ) <= @mes and pe.anio = @anio and pe.codi_tipo_plan = '03' and pe.codi_conc = '199998' )
/*	if @tota_ingr_vaca >0 
	begin
		print @codi_pers_auxi
		print @tota_ingr_vaca
	end*/
	set @tota_util = (Select isnull( importe, 0 )  from UTIL_PERS_ANUAL where codi_pers = @Codi_pers_auxi and periodo = @anio )
	

	set @tota_dev5ta_pesc = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_de_tripulantes PE, Planilla_tripulante_conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema  and pe.codi_plan_trip = pec.codi_plan_trip -- and substring( pe.mesanio ,1,4 ) = @anio
		and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070' ) and pe.codi_tipo_plan = '08' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio  )

	set @tota_dev5ta_boni_trip = (Select isnull( Sum( isnull( valor, 0 )  ) , 0 ) From Planilla_Boni_tripu PE, Planilla_BoniTri_Conceptos PEC , Semana se
		where pe.codi_pers = @codi_pers_auxi and pe.codi_Sema = se.codi_sema and substring( pe.mesanio ,1,4 ) = @anio and pe.codi_plan_btri = pec.codi_plan_btri
		and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070' ) and pe.codi_tipo_plan = '15' and se.nro_sema >= @sema_inic and se.nro_sema <= @sema_fina 
		and substring(se.aniomes , 1,4 ) = @anio )

	set @tota_dev5ta_boni_moto = (Select isnull( Sum( isnull( valor, 0 ) ) , 0 ) From Planilla_boni_moto PE, Planilla_boni_concepto PEC 
		where pe.codi_pers = @codi_pers_auxi and cast( substring( pe.mesanio ,1,2 ) as smallint ) <= @mes and substring( pe.mesanio ,3,4 ) = @anio 
		and pe.codi_plan_boni = pec.codi_plan_boni and ( pec.codi_conc = '100090' OR pec.codi_conc = '100070'  ) and pe.tipo = 'M' )

	set @tota_ingr = @tota_ingr_pesc + @tota_ingr_boni_trip + @tota_ingr_boni_moto + @tota_ingr_subs + @tota_ingr_grat + @tota_ingr_vaca + @tota_util
	set @tota_ingr = @tota_ingr - @tota_dev5ta_pesc - @tota_dev5ta_boni_trip - @tota_dev5ta_boni_moto

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
	
	set @tota_quin_rete = @tota_quin_pesc + @tota_quin_boni_trip + @tota_quin_boni_moto + @tota_quin_subs

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
			if  ( @base_impo < ( @nro_maxi_uit * @mont_uit) )
			begin
	
				if ( @base_impo >= (@nro_mini_uit * @mont_uit) )
				begin
					set @valo_desc_auxi = ( @base_impo - (@nro_mini_uit * @mont_uit )) * @PORCENTAJE / 100
				end
			end
			ELSE
			BEGIN
				set @valo_desc_auxi = (( ( @nro_maxi_uit - @nro_mini_uit)  * @mont_uit )) * @PORCENTAJE / 100
			--	PRINT @valo_desc_auxi
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
		set @base_impo = 0
		set @valo_desc_rent_quin = 0
	end
	set @dife_rent = @valo_desc_rent_quin - @tota_quin_rete
	Insert Into #Rela_quin_trip ( codi_pers , apel_1 , apel_2 , nomb_1 , nomb_2 , trabajador , tota_ingre , base_impo , impo_rent_quin, tota_rete , dife_rent )
	Values (@codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador, @tota_ingr, @base_impo, @valo_desc_rent_quin , @tota_quin_rete, @dife_rent )
	Fetch next from curs_carg_trab_trip into @codi_pers_auxi, @apel_1, @apel_2, @nomb_1, @nomb_2, @trabajador	
end

close curs_carg_trab_trip;
deallocate curs_carg_trab_trip;

Select * from #Rela_quin_trip order by apel_1, apel_2, nomb_1, nomb_2 ;

End
GO
