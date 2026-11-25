CREATE PROCEDURE [dbo].[sp_repo_cost_emba_anual]
	@ani [int],
	@mes_inic [smallint],
	@mes_fin [smallint]
WITH EXECUTE AS CALLER
AS
set nocount on
Declare @unid_oper char(5)
declare @desc_unid_oper varchar(100)
declare @tipo_cost char(2)
declare @tipo_cost_gene char(2)
declare @desc_tipo_cost varchar(100)
declare @desc_tipo_cost_gene varchar(50)
declare @orde_cost integer
declare @impo_sole decimal(15,3)
declare @impo_dola decimal(15,3)
declare @pesc_mens decimal(15,3)
--declare @cont_mes smallint
declare @cont_ep smallint
declare @indi_ep smallint
declare @tipo_camb decimal(12,3)
declare @fech_tipo_camb_mes datetime
declare @orde_cost_gene integer

Create table #cost_anual_unid_oper( codi_unid_oper char(5), desc_unid_oper varchar(100), anio integer, mes smallint, tone_mens decimal(15,3), codi_tipo_cost_gene char(2), 
		desc_tipo_cost_gene varchar(100) null, orden_cost_gene integer null, codi_tipo_cost char(2), desc_tipo_cost varchar(100) null, orden_cost integer null, 
		impo_sole decimal(15,2) null, tipo_camb decimal(15,3) null, impo_dola decimal(15,2) null, indi_ep smallint, orde_ep integer null )

--set @cont_mes = @mes_inic
--while @cont_mes >= @mes_inic and @cont_mes <= @mes_fin
--begin
	insert into #cost_anual_unid_oper( codi_unid_oper, desc_unid_oper, anio, mes, tone_mens, codi_tipo_cost_gene, desc_tipo_cost_gene, 
		orden_cost_gene, codi_tipo_cost, desc_tipo_cost, orden_cost, impo_sole, tipo_camb, impo_dola, indi_ep, orde_ep )
