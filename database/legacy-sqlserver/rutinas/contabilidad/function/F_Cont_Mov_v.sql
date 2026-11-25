CREATE FUNCTION [dbo].[F_Cont_Mov_v](@sd [char](1), @cuenta [char](7), @otros [decimal](9, 3))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt int
	if left( @cuenta ,1) = '1'  begin set @rt = 1 end
	if left( @cuenta ,2) = '40'  begin set @rt = 2 end
	if left( @cuenta ,1) = '7'    begin set @rt = 3 end
	if @cuenta=(select cuenta from cuentas_provision where codigo='22') or isnull(@otros,0)<>0  begin set @rt = 4 end
	return @rt
END
GO
