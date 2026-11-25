CREATE PROCEDURE [dbo].[usp_productos_similares]
	@codi_alma [char](2),
	@codi_prod [char](8)
WITH EXECUTE AS CALLER
AS
--declare @codi_prod char(8),@codi_alma char (2)    
--select @codi_prod='00011672',@codi_alma='01'    
    
declare @posibles_productos table (codi_prod char(8))    
declare @no_productos table(codi_prod char(8))    
declare @codi_prod_aux char(8)    
    
insert @posibles_productos    
select codi_prod    
from     
(    
select codi_prod,count(codi_prin) cantidad_principio from principio_x_producto (nolock)    
where  codi_prod<>@codi_prod    
group by codi_prod) SQl    
where cantidad_principio=(select count(codi_prin) cant_principios from principio_x_producto (nolock)   
where codi_prod=@codi_prod)    
    
DECLARE C1 CURSOR FOR     
select codi_prod     
from @posibles_productos    
    
OPEN C1     
FETCH NEXT FROM C1 INTO @codi_prod_aux    
 WHILE @@FETCH_STATUS = 0     
 BEGIN     
 insert @no_productos    
 SELECT codi_prod FROM principio_x_producto (nolock)    
 where codi_prod=@codi_prod_aux and codi_prin not in  (SELECT codi_prin from principio_x_producto (nolock) where codi_prod=@codi_prod)    
-- select @codi_prod_aux    
FETCH NEXT FROM C1     
    
INTO @codi_prod_aux    
    
END     
 CLOSE C1     
DEALLOCATE C1     
    
    
SELECT p.codi_prod , p.desc_prod , p.codi_mone, pre.desc_pres , sf.desc_sub_fami_prod ,    
 p.cod_impuesto, p.nro_decim_precio,  prec_prov,p.descto_porcenta, p.tcambio, ap.stock_alma - isnull(cantidad_descontar,0) stock_alma,     
ap.prec_porc_uti_men,ap.prec_porc_uti_may,ap.prec_porc_uti_esp ,    
(SELECT valor FROM valores_unitarios_anuales where codi_valo_unit=2 and esta_acti=1) as igv,    
costo_oper, prec_costo,isnull(ROT,0) rot    
FROM PRODUCTOS P INNER JOIN ALMACEN_PRODUCTO AP ON P.CODI_PROD=AP.CODI_PROD    
INNER JOIN  PRESENTACION PRE ON P.COD_PRES=PRE.COD_PRES    
left join SUB_FAMILIA_PRODUCTO SF ON P.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD    
LEFT JOIN (select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROd    
 FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma      
  inner join FACTURA_DETALLE  as FD (nolock)on FAC.codi_fact = FD.codi_fact      
  inner join ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)      
  inner join PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod      
  INNER join PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES      
  inner join CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV      
  INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD      
 where SUC.codi_alma =@codi_alma    
   and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime)     
between (DATEADD (DD , -30 , CAST(CONVERT(CHAR(10),GETDATE(),103) AS VARCHAR) )) and (CAST(CONVERT(CHAR(10),GETDATE(),103) AS VARCHAR)))       
  AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)      
 group by FD.codi_prod, CP.codi_clie_prov) sql ON P.CODI_PROD=SQL.CODI_PROD    
left join (select codi_prod,sum(cantidad) cantidad_descontar
from registro_vale_detalle d (nolock) join registro_vale c (nolock)  on c.codi_vale=d.codi_vale
where (codi_fact is null or codi_fact='') and d.codi_alma=@codi_alma
group by codi_prod
)sqld on p.codi_prod=sqld.codi_prod

WHERE AP.CODI_ALMA=@codi_alma and p.codi_prod in (select codi_prod from @posibles_productos where codi_prod not in (select codi_prod from @no_productos))
GO
