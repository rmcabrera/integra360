CREATE FUNCTION [dbo].[F_VALOR_PARTES](@pers [char](5), @embar [char](5), @sema [char](8), @di [varchar](10))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @r numeric(12,2)
	declare @n numeric(12,2)	
	declare @a numeric(12,2)	
	declare @m numeric(12,2)	
	declare @s numeric(12,2)	
	declare @p numeric(12,2)	
	select @n =parte ,@a =adicional  ,@m=monto from planilla_pesca_tripulantes where codi_sema=@sema and codi_unid_oper=@embar and codi_pers=@pers and upper(nom_dia)=upper(@di)
	and pesc_real>0 and not (pesc_real is null)
	if (@n is null) set @n=0
	if (@a is null) set @a=0
	set @s=@n/* + @a*/
	set @p=0
	if (@s<>0 and not( @s is null)) set @p=@m/@s
	return @p
END
GO
