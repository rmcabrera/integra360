CREATE PROCEDURE [dbo].[usp_resumen_caja_deposito_admin]
	@alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime,@fec2 datetime, @alma char(2)  
--SELECT @fec1='10/02/2020', @FEC2='10/02/2020' , @alma ='04'

declare @Vx table(fecha datetime null, nro_docu varchar(25) null, glosa varchar(150) null, importe numeric(18,2) null, importe_d numeric(18,2) null, 
                  suc varchar(25) null, id_rubro int null, desc_rubro varchar(100) null, i_o int null)

insert @Vx
select max(fech_fact) fecha , cast(count(nro_fact) as varchar(10)) +' Docs' nro_docu ,'VENTAS DEL PERIODO ' glosa,
SUM(case when codi_mone='01' then TOTA_FACT else 0 end) importe,
SUM(case when codi_mone='02' then TOTA_FACT else 0 end) importe_d,
(SELECT NEMO_ALMA FROM dbo.ALMACEN (nolock) WHERE CODI_ALMA=F.CODI_ALMA) suc ,

	(select id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = '000') id_rubro,
	(select   (select desc_rubro from rubros_Caja X (nolock) 
			where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = '000') 
			and i_o=1)) desc_rubro,
	(select  (select i_o from rubros_Caja X (nolock) 
			where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = '000')
			and i_o=1)) i_o
			
from dbo.factura F (nolock)
where  (fech_fact>=@fec1 and fech_fact<DateAdd(day,1,@fec2)) and isnull(estado,'')<>'A' and codi_tipo_pago=1 and codi_alma=@alma
group by codi_alma

union all

select cc.fecha fecha , cc.nro_recibo nro_docu, 
(isnull(glosa,(select desc_reemb from dbo.tipo_reembolso (nolock) where tipo_reemb=tipo_contab))+' / '+
(case when codi_usua_soli is null then (select top 1 lower(razon_social) from dbo.empresa (nolock) ) else
(select isnull(apel_1,'')+' '+isnull(nomb_1,'') from dbo.usuarios (nolock) where codi_usua=codi_usua_soli) end)) glosa,
SUM(case when cc.codi_mone='01' then cc.importe else 0 end) importe,
SUM(case when cc.codi_mone='02' then cc.importe else 0 end) importe_d,
(SELECT NEMO_ALMA FROM dbo.ALMACEN (nolock) WHERE CODI_ALMA=cc.CODI_ALMA) suc ,

	(select id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = tipo_contab and r.i_o=tipo_io) id_rubro,
	(select (select desc_rubro from rubros_Caja X (nolock) 
			where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb =tipo_contab and r.i_o=tipo_io)
					and X.i_o=tipo_io)) desc_rubro,
	(select (select i_o from rubros_Caja X (nolock) 
			where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb =tipo_contab  and r.i_o=tipo_io)
				and X.i_o=tipo_io)) i_o

from dbo.caja_chica cc (nolock)
where cc.fecha>=@fec1 and cc.fecha<=@fec2 and cc.codi_alma=@alma AND isnull(dscto_adm,'0')='1'
group by  cc.CODI_ALMA , cc.codi_clie_prov , cc.tipo_io , cc.fecha, cc.nro_recibo, cc.glosa, tipo_contab, codi_usua_soli, cc.codi_liqu, cc.codi_unid_oper

select id_rubro idd, max(convert(char(10),fecha,103)) fecha, null nro_docu, null glosa, sum(importe) importe, sum(importe_d) importe_d, max(suc) suc, max(desc_rubro) desc_rubro
from @Vx
where id_rubro<>5 or id_rubro is null
group by id_rubro

union all

select id_rubro idd, fecha, nro_docu, glosa, importe, importe_d, suc, desc_rubro
from @Vx
where id_rubro=5
GO
