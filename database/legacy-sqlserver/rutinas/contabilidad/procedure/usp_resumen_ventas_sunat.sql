CREATE PROCEDURE [dbo].[usp_resumen_ventas_sunat]
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime , @f2 datetime
--select  @f1 ='01/03/2017', @f2 ='10/03/2017'

set quoted_identifier off
set nocount on 

declare @SQLString nvarchar(4000), @cond varchar(100)

create table #tx ( compr varchar(10) null, fecha datetime null, fecha_venc datetime null,
			docu char(4) null, serie varchar(5) null,
			nro_docu varchar(20) null, codi_clie_prov char(5) null, 
			vfexp numeric(12,2) null, base_impo numeric(12,2) null, exo numeric(12,2) null,
			inafecta numeric(12,2) null, isc numeric(12,2) null, igv numeric(12,2) null, otros numeric(12,2) null,
			total numeric(12,2) null, tpc numeric(12,4) null, fecha_nd_nc datetime null,
			tipo_docu_nd_nc char(4) null, serie_nd_nc varchar(6) null, nro_docu_nd_nc varchar(20) null,
			dolar numeric(12,2) null)

set @cond=""

set @SQLSTring ="SELECT compr,
			max(fecha) fecha, 
			max(fecha_venc) fecha_venc,
			--right(max(codi_Tipo_docu),2) Docu,
			max(codi_tipo_docu)Docu,
			max(serie) serie,
			max(nro_docu) nro_docu,
			max(codi_clie_prov) codi_clie_prov,
		
			sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
						 and left(nro_cuen,2)<>'40' and isnull(tipo_venta ,'1')='E'
		                        then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  vfexp,

			sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							and left(nro_cuen,2)<>'40'/* and isnull(tipo_venta,'1') not in ('E','4','5','6')*/
							and not(nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta,'1')='4')
		                        then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  BASE_IMPO,

			sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							 and left(nro_cuen,2)<>'40' /*and isnull(tipo_venta,'1') ='5'*/
							and (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4')
		                        then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  EXO,

			0.00 INAFECTA, 
			0.0 AS ISC,
			sum(case when left(nro_cuen,2)='40' then  importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  igv,
			0.0 as OTROS,
			sum(case when left(nro_cuen,2) in ('12','13','14','16') and not 
						left(nro_Cuen,4) in ('1311') then  importe*case when cargo_abono='C' then 1 else -1 end  else 0 end)  total,
			max(tipo_cambio) tpc,
			max(FECHA_ND_NC) fecha_nd_nc, RIGHT(max(TIPO_DOCU_ND_NC),2) tipo_docu_nd_nc, 
			max(SERIE_ND_NC) serie_nd_nc, max(NRO_DOCU_ND_NC) nro_docu_nd_nc,
			sum(case when left(nro_cuen,2) in ('12','13','14','16') and not 
						left(nro_Cuen,4) in ('1311') then  importe_d*case when cargo_abono='C' then 1 else -1 end  else 0 end) dolar
		FROM Movi_Contables M(nolock)
		where subdia='V'  and isnumeric(serie)=1 and 
					cast(convert(char(10),fecha,103) as datetime) between cast('"+convert(char(10),@f1,103) +"' as datetime) and 
			cast('"+convert(char(10),@f2,103)+"' as datetime)  
		group by codi_tipo_docu,serie, compr
		order by cast(compr as int)"
		
insert #TX (compr , fecha , fecha_venc ,docu , serie ,	nro_docu , codi_clie_prov , 
		vfexp , base_impo , exo , inafecta , isc , igv , otros ,total , tpc , fecha_nd_nc ,
		tipo_docu_nd_nc , serie_nd_nc , nro_docu_nd_nc ,dolar )
execute sp_Executesql @SQLstring 

select compr , fecha , fecha_venc ,
	(select codi_sunat from tipo_documento t (nolock) where t.codi_tipo_docu = docu)docu , serie ,	nro_docu , 
	(select (select cast(codi_sunat as int) from TIPO_DOCU_IDEN X (nolock) where x.codi_tipo_docu_iden=c.codi_tipo_docu_iden)
		 from cliente_proveedor c (nolock) where c.codi_clie_prov=t.codi_clie_prov) codi_clie_prov , 
	vfexp , base_impo , exo , inafecta , isc , igv , otros ,total , tpc , fecha_nd_nc ,
	tipo_docu_nd_nc , serie_nd_nc , nro_docu_nd_nc ,dolar ,
	(select case when upper(tipo_pers) ='JURÍDICA' then razo_soci else denominacion end 
		from cliente_proveedor C (nolock) where C.codi_clie_prov = T.codi_clie_prov) Razon,
	(select ruc from cliente_proveedor C (nolock) where C.codi_clie_prov = T.codi_clie_prov) Ruc
from #Tx T

drop table #Tx

set quoted_identifier on
GO
