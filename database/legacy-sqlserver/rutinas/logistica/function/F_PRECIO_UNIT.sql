CREATE FUNCTION [dbo].[F_PRECIO_UNIT](@codi [char](10), @deta [char](12))
RETURNS [numeric](12, 4) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt numeric(12,4)
	declare @pr numeric(12,4)
	declare @mn char(2)
	declare @tpc numeric(12,4)
	declare @fec datetime
	select @pr =prec_unit, @mn =codi_mone from detalle_nota_ingreso where codi_nota_ingr=@codi and nro_item_nota_ingr=@deta
	select @fec=fech_nota_ingr from nota_ingreso where codi_nota_ingr=@codi 
	if (@mn='01') set @rt=@pr
	else
	begin
		select @tpc=venta from tipo_cambio_a_dolar where convert(char(10),fech_camb,103)=convert(char(10),@fec,103)
		set @rt=@pr*@tpc
	end
	return @rt
END
GO