--	Select uo.codi_unid_oper, uo.desc_unid_oper, @ani, @cont_mes, (Select isnull( sum( isnull( pesc_real , 0 ) ) , 0 ) from zarpes 
	Select uo.codi_unid_oper, uo.desc_unid_oper, @ani, mc.mes, (Select isnull( sum( isnull( pesc_real , 0 ) ) , 0 ) from zarpes 
		where month(fech_repo)= cast(mc.mes as integer ) and year(fech_Repo)= cast(mc.anio as integer ) and codi_unid_oper = uo.codi_unid_oper ) as tone_mens,
		tcg.codi_tipo_cost_gene, tcg.desc_tipo_cost_gene, tcg.orden, tc.codi_tipo_cost, tc.desc_tipo_cost, tc.orden, 
		round( isnull( sum( isnull( importe, 0 ) ) , 0 ) , 2) as impo_sole,
		round( isnull( ( Select isnull( venta, 0 ) from tipo_cambio_a_dolar
		where fech_camb in (Select max( fech_camb) from tipo_cambio_a_dolar 
					where month( fech_camb ) = cast(mc.mes as integer ) and year( fech_camb ) = cast(mc.anio as integer )) and codi_mone_camb='02')  , 0) , 3 )  as tipo_camb,
		isnull( round( round( isnull( sum( isnull( importe, 0 ) ) , 0 ) , 3) / round( ( Select isnull( venta, 0 ) from tipo_cambio_a_dolar
		where fech_camb in (Select max( fech_camb) from tipo_cambio_a_dolar 
					where month( fech_camb ) = cast(mc.mes as integer ) and year( fech_camb ) = cast(mc.anio as integer )) and codi_mone_camb='02') , 3 )  , 2 ) , 0 ) as impo_dola,
		1 as indi_ep, uo.orden  as orde_ep
	from movi_contables mc, TIPO_costo tc, tipo_cost_gene tcg, embarcaciones uo
--	where anio = @ani and mes = @cont_mes and mc.codi_unid_oper =* uo.codi_unid_oper and mc.cargo_abono = 'C'
	where anio = @ani and mes >= @mes_inic and mes <= @mes_fin and mc.codi_unid_oper = uo.codi_unid_oper and mc.cargo_abono = 'C'
		and nro_cuen in ( Select nro_cuen from cuen_x_tipo_cost where codi_tipo_cost = tc.codi_tipo_cost) and tc.tcg = tcg.codi_tipo_cost_gene
	and uo.codi_unid_oper in ( Select distinct codi_unid_oper  from movi_contables where anio = @ani)
	and ( uo.fech_cese is null or ( year( uo.fech_cese ) > @ani  )  or ( year( uo.fech_cese ) = @ani and month( uo.fech_cese ) >= mc.mes )   )
	--and ( uo.fech_cese is null or ( year( uo.fech_cese ) > @ani  )  
--		or ( uo.fech_cese >=  dateadd( month, 1, cast( '01/' + cast( @cont_mes as char(2) )   + '/' + cast(@ani as char(4) ) as datetime  )   )
--		or ( uo.fech_cese >=  dateadd( month, 1, cast( '01/' +  mc.mes   + '/' + cast(@ani as char(4) ) as datetime  )   )
--			)   )
	group by uo.desc_unid_oper, uo.codi_unid_oper, mc.anio, mc.mes, tcg.codi_tipo_cost_gene, tcg.desc_tipo_cost_gene, tcg.orden, tc.codi_tipo_cost, 
		tc.desc_tipo_cost, tc.orden, uo.orden
	order by uo.desc_unid_oper,  tcg.codi_tipo_cost_gene, tc.codi_tipo_cost, MC.MES
	
	insert into #cost_anual_unid_oper( codi_unid_oper, desc_unid_oper, anio, mes, tone_mens, codi_tipo_cost_gene, desc_tipo_cost_gene, 
		orden_cost_gene, codi_tipo_cost, desc_tipo_cost, orden_cost, impo_sole, tipo_camb, impo_dola, indi_ep, orde_ep )
--	Select uo.codi_unid_oper, uo.desc_unid_oper, @ani, @cont_mes, (Select isnull( sum( isnull( pesc_real , 0 ) ) , 0 ) from zarpes 
	Select uo.codi_unid_oper, uo.desc_unid_oper, @ani, mc.mes, (Select isnull( sum( isnull( pesc_real , 0 ) ) , 0 ) from zarpes 
		where month(fech_repo)= cast(mc.mes as integer ) and year(fech_Repo)= cast(mc.anio as integer ) and codi_unid_oper = uo.codi_unid_oper ) as tone_mens,
		tcg.codi_tipo_cost_gene, tcg.desc_tipo_cost_gene, tcg.orden, tc.codi_tipo_cost, tc.desc_tipo_cost, tc.orden, 
		-1 * round( isnull( sum( isnull( importe, 0 ) ) , 0 ) , 2) as impo_sole,
		round( isnull( ( Select isnull( venta, 0 ) from tipo_cambio_a_dolar
		where fech_camb in (Select max( fech_camb) from tipo_cambio_a_dolar 
					where month( fech_camb ) = cast(mc.mes as integer ) and year( fech_camb ) = cast(mc.anio as integer )) and codi_mone_camb='02')  , 0) , 3 )  as tipo_camb,
		- 1 * isnull( round( round( isnull( sum( isnull( importe, 0 ) ) , 0 ) , 3) / round( ( Select isnull( venta, 0 ) from tipo_cambio_a_dolar
		where fech_camb in (Select max( fech_camb) from tipo_cambio_a_dolar 
					where month( fech_camb ) = cast(mc.mes as integer ) and year( fech_camb ) = cast(mc.anio as integer )) and codi_mone_camb='02') , 3 )  , 2 ) , 0 ) as impo_dola,
		1 as indi_ep, uo.orden as orde_ep
	from movi_contables mc, TIPO_costo tc, tipo_cost_gene tcg, embarcaciones uo
--	where anio = @ani and mes = @cont_mes and mc.codi_unid_oper =* uo.codi_unid_oper and mc.cargo_abono = 'A'
	where anio = @ani and mes >= @mes_inic and mes <= @mes_fin and mc.codi_unid_oper = uo.codi_unid_oper and mc.cargo_abono = 'A'
		and nro_cuen in ( Select nro_cuen from cuen_x_tipo_cost where codi_tipo_cost = tc.codi_tipo_cost) and tc.tcg = tcg.codi_tipo_cost_gene
	and uo.codi_unid_oper in ( Select distinct codi_unid_oper  from movi_contables where anio = @ani)
--	and ( uo.fech_cese is null or ( year( uo.fech_cese ) > @ani  )  or ( year( uo.fech_cese ) = @ani and month( uo.fech_cese ) >= @cont_mes )   )
	and ( uo.fech_cese is null or ( year( uo.fech_cese ) > @ani  )  or ( year( uo.fech_cese ) = @ani and month( uo.fech_cese ) >= mc.mes )   )
	group by uo.desc_unid_oper, uo.codi_unid_oper, mc.anio, mc.mes, tcg.codi_tipo_cost_gene, tcg.desc_tipo_cost_gene, tcg.orden, tc.codi_tipo_cost, 
		tc.desc_tipo_cost, tc.orden, uo.orden
	order by uo.desc_unid_oper,  tcg.codi_tipo_cost_gene, tc.codi_tipo_cost, MC.MES

	insert into #cost_anual_unid_oper( codi_unid_oper, desc_unid_oper, anio, mes, tone_mens, codi_tipo_cost_gene, desc_tipo_cost_gene, 
		orden_cost_gene, codi_tipo_cost, desc_tipo_cost, orden_cost, impo_sole, tipo_camb, impo_dola, indi_ep, orde_ep )
	SELECT em.codi_unid_oper, em.desc_unid_oper, res.anio, res.mes, 0 as tone_mens, 
		res.codi_tipo_cost_gene, res.desc_tipo_cost_gene, res.orde_tcg, res.codi_tipo_cost, res.desc_tipo_cost, res.orde_tc, 
		ROUND( em.capa_neta * res.impo_sole_tota /( Select sum( capa_neta ) From embarcaciones 
			Where  codi_unid_oper in ( Select distinct codi_unid_oper  from movi_contables where anio = @ani)
			 and ( fech_cese is null or ( year( fech_cese ) > @ani  )  or ( year( fech_cese ) = @ani and month( fech_cese ) >= res.mes )  )   ) , 2 ) as impo_sole, 
--			or ( year( fech_cese ) > @ani  )  or ( year( fech_cese ) = @ani and month( fech_cese ) >= @cont_mes )  )   ) , 2 ) as impo_sole, 
		 res.tipo_camb,
		round( ROUND( em.capa_neta * res.impo_sole_tota /( Select sum( capa_neta ) From embarcaciones 
			Where  codi_unid_oper in ( Select distinct codi_unid_oper  from movi_contables where anio = @ani)
			 and  ( fech_cese is null 
			or ( year( fech_cese ) > @ani  )  or ( year( fech_cese ) = @ani and month( fech_cese ) >= res.mes )  )   )  , 2 ) / res.tipo_camb , 2 )  as impo_dola,
