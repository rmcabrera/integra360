CREATE FUNCTION [dbo].[F_cuenta_IGV](@rg [char](7), @ms [char](2), @an [char](4), @sub [char](1))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt  numeric(12,2)
	declare @ct char(7)
	select @ct=cuenta from cuentas_provision where codigo='01'
	select @rt=sum(case when nro_cuen=@ct then case when codi_tipo_docu='0007' then -1*importe else importe end  else 0 end) 
		from movi_contables where  subdia=@sub and mes=@ms and anio=@an and nro_cuen = @ct and
		codi_vouc in (select distinct codi_vouc  from movi_contables where nro_cuen=@rg and subdia=@sub and mes=@ms and anio=@an)
	if (@rt is null) set @rt=0
	return @rt
END
GO
