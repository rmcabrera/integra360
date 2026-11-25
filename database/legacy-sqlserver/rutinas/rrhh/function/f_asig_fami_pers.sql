CREATE FUNCTION [dbo].[f_asig_fami_pers](@PER [char](5), @hoy [datetime])
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	DECLARE @RT numeric(12,2)
	DECLARE @V integer
	DECLARE @SB integer
	Declare @asig integer
	Declare @maf decimal(9,2)
	Declare @tmaf decimal(9,0)
	Declare @msb decimal(9,2)
	Declare @tmsb decimal(9,0)
	set @rt = 0
	set @asig = (Select isnull( asig_fami , 0 ) from personal where codi_pers = @per)
	if @asig = 1 
	begin
		Set @v = (Select codi_valo_unit from valores_unitarios where upper( desc_valo_unit) = 'ASIGNACIÓN FAMILIAR'  OR upper( desc_valo_unit) = 'ASIGNACION FAMILIAR'  )
		Set @SB = (Select codi_valo_unit from valores_unitarios where upper( desc_valo_unit) = 'SUELDO BASICO'  OR upper( desc_valo_unit) = 'SUELDO BÁSICO'  )
		Set @maf = (Select valor from valores_unitarios_anuales where codi_valo_unit = @v and fech_asig <= @hoy and fech_asig_fin >= @hoy )
		Set @tmaf = (Select tipo_valo from valores_unitarios_anuales where codi_valo_unit = @v and fech_asig <= @hoy and fech_asig_fin >= @hoy )
		Set @msb = (Select valor from valores_unitarios_anuales where codi_valo_unit = @sb and fech_asig <= @hoy and fech_asig_fin >= @hoy )
		Set @tmsb = (Select tipo_valo from valores_unitarios_anuales where codi_valo_unit = @sb and fech_asig <= @hoy and fech_asig_fin >= @hoy )
		if @tmaf = 0
		begin
			set @maf = @maf / 100
		end
		if @tmsb = 0
		begin
			set @msb = @msb / 100
		end
		set @rt = @maf * @msb
	end
	else
	begin
		set @rt = 0
	end	
	RETURN @rt
END
GO
