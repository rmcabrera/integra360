CREATE PROCEDURE [dbo].[SP_Planilla_Pesca_Reporte_Especial]
	@semana [char](8),
	@embar [char](5)
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
	
	Create Table #Temporal (Codi_sema char(8) null,   codi_unid_oper varchar(50) null, codi_pers varchar(100) null,
	   codi_carg char(4) null, prec_snp numeric(12,3) null, refri numeric(12,3) null, ju_tm numeric(12,3) null, ju_monto numeric(12,2) null
	,vi_tm numeric(12,3) null,vi_monto numeric(12,2) null, sa_tm numeric(12,3) null, sa_monto numeric(12,2) null,
	 do_tm numeric(12,3) null, do_monto numeric(12,2) null, lu_tm numeric(12,3) null, lu_monto numeric(12,2) null,
	 ma_tm numeric(12,3) null,  ma_monto numeric(12,2) null, mi_tm numeric(12,3) null,  mi_monto numeric(12,2) null ,codi char(5) null)
	
	declare C1 cursor for select codi_pers, codi_carg, nom_dia, pesc_real,prec_snp,espe_monto,refri from planilla_pesca_tripulantes
		where codi_sema=@semana and codi_unid_oper=@embar

	open C1
	fetch 	C1 into @persona, @cargo, @dia, @tm ,@snp, @mont ,@rf
	WHILE @@FETCH_STATUS = 0
	begin	
		select @des = desc_unid_oper from embarcaciones where codi_unid_oper=@embar
		select @cargo= codi_carg, @per = apel_1 + ' ' +apel_2 + ' '+ nomb_1+' '+ nomb_2 from personal where codi_pers=@persona
			
		insert into #Temporal (Codi_sema,  codi_unid_oper , codi_pers ,
		   codi_carg , prec_snp ,refri, ju_tm , ju_monto ,vi_tm ,vi_monto , sa_tm , sa_monto ,
		  do_tm , do_monto , lu_tm , lu_monto , ma_tm ,  ma_monto , mi_tm ,  mi_monto ,codi )
		values(@semana,@des,@per,@cargo,@snp, @rf, case @dia when 'Jueves' then @tm else 0 end ,
		case @dia when 'Jueves' then @mont else 0 end ,case @dia when 'Viernes' then @tm else 0 end,case @dia when 'Viernes' then @mont else 0 end,
		case @dia when 'Sábado' then @tm else 0 end,case @dia when 'Sábado' then @mont else 0 end,case @dia when 'Domingo' then @tm else 0 end,
		case @dia when 'Domingo' then @mont else 0 end,case @dia when 'Lunes' then @tm else 0 end,case @dia when 'Lunes' then @mont else 0 end,
		case @dia when 'Martes' then @tm else 0 end,case @dia when 'Martes' then @mont else 0 end,case @dia when 'Miércoles' then @tm else 0 end,
		case @dia when 'Miércoles' then @mont else 0 end , @persona)
		fetch 	C1 into @persona, @cargo, @dia, @tm ,@snp, @mont,@rf
	end
	Close C1
	deallocate C1
	select Codi_sema ,  codi_unid_oper , codi_pers ,  codi_carg , avg(prec_snp) as SNP , sum(ju_tm) as JU_TM ,sum( ju_monto) as Ju_mt ,
		sum(vi_tm) as Vi_tm ,sum(vi_monto) as Vi_mt ,sum( sa_tm) as Sa_tm, sum(sa_monto) as Sa_mt, sum(do_tm ) as Do_tm, sum(do_monto) as Do_mt,
		 sum(lu_tm ) as Lu_tm, sum(lu_monto ) as Lu_mt, sum(ma_tm ) as Ma_tm,  sum(ma_monto ) as ma_mt,
		sum( mi_tm ) as mi_tm,  sum(mi_monto)   as Mi_mt  , avg(refri)  as Refri , codi from #temporal group by Codi_sema , codi_unid_oper , codi_pers , codi_carg ,codi

End
GO
