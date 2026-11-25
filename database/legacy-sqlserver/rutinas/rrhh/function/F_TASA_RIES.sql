CREATE FUNCTION [dbo].[F_TASA_RIES](@ANIO [char](4), @MES [char](2), @TIPO_RIES [char](2), @tipo_pers [char](2))
RETURNS [numeric](12, 4) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @FECH_AUXI DATETIME
	declare @rt numeric(12,3)

	SET @FECH_AUXI = CAST('01/' + @MES + '/' + @ANIO AS smalldatetime) 
	SET @RT = (Select tasa From tipo_ries_tasa where codi_tipo_ries = @tipo_ries and codi_tipo_pers = @tipo_pers and fech_inic <= @fech_auxi and fech_fin >= @fech_auxi )
	if (@RT is null) set @RT=0
	
	return @rt
END
GO
