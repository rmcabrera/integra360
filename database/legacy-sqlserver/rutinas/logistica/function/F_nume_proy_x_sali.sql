CREATE FUNCTION [dbo].[F_nume_proy_x_sali](@codi_docu_sali [char](10))
RETURNS [char](20) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @cont_proy as integer
	declare @codi_proy as char(20)

	Select @codi_proy = isnull( codi_proy  , '' ) From Sali_mate_x_proy where codi_docu_sali = @codi_docu_sali;
	
	return @codi_proy
END
GO
