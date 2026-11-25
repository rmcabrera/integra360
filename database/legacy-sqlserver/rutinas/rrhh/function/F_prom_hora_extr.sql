CREATE FUNCTION [dbo].[F_prom_hora_extr](@anio [char](4), @codi_pers [char](5), @TP [char](1), @fecha [datetime], @nro_mese [int], @tipo_pers [char](2), @tipo [char](2))
RETURNS [decimal](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt numeric(2)
	declare @prom_he25_auxi decimal(15,2)
	declare @prom_he35_auxi decimal(15,2)
	declare @mes_inic int
	declare @anio_inic int
	declare @fech_inic_auxi datetime
	declare @fech_inic datetime	

	DECLARE @CODI_PERS_AUXI CHAR(5)
	DECLARE @CODI_tipo_PERS_AUXI CHAR(5)
	Declare @ls_indi_grab char(1)
	DECLARE @cont_plan_vaca integer
	DECLARE @Cont smallint
	DECLARE @Cont_he smallint
	DECLARE @Cont_he_segu smallint
	DECLARE @nro_dias_vaca smallint
	Declare @indi_sali bit
	Declare @indi_he bit
	Declare @indi_he_auxi bit
	Declare @prom_he25 decimal(9,2)
	Declare @prom_he35 decimal(9,2)
	declare @fech_ingr datetime
	declare @fech_maxi_auxi datetime
	declare @fech_auxi datetime
	declare @fech_term_auxi datetime
	set @CODI_PERS_AUXI = @codi_pers
	set @fech_inic = dateadd(month, -6, @fecha)
	set @fech_inic_auxi = @fech_inic	
	while @fech_inic_auxi < @Fech_Inic
	begin		
		set @mes_inic = datepart(month, @fech_inic_auxi)
		set @anio_inic = datepart(year, @fech_inic_auxi)				
		set @prom_he25_auxi = 0
		set @prom_he35_auxi = 0		
		if @codi_tipo_pers_auxi = '01' 
		begin
			set @prom_he25_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P, Planilla_empleado_conceptos PC
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
					and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100060' and PC.codi_conc < '100065'))
					--or codi_tipo_plan = '03'
			set @prom_he35_auxi = (Select isnull(sum(valor),0) From Planilla_de_empleados P, Planilla_empleado_conceptos PC
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_empl = PC.codi_plan_empl
					and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100065' and PC.codi_conc < '100070'))
		end
		if @codi_tipo_pers_auxi = '02' 
		begin
			set @prom_he25_auxi = (Select isnull(sum(valor),0) From Planilla_de_Obreros P, Planilla_obrero_conceptos PC
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
					and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100060' and PC.codi_conc < '100065'))
			set @prom_he35_auxi = (Select isnull(sum(valor),0) From Planilla_de_obreros P, Planilla_obrero_conceptos PC
					where P.codi_pers = @codi_pers_auxi and P.anio = @anio_inic and P.mes = @mes_inic and P.codi_plan_obre = PC.codi_plan_obre
					and (P.codi_tipo_plan = '01' ) and P.indi_tiem = 'M' and (PC.codi_conc >= '100065' and PC.codi_conc < '100070'))
		end				
		if @prom_he25_auxi > 0 or @prom_he35_auxi > 0 
		begin
			set @cont_he = @cont_he + 1
			set @indi_he_auxi = 1
		end
		else
		begin
			set @indi_he_auxi = 0
		end
		
		if @cont = 1 
		begin	
			set @INDI_HE = @indi_he_auxi 
			if @prom_he25_auxi > 0 or @prom_he35_auxi > 0 
			begin
				set @cont_he_segu = 1
			end		
			else
			begin
				set @cont_he_segu = 0
			end													
		end
		else
		begin
			if (@indi_he = @indi_he_auxi)
			begin
				if @prom_he25_auxi > 0 or @prom_he35_auxi > 0 
				begin
					set @cont_he_segu =  @cont_he_segu + 1
				end						
			end
			else
			begin
				set @indi_he = @indi_he_auxi
			end
		end	

		set @mes_inic = @mes_inic + 1 
		if @mes_inic > 12 
		begin
			set @mes_inic = @mes_inic - 12
			set @anio_inic = @anio_inic + 1
		end	
		set @prom_he25 = @prom_he25 + @prom_he25_auxi
		set @prom_he35 = @prom_he35 + @prom_he35_auxi
		set @cont = @cont + 1

		set @fech_inic_AUXI = dateadd( month, 1, @fech_inic_AUXI )
	end
	if (@cont_he_segu > 2) or (@cont_he >= 3)
	begin				
		set @prom_he25 = (@prom_he25 / 6) 
		set @prom_he35 = (@prom_he35 / 6) 
	end
	else
	begin
		set @prom_he25 = 0
		set @prom_he35 = 0
	end	
	if @tipo = '25' set @rt = @prom_he25
	if @tipo = '35' set @rt = @prom_he35

	if (@rt is null) set @rt=0
	return @rt
END
GO
