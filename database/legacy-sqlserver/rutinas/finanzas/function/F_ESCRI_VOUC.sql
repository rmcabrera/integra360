CREATE FUNCTION [dbo].[F_ESCRI_VOUC](@COMPR [char](10), @NRO_CUEN [char](7), @codi_vouc [char](10))
RETURNS [char](30) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @NRO_ESCR CHAR(30)
	declare @CODI_ESCR CHAR(30)

	SET @CODI_ESCR = ( SELECT MIN(CODI_ESCR) 
			FROM ESCRIBALO_DETA (nolock) WHERE CODI_VOUC = @COMPR AND REGB = @NRO_CUEN
				AND CODI_agru = @codi_vouc  )
	
	if (@CODI_ESCR is null) set @CODI_ESCR=''
	IF @CODI_ESCR <> '' 
	BEGIN
		SET @NRO_ESCR = (Select nro_escr + '/' +  anio + '-' + inic 
			from escribalo (nolock) where codi_escr = @codi_escr )		
	END
	
	if (@NRO_ESCR is null) set @NRO_ESCR=''
	return @NRO_ESCR
END
GO
