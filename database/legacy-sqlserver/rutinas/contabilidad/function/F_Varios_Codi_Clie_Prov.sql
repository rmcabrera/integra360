CREATE FUNCTION [dbo].[F_Varios_Codi_Clie_Prov](@subdia [char](1), @codi_vouc [char](10))
RETURNS [varchar](100) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @codi_clie_prov char(5)
	declare @clie_prov varchar(100)
	declare @banco char(7)
	declare @c_cuenta numeric
	declare @tipo_pers char(20)
	select @banco= max( banco ) from movi_contables where subdia=@subdia and codi_vouc=@codi_vouc
	select @c_cuenta = count(nro_cuen) from movi_contables  where subdia=@subdia and codi_vouc=@codi_vouc and nro_cuen=@banco
	if @c_cuenta > 1
	Begin
		set @clie_prov = 'VARIOS'
	End
	Else
	Begin
		select @Codi_clie_prov= isnull(codi_clie_prov,'0') from movi_contables  where subdia=@subdia and codi_vouc=@codi_vouc and nro_cuen=@banco
		select @tipo_pers = upper(tipo_pers) from cliente_proveedor where codi_clie_prov=@codi_clie_prov
		If @tipo_pers = 'NATURAL'
		Begin
			select @clie_prov = isnull(apel_1,'') +' '+ isnull(apel_2,'') +' '+ isnull(nomb_1,'') +' '+ isnull(nomb_2,'') from cliente_proveedor where codi_clie_prov=@codi_clie_prov
		End
		Else
		Begin
			select @clie_prov = razo_soci from cliente_proveedor where codi_clie_prov=@codi_clie_prov
		End
	End
	if (@clie_prov is null) set @clie_prov='NINGUNO'
--	return cast( @c_cuenta as char )
	return @CLIE_PROV
END
GO