--			or ( year( fech_cese ) > @ani  )  or ( year( fech_cese ) = @ani and month( fech_cese ) >= @cont_mes )  )   )  , 2 ) / res.tipo_camb , 2 )  as impo_dola,
		0 as indi_ep, em.orden
	from embarcaciones em, (
		Select  MC.ANIO, MC.MES as mes, round( isnull( sum( isnull( importe, 0 ) ) , 0 ) , 2) as impo_sole_TOTA, 
		tcg.codi_tipo_cost_gene, tcg.desc_tipo_cost_gene, tcg.orden as orde_tcg, tc.codi_tipo_cost, tc.desc_tipo_cost, tc.orden as orde_tc, 
			round( isnull( ( Select isnull( venta, 0 ) from tipo_cambio_a_dolar
			where fech_camb in (Select max( fech_camb) from tipo_cambio_a_dolar 
						where month( fech_camb ) = cast(mc.mes as integer ) and year( fech_camb ) = cast(mc.anio as integer )) and codi_mone_camb='02') , 0) , 3 )  as tipo_camb
		from movi_contables mc, TIPO_costo tc, tipo_cost_gene tcg
--		where anio = @ani and mes = @cont_mes and mc.cargo_abono = 'C'
		where anio = @ani and mes >= @mes_inic and mes <= @mes_fin and mc.cargo_abono = 'C'
			and ( mc.codi_unid_oper not in (Select codi_unid_oper from embarcaciones )  or mc.codi_unid_oper is null ) 
			and nro_cuen in ( Select nro_cuen from cuen_x_tipo_cost where codi_tipo_cost = tc.codi_tipo_cost) and tc.tcg = tcg.codi_tipo_cost_gene
		group by mc.anio, mc.mes, tcg.codi_tipo_cost_gene, tcg.desc_tipo_cost_gene, tcg.orden, tc.codi_tipo_cost, tc.desc_tipo_cost, tc.orden  ) res
