CREATE FUNCTION [dbo].[F_TC](@Fecha [datetime], @tipo [char](1), @origen [char](2), @destino [char](2))
RETURNS [decimal](10, 4) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @tc decimal(10,4)
	declare @cc int
	declare @mxfecha datetime
	set @tipo=upper(@tipo)
	set @tc=0
	If @tipo='V'
	Begin
		Select @cc=count(venta) from tipo_cambio_a_dolar where fech_camb=@fecha and codi_mone_orig=@origen and codi_mone_camb=@destino
		if @cc<>0 
		begin
			Select @tc=venta from tipo_cambio_a_dolar where fech_camb=@fecha and codi_mone_orig=@origen and codi_mone_camb=@destino
		end
	End
	Else
	Begin
		Select @cc=count(compra) from tipo_cambio_a_dolar where fech_camb=@fecha and codi_mone_orig=@origen and codi_mone_camb=@destino
		if @cc<>0 
		begin
			Select @tc=compra from tipo_cambio_a_dolar where fech_camb=@fecha and codi_mone_orig=@origen and codi_mone_camb=@destino
		end
	End
	return @tc
END
GO
