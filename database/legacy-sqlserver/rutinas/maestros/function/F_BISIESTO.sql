CREATE FUNCTION [dbo].[F_BISIESTO](@ANIO [int])
RETURNS [char](1) WITH EXECUTE AS CALLER
AS 
BEGIN 

declare  @lb_Bis char(1)

If  @Anio % 100 = 0  

BEGIN
	If @Anio % 400 = 0 
		BEGIN
			SET @lb_Bis = 1
		END
	Else
		BEGIN
			SET @lb_Bis = 0  
		END
	
END

Else

BEGIN
   If @Anio % 4 = 0 
	  BEGIN
		SET @lb_Bis = 1
	  END
	Else
	BEGIN
		SET @lb_Bis = 0
END
end

Return  @lb_Bis

end
GO
