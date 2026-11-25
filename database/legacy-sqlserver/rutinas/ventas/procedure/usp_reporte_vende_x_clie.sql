CREATE PROCEDURE [dbo].[usp_reporte_vende_x_clie]
	@fec1 [datetime],
	@fec2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime , @fec2 datetime, @alma char(2)
--select @fec1 ='01/06/2018' , @fec2='10/06/2018', @alma ='04'

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
			codi_Clie_prov,
			(select case when razo_soci is null or rtrim(razo_soci)='' then denominacion
				else razo_soci end from cliente_proveedor C (nolock) where C.codi_clie_prov=F.codi_clie_prov)  Cliente,
			sum(tota_fact) tota_fact, f.cod_usua_vende,
			--SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when codi_imp=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end))) tota_costo	,
			codi_mone
		from factura F (nolock) 
		where cast(convert(char(10),fech_fact,103) as smalldatetime) between @fec1 and @fec2 and isnull(F.estado,'')<> 'A'  " +@Condi + 
	" 
	group by cod_usua_vende, codi_clie_prov, codi_mone
	order by 1,2,3,4"

execute sp_executesql @SQLString, @ParmString, @fec1=@fec1, @fec2=@fec2
GO
