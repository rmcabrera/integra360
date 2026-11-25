CREATE PROCEDURE [dbo].[usp_reporte_vende_x_fact_resu_turno]
	@fec1 [datetime],
	@fec2 [datetime],
	@alma [char](2),
	@vende [char](5)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime , @fec2 datetime, @alma char(2), @vende char(5)
--select @fec1 ='01/01/2020' , @fec2='30/01/2020' , @alma ='19', @vende=''

set nocount on
set QUOTED_IDENTIFIER OFF

declare @SQLSTRING nvarchar(4000)
declare @Condi varchar(100)
declare @ParmString nvarchar(100)

declare @Tx table(vendedor varchar(150) null, documento varchar(50) null, ser_fact varchar(20) null, nro_fact varchar(20) null,
				  codi_clie_prov char(5) null, cliente varchar(150) null, codi_tipo_docu char(5) null, tota_fact decimal(12,3) null,
				  cod_usua_vende char(5) null, codi_mone char(2) null, tota_costo numeric(12,3) null, cod_lin char(2) null, turno int null)

set @ParmString = "@fec1 as datetime, @fec2 as datetime "
if @alma ='' or @alma is null set @Condi='' else set @Condi=" and F.codi_alma =" +@alma

set @SQLString ="select (select apel_1 + isnull(' ' +apel_2, '') + isnull(' ' +nomb_1,'') + isnull(' ' +nomb_2,'')
			from usuarios U (nolock)  where U.codi_usua=f.cod_usua_vende) Vendedor,
		(select desc_tipo_docu from tipo_documento T (nolock) where T.codi_tipo_docu=f.codi_tipo_docu) Documento, 
		ser_fact ser_fact, nro_fact nro_fact, 
		F.codi_clie_prov codi_clie_prov, (select case when razo_soci is null or rtrim(razo_soci)='' then denominacion
			else razo_soci end from cliente_proveedor C (nolock) where C.codi_clie_prov=F.codi_clie_prov) Cliente,
		F.codi_tipo_docu, 
		
		cant_item * prec_item tota_fact, f.cod_usua_vende, F.codi_mone codi_mone,
		
		D.CANT_ITEM* (D.PREC_COSTO * (case when codi_imp=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end))
		/ case when codi_mone='01' then 1 else tcambio end as tota_costo, 
		
		(select cod_lin_pro from familia_producto FP (nolock) where FP.codi_fami_prod in 
			(select codi_fami_prod from sub_familia_producto S(nolock) where S.codi_sub_fami_prod in
				(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=D.codi_prod))) as cod_lin,				
		case when convert(char(8),creacion,108)>='06:00:00' and convert(char(8),creacion,108)<='15:00:00' then 1 else 2 end turno
				
	from factura F (nolock) 
	join factura_detalle D (nolock)
	on F.codi_fact = D.codi_fact
	where cast(convert(char(10),fech_fact,103) as smalldatetime) between @fec1 and @fec2 and isnull(F.estado,'')<> 'A'  " +@Condi 
	

insert @Tx
execute sp_executesql @SQLString, @ParmString, @fec1=@fec1, @fec2=@fec2

select upper(max(vendedor)) vendedor, max(documento) documento, max(ser_fact) ser_fact, 
	   max(nro_fact) nro_fact, max(codi_clie_prov) codi_clie_prov, max(cliente) cliente, 
	   max(codi_tipo_docu) codi_tipo_docu, sum(tota_fact) tota_fact, cod_usua_vende, 
	   (codi_mone) codi_mone, sum(tota_costo) tota_costo, cod_lin,
	   (select des_lin_pro from linea_familia_pro P(nolock) where P.cod_lin_pro=cod_lin) linea, turno
from @Tx
where (cod_usua_vende=@vende or (@vende='' or @vende is null) )
group by cod_usua_vende, cod_lin, codi_mone, turno
order by turno, vendedor, linea
GO
