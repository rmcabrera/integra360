CREATE FUNCTION [dbo].[F_Dias_traba_trip](@Semana [char](8), @Embar [char](5), @pers [char](5), @nasis [char](1))
RETURNS [smallint] WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @ND smallint
	select @ND=count(dia) from planilla_pesca_tripulantes where codi_sema=@semana and codi_unid_oper=@embar 
		and codi_pers=@pers and MONTO>0 and nro_asis=@nasis AND NOT (MONTO IS NULL)
	Return @ND
END
GO
