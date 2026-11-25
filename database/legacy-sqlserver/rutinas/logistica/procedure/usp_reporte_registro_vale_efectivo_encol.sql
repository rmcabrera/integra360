CREATE PROCEDURE [dbo].[usp_reporte_registro_vale_efectivo_encol]
	@fec1 [datetime],
	@fec2 [datetime],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime, @fec2 datetime ,@codi_alma char(2)
--select @fec1='24/06/2013', @fec2='24/06/2013',@codi_alma='01'
	select 1 tipo, max(suc)as suc, max(razo_soci)as razo_soci,max(glosa)as glosa,max(fecha)as fecha,
		sum(importe)as importe,sum(importe_d)as importe_d, cast(count(nro_vale) as varchar(10)) +' Docs'as nro_vale ,
		max(codi_clie_prov) as codi_clie_prov,max(codi_alma)as codi_alma, max(CODI_MONE)as CODI_MONE, max(creacion)as creacion, max(codi_usua) as codi_usua
	from (
	select 
	(select nemo_alma from dbo.almacen (nolock) where almacen.codi_alma=r.codi_alma)suc,
	'CLIENTES VARIOS'razo_soci,'VENTAS DEL PERIODO'glosa,
	r.fecha as fecha, 
	(case when codi_mone='01' then TOTA_FACT else 0 end) importe,
	(case when codi_mone='02' then TOTA_FACT else 0 end) importe_d,nro_vale,codi_clie_prov, codi_alma, CODI_MONE, creacion, codi_usua
	
	from registro_vale r(nolock)
	where (r.fecha>=@fec1 and r.fecha<DateAdd(day,1,@fec2)) and r.codi_alma=@codi_alma and r.codi_tipo_pago=1 )sql--)sql
	group by nro_vale
GO
