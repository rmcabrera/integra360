CREATE FUNCTION [dbo].[F_Precio_SNP](@codi [char](8))
RETURNS [numeric](12, 3) WITH EXECUTE AS CALLER
AS 
BEGIN 
declare @str numeric(12,3)
select @str=precio from precio_snp where codi_sema=@codi 

return @str

END
GO
