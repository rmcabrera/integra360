CREATE PROCEDURE [dbo].[usp_saldos_deposito_caja]
	@alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @alma char(2), @fec1 datetime ,@fec2 datetime
--select @alma ='18', @fec1 ='23/08/2017',@fec2 ='18/07/2018'

set nocount on

declare @Tx table (idd int, fecha datetime, codi_mone char(2) , soles numeric(12,2) null, dolares numeric(12,2) null)

declare @Ax table (codi_alma char(2)  null, fecha datetime)

insert @Ax
select '19','17/02/2018' union all
select '18','22/02/2018' union all
select '03','21/02/2018' union all
select '06','21/02/2018' union all
select '08','22/02/2018' union all
select '09','22/02/2018' union all
select '20','21/02/2018' union all
select '15','21/02/2018' union all
select '04','16/02/2018' union all
select '05','21/02/2018' union all
select '07','20/02/2018' union all
select '21','22/02/2018' 


insert @Tx
SELECT 2 idd, 
         D.fecha as fecha,   
         D.codi_mone,   
		case when codi_mone='01' then importe else 0.00 end importe,
		case when codi_mone='02' then importe else 0.00 end importe_d
    FROM DEPOSITOS D (nolock)
	where (fecha>=@fec1 and fecha<DateAdd(day,1,@fec2)) and codi_alma=@alma and tipo<>'S'
			and exists (select * from @Ax A where A.codi_alma=D.codi_alma and A.fecha<=D.fecha )
			and fecha_depo<DateAdd(day,1,@fec2)
union all
select 1 idd,
       cast(convert(char(10), fecha , 103) as datetime ) fecha, codi_mone, 
       sum(importe), sum(importe_d)
from 
	(select 1 tipo , max(fech_fact) fecha , cast(count(nro_fact) as varchar(10)) +' Docs' nro_docu ,'VENTAS DEL PERIODO ' glosa,
	SUM(case when codi_mone='01' then TOTA_FACT else 0 end) importe,
	SUM(case when codi_mone='02' then TOTA_FACT else 0 end) importe_d,
	(SELECT NEMO_ALMA FROM dbo.ALMACEN (nolock) WHERE CODI_ALMA=F.CODI_ALMA) suc ,
	'CLIENTES VARIOS' deno , cast ( null as datetime) hora_real,'00000' codi_clie, 
	(select count(*) from caja_cierre where codi_alma=@alma and cast(convert(char(10),fecha ,103 ) as datetime ) =@fec1) est_cierre,'' nd,
		(select id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = '000') id_rubro,
		(select   (select desc_rubro from rubros_Caja X (nolock) 
				where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = '000') 
				and i_o=1)) desc_rubro,
		(select  (select i_o from rubros_Caja X (nolock) 
				where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = '000')
				and i_o=1)) i_o, f.codi_mone
	
	from dbo.factura F (nolock)
	where  (fech_fact>=@fec1 and fech_fact<DateAdd(day,1,@fec2)) and isnull(estado,'')<>'A' 
				and codi_tipo_pago=1 and codi_alma=@alma
				and exists (select * from @Ax A where A.codi_alma=F.codi_alma and A.fecha<=F.fech_fact )
	group by codi_alma, fech_fact, codi_mone
--	order by codi_alma, fech_fact
	union all
	select cc.tipo_io tipo , cc.fecha fecha , cc.nro_recibo nro_docu, 
	(isnull(glosa,(select desc_reemb from dbo.tipo_reembolso (nolock) where tipo_reemb=tipo_contab))+' / '+
	(case when codi_usua_soli is null then (select top 1 lower(razon_social) from dbo.empresa (nolock) ) else
	(select isnull(apel_1,'')+' '+isnull(nomb_1,'') from dbo.usuarios (nolock) where codi_usua=codi_usua_soli) end)) glosa,
	SUM(case when cc.codi_mone='01' then cc.importe else 0 end)* case when tipo_io=0 then -1 else 1 end  importe,
	SUM(case when cc.codi_mone='02' then cc.importe else 0 end)* case when tipo_io=0 then -1 else 1 end importe_d,
	(SELECT NEMO_ALMA FROM dbo.ALMACEN (nolock) WHERE CODI_ALMA=cc.CODI_ALMA) suc ,
	(select denominacion from dbo.cliente_proveedor (nolock) where codi_clie_prov=cc.codi_clie_prov) deno , max(hora_real) hora_real, codi_clie_prov codi_clie,
	(select count(*) from caja_cierre where codi_alma=@alma and cast(convert(char(10),fecha ,103 ) as datetime ) =@fec1) est_cierre,isnull(max(nro_docu),'') nd,
		(select id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = tipo_contab and r.i_o=tipo_io) id_rubro,
		(select (select desc_rubro from rubros_Caja X (nolock) 
				where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb =tipo_contab and r.i_o=tipo_io)
						and X.i_o=tipo_io)) desc_rubro,
		(select (select i_o from rubros_Caja X (nolock) 
				where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb =tipo_contab  and r.i_o=tipo_io)
					and X.i_o=tipo_io)) i_o, cc.codi_mone
	from dbo.caja_chica cc (nolock)
	where cc.fecha>=@fec1 and cc.fecha<=@fec2 and cc.codi_alma=@alma AND isnull(dscto_adm,'0')<>'1'
				and exists (select * from @Ax A where A.codi_alma=CC.codi_alma and A.fecha<=CC.fecha )
	group by  cc.CODI_ALMA , cc.codi_clie_prov , cc.tipo_io , cc.fecha, cc.nro_recibo, cc.glosa, tipo_contab, codi_usua_soli, cc.codi_mone) SQL
group by cast(convert(char(10), fecha , 103) as datetime) , codi_mone
order by fecha, idd


/*select * from dbo.caja_chica cc (nolock)
	where cc.fecha>=@fec1 and cc.fecha<=@fec2 and cc.codi_alma=@alma AND isnull(dscto_adm,'0')<>'1'
*/	
declare @Sx table (fecha datetime, codi_mone char(2), soles numeric(12,2) null, dolar numeric(12,2) null)

insert @Sx
select fecha, codi_mone, 
		sum(soles*case when idd=1 then 1 else -1 end ) as soles,
		sum(dolares*case when idd=1 then 1 else -1 end ) as dolar
from @Tx
group by fecha, codi_mone
having sum(soles*case when idd=1 then 1 else -1 end ) <>0 or 
		sum(dolares*case when idd=1 then 1 else -1 end ) <>0

select fecha, codi_mone, soles, dolar
from @Sx where soles<>0
union all
select fecha, codi_mone, dolar, dolar
from @Sx where dolar<>0
GO
