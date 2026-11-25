CREATE FUNCTION [dbo].[F_SALDO_MES](@anio [char](4), @ms [char](2), @prod [char](8), @alma [char](2))
RETURNS [decimal](10, 4) WITH EXECUTE AS CALLER
AS 
BEGIN 
--	declare @anio char(4), @ms char(2), @prod char(8), @alma char(2)
--	select @anio='2014', @ms='01', @prod='00080427' , @alma='02'

	declare @SALDO decimal(10,4)
	declare @almacen table (alm char(2))

	if @alma<>'00'
		insert @almacen
		select @alma
	else
		insert @almacen
		select codi_alma from almacen (nolock)

	select @SALDO = isnull(sum(sum_ant),0)
	from
	(
	select isnull(sum(cant_ingr - cant_sali),0) as sum_ant 
	from kardex (nolock)
	where periodo=@anio and month(fech_tran)<@ms and codi_prod=@prod and codi_alma in (select alm from @almacen)
		
	union all
	
	select isnull(sum(cant_ingr - cant_sali),0) as sum_mes 
	from kardex (nolock)
	where periodo=@anio and month(fech_tran)=@ms and codi_prod=@prod and codi_alma in (select alm from @almacen)
	) as SQL
	if @SALDO is null begin set @SALDO=0 end

	return @SALDO
--	select @SALDO
END
GO
