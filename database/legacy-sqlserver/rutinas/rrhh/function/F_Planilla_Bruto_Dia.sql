CREATE FUNCTION [dbo].[F_Planilla_Bruto_Dia](@embar [char](5), @sema [char](8), @di [varchar](10))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN
Declare @Sum_dj numeric(12,2)
Declare @pers char(5)
Declare @pd numeric(12,2)
Declare @vp numeric(12,2)

Declare Cur cursor for select codi_pers from planilla_pesca_tripulantes
where codi_sema=@sema and codi_unid_oper=@embar and upper(nom_dia)=upper(@di);

open Cur
FETCH Cur INTO @pers

Set @sum_dj = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	Set @pd = dbo.f_partes_dia(@pers, @embar, @sema, @di)
	Set @vp = dbo.f_valor_partes(@pers, @embar, @sema, @di) 
	if(@pd is null) set @pd=0
	if(@vp is null) set @vp=0
	Set @sum_dj = @sum_dj + @pd * @vp
	FETCH Cur INTO @pers
END

close Cur
DEALLOCATE cur

return @sum_dj
END
GO
