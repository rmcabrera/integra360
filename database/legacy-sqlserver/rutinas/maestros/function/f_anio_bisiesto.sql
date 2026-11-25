CREATE FUNCTION [dbo].[f_anio_bisiesto](@anio [numeric](18, 0))
RETURNS [smallint] WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @Bis smallint
	declare @anio_deci decimal(15,2)
	declare @anio_ente decimal(15,2)


	set @anio_deci = @anio / 100
	set @anio_ente = round( @anio_deci, 0 )
	If round( @anio_deci - @anio_ente , 2 ) = 0 
	begin
		set @anio_deci = @anio / 400
		set @anio_ente = round( @anio_deci, 0 )
		If round( @anio_deci - @anio_ente , 2 ) = 0 
		begin
			set @Bis = 1
		end
		Else
		begin
			set @Bis = 0
		End 
	end
	Else
	begin
		set @anio_deci = @anio / 4
		set @anio_ente = round( @anio_deci, 0 )
		If @anio_deci - @anio_ente = 0 
		begin
			set @Bis = 1
		end
		Else
		begin
			set @Bis = 0
		End 
	End 
	return @Bis 
END
GO
