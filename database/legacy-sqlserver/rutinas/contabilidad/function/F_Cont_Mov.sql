CREATE FUNCTION [dbo].[F_Cont_Mov](@tpd [char](4), @sd [char](1), @rg [char](10), @cod [char](10))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt int
	select @rt=count(codi_contable)
	from movi_contables 
	where codi_tipo_docu=@tpd and subdia=@sd and codi_vouc =@rg and codi_contable<= @cod;
	return @rt
END
GO
