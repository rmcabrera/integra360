CREATE FUNCTION [dbo].[f_ultimo_dia](@mes [int], @anio [int])
RETURNS [int] WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @li_Ud int
	if @mes = 1  set @li_Ud = 31
	if @mes = 2  
	begin
		if dbo.f_Bisiesto(@Anio) =1  set @li_Ud = 29
		else  set @li_Ud = 28
	end
	if @mes = 3   set @li_Ud = 31
	if @mes = 4   set @li_Ud = 30
	if @mes = 5   set @li_Ud = 31
	if @mes = 6   set @li_Ud = 30
	if @mes = 7   set @li_Ud = 31
	if @mes = 8   set @li_Ud = 31
	if @mes = 9   set @li_Ud = 30
	if @mes = 10 set @li_Ud = 31
	if @mes = 11 set @li_Ud = 30
	if @mes = 12 set @li_Ud = 31

	Return @li_Ud
END
GO
