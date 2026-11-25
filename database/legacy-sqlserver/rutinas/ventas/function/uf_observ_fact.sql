CREATE FUNCTION [dbo].[uf_observ_fact](@descri [varchar](1000))
RETURNS [varchar](1000) WITH EXECUTE AS CALLER
AS 
begin
	declare @newcad varchar(1000)
	declare @ct int
	--set @descri = (select observaciones from FACTURA_DETALLE where CODI_FACT=7622)
	set @ct =1
	set @newcad =''
	while @ct <= LEN(@descri)
	begin
		if ascii(substring(@descri,@ct,1)) in (13) set @newcad = @newcad + '^' 
		if ascii(substring(@descri,@ct,1)) in (10) set @newcad = @newcad + '' 
		if ascii(substring(@descri,@ct,1)) not in (10,13)  set @newcad = @newcad + substring(@descri,@ct,1) 
		
		set @ct= @ct +1 
	end

	return @newcad
	
end
GO
