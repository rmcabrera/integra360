CREATE FUNCTION [dbo].[F_Cargo_dia](@diap [datetime], @pers [char](5), @embar [char](5), @semana [char](8))
RETURNS [char](5) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @Cod as char(5)
	select @cod= codi_carg	from planilla_pesca_tripulantes where convert(char(10), dia,103) = convert(char(10), @diap ,103) and codi_pers=@pers and codi_unid_oper=@embar
	and codi_sema=@semana
	return @cod
END
GO
