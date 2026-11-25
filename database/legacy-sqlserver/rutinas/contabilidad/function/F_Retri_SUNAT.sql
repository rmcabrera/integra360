CREATE FUNCTION [dbo].[F_Retri_SUNAT](@cuen [char](7))
RETURNS [char](5) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @su char(5)
	select @su=CODI_SUNAT from SUNAT where nro_cuen=@cuen
	return @su
END


/*CREATE FUNCTION F_Retri_SUNAT(@or char(5), @tpd char(4) ,@sd char(1))
RETURNS char(7) AS  
BEGIN 
	Declare @su char(7)
	select @su=ctasunat from contabilizacion where origen=@or and tipod=@tpd and subdiario=@sd
	return @su
END*/
GO
