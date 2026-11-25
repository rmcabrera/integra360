CREATE FUNCTION [dbo].[F_sum_cuen_carg_mes](@cuenta [char](7), @mes [char](2), @anio [char](4))
RETURNS [numeric](14, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @r numeric(14,2)
	declare @r1 numeric(14,2)
	declare @r2 numeric(14,2)
	select @r1 = Sum(importe) from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta and mes=@mes and anio=@anio and cargo_abono = 'C'
--	select @r2 =Sum(importe) from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta and mes=@mes and anio=@anio and cargo_abono = 'A'
	if(@r1 is null) set @r1= 0
	if(@r2 is null) set @r2= 0
	set @r = @r1 -- - @r2
	return @r	
END
GO
