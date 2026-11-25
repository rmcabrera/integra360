CREATE FUNCTION [dbo].[F_Depre_Activo](@act [char](7), @fec [char](6))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt numeric(12,2)
	set @rt= (select depre_hist_act from detalle_calc_Af where codi_activo = @act and fecha_Detalle in (select max(fecha_detalle) 
			from detalle_calc_af where CODI_ACTIVO =@act 	 and fecha_detalle<@fec and retirado='0' ))
	if ( @rt is null) set @rt=0 
	return @rt
END
GO
