CREATE PROCEDURE [dbo].[sp_reporte_orden_pedido]
	@codi [int]
WITH EXECUTE AS CALLER
AS
--declare @codi int
--select @codi=25036

set nocount on
select X.codi_orden_pedi,
	(select isnull(apel_1,'') +  isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'')	
	from usuarios U(nolock) where U.codi_usua=codi_pers_resp) responsable,
	motivo, observacion,
	(select desc_alma from almacen A(nolock) where A.codi_alma = X.codi_unid_oper_soli) unid_solicita,
	(select desc_alma from almacen B(nolock) where B.codi_alma = X.codi_unid_oper_dest) unid_destino,
	(select razon_social from empresa (nolock)) razon_social,
	Y.codi_prod, (select desc_prod from productos P(nolock) where P.codi_prod = Y.codi_prod) desc_prod,
	cantidad, '' cantidad_aux, '' lote, '' fecha_venc,
	(select desc_sub_fami_prod from sub_familia_producto S(nolock) where S.codi_sub_fami_prod in
		(select p.codi_sub_fami_prod from productos p(nolock) where p.codi_prod=Y.codi_prod)) sub_familia,
		
	(select desc_alma from almacen B(nolock) where B.codi_alma = X.codi_alma_orig) lugar_orig	
	
from registro_orden_pedido X(nolock)
join registro_orden_pedido_deta Y(nolock)
on X.codi_orden_pedi = Y.codi_orden_pedi
where X.codi_orden_pedi = @codi
GO
