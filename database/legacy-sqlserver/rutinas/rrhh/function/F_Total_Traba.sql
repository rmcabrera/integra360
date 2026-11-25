CREATE FUNCTION [dbo].[F_Total_Traba](@diap [datetime], @EMBAR [char](5))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @rt int
	select @rt=count(pesc_real) from planilla_pesca_tripulantes where convert( char(10),dia,103)=convert(char(10) , @diap, 103) and monto>0
		and codi_unid_oper=@embar
	Return @rt
END
GO
