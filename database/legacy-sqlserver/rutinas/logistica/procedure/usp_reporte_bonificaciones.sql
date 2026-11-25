CREATE PROCEDURE [dbo].[usp_reporte_bonificaciones]
	@anio [int]
WITH EXECUTE AS CALLER
AS
--declare @anio int  
--select @anio =2016   
  
set nocount on   
  
create table #Tx (mes int, codi_clie_prov char(5), codi_prod char(8), cantidad int, precio numeric(12,4) null)  
  
  
insert #Tx  
select  month(FECH_NOTA_INGR) as mes,   
  codi_clie_prov, codi_prod, cantidad,      
  ROUND(isnull((select top 1 PREC_UNIT* (case when X.codi_mone='01' then 1 else   
  case when isnull(X.tipo_camb,0)=0 then dbo.f_tc(convert(char(10),X.fech_nota_ingr,103),'V','01','02') else x.tipo_camb end end)  
  from nota_ingreso X (nolock) join detalle_nota_ingreso Y(nolock) on X.codi_nota_ingr=Y.codi_nota_ingr  
   where convert(char(10),X.fech_nota_ingr,103)<=A.FECH_NOTA_INGR and Y.codi_prod=B.codi_prod and   
    X.tipo_nota_ingr='01' and X.codi_alma='01'  
  order by X.fech_nota_ingr desc) ,0) ,2) as precio  
from nota_ingreso A (nolock)  
join DETALLE_NOTA_INGRESO B (nolock)  
on A.CODI_NOTA_INGR=B.CODI_NOTA_INGR  
where year(FECH_NOTA_INGR)=@anio and TIPO_NOTA_INGR='26'  
  --and month(fech_nota_ingr)=2  
order by 1  
  
  
  
select mes,   
  upper(dbo.uf_nom_mes(mes)) as NomMes,  
  codi_clie_prov,  
  dbo.F_Cliente_Proveedor(codi_clie_prov) as Laboratorio,  
  codi_prod,  
  (select desc_prod from productos P (nolock) where p.codi_prod=T.codi_prod) as Producto,  
  sum(cantidad) as cantidad,  
  avg(precio) as precio,  
  sum(cantidad*precio) as Total,  
  (select razon_social from empresa (nolock)) as Empresa  
from #Tx  as T  
group by mes,codi_clie_prov, codi_prod  
order by mes  
  
drop table #Tx
GO
