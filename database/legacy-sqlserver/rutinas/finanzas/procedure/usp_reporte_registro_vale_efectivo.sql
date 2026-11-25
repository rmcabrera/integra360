CREATE PROCEDURE [dbo].[usp_reporte_registro_vale_efectivo]
	@fec1 [datetime],
	@fec2 [datetime],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime, @fec2 datetime ,@codi_alma char(2)
--select @fec1='08/08/2015', @fec2='08/08/2015',@codi_alma='17'

select max(suc)as suc, max(razo_soci)as razo_soci,max(fecha)as fecha,
	sum(importe)as importe,sum(importe_d)as importe_d, cast(count(nro_vale) as varchar(10)) +' Docs'as nro_vale ,max(glosa)as glosa,
	codi_tipo_pago
from (

select 
(select nemo_alma from dbo.almacen (nolock) where almacen.codi_alma=r.codi_alma)suc,
/*(select case when tipo_pers ='Natural' then apel_1+' '+isnull(apel_2,'')+' '+isnull(nomb_1,'') else razo_soci end from cliente_proveedor c (nolock)
	where c.codi_clie_prov=r.codi_clie_prov)*/'CLIENTES VARIOS'razo_soci,
r.fecha as fecha, 
(case when codi_mone='01' then r.TOTA_FACT else 0 end) importe,
(case when codi_mone='02' then r.TOTA_FACT else 0 end) importe_d,nro_vale, 'VENTAS DEL PERIODO' as glosa , 
	codi_tipo_pago
 from registro_vale r(nolock)
--join caja_chica_depo c(nolock)
--on r.codi_vale =cast(c.codi_docu as numeric)
 where  (convert(varchar(10), r.fecha, 103) between @fec1 and @fec2) and codi_tipo_pago=1 
	and codi_alma=@codi_alma and isnull(r.estado,'')<>'N' /*and isnumeric(codi_docu)=1*/)sql
group by suc,codi_tipo_pago
union all 
select 
	(select nemo_alma from dbo.almacen (nolock) where almacen.codi_alma=r.codi_alma)suc,
	(select case when tipo_pers ='Natural' then apel_1+' '+isnull(apel_2,'')+' '+isnull(nomb_1,'') else razo_soci end from cliente_proveedor c (nolock)
		where c.codi_clie_prov=r.codi_clie_prov) as razo_soci,
	r.fecha as fecha, 
	(case when D.codi_mone='01' then c.importe else 0 end) importe,
	(case when D.codi_mone='02' then c.importe else 0 end) importe_d,
	cast(nro_vale as varchar), 'VENTAS DEL PERIODO' as glosa , 
		codi_tipo_pago
	 from registro_vale r(nolock)
	join caja_chica_depo c(nolock)
	on cast(r.codi_vale as varchar)=c.codi_docu 
	join depositos d(nolock)on d.codi_depo=c.codi_depo
	where (d.fecha_depo>=@fec1 and d.fecha_depo<DateAdd(day,1,@fec2)) and 
		--(convert(varchar(10), r.fecha, 103) between @fec1 and @fec2) and 
		codi_tipo_pago=4 and isnull(r.estado,'')<>'N'
		and R.codi_alma=@codi_alma /*and isnumeric(codi_docu)=1*/
	order by 2
GO
