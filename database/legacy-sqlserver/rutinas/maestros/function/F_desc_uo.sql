CREATE FUNCTION [dbo].[F_desc_uo](@CODI_unid_oper [char](5))
RETURNS [varchar](200) WITH EXECUTE AS CALLER
AS 
BEGIN 
	DECLARE @RT VARCHAR(200)
	DECLARE @V VARCHAR(200)
	DECLARE @TP VARCHAR(200)
	
	SET @RT = (SELECT ISNULL( Desc_unid_oper ,'') FROM unid_oper WHERE CODI_unid_oper = @CODI_unid_oper ) 
	

	RETURN @RT
END
GO
