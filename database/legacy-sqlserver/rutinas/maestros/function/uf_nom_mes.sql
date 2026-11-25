CREATE FUNCTION [dbo].[uf_nom_mes](@ms [int])
RETURNS [varchar](24) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @mes varchar(24)
	set @mes=''
	if @ms = 1 set @mes='Enero'
	if @ms = 2 set @mes='Febrero'		
	if @ms = 3 set @mes='Marzo'		
	if @ms = 4 set @mes='Abril'		
	if @ms = 5 set @mes='Mayo'		
	if @ms = 6 set @mes='Junio'		
	if @ms = 7 set @mes='Julio'		
	if @ms = 8 set @mes='Agosto'		
	if @ms = 9 set @mes='Setiembre'		
	if @ms = 10 set @mes='Octubre'		
	if @ms = 11 set @mes='Noviembre'		
	if @ms = 12 set @mes='Diciembre'		

	return @mes
END
GO
