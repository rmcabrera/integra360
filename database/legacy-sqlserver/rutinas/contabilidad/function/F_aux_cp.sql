CREATE FUNCTION [dbo].[F_aux_cp](@reg [char](10))
RETURNS [varchar](5) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt varchar(5)
	select @rt=codi_clie_prov from movi_contables where subdia='C' and registro =@reg and cargo_abono='A' and nro_cuen='4210000'
	return @rt
END
GO
