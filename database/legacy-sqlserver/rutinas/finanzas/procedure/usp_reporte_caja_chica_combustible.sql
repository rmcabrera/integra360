CREATE PROCEDURE [dbo].[usp_reporte_caja_chica_combustible]
	@F1 [datetime],
	@F2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @F1 datetime, @F2 datetime, @alma char(2)
--select @F1='02/01/2015', @F2='30/12/2015', @alma='01'

select codi_alma, 
	  (select desc_divi_unid_oper from unid_oper_divi uod(nolock) where uod.codi_divi_unid_oper in
			(select uo.codi_divi_unid_oper from unid_oper uo(nolock) where uo.codi_unid_oper=cc.placa)) tipo,
	  placa as codi_placa, 
	  (select desc_unid_oper from unid_oper uo(nolock) where uo.codi_unid_oper=placa) placa,
	   	  (select nemo from tipo_documento td(nolock) where td.codi_tipo_docu=cc.codi_tipo_docu) docu, 
	   serie, nro_docu, codi_clie_prov as codi_clie,
      ltrim((select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
       from cliente_proveedor cp(nolock) where cp.codi_clie_prov=cc.codi_clie_prov)) cliente,
       fecha, (select desc_reemb from tipo_reembolso tr(nolock) where tr.tipo_reemb=tipo_contab) tipo_contab, 
       galones, km_ini, km_fin,
       (select upper(login) from usuarios u(nolock) where u.codi_usua = codi_usua_soli) usuario,
		nro_recibo, fecha_docu, (select simbolo from monedas m(nolock) where m.codi_mone=cc.codi_mone) codi_mone, importe
from caja_chica cc(nolock)
where (cast(convert(char(10),fecha,103) as datetime) between @F1 and @F2) and tipo_contab in ('034','132')
and (isnull(@alma,'')='' or codi_alma=@alma) and isnull(placa,'')<>''
GO
