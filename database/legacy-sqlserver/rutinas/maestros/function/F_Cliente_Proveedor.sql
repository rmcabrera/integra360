CREATE FUNCTION [dbo].[F_Cliente_Proveedor](@codi [char](5))
RETURNS [varchar](200) WITH EXECUTE AS CALLER
AS 
BEGIN 
  	Declare  @rt varchar(200)
  	Declare  @tipo varchar(20)
	if (ltrim(rtrim(@codi))='' or  (@codi is null)) set @rt=''
	select @tipo=tipo_pers from cliente_proveedor where codi_clie_prov=@codi
	if (upper(LEFT( @tipo, 1 ) )='N' )
	begin
		set @rt = (select case when apel_1+ ' '+ isnull(apel_2 + ' ','')+ isnull(nomb_1+ ' ','')+ isnull(nomb_2,'')='' then 
						DENOMINACION else 
					isnull(apel_1+ ' '+ isnull(apel_2 + ' ','')+ isnull(nomb_1+ ' ','')+ isnull(nomb_2,'')  ,
						 DENOMINACION) end 
		from cliente_proveedor (nolock)
			where codi_clie_prov=@codi)
	end
	else
	begin
		select @rt= isnull( razo_soci  , DENOMINACION) from cliente_proveedor where codi_clie_prov=@codi
	
	end
	return @rt
END
GO
