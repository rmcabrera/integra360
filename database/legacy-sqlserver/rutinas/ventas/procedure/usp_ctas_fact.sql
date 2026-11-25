CREATE PROCEDURE [dbo].[usp_ctas_fact]
	@codi [char](10)
WITH EXECUTE AS CALLER
AS
--declare @codi char(10)
--select @codi='0000000002'

set nocount on
declare @clie char(5), @fec datetime , @ser varchar(5), @nro varchar(20)
declare @ani char(4), @ms char(2)

select @clie = codi_clie_prov, @fec= fech_fact, @ser = ser_fact, @nro = nro_Fact 
	from factura (nolock) where codi_fact=@codi

set @ani = cast(year(@fec) as char(4))
set @ms =  right('0'+rtrim(cast( month(@fec) as varchar(2))),2)


select nro_cuen from movi_contables (nolock) 
where anio=@ani and mes=@ms and subdia='V' and codi_clie_prov=@clie 
	and codi_tipo_docu='0001'
	and serie=@ser and rtrim(nro_docu)=@nro
GO
