CREATE FUNCTION [dbo].[F_DIAS_Subs](@sema [char](8), @embar [char](5), @pers [char](5))
RETURNS [numeric](2, 0) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @ND smallint
	select @ND=dias from subsidios where codi_pers=@pers and codi_unid_oper=@embar and codi_sema=@sema 
	Return @ND
END
GO
