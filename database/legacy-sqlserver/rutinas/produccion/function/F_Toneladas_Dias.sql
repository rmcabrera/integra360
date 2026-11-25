CREATE FUNCTION [dbo].[F_Toneladas_Dias](@dia [datetime], @embarca [char](5), @per [char](5))
RETURNS [numeric](12, 3) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @rt numeric(12,3)
--	select @rt=sum(pesc_real) from zarpes where convert( char(10),fech_repo,103)=convert(char(10) , @dia, 103) and codi_unid_oper=@embarca
	select @rt=pesc_real from planilla_pesca_tripulantes where convert( char(10),dia,103)=convert(char(10) , @dia, 103)  and codi_pers=@per 
			and monto>0  and codi_unid_oper=@embarca
	Return @rt
END
GO
