CREATE FUNCTION [dbo].[F_Renta_Quinta_fija](@persona [char](5), @mesc [char](2), @ani [char](4), @ingre [decimal](9, 2), @codi_tipo_plan [char](2), @fech_tm [datetime])
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
begin

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------
--	declare @persona char(5), @mesc char(2), @ani char(4), @ingre decimal(9,2), @codi_tipo_plan char(2) , @fech_tm datetime
--	select @persona ='00016', @mesc ='01', @ani ='2023', @ingre =7415, @codi_tipo_plan ='01', @fech_tm ='31/01/2023'

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------
	Declare @asig_fami smallint
	Declare @sueldo DECIMAL(9,2)
	Declare @suel_mini DECIMAL(9,2)
	Declare @remu_asig_fami DECIMAL(9,2)
	Declare @mont_asig_fami DECIMAL(9,2)
	Declare @rent_5ta numeric(12,2)
	Declare @tipo_mont_af smallint
	Declare @fech_ingre datetime
	Declare @fech_ia datetime
	Declare @fech_im datetime
--	Declare @fech_tm datetime
	Declare @fech_ig datetime
	Declare @tipo_trab char(2)
	Declare @sb char(2)
	Declare @tmsb smallint


	Select @sueldo = suel_basi, @asig_fami = asig_fami, @fech_ingre = fech_ingre from personal where codi_pers = @persona;
	set @tipo_trab = ( Select top 1 codi_tipo_pers from personal_por_tipo_trabajador where codi_pers = @persona )
	set @fech_ia = cast( '01/01/' + @ani as datetime )
	set @fech_im = cast( '01/' + @mesc + '/' + @ani as datetime )

	if @mesc < '10' 
	begin
		set @fech_ig = cast( '01/07/' + @ani as datetime )
	end
	else
	begin
		set @fech_ig = cast( '01/12/' + @ani as datetime )
	end

	if @asig_fami = 1 
	begin
		set @remu_asig_fami =  ( Select dbo.f_asig_fami_pers ( @persona, @fech_im ) From personal where codi_pers = @persona )
	end
	else
	begin
		set @remu_asig_fami = 0
	end	

	Set @SB = (Select codi_valo_unit from valores_unitarios where upper( desc_valo_unit) = 'SUELDO BASICO'  OR upper( desc_valo_unit) = 'SUELDO BÁSICO'  )
	Set @suel_mini = (Select valor from valores_unitarios_anuales where codi_valo_unit = @sb and fech_asig <= @fech_im and fech_asig_fin > @fech_im )
	Set @tmsb = (Select tipo_valo from valores_unitarios_anuales where codi_valo_unit = @sb and fech_asig <= @fech_im and fech_asig_fin > @fech_im )
	if @tmsb = 0
	begin
		set @suel_mini = @suel_mini / 100
	end


--select @persona, @mesc, @ani, @tipo_trab, @ingre, 0, @remu_asig_fami, @suel_mini, @fech_ingre, @fech_tm, @fech_ig, @fech_ia, @codi_tipo_plan 
	set @rent_5ta = ( Select  dbo.F_Renta_Quinta_fija_calc ( @persona, @mesc, @ani, @tipo_trab, @ingre, 0, @remu_asig_fami, 
			@suel_mini, @fech_ingre, @fech_tm, @fech_ig, @fech_ia, @codi_tipo_plan ) From personal where codi_pers = @persona)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------
	return @rent_5ta 

END
GO
