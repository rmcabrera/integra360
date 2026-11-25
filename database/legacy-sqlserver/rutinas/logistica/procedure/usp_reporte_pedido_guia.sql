CREATE PROCEDURE [dbo].[usp_reporte_pedido_guia]
	@F1 [datetime],
	@F2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @F1 datetime, @F2 datetime, @alma char(2)
--select @F1='01/01/2017', @F2='12/04/2017', @alma='03'

set nocount on

select codi_unid_oper_soli, 
	   (select desc_alma from almacen a(nolock) where a.codi_alma = codi_unid_oper_soli) alma_soli,
	   codi_unid_oper_dest, 
	   (select desc_alma from almacen a(nolock) where a.codi_alma = codi_unid_oper_dest) alma_dest,
	   codi_alma_orig, 
	   (select desc_alma from almacen a(nolock) where a.codi_alma = codi_alma_orig) alma_orig,
       r.fecha, r.codi_orden_pedi, 
       (select desc_prod from productos p(nolock) where p.codi_prod=d.codi_prod) prod_pedi,
       d.cantidad, case when r.envio='1' then 'ENVIADO' else '' end envio, 
       case when r.estado='A' then 'APROBADO' else '' end estado,
       rtrim(ser_guia) + ' - ' + ltrim(nro_guia) as nro_guia, 
       (select desc_prod from productos p(nolock) where p.codi_prod=gd.codi_prod) prod_guia,
       gd.cantidad as cantidad_g, fech_tras
       
from registro_orden_pedido r(nolock)
join registro_orden_pedido_deta d(nolock)
on r.codi_orden_pedi = d.codi_orden_pedi
left join guia g(nolock)
on g.codi_orden_pedi = r.codi_orden_pedi
left join guia_detalle gd(nolock)
on g.codi_guia = gd.codi_guia and d.codi_prod=gd.codi_prod
where convert(char(10),r.fecha,103) between @F1 and @F2 and (isnull(@alma,'')='' or r.codi_unid_oper_soli=@alma)
GO
