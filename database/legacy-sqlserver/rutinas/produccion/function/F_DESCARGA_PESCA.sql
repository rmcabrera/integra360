CREATE FUNCTION [dbo].[F_DESCARGA_PESCA](@embar [char](5), @semana [char](8), @dia [varchar](10))
RETURNS [char](5) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt char(5)
	select @rt=codi_clie_prov from zarpes where datename(weekday,fech_repo)=@dia and codi_unid_oper=@embar
		and codi_sema=@semana
	if (@rt is null) set @rt=''
	return @rt
END
GO
