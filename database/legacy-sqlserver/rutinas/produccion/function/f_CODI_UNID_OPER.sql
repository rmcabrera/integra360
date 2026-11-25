CREATE FUNCTION [dbo].[f_CODI_UNID_OPER](@codi_ingr [numeric](18, 0), @codi_alma [char](20))
RETURNS [char](5) WITH EXECUTE AS CALLER
AS 
BEGIN 
	
     declare @codi_unid_oper as varchar(5)
	Select @codi_unid_oper = codi_unid_oper_prod 
                From Nota_ingreso_Aceite 
	Where codi_ingr= @codi_ingr and codi_alma = @codi_alma
	
	return @codi_unid_oper 
END
GO
