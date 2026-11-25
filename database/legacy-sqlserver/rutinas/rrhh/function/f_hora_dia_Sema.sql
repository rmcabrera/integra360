CREATE FUNCTION [dbo].[f_hora_dia_Sema](@fecha [datetime], @codi_pers [char](5), @anio [char](4), @mes [char](2))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
BEGIN 
declare @hora_dia as integer
declare @dias_dife as integer
declare @fech_inic as datetime
	Select @fech_inic = fech_inic from hora_labo_sema 
	where fech_inic <= @fecha and fech_term >= @fecha and codi_pers = @codi_pers and anio = @anio and mes = @mes 
	set @dias_dife = datediff(day, @fech_inic, @fecha)
	if @dias_dife = 0 
	begin 
		Select @hora_dia = d_01 from hora_labo_sema where fech_inic = @fech_inic and codi_pers = @codi_pers and anio = @anio and mes = @mes
	end
	if @dias_dife = 1
	begin 
		Select @hora_dia = d_02 from hora_labo_sema where fech_inic = @fech_inic and codi_pers = @codi_pers and anio = @anio and mes = @mes
	end
	if @dias_dife = 2
	begin 
		Select @hora_dia = d_03 from hora_labo_sema where fech_inic = @fech_inic and codi_pers = @codi_pers and anio = @anio and mes = @mes
	end
	if @dias_dife = 3
	begin 
		Select @hora_dia = d_04 from hora_labo_sema where fech_inic = @fech_inic and codi_pers = @codi_pers and anio = @anio and mes = @mes
	end
	if @dias_dife = 4
	begin 
		Select @hora_dia = d_05 from hora_labo_sema where fech_inic = @fech_inic and codi_pers = @codi_pers and anio = @anio and mes = @mes
	end
	if @dias_dife = 5
	begin 
		Select @hora_dia = d_06 from hora_labo_sema where fech_inic = @fech_inic and codi_pers = @codi_pers and anio = @anio and mes = @mes
	end
	if @dias_dife = 6
	begin 
		Select @hora_dia = d_07 from hora_labo_sema where fech_inic = @fech_inic and codi_pers = @codi_pers and anio = @anio and mes = @mes
	end
	
	return isnull(@hora_dia , -1 )
END
GO
