CREATE FUNCTION [dbo].[F_Dias_trip](@Semana [char](8), @Embar [char](5), @pers [char](5))
RETURNS [smallint] WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @ND smallint
	select @ND=count(dia) from planilla_pesca_tripulantes where codi_sema=@semana and codi_unid_oper=@embar 
		and codi_pers=@pers and MONTO>0 aND NOT (MONTO IS NULL)
	Return @ND
END
GO
