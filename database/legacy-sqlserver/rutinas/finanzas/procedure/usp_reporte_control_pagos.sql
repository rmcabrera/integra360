CREATE PROCEDURE [dbo].[usp_reporte_control_pagos]
	@fec1 [datetime],
	@fec2 [datetime],
	@tipo [char](1)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime, @fec2 datetime
--select @fec1 ='01/01/2017', @fec2 ='27/06/2017'

set nocount on 

select id_sec,
	fecha_reg, numero, documento, medio_pago, cuota,
	codi_clie_prov, dbo.f_cliente_proveedor(codi_clie_prov) cliente,
	concepto, codigo, fecha, codi_mone, 
	(select simbolo from monedas m(nolock) where m.codi_mone=r.codi_mone) moneda,
	importe, comentario, fecha_pago, observaciones, activo, condicion

from registro_pagos r(nolock)
where cast(convert(char(10),fecha_reg,103) as datetime) between @fec1 and @fec2
GO
