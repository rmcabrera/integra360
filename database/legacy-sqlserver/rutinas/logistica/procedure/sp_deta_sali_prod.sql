CREATE PROCEDURE [dbo].[sp_deta_sali_prod]
	@codi_orde_pedi [char](10)
WITH EXECUTE AS CALLER
AS
CREATE TABLE #RESU_PRODUCTOS_DESPACHADOS
( CODI_PROD_PD    CHAR(10) , CANTIDAD_PD DECIMAL(9,2), NRO_CUEN_PD CHAR(7))
INSERT INTO #RESU_PRODUCTOS_DESPACHADOS 
SELECT  dsm.codi_prod , sum(dsm.cantidad), dsm.nro_cuen
FROM salida_material AS sm
     JOIN detalle_salida_materiales AS dsm
       ON (sm.codi_docu_sali = dsm.codi_docu_sali)
WHERE sm.codi_orde_pedi =@codi_orde_pedi and dsm.cantidad > 0
group by dsm.codi_prod, dsm.nro_cuen

CREATE TABLE #RESU_PRODUCTOS_PEDIDOS
( CODI_PROD_PP    CHAR(10) , CANTIDAD_PP DECIMAL(9,2),  NRO_CUEN_PP CHAR(7) )

INSERT INTO #RESU_PRODUCTOS_PEDIDOS 
SELECT  dop.codi_prod , sum(dop.cantidad), dop.nro_cuen
FROM orden_de_pedido AS op
     JOIN detalle_orden_de_pedido AS dop
       ON (op.codi_orde_pedi = dop.codi_orde_pedi) AND dop.estado='P'
WHERE op.codi_orde_pedi =@codi_orde_pedi
group by dop.codi_prod, dop.nro_cuen

CREATE TABLE #RESU_PRODUCTOS_ATENDER
( CODI_PROD_PA    CHAR(10) , CANTIDAD_PA DECIMAL(9,2) , NRO_CUEN_PA CHAR(7) )
INSERT INTO #RESU_PRODUCTOS_ATENDER
SELECT pp.CODI_PROD_PP,  (pp.CANTIDAD_PP - pd.CANTIDAD_PD) as diferencia , pp.NRO_CUEN_PP
FROM #RESU_PRODUCTOS_PEDIDOS as pp  join  #RESU_PRODUCTOS_DESPACHADOS as pd on (pp.CODI_PROD_PP=pd.CODI_PROD_PD)
WHERE (pp.CANTIDAD_PP - pd.CANTIDAD_PD) > 0
 
INSERT INTO #RESU_PRODUCTOS_ATENDER
SELECT  CODI_PROD_PP ,ISNULL(CANTIDAD_PP,0),  ISNULL(NRO_CUEN_PP,'0')
FROM #RESU_PRODUCTOS_PEDIDOS 
WHERE CODI_PROD_PP   not in  (SELECT CODI_PROD_PD FROM #RESU_PRODUCTOS_DESPACHADOS )


Select *
from #RESU_PRODUCTOS_ATENDER
GO
