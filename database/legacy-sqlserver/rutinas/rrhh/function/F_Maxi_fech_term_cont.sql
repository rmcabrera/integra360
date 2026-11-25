CREATE FUNCTION [dbo].[F_Maxi_fech_term_cont](@codi_pers [char](5))
RETURNS [datetime] WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @fech_maxi datetime
	Select @fech_maxi = isnull( Max( fech_fin_cont ) , cast('01/01/1900' as datetime) ) From Contratos_personal where codi_pers = @codi_pers


	return @fech_maxi
END
GO
