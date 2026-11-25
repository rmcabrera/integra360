CREATE PROCEDURE [dbo].[usp_reporte_orden_compra_dist]
	@F1 [datetime],
	@F2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @F1 datetime, @F2 datetime
--select @F1='25/06/2018', @F2='25/07/2018'

create table #Tx (codi_orde_comp char(10) null)

set nocount on

insert #Tx
select codi_orde_comp 
from orden_de_compra (nolock) where convert(char(10),fecha,103) between @F1 and @F2

select codi_deta_orde_comp, D.codi_orde_comp, D.codi_prod, desc_prod,
     case when tipo_prod='ANT' then 'Antiguo'
          when tipo_prod='NUE' then 'Nuevo' else 'Intermedio' end tipo_prod, 
     case when tipo_compra='N' then 'Normal' else 'Forzada' end tipo_compra, 
     fecha_venc, D.cantidad, 
     (select simb_unid_medi from unidad_medida U(nolock) where U.codi_unid_medi=P.codi_unid_medi) simb_unid_medi,
     descuento, prec_orig, precio, round(round(precio,4) * round(D.cantidad,4),4) subtotal,
     (select cast(isnull(nro_orde_pedi,'0') as numeric) from orden_de_pedido where codi_orde_pedi=left(codi_deta_orde_pedi,10)) as nro_pedi,
     D.nro_cuen, (select desc_cuen from cuentas_contable C(nolock) where C.nro_cuen=D.nro_cuen) desc_cuen,
	 DD.codi_prod codi_prod_dist, (select nemo_alma from almacen A(nolock) where A.codi_alma=DD.codi_alma) almacen, 
	 DD.cantidad cantidad_dist, 
	 (select nro_orde_comp from orden_de_compra O(nolock) where O.codi_orde_comp=T.codi_orde_comp) nro_orde_comp,
	 (select fecha from orden_de_compra O(nolock) where O.codi_orde_comp=T.codi_orde_comp) fecha

from detalle_orden_compra D(nolock)
join #Tx T
on D.codi_orde_comp=T.codi_orde_comp
join productos P(nolock)
on P.codi_prod=D.codi_prod
join detalle_orden_compra_distribucion DD(nolock)
on DD.codi_orde_comp=D.codi_orde_comp and DD.codi_prod=D.codi_prod

drop table #Tx
GO
