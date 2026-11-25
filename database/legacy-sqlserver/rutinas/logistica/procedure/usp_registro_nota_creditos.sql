CREATE PROCEDURE [dbo].[usp_registro_nota_creditos]
	@tipo [char](1),
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](8),
	@codi_clie_prov [varchar](5)
WITH EXECUTE AS CALLER
AS
--declare @tipo as char(1) , @codi_alma char(2)  , @fec1 datetime , @fec2 datetime , @nro_docu varchar(8) , @codi_clie_prov varchar(5) 
--select @tipo ='F', @codi_alma ='01', @fec1 ='01/01/2009', @fec2 ='31/12/2009', @nro_docu ='', @codi_clie_prov =''

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
	select codi_nota_cred, f.codi_alma, f.fech_nota_cred, '0007', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0007' ) as docum,
		f.ser_nota_cred, f.nro_nota_cred, cp.denominacion, f.codi_mone, 
		isnull((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fech_nota_cred),0), 
		f.valo_vent, f.igv, f.prec_vent,isnull(f.estado,'0') estado,  f.contabilizado, a.nemo_alma,
		cp.codi_clie_prov
	from 	dbo.nota_credito F (nolock) inner join dbo.Almacen A (nolock) on F.codi_alma=A.codi_alma
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_prov=cp.codi_clie_prov
	where 	F.codi_alma in (Select codi_alma from @alma)
		and  cast(f.nro_nota_cred as numeric) =@nro_docu
	order by f.codi_alma, f.ser_nota_cred, f.nro_nota_cred

end

else if @tipo='C'  -- POR CLIENTE
begin
	select codi_nota_cred, f.codi_alma, f.fech_nota_cred, '0007', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0007' ) as docum,
		f.ser_nota_cred, f.nro_nota_cred, cp.denominacion, f.codi_mone, 
		isnull((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fech_nota_cred),0), 
		f.valo_vent, f.igv, f.prec_vent, isnull(f.estado,'0') estado, f.contabilizado, a.nemo_alma,
		cp.codi_clie_prov
	from 	dbo.nota_credito F (nolock) inner join dbo.Almacen A (nolock) on F.codi_alma=A.codi_alma
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_prov=cp.codi_clie_prov
	where 	F.codi_alma in (Select codi_alma from @alma)
		and (convert(varchar(10), F.fech_nota_cred , 103) between @fec1 and @fec2)
			and F.codi_clie_prov = @codi_clie_prov
	order by f.codi_alma, f.ser_nota_cred, f.nro_nota_cred

end

else if @tipo='P'  -- Provisionadas 
begin
	select codi_nota_cred, f.codi_alma, f.fech_nota_cred, '0007', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0007' ) as docum,
		f.ser_nota_cred, f.nro_nota_cred, cp.denominacion, f.codi_mone, 
		isnull((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fech_nota_cred),0), 
		f.valo_vent, f.igv, f.prec_vent, isnull(f.estado,'0') estado, f.contabilizado, a.nemo_alma,cp.codi_clie_prov
	from 	dbo.nota_credito F (nolock) inner join dbo.Almacen A (nolock) on F.codi_alma=A.codi_alma
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_prov=cp.codi_clie_prov
	where 	F.codi_alma in (Select codi_alma from @alma)
		and (convert(varchar(10), F.fech_nota_cred , 103) between @fec1 and @fec2)
			and (F.contabilizado='0' or F.contabilizado is null)
	order by f.codi_alma, f.ser_nota_cred, f.nro_nota_cred

end

else
	---SOLO ENTRE FECHAS
	select codi_nota_cred, f.codi_alma, f.fech_nota_cred, '0007', 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0007' ) as docum,
		f.ser_nota_cred, f.nro_nota_cred, cp.denominacion, f.codi_mone, 
		isnull((select venta from tipo_cambio_a_dolar C (nolock) where c.fech_camb = f.fech_nota_cred),0) tpc, 
		f.valo_vent, f.igv, f.prec_vent, isnull(f.estado,'0') estado,  f.contabilizado, a.nemo_alma,
		cp.codi_clie_prov
	from 	dbo.nota_credito F (nolock) inner join dbo.Almacen A (nolock) on F.codi_alma=A.codi_alma
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_prov=cp.codi_clie_prov
	where 	F.codi_alma in (Select codi_alma from @alma)
		and (convert(varchar(10), F.fech_nota_cred , 103) between @fec1 and @fec2)
	order by f.codi_alma, f.ser_nota_cred, f.nro_nota_cred
GO
