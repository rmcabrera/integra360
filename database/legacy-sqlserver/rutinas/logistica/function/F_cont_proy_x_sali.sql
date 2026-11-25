CREATE FUNCTION [dbo].[F_cont_proy_x_sali](@codi_docu_sali [char](10))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @cont_proy as integer
	Select @cont_proy = isnull( count(codi_proy) , 0 ) From Sali_mate_x_proy where codi_docu_sali = @codi_docu_sali;
	
	return @cont_proy
END
GO
