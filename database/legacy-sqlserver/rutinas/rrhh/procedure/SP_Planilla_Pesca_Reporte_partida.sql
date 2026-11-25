CREATE PROCEDURE [dbo].[SP_Planilla_Pesca_Reporte_partida]
	@semana [char](8),
	@embar [char](5),
	@asi [char](1)
WITH EXECUTE AS CALLER
AS
begin
	Declare @persona char(5)
	Declare @des varchar(50)
	Declare @per varchar(100)
	Declare @cargo char(4)
	Declare @snp	numeric(12,3)
	Declare @rf	numeric(12,3)
	Declare @tm numeric(12,3)
	Declare @Dia char(10)
	Declare @mont numeric(12,2)
	Declare @diast numeric(12,0)
	Declare @tm1 numeric(12,3)
	Declare @tm2 numeric(12,3)
	Declare @tm3 numeric(12,3)
	Declare @tm4 numeric(12,3)
	Declare @tm5 numeric(12,3)
	Declare @tm6 numeric(12,3)
	Declare @tm7 numeric(12,3)
	
	Create Table #Temporal (Codi_sema char(8) null,   codi_unid_oper varchar(50) null, codi_pers varchar(100) null,
	   codi_carg char(4) null, prec_snp numeric(12,3) null, refri numeric(12,3) null, ju_tm numeric(12,3) null, ju_monto numeric(12,2) null
	,vi_tm numeric(12,3) null,vi_monto numeric(12,2) null, sa_tm numeric(12,3) null, sa_monto numeric(12,2) null,
	 do_tm numeric(12,3) null, do_monto numeric(12,2) null, lu_tm numeric(12,3) null, lu_monto numeric(12,2) null,
	 ma_tm numeric(12,3) null,  ma_monto numeric(12,2) null, mi_tm numeric(12,3) null,  mi_monto numeric(12,2) null, dias_trab numeric(12,2) null, codi char(5) null,
	p1 numeric(12,3) null, p2 numeric(12,3) null , p3 numeric(12,3) null	, p4 numeric(12,3) null	, p5 numeric(12,3) null	, p6 numeric(12,3) null	, p7 numeric(12,3) null	)

	set @tm1=isnull((select distinct  pesc_real  from planilla_pesca_tripulantes P
		         where P.codi_sema=@semana and P.codi_unid_oper=@embar and p.nom_dia='Jueves'  and nro_asis=@asi and parte>0) ,0)
	set @tm2=isnull((select distinct  pesc_real  from planilla_pesca_tripulantes P
		         where P.codi_sema=@semana and P.codi_unid_oper=@embar and p.nom_dia='Viernes'  and nro_asis=@asi and parte>0) ,0)
	set @tm3=isnull((select distinct  pesc_real  from planilla_pesca_tripulantes P
		         where P.codi_sema=@semana and P.codi_unid_oper=@embar and p.nom_dia='Sábado'  and nro_asis=@asi and parte>0)  ,0)
	set @tm4=isnull((select distinct  pesc_real  from planilla_pesca_tripulantes P
		         where P.codi_sema=@semana and P.codi_unid_oper=@embar and p.nom_dia='Domingo'  and nro_asis=@asi and parte>0),0)
	set @tm5=isnull((select distinct  pesc_real  from planilla_pesca_tripulantes P
		         where P.codi_sema=@semana and P.codi_unid_oper=@embar and p.nom_dia='Lunes'  and nro_asis=@asi and parte>0),0)
	set @tm6=isnull((select distinct  pesc_real  from planilla_pesca_tripulantes P
		         where P.codi_sema=@semana and P.codi_unid_oper=@embar and p.nom_dia='Martes'  and nro_asis=@asi and parte>0),0)
	set @tm7=isnull((select distinct  pesc_real  from planilla_pesca_tripulantes P
		         where P.codi_sema=@semana and P.codi_unid_oper=@embar and p.nom_dia='Miércoles'  and nro_asis=@asi and parte>0 ), 0)

	declare C1 cursor for select codi_pers, codi_carg, nom_dia, pesc_real,prec_snp,monto,refri from planilla_pesca_tripulantes
		where codi_sema=@semana and codi_unid_oper=@embar and nro_asis=@asi

	open C1
	fetch 	C1 into @persona, @cargo, @dia, @tm ,@snp, @mont ,@rf
	WHILE @@FETCH_STATUS = 0
	begin	
		select @des = desc_unid_oper from embarcaciones where codi_unid_oper=@embar
		select @cargo= codi_carg, @per = apel_1 + ' ' +apel_2 + ' '+ nomb_1+' '+ nomb_2 from personal where codi_pers=@persona
		set @diast=dbo.F_Dias_traba_trip(@semana,@embar , @persona, @asi)
			
		insert into #Temporal (Codi_sema,  codi_unid_oper , codi_pers ,
		   codi_carg , prec_snp ,refri, ju_tm , ju_monto ,vi_tm ,vi_monto , sa_tm , sa_monto ,
		  do_tm , do_monto , lu_tm , lu_monto , ma_tm ,  ma_monto , mi_tm ,  mi_monto , dias_trab , codi ,p1 ,p2, p3, p4, p5, p6, p7)
		values(@semana,@des,@per,@cargo,@snp, @rf, case @dia when 'Jueves' then @tm else 0 end ,
		case @dia when 'Jueves' then @mont else 0 end ,case @dia when 'Viernes' then @tm else 0 end,case @dia when 'Viernes' then @mont else 0 end,
		case @dia when 'Sábado' then @tm else 0 end,case @dia when 'Sábado' then @mont else 0 end,case @dia when 'Domingo' then @tm else 0 end,
		case @dia when 'Domingo' then @mont else 0 end,case @dia when 'Lunes' then @tm else 0 end,case @dia when 'Lunes' then @mont else 0 end,
		case @dia when 'Martes' then @tm else 0 end,case @dia when 'Martes' then @mont else 0 end,case @dia when 'Miércoles' then @tm else 0 end,
		case @dia when 'Miércoles' then @mont else 0 end , @diast, @persona,   	case @dia when 'Jueves' then @snp*@rf else 0 end ,
		case @dia when 'Viernes' then @snp*@rf else 0 end,  case @dia when 'Sábado' then @snp*@rf else 0 end,
		case @dia when 'Domingo' then @snp*@rf else 0 end, case @dia when 'Lunes' then @snp*@rf else 0 end,
		case @dia when 'Martes' then @snp*@rf else 0 end, 	case @dia when 'Miércoles' then @snp*@rf else 0 end) 
		fetch 	C1 into @persona, @cargo, @dia, @tm ,@snp, @mont, @rf

	end
	Close C1
	deallocate C1
	select Codi_sema ,  codi_unid_oper , codi_pers ,  codi_carg , isnull(avg(prec_snp),0) as SNP , @tm1 as JU_TM , isnull(sum( ju_monto),0) as Ju_mt ,
		@tm2 as Vi_tm , sum(vi_monto) as Vi_mt  , @tm3  as Sa_tm, sum(sa_monto) as Sa_mt, 
		@tm4 as Do_tm, sum(do_monto) as Do_mt, 	  @tm5 as Lu_tm, sum(lu_monto ) as Lu_mt,  @tm6 as Ma_tm,  sum(ma_monto ) as ma_mt,
		@tm7 as mi_tm,  sum(mi_monto)   as Mi_mt  , avg(refri)  as Refri , dias_trab, codi,
		sum(p1) p1 , sum(p2) p2 , sum(p3) p3, sum(p4) p4 , sum(p5) p5 , sum(p6) p6 , sum(p7) p7    from #temporal 
		 group by Codi_sema , codi_unid_oper , codi_pers , codi_carg ,dias_trab, codi
End
GO
