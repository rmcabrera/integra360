CREATE PROCEDURE [dbo].[usp_reporte_fact_diario]
	@alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @alma char(2), @fec1 datetime, @fec2 datetime
--select @alma='', @fec1='01/06/2019', @fec2='02/06/2019'
 
set nocount on

select dia, 
	   (select desc_tipo_medio_pago from tipo_pago T(nolock) where T.codi_tipo_medio_pago=codi_tipo_pago) as tipo_pago,
	   sum(tota_fact) as total
from(
select cast(convert(char(10),fech_fact,103) as datetime) as dia, 
        codi_tipo_pago, tota_fact
from factura (nolock)
where cast(convert(char(10),fech_fact,103) as datetime) between @fec1 and @fec2
and (isnull(@alma,'')='' or codi_alma=@alma) and isnull(estado,'')<>'A') as SQL

group by dia, codi_tipo_pago
order by 1 asc, 2 desc
GO
