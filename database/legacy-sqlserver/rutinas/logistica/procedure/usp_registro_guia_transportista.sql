CREATE PROCEDURE [dbo].[usp_registro_guia_transportista]
	@tipo [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](8),
	@codi_clie_prov [varchar](5)
WITH EXECUTE AS CALLER
AS
--declare @tipo as char(1) ,/* @codi_alma char(2) */  @fec1 datetime , @fec2 datetime , @nro_docu varchar(8) , @codi_clie_prov varchar(5) 
--select @tipo ='F', /*@codi_alma ='01',*/ @fec1 ='01/01/2009', @fec2 ='31/12/2009', @nro_docu ='', @codi_clie_prov =''

set nocount on 
/*
declare @alma table (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen
END
ELSE
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock) where codi_alma = @codi_alma
END
*/
if @tipo='N'  --POR NRO DOCUMENTO
begin
	select  id_guia/* f.codi_alma*/, f.fecha, '0009', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,
		f.serie, f.numero,cp.denominacion, 
		(select denominacion from cliente_proveedor c (nolock) where c.codi_clie_prov= f.codi_clie_dest) dest --f.codi_mone, 
		--isnull(round((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fecha),2),0) as tcambio, 
		--f.total_venta, f.igv_venta, f.sub_total, isnull(f.estado,'0') estado,a.nemo_alma,
		--f.total_venta, f.igv_venta, f.prec_vent, isnull(f.estado,'0') estado, f.contabilizado, a.nemo_alma,
		
	from 	dbo.guia_transportista F (nolock)-- inner join dbo.Almacen A (nolock) on F.id_guia = A.codi_alma
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_remi = cp.codi_clie_prov
	where 	/*F.codi_alma in (Select codi_alma from @alma) and*/ cast(f.numero as numeric) =@nro_docu
	order by /* f.codi_alma*/ f.serie, f.numero

end

else if @tipo='C'  -- POR CLIENTE
begin
	select  id_guia,/* f.codi_alma*/ f.fecha, '0009', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,
		f.serie, f.numero,cp.denominacion,
		(select denominacion from cliente_proveedor c (nolock) where c.codi_clie_prov= f.codi_clie_dest) dest  --f.codi_mone, 
		--isnull(round((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fecha),2),0) as tcambio, 
		--f.total_venta, f.igv_venta, f.sub_total, isnull(f.estado,'0') estado, a.nemo_alma,
		--f.total_venta, f.igv_venta, f.prec_vent, isnull(f.estado,'0') estado, f.contabilizado, a.nemo_alma,
		
	from 	dbo.guia_transportista F (nolock)-- inner join dbo.Almacen A (nolock) on F.id_guia = A.codi_alma
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_remi = cp.codi_clie_prov
	where 	/*F.codi_alma in (Select codi_alma from @alma)and */
		 (convert(varchar(10), F.fecha, 103) between @fec1 and @fec2)
		--and F.codi_clie_dest = @codi_clie_prov
	order by /* f.codi_alma*/ f.serie, f.numero

end

else if @tipo='P'  -- Provisionadas 
begin
	select  id_guia,/* f.codi_alma*/ f.fecha, '0009', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,
		f.serie, f.numero,cp.denominacion,
		(select denominacion from cliente_proveedor c (nolock) where c.codi_clie_prov= f.codi_clie_dest) dest  --f.codi_mone, 
		--isnull(round((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fecha),2),0) as tcambio, 
		--f.total_venta, f.igv_venta, f.sub_total, isnull(f.estado,'0') estado, a.nemo_alma,
		
		--f.total_venta, f.igv_venta, /*f.prec_vent*/, isnull(f.estado,'0') estado, /*f.contabilizado*/, a.nemo_alma, cp.codi_clie_prov
	from 	dbo.guia_transportista F (nolock) /*inner join dbo.Almacen A (nolock) on F.codi_alma = A.codi_alma*/
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_remi = cp.codi_clie_prov
	where 	/*F.codi_alma in (Select codi_alma from @alma)AND*/
		 (convert(varchar(10), F.fecha, 103) between @fec1 and @fec2)
		---and (F.contabilizado='0' or F.contabilizado is null)
	order by /* f.codi_alma*/f.serie, f.numero

end

else
	---SOLO ENTRE FECHAS
	select  id_guia,/* f.codi_alma*/ f.fecha, '0009', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,
		f.serie, f.numero,cp.denominacion,
                (select denominacion from cliente_proveedor c (nolock) where c.codi_clie_prov= f.codi_clie_dest) dest  --f.codi_mone, 
		--isnull(round((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fecha),2),0) as tcambio, 
		--f.total_venta, f.igv_venta, f.sub_total, isnull(f.estado,'0') estado, a.nemo_alma,
		--f.total_venta, f.igv_venta, /*f.prec_vent*/, isnull(f.estado,'0') estado, /*f.contabilizado*/, a.nemo_alma, cp.codi_clie_prov
		
	from 	dbo.guia_transportista F --(nolock) inner join dbo.Almacen A (nolock) on F.codi_alma = A.codi_alma
		inner join dbo.cliente_proveedor cp (nolock) on  f.codi_clie_remi = cp.codi_clie_prov
	where 	--F.codi_alma in (Select codi_alma from @alma) AND 
		 (convert(varchar(10), F.fecha, 103) between @fec1 and @fec2)
	order by /* f.codi_alma*/ f.serie, f.numero
GO
