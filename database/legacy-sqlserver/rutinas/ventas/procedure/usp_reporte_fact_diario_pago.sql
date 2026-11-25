CREATE PROCEDURE [dbo].[usp_reporte_fact_diario_pago]
	@alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @alma char(2), @fec1 datetime, @fec2 datetime
--select @alma='04', @fec1='01/06/2019', @fec2='15/06/2019'
 
set nocount on

select dia, sum(efec) as efec, sum(cred) as cred
from(
select cast(convert(char(10),fech_fact,103) as datetime) as dia, 
       case when codi_tipo_pago=1 then tota_fact else 0 end efec, 
       case when codi_tipo_pago=4 then tota_fact else 0 end cred
       --codi_tipo_pago
       
from factura (nolock)
where cast(convert(char(10),fech_fact,103) as datetime) between @fec1 and @fec2
and (isnull(@alma,'')='' or codi_alma=@alma) and isnull(estado,'')<>'A') as SQL

group by dia--, codi_tipo_pago

order by 1 asc
GO
