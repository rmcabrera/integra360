CREATE FUNCTION [dbo].[F_Fech_Venc](@regist [char](8))
RETURNS [datetime] WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @fv datetime
	select @fv=Max(fecha_venc) from movi_contables where registro=@regist;
	return @fv
END
GO
