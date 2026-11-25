CREATE PROCEDURE [dbo].[usp_registro_guia_remision]
	@tipo [char](2),
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](8),
	@codi_clie_prov [varchar](5)
WITH EXECUTE AS CALLER
AS
--declare @tipo as char(1) , @codi_alma char(2)  , @fec1 datetime , @fec2 datetime , @nro_docu varchar(8) , @codi_clie_prov varchar(5) 
--select @tipo ='F', @codi_alma ='01', @fec1 ='20/04/2017', @fec2 ='31/12/2017', @nro_docu ='', @codi_clie_prov =''

set nocount on 

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

if @tipo='N'  --POR NRO DOCUMENTO
begin
	select  codi_guia, f.codi_alma, f.fech_tras, '0009', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,
		f.ser_guia, f.nro_guia, cp.denominacion, f.codi_mone, 
		isnull(round((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fech_tras),2),0) as tcambio, 
		f.total_venta, f.igv_venta, f.sub_total, isnull(f.estado,'0') estado,a.nemo_alma,
		--f.total_venta, f.igv_venta, f.prec_vent, isnull(f.estado,'0') estado, f.contabilizado, a.nemo_alma,
		cp.codi_clie_prov, (select desc_moti_tras from dbo.motivo_traslado M(nolock) where M.codi_moti_tras=F.codi_moti_tras) desc_moti_tras,
		(select nemo_alma from dbo.almacen A(nolock) where A.codi_alma=F.codi_alma_desti) punto_llegada, codi_fact,
		(select nemo from dbo.tipo_documento t(nolock) where T.codi_tipo_docu in
			(select codi_tipo_docu from dbo.factura x(nolock) where x.codi_fact=F.codi_fact)) nemo_docu,
		(select ser_fact + ' - ' + nro_fact from dbo.factura x(nolock) where x.codi_fact=F.codi_fact) nro_ser_fact,
		(select tipo_sali from dbo.docu_sali_mate M(nolock) where M.codi_docu_sali=F.codi_docu_sali) tipo_docu_sali,
		(select condicion from dbo.docu_sali_mate M(nolock) where M.codi_docu_sali=F.codi_docu_sali) condicion,apro_por,
		(select desc_trans from transportistas T(nolock) where T.codi_trans=codi_chof) chofer, observaciones
		
	from 	dbo.guia F (nolock) inner join dbo.Almacen A (nolock) on F.codi_guia = A.codi_alma
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_dest = cp.codi_clie_prov
	where 	F.codi_alma in (Select codi_alma from @alma) and cast(f.nro_guia as numeric) =@nro_docu
	order by f.codi_alma, f.ser_guia, f.nro_guia

end

else if @tipo='C'  -- POR CLIENTE
begin
	select  codi_guia, f.codi_alma, f.fech_tras, '0009', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,
		f.ser_guia, f.nro_guia, cp.denominacion, f.codi_mone, 
		isnull(round((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fech_tras),2),0) as tcambio, 
		f.total_venta, f.igv_venta, f.sub_total, isnull(f.estado,'0') estado, a.nemo_alma,
		--f.total_venta, f.igv_venta, f.prec_vent, isnull(f.estado,'0') estado, f.contabilizado, a.nemo_alma,
		cp.codi_clie_prov, (select desc_moti_tras from dbo.motivo_traslado M(nolock) where M.codi_moti_tras=F.codi_moti_tras) desc_moti_tras,
		(select nemo_alma from dbo.almacen A(nolock) where A.codi_alma=F.codi_alma_desti) punto_llegada, codi_fact, 
		(select nemo from dbo.tipo_documento t(nolock) where T.codi_tipo_docu in
			(select codi_tipo_docu from dbo.factura x(nolock) where x.codi_fact=F.codi_fact)) nemo_docu,
		(select ser_fact + ' - ' + nro_fact from dbo.factura x(nolock) where x.codi_fact=F.codi_fact) nro_ser_fact,
		(select tipo_sali from dbo.docu_sali_mate M(nolock) where M.codi_docu_sali=F.codi_docu_sali) tipo_docu_sali,
		(select condicion from dbo.docu_sali_mate M(nolock) where M.codi_docu_sali=F.codi_docu_sali) condicion,apro_por,
		(select desc_trans from transportistas T(nolock) where T.codi_trans=codi_chof) chofer, observaciones
		
	from 	dbo.guia F (nolock) inner join dbo.Almacen A (nolock) on F.codi_alma = A.codi_alma
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_dest = cp.codi_clie_prov
	where 	F.codi_alma in (Select codi_alma from @alma)
		and (convert(varchar(10), F.fech_tras , 103) between @fec1 and @fec2)
		and F.codi_clie_dest = @codi_clie_prov
	order by f.codi_alma, f.ser_guia, f.nro_guia

