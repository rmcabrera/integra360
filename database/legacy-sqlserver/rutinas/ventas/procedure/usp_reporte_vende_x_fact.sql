CREATE PROCEDURE [dbo].[usp_reporte_vende_x_fact]
	@fec1 [datetime],
	@fec2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime , @fec2 datetime, @alma char(2)
--select @fec1 ='01/06/2016' , @fec2='10/06/2016' , @alma ='18'

set nocount on
set QUOTED_IDENTIFIER OFF

declare @SQLSTRING nvarchar(4000)
declare @Condi varchar(100)
declare @ParmString nvarchar(100)

set @ParmString = "@fec1 as datetime, @fec2 as datetime "
if @alma ='' or @alma is null set @Condi='' else set @Condi=" and F.codi_alma =" +@alma

set @SQLString ="

		select upper((select apel_1 + isnull(' ' +apel_2, '') + isnull(' ' +nomb_1,'') + isnull(' ' +nomb_2,'')
			from usuarios U (nolock)  where U.codi_usua=f.cod_usua_vende)) Vendedor,
			(select desc_tipo_docu from tipo_documento T (nolock) where T.codi_tipo_docu=f.codi_tipo_docu) Documento, 
			max(ser_fact) ser_fact, max(nro_fact) nro_fact, 
			max(F.codi_clie_prov) codi_clie_prov, (select case when razo_soci is null or rtrim(razo_soci)='' then denominacion
				else razo_soci end from cliente_proveedor C (nolock) where C.codi_clie_prov=max(F.codi_clie_prov) ) Cliente,
			F.codi_tipo_docu, 
			max(tota_fact) tota_fact, f.cod_usua_vende, max(F.codi_mone) codi_mone,
			--sum(cant_item * prec_costo) tota_costo
			SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when codi_imp=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end))) tota_costo					
			--SUM(D.CANT_ITEM *(D.PREC_ITEM * (CASE WHEN factura.codi_mone='01' THEN 1 ELSE factura.tcambio END))) venta,			
		from factura F (nolock) 
		join factura_detalle D (nolock)
		on F.codi_fact = D.codi_fact
		where cast(convert(char(10),fech_fact,103) as smalldatetime) between @fec1 and @fec2 and isnull(F.estado,'')<> 'A'  " +@Condi + 
	" 
	group by cod_usua_vende, codi_tipo_docu, ser_fact, nro_fact
	order by 1,2,3,4"

execute sp_executesql @SQLString, @ParmString, @fec1=@fec1, @fec2=@fec2
GO
