CREATE PROCEDURE [dbo].[crear_tabla_plan_ante]
	@anio [char](4),
	@mes [char](2),
	@indi_tiem [char](1),
	@TIPO_PERS [char](2)
WITH EXECUTE AS CALLER
AS
Declare @codi_plan char(12)
Declare @codi_pers char(5)
Declare @codi_anti char(5)
Declare @codi_conc char(6)
Declare @codi_conc1 char(6)
declare @nro_sema char(2)
declare @periodo char(6)
declare @afp char(2)
declare @codi_afp char(2)
declare @tipo_OA char(1)

Declare @cont integer
Declare  @i integer
Declare  @nume_dias_norm integer
Declare  @nume_dias_domi integer
Declare  @nume_dias_feri integer
Declare  @hora_labo integer

Declare  @nume_hora integer
Declare  @nume_hora_50 integer
Declare  @nume_hora_100 integer

Declare @remu_basi decimal (9,2)
Declare @remu_af decimal (9,2)
Declare @remu_hora_50 decimal (9,2)
Declare @remu_hora_100 decimal (9,2)
Declare @remu_domi decimal (9,2)
Declare @remu_otra_remu decimal (9,2)
Declare @remu_brut decimal (9,2)
Declare @remu_comp decimal (9,2)
Declare @remu_snp decimal (9,2)
Declare @remu_sp_cf decimal (9,2)
Declare @remu_sp_cv decimal (9,2)
Declare @remu_sp_ps decimal (9,2)
Declare @remu_cta_cte decimal (9,2)
Declare @remu_juic decimal (9,2)
Declare @remu_ipss decimal (9,2)
Declare @remu_otro_desc decimal (9,2)
Declare @remu_otro_desc_2 decimal (9,2)
Declare @remu_otro_desc_3 decimal (9,2)
Declare @remu_rent_quin decimal (9,2)
Declare @remu_adel_quin decimal (9,2)
Declare @remu_tota_desc decimal (9,2)
Declare @remu_neta decimal (9,2)
Declare @remu_apor_essa decimal (9,2)
Declare @remu_apor_ies decimal (9,2)
Declare @remu_apor_SCTR_sa decimal (9,2)
Declare @remu_apor_sctr_pe decimal (9,2)
Declare @remu_apor_sena decimal (9,2)
Declare @remu_apor_tota decimal (9,2)
Declare @valo_auxi decimal (9,2)

declare @vaca_trun bit

Create Table #plan_ante (periodo char(5), num_sem integer, fec_del datetime, fec_al datetime, afp char(2), tipo char(1), codigo char(11), hras numeric(6,2), 
	valor numeric (6,2) , hrs_ordina numeric (6,2) , hrs_ext50 numeric (6,2),  hrs_ext100 numeric (6,2),  hrs_sub numeric (6,2), remu_basic numeric(10,2),
	asig_famil numeric(10,2) , subsidio numeric (10,2), imp_ext50 numeric (10,2) , imp_ext100 numeric (10,2), imp_domini numeric (10,2), incr_afp1 numeric (10,2),
	incr_afp2 numeric ( 10,2), vacaciones numeric (10,2), otra_remun numeric (10,2), bon_movil numeric (10,2), rie_caja numeric (10,2), gra_extra numeric(10,2),
	rem_cargo numeric(10,2), remu_bruta numeric (10,2), remu_compu numeric (10,2), rps_trabaj numeric (8,2) , snp_trabaj numeric (8,2), fon_trabaj numeric (8,2),
	adelanto numeric(8 ,2), judicial numeric (8,2), fondo_pens numeric(8,2), cta_cte numeric (8,2), otro_dscto numeric (8,2), otro1 numeric (8,2), otro2 numeric (8,2),
	otro3 numeric(8 ,2), otro4 numeric(8 ,2), otro5 numeric(8 ,2), solid_ipss numeric (8,2), inval_sobr numeric (8,2), comis_fija numeric (8,2), comis_porc numeric (8,2),
	renta_5ta numeric (8,2), otras_rete numeric(8,2), tota_dscto numeric (8,2), remun_neta numeric(8,2), rps_empres numeric (8,2), snp_empres numeric (8,2),
	acc_empres numeric (8,2), sctr_salud numeric (8,2), fon_empres numeric (8,2), sen_empres numeric (8,2), otra_aport numeric (8,2), tota_aport numeric (8,2), 
	grati char (2), fech_proce datetime, mesgrati numeric (5,2), v char(1) , ta_ar char (3), re_tot0 numeric (8,2) , re_tot50 numeric (8,2), re_tot100 numeric (8,2),
	ciudad char (1), truncas bit )