--	Where  em.fech_cese is null or ( year( em.fech_cese ) > @ani  )  or ( year( em.fech_cese ) = @ani and month( em.fech_cese ) >= @cont_mes )   
	Where   em.codi_unid_oper in ( Select distinct codi_unid_oper  from movi_contables where anio = @ani)
		and  ( em.fech_cese is null or ( year( em.fech_cese ) > @ani  )  or ( year( em.fech_cese ) = @ani and month( em.fech_cese ) >= res.mes )   ) 

	insert into #cost_anual_unid_oper( codi_unid_oper, desc_unid_oper, anio, mes, tone_mens, codi_tipo_cost_gene, desc_tipo_cost_gene, 
		orden_cost_gene, codi_tipo_cost, desc_tipo_cost, orden_cost, impo_sole, tipo_camb, impo_dola, indi_ep, orde_ep )
	SELECT em.codi_unid_oper, em.desc_unid_oper, res.anio, res.mes, 0 as tone_mens, 
		res.codi_tipo_cost_gene, res.desc_tipo_cost_gene, res.orde_tcg, res.codi_tipo_cost, res.desc_tipo_cost, res.orde_tc, 
		ROUND( em.capa_neta * res.impo_sole_tota / ( Select sum( capa_neta ) From embarcaciones Where ( fech_cese is null 
			or ( year( fech_cese ) > @ani  )  or ( year( fech_cese ) = @ani and month( fech_cese ) >= res.mes )  )   )  , 2 ) as impo_sole, 
--			or ( year( fech_cese ) > @ani  )  or ( year( fech_cese ) = @ani and month( fech_cese ) >= @cont_mes )  )   )  , 2 ) as impo_sole, 
		 res.tipo_camb,
		round( ROUND( em.capa_neta * res.impo_sole_tota / ( Select sum( capa_neta ) From embarcaciones Where ( fech_cese is null 
			or ( year( fech_cese ) > @ani  )  or ( year( fech_cese ) = @ani and month( fech_cese ) >= res.mes )  )   ) , 2 ) / res.tipo_camb , 2 )  as impo_dola,
--			or ( year( fech_cese ) > @ani  )  or ( year( fech_cese ) = @ani and month( fech_cese ) >= @cont_mes )  )   ) , 2 ) / res.tipo_camb , 2 )  as impo_dola,
		0 as indi_ep, em.orden
	from embarcaciones em, (
		Select  MC.ANIO, MC.MES as mes, -1 * round( isnull( sum( isnull( importe, 0 ) ) , 0 ) , 2) as impo_sole_tota, 
		tcg.codi_tipo_cost_gene, tcg.desc_tipo_cost_gene, tcg.orden as orde_tcg, tc.codi_tipo_cost, tc.desc_tipo_cost, tc.orden as orde_tc, 
			round( isnull( ( Select isnull( venta, 0 ) from tipo_cambio_a_dolar
			where fech_camb in (Select max( fech_camb) from tipo_cambio_a_dolar 
						where month( fech_camb ) = cast(mc.mes as integer ) and year( fech_camb ) = cast(mc.anio as integer )) and codi_mone_camb='02'), 0) , 3 )  as tipo_camb
		from movi_contables mc, TIPO_costo tc, tipo_cost_gene tcg
--		where anio = @ani and mes = @cont_mes and mc.cargo_abono = 'A' 
		where anio = @ani and mes >= @mes_inic and mes <= @mes_fin  and mc.cargo_abono = 'A' 
			and ( mc.codi_unid_oper not in (Select codi_unid_oper from embarcaciones) or mc.codi_unid_oper is null )
			and nro_cuen in ( Select nro_cuen from cuen_x_tipo_cost where codi_tipo_cost = tc.codi_tipo_cost) and tc.tcg = tcg.codi_tipo_cost_gene
		group by mc.anio, mc.mes, tcg.codi_tipo_cost_gene, tcg.desc_tipo_cost_gene, tcg.orden, tc.codi_tipo_cost, tc.desc_tipo_cost, tc.orden  ) res
--	Where  em.fech_cese is null or ( year( em.fech_cese ) > @ani  )  or ( year( em.fech_cese ) = @ani and month( em.fech_cese ) >= @cont_mes )   
	Where   em.codi_unid_oper in ( Select distinct codi_unid_oper  from movi_contables where anio = @ani)
		and ( em.fech_cese is null or ( year( em.fech_cese ) > @ani  )  or ( year( em.fech_cese ) = @ani and month( em.fech_cese ) >= res.mes ) )  
--	set @cont_mes = @cont_mes + 1
--end

SELECT  *
from #cost_anual_unid_oper
order by desc_unid_oper, orden_cost_gene, orden_cost, MES
GO
