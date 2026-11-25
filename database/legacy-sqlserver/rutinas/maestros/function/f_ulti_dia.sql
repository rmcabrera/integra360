CREATE FUNCTION [dbo].[f_ulti_dia](@anio [int], @mes [int])
RETURNS [smallint] WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @Bis smallint
	declare @ulti_dia smallint
	if @mes = 1 begin set @ulti_dia = 31 end

	if @mes = 2 
	begin 
		set @ulti_dia = 28
		set @bis = (Select top 1 dbo.f_anio_bisiesto(@anio) From feriados)
		if @bis = 1 begin set @ulti_dia = 29 end
	end

	if @mes = 3 begin set @ulti_dia = 31 end
	if @mes = 4 begin set @ulti_dia = 30 end
	if @mes = 5 begin set @ulti_dia = 31 end
	if @mes = 6 begin set @ulti_dia = 30 end
	if @mes = 7 begin set @ulti_dia = 31 end
	if @mes = 8 begin set @ulti_dia = 31 end
	if @mes = 9 begin set @ulti_dia = 30 end
	if @mes = 10 begin set @ulti_dia = 31 end
	if @mes = 11 begin set @ulti_dia = 30 end
	if @mes = 12 begin set @ulti_dia = 31 end


	return @ulti_dia 
END
GO
