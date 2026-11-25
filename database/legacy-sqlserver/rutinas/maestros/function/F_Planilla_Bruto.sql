CREATE FUNCTION [dbo].[F_Planilla_Bruto](@embar [char](5), @sema [char](8))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN
Declare @Sum_dj numeric(12,2)
Set @sum_dj = dbo.f_Planilla_Bruto_dia(@embar, @sema, 'Jueves')+dbo.f_Planilla_Bruto_dia(@embar, @sema, 'Viernes')+
dbo.f_Planilla_Bruto_dia(@embar, @sema, 'Sábado')+dbo.f_Planilla_Bruto_dia(@embar, @sema, 'Domingo')+
dbo.f_Planilla_Bruto_dia(@embar, @sema, 'Lunes')+dbo.f_Planilla_Bruto_dia(@embar, @sema, 'Martes')+
dbo.f_Planilla_Bruto_dia(@embar, @sema, 'Miércoles')
return @sum_dj
END
GO