end

else if @tipo='P'  -- Provisionadas 
begin
	select  codi_guia, f.codi_alma, f.fech_tras, '0009', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,
		f.ser_guia, f.nro_guia, cp.denominacion, f.codi_mone, 
		isnull(round((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fech_tras),2),0) as tcambio, 
		f.total_venta, f.igv_venta, f.sub_total, isnull(f.estado,'0') estado, a.nemo_alma, cp.codi_clie_prov,
		--f.total_venta, f.igv_venta, /*f.prec_vent*/, isnull(f.estado,'0') estado, /*f.contabilizado*/, a.nemo_alma, cp.codi_clie_prov
		(select desc_moti_tras from dbo.motivo_traslado M(nolock) where M.codi_moti_tras=F.codi_moti_tras) desc_moti_tras, 
                (select nemo_alma from dbo.almacen A(nolock) where A.codi_alma=F.codi_alma_desti) punto_llegada, codi_fact,
		(select nemo from dbo.tipo_documento t(nolock) where T.codi_tipo_docu in
			(select codi_tipo_docu from dbo.factura x(nolock) where x.codi_fact=F.codi_fact)) nemo_docu,
		(select ser_fact + ' - ' + nro_fact from dbo.factura x(nolock) where x.codi_fact=F.codi_fact) nro_ser_fact,
		(select tipo_sali from dbo.docu_sali_mate M(nolock) where M.codi_docu_sali=F.codi_docu_sali) tipo_docu_sali,
		(select condicion from dbo.docu_sali_mate M(nolock) where M.codi_docu_sali=F.codi_docu_sali) condicion,apro_por,
		(select desc_trans from transportistas T(nolock) where T.codi_trans=codi_chof) chofer, observaciones
		
	from 	dbo.guia F (nolock) inner join dbo.Almacen A (nolock) on F.codi_alma = A.codi_alma
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_dest = cp.codi_clie_prov
	where 	F.codi_alma in (Select codi_alma from @alma)
		and (convert(varchar(10), F.fech_tras, 103) between @fec1 and @fec2)
		---and (F.contabilizado='0' or F.contabilizado is null)
	order by f.codi_alma, f.ser_guia, f.nro_guia

end

else
	---SOLO ENTRE FECHAS
	select  codi_guia, f.codi_alma, f.fech_tras, '0009', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,
		f.ser_guia, f.nro_guia, cp.denominacion, f.codi_mone, 
		isnull(round((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fech_tras),2),0) as tcambio, 
		f.total_venta, f.igv_venta, f.sub_total, isnull(f.estado,'0') estado, a.nemo_alma,
		--f.total_venta, f.igv_venta, /*f.prec_vent*/, isnull(f.estado,'0') estado, /*f.contabilizado*/, a.nemo_alma, cp.codi_clie_prov
		cp.codi_clie_prov, (select desc_moti_tras from dbo.motivo_traslado M(nolock) where M.codi_moti_tras=F.codi_moti_tras) desc_moti_tras,
		(select nemo_alma from dbo.almacen A(nolock) where A.codi_alma=F.codi_alma_desti) punto_llegada, F.codi_fact,
		(select nemo from dbo.tipo_documento t(nolock) where T.codi_tipo_docu in
			(select codi_tipo_docu from dbo.factura x(nolock) where x.codi_fact=F.codi_fact)) nemo_docu,
		(select ser_fact + ' - ' + nro_fact from dbo.factura x(nolock) where x.codi_fact=F.codi_fact) nro_ser_fact,
		(select tipo_sali from dbo.docu_sali_mate M(nolock) where M.codi_docu_sali=F.codi_docu_sali) tipo_docu_sali,
		(select condicion from dbo.docu_sali_mate M(nolock) where M.codi_docu_sali=F.codi_docu_sali) condicion,apro_por,
		(select desc_trans from transportistas T(nolock) where T.codi_trans=codi_chof) chofer, observaciones
		
	from 	dbo.guia F (nolock) inner join dbo.Almacen A (nolock) on F.codi_alma = A.codi_alma
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_dest = cp.codi_clie_prov
	where 	F.codi_alma in (Select codi_alma from @alma)
		and (convert(varchar(10), F.fech_tras, 103) between @fec1 and @fec2)
	order by f.codi_alma, f.ser_guia, f.nro_guia
GO