set @periodo = @mes + '/' + right(@anio,2)
if @tipo_pers = '01'
begin
	set @nro_sema = '0'
	set @tipo_OA = 'A'
		
	DECLARE Curs_carg_plan CURSOR FOR
	SELECT codi_plan_empl, codi_pers from planilla_de_Empleados where anio = @anio and mes = @mes and indi_tiem = @indi_tiem and codi_tipo_plan = '01';
end
if @tipo_pers = '02' or @tipo_pers = '05' 
begin
	set @nro_sema = '52'
	set @tipo_OA = 'O'
	
	DECLARE Curs_carg_plan CURSOR FOR
	SELECT P.codi_plan_obre, P.codi_pers from planilla_de_Obreros P,  Personal_por_tipo_trabajador PT 
	where P.anio = @anio and P.mes = @mes and P.indi_tiem = @indi_tiem and P.codi_tipo_plan = '01' and p.codi_pers = PT.codi_pers and pt.codi_tipo_pers = @tipo_pers;
end
Open Curs_carg_plan;
Fetch Curs_carg_plan into @codi_plan, @codi_pers;
While @@fetch_status  = 0
Begin
	set @remu_basi  = 0
	set @remu_hora_50 = 0
	set @remu_hora_100 = 0
	set @remu_otra_remu = 0
	set @remu_cta_cte = 0
	set @remu_juic = 0
	set @remu_otro_desc = 0
	set @remu_otro_desc_2 = 0
	set @remu_otro_desc_3 = 0
	set @nume_hora = 0
	set @nume_hora_50 = 0
	set @nume_hora_100 = 0
	set @remu_af = 0
	set @remu_brut = 0
	set @remu_comp = 0
	set @remu_ipss = 0
	set @remu_rent_quin = 0
	set @remu_snp = 0
	set @remu_sp_cf = 0
	set @remu_sp_cv = 0
	set @remu_sp_ps = 0
	set @remu_tota_desc = 0
	set @remu_apor_ies = 0
	set @remu_apor_essa = 0
	set @remu_apor_sctr_sa = 0
	set @remu_apor_sctr_pe = 0
	set @remu_apor_sena = 0
	set @remu_apor_tota = 0
	set @nume_dias_norm = 0
	set @remu_adel_quin = 0

	set @codi_afp = '00'

	set @codi_afp = (Select codi_sist_pens From Personal where codi_pers = @codi_pers)
	if @codi_afp = '01' begin set @afp  = 'NA' END
	if @codi_afp = '02' begin set @afp  = 'IN' END
	if @codi_afp = '03' begin set @afp  = 'PR' END
	if @codi_afp = '04' begin set @afp  = 'HO' END
	if @codi_afp = '05' begin set @afp  = 'UV' END
	set @hora_labo = (Select hora_labo From Personal where codi_pers = @codi_pers)

	set @codi_anti = (Select codi_anti From Personal where codi_pers = @codi_pers)	
	if @tipo_pers = '01'
	begin
		DECLARE Curs_carg_plan_deta CURSOR FOR SELECT codi_conc, valor from planilla_Empleado_conceptos where codi_plan_empl = @codi_plan;
	end
	if @tipo_pers = '02' or @tipo_pers = '05'
	begin
		DECLARE Curs_carg_plan_deta CURSOR FOR SELECT codi_conc, valor from planilla_Obrero_conceptos where codi_plan_obre = @codi_plan;
	end
	Open Curs_carg_plan_deta;
	Fetch Curs_carg_plan_deta into @codi_conc,  @valo_auxi;	
	While @@fetch_status  = 0
	Begin
		if @codi_conc =  '100010' begin set @remu_af = @valo_auxi end
		if @codi_conc =  '100040' begin set @remu_basi = @valo_auxi end
		if @codi_conc =  '100041' 
		begin 
			if @tipo_pers = '01' 
			begin
				set @remu_basi = @remu_basi + @valo_auxi 
				set @remu_domi = 0
			end
			if @tipo_pers = '02' or @tipo_pers = '05'
			begin
				set @remu_domi = @valo_auxi 
			end
		end
		if @codi_conc =  '100045' begin set @remu_basi = @remu_basi + @valo_auxi end
		if @codi_conc =  '100060' begin set @remu_hora_50 = @valo_auxi end
		if @codi_conc =  '100065' begin set @remu_hora_50 = @remu_hora_50 + @valo_auxi end
		if @codi_conc =  '100042' begin set @remu_hora_100 = @valo_auxi end
		if @codi_conc =  '100046' begin set @remu_hora_100 = @remu_hora_100 + @valo_auxi end
		if @codi_conc =  '100061' begin set @remu_hora_100 = @remu_hora_100 + @valo_auxi end
		if @codi_conc =  '100062' begin set @remu_hora_100 = @remu_hora_100 + @valo_auxi end
		if @codi_conc =  '100066' begin set @remu_hora_100 = @remu_hora_100 + @valo_auxi end
		if @codi_conc =  '100067' begin set @remu_hora_100 = @remu_hora_100 + @valo_auxi end
		if @codi_conc =  '100110' begin set @remu_otra_remu = @valo_auxi end
		if @codi_conc =  '100111' begin set @remu_otra_remu = @remu_otra_remu  + @valo_auxi end
		if @codi_conc =  '100112' begin set @remu_otra_remu = @remu_otra_remu  + @valo_auxi end
		if @codi_conc =  '199999' begin set @remu_brut = @valo_auxi end
		if @codi_conc =  '199998' begin set @remu_comp = @valo_auxi end		
		if @codi_conc =  '200001' begin set @remu_cta_cte = @valo_auxi end		
		if @codi_conc =  '200002' begin set @remu_cta_cte = @remu_cta_cte + @valo_auxi end
		if @codi_conc =  '200003' begin set @remu_cta_cte = @remu_cta_cte + @valo_auxi end
		if @codi_conc =  '200004' begin set @remu_cta_cte = @remu_cta_cte + @valo_auxi end
		if @codi_conc =  '200011' begin set @remu_juic = @valo_auxi end		
		if @codi_conc =  '200012' begin set @remu_juic = @remu_juic + @valo_auxi end
		if @codi_conc =  '200013' begin set @remu_juic = @remu_juic + @valo_auxi end
		if @codi_conc =  '200014' begin set @remu_juic = @remu_juic + @valo_auxi end
		if @codi_conc =  '200020' begin set @remu_ipss = @valo_auxi end
		if @codi_conc =  '200030' begin set @remu_snp = @valo_auxi end
		if @codi_conc =  '200031' begin set @remu_sp_cf = @valo_auxi end		
		if @codi_conc =  '200032' begin set @remu_sp_cv = @valo_auxi end		
		if @codi_conc =  '200033' begin set @remu_sp_ps = @valo_auxi end
		if @codi_conc =  '200040' begin set @remu_rent_quin = @valo_auxi end
		if @codi_conc =  '200075' begin set @remu_adel_quin = @valo_auxi end
		if @codi_conc =  '200091' begin set @remu_cta_cte = @remu_cta_cte + @valo_auxi end
		if @codi_conc =  '200092' begin set @remu_cta_cte = @remu_cta_cte + @valo_auxi end
		if @codi_conc =  '200093' begin set @remu_cta_cte = @remu_cta_cte + @valo_auxi end
		if @codi_conc =  '200094' begin set @remu_cta_cte = @remu_cta_cte + @valo_auxi end
		if @codi_conc =  '200120' begin set @remu_otro_desc = @valo_auxi end
		if @codi_conc =  '200121' begin set @remu_otro_desc_2 = @valo_auxi end
		if @codi_conc =  '200122' begin set @remu_otro_desc_2 = @remu_otro_desc_2 + @valo_auxi end
		if @codi_conc =  '200123' begin set @remu_otro_desc_2 = @remu_otro_desc_2 + @valo_auxi end
		if @codi_conc =  '200130' begin set @remu_otro_desc_3 =  @valo_auxi end
		if @codi_conc =  '200131' begin set @remu_otro_desc_3 =  @remu_otro_desc_3 + @valo_auxi end
		if @codi_conc =  '200999' begin set @remu_otro_desc_3 =  @remu_otro_desc_3 + @valo_auxi end
		if @codi_conc =  '299999' begin set @remu_tota_desc = @valo_auxi end
		if @codi_conc =  '300000' begin set @remu_apor_ies = @valo_auxi end
		if @codi_conc =  '300010' begin set @remu_apor_essa = @valo_auxi end
		if @codi_conc =  '300020' begin set @remu_apor_sctr_sa = @valo_auxi end
		if @codi_conc =  '300021' begin set @remu_apor_sctr_pe = @valo_auxi end		
		if @codi_conc =  '300040' begin set @remu_apor_sena = @valo_auxi end		
		if @codi_conc =  '399999' begin set @remu_apor_tota = @valo_auxi end		

		if @codi_conc =  '500000' begin set @nume_dias_norm = @valo_auxi end		
		if @codi_conc =  '500010' 
		begin 
			set @nume_hora = 0
			set @nume_dias_domi = 0 
			set @nume_dias_feri = 0
			set @nume_hora = @valo_auxi
			if @nume_hora > 0 and @nume_hora <= 6 * @hora_labo
			begin 
				set @nume_dias_domi = 1 
				set @nume_dias_feri = 1 
			end
			if @nume_hora > 6 * @hora_labo and @nume_hora <= 12 * @hora_labo
			begin 
				set @nume_dias_domi = 2
				set @nume_dias_feri = 1 
			end
			if @nume_hora > 12 * @hora_labo and @nume_hora <= 18 * @hora_labo
			begin 
				set @nume_dias_domi = 3
				set @nume_dias_feri = 2
			end
			if @nume_hora > 18 * @hora_labo 
			begin 
				set @nume_dias_domi = 4
				set @nume_dias_feri = 2
			end	
			set @nume_dias_norm = @nume_dias_norm + @nume_dias_domi + @nume_dias_feri
			set @nume_hora = @nume_hora + @nume_dias_domi * @hora_labo + @nume_dias_feri * @hora_labo
		end		

		if @codi_conc =  '500011' begin set @nume_hora_100 = @valo_auxi end		
		if @codi_conc =  '500012' or @codi_conc =  '500021' or @codi_conc =  '500022' or @codi_conc =  '500031' or @codi_conc =  '500032'
		begin
			set @nume_hora_100 = @nume_hora_100 + @valo_auxi
		end
		if @codi_conc =  '500020' begin set @nume_hora_50 = @valo_auxi end		
		if @codi_conc =  '500030' begin set @nume_hora_50 = @nume_hora_50 + @valo_auxi end		
			
		if @codi_conc =  '999990' begin set @remu_neta = @valo_auxi end	
		
		
		Fetch Curs_carg_plan_deta into @codi_conc,  @valo_auxi;
	end
	CLOSE Curs_carg_plan_deta;
	Deallocate Curs_carg_plan_deta;

	Insert Into #plan_ante (periodo , num_sem , fec_del , fec_al , afp , tipo , codigo , hras , valor  , hrs_ordina  , hrs_ext50 ,  hrs_ext100 ,  hrs_sub , remu_basic ,
		asig_famil  , subsidio , imp_ext50  , imp_ext100 , imp_domini , incr_afp1, incr_afp2 , vacaciones , otra_remun , bon_movil , rie_caja , gra_extra,
		rem_cargo , remu_bruta , remu_compu , rps_trabaj , snp_trabaj, fon_trabaj ,	adelanto , judicial , fondo_pens , cta_cte , otro_dscto , otro1 , otro2,
		otro3 , otro4 , otro5 , solid_ipss , inval_sobr , comis_fija , comis_porc , renta_5ta , otras_rete , tota_dscto , remun_neta , rps_empres , snp_empres ,
		acc_empres , sctr_salud , fon_empres , sen_empres , otra_aport , tota_aport ,  grati , fech_proce , mesgrati , v  , ta_ar , re_tot0  , re_tot50 , re_tot100,
		ciudad , truncas )
	Values ( @periodo, @nro_sema, null, null, @afp, @tipo_oa, @codi_anti, @nume_hora, 0, 0, @nume_hora_50, @nume_hora_100, 0, @remu_basi,
		@remu_af, 0, @remu_hora_50, @remu_hora_100, @remu_domi, 0, 0, 0, @remu_otra_remu, 0,0,0,0, @remu_brut, @remu_comp, 0, @remu_snp,
		0, @remu_adel_quin, @remu_juic, @remu_sp_cf, @remu_cta_cte, @remu_otro_desc, @remu_otro_desc_2, @remu_otro_desc_3, 0,0,0,
		@remu_ipss, @REMU_sp_ps, 0, @remu_sp_cv,  @remu_rent_quin, 0 , @remu_tota_desc, @remu_neta, @remu_apor_essa, 0,
		@remu_apor_sctr_pe, @remu_apor_sctr_sa, @remu_apor_ies, @remu_apor_sena, 0, @remu_apor_tota, 0, null, 0, '', '', 0,0,0,'',0  )

	Fetch Curs_carg_plan into @codi_plan, @codi_pers;
End
Close Curs_carg_plan;
Deallocate Curs_carg_plan;

SELECT * FROM #plan_ante
GO
