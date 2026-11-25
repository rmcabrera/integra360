CREATE FUNCTION [dbo].[F_Dias_traba_Moto](@mesa [char](8), @embar [char](5), @pers [char](5), @tip [char](1))
RETURNS [smallint] WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @ND smallint
	if (@tip='Q')  select @ND=dias_traba_quin from asistencia_motorista where codi_pers=@pers and codi_unid_oper=@embar and mesanio=@mesa 
	if (@tip='M')  select @ND=dias_traba_mens from asistencia_motorista where codi_pers=@pers and codi_unid_oper=@embar and mesanio=@mesa 
	Return @ND
END
GO
