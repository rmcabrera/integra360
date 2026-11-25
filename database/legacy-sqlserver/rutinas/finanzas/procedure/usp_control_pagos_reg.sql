CREATE PROCEDURE [dbo].[usp_control_pagos_reg]
	@tipo [char](1),
	@fec1 [datetime],
	@fec2 [datetime],
	@codi_clie_prov [varchar](5)
WITH EXECUTE AS CALLER
AS
--declare @tipo as char(1), @fec1 smalldatetime, @fec2 smalldatetime, @codi_clie_prov varchar(5) 
--select @tipo ='F', @fec1 ='01/01/2017', @fec2 ='27/06/2017', @codi_clie_prov=1

set nocount on 

if @tipo='N'  --POR NÚMERO
begin
	select id_sec,
       fecha_reg, numero, documento, medio_pago, cuota,
	   codi_clie_prov, dbo.f_cliente_proveedor(codi_clie_prov) cliente,
	   concepto, codigo, fecha, codi_mone, 
	   (select simbolo from monedas m(nolock) where m.codi_mone=r.codi_mone) moneda,
	   importe,	comentario, fecha_pago,	observaciones, activo, condicion
	
	from registro_pagos r(nolock)
	where numero = cast(@codi_clie_prov as numeric(18))
end
else
if @tipo='C'
begin
	select id_sec,
       fecha_reg, numero, documento, medio_pago, cuota,
	   codi_clie_prov, dbo.f_cliente_proveedor(codi_clie_prov) cliente,
	   concepto, codigo, fecha, codi_mone, 
	   (select simbolo from monedas m(nolock) where m.codi_mone=r.codi_mone) moneda,
	   importe,	comentario, fecha_pago,	observaciones, activo, condicion
	
	from registro_pagos r(nolock)
	where codi_clie_prov = @codi_clie_prov
end 
else

-- ENTRE FECHAS
	select id_sec,
		fecha_reg, numero, documento, medio_pago, cuota,
		codi_clie_prov, dbo.f_cliente_proveedor(codi_clie_prov) cliente,
		concepto, codigo, fecha, codi_mone, 
		(select simbolo from monedas m(nolock) where m.codi_mone=r.codi_mone) moneda,
		importe, comentario, fecha_pago, observaciones, activo, condicion
	
	from registro_pagos r(nolock)
	where cast(convert(char(10),fecha_reg,103) as datetime) between @fec1 and @fec2
GO
