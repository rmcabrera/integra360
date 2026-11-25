CREATE FUNCTION [dbo].[F_PARTES_ADIC](@pers [char](5), @embar [char](5), @sema [char](8), @di [varchar](10))
RETURNS [char](4) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @r char(4)
	declare @n numeric(12,2)	
	select @n =adicional from planilla_pesca_tripulantes where codi_sema=@sema and codi_unid_oper=@embar and codi_pers=@pers and upper(nom_dia)=upper(@di)
		and pesc_real>0 and not (pesc_real is null)
	if(@n is null) set @r='0'
	else 
	begin
		set @r=STR(@n, 4,2)
	end
	return @r	
END
GO
