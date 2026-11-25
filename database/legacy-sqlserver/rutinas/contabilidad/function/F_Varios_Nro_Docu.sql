CREATE FUNCTION [dbo].[F_Varios_Nro_Docu](@subdia [char](1), @codi_vouc [char](10))
RETURNS [varchar](100) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @nro_docu varchar(30)
	declare @min_docu varchar(10)
	declare @max_docu varchar(10)
	declare @banco char(7)
	declare @c_cuenta numeric
	select @banco= max(banco ) from movi_contables where subdia=@subdia and codi_vouc=@codi_vouc
	select @c_cuenta = count(nro_cuen) from movi_contables  where subdia=@subdia and codi_vouc=@codi_vouc and nro_cuen=@banco
	if @c_cuenta > 1
	Begin
		select @min_docu= min(cast( nro_docu as numeric)) from movi_contables  where subdia=@subdia and codi_vouc=@codi_vouc and nro_cuen=@banco
		select @max_docu= max(cast( nro_docu as numeric)) from movi_contables  where subdia=@subdia and codi_vouc=@codi_vouc and nro_cuen=@banco
		set @nro_docu=@min_docu+' - '	+@max_docu
	End
	Else
	Begin
		select @nro_docu=nro_docu  from movi_contables  where subdia=@subdia and codi_vouc=@codi_vouc and nro_cuen=@banco
	End
	if (@nro_docu is null) set @nro_docu = 'NINGUNO'
	return @nro_docu
END
GO
