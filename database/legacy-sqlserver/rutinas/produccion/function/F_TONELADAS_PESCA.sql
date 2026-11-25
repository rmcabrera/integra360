CREATE FUNCTION [dbo].[F_TONELADAS_PESCA](@embar [char](5), @semana [char](8), @dia [varchar](10))
RETURNS [numeric](12, 3) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt numeric(12,3)
	select distinct @rt=pesc_real from planilla_pesca_tripulantes where nom_dia=@dia and codi_unid_oper=@embar
		and codi_sema=@semana and pesc_Real>0
/*	select @rt=sum(pesc_real) from zarpes where datename(weekday,fech_repo)=@dia and codi_unid_oper=@embar
		and codi_sema=@semana*/
	if (@rt is null) set @rt=0
	return @rt
END
GO
