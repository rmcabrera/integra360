CREATE FUNCTION [dbo].[f_precio_pesca](@codi [char](8), @cod2 [char](5))
RETURNS [numeric](12, 3) WITH EXECUTE AS CALLER
AS 
BEGIN 
declare @str numeric(12,3)
declare @str_2 numeric(12,3)

select DISTINCT @str=prec_snp from planilla_pesca_tripulantes  where codi_sema=@codi  and  codi_unid_oper=@cod2
select DISTINCT @str_2=refri from planilla_pesca_tripulantes  where codi_sema=@codi  and  codi_unid_oper=@cod2

if @str_2  > 1 set  @str=@str*@str_2
	
return @str
END
GO
