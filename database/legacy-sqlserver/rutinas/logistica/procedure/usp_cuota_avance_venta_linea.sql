CREATE PROCEDURE [dbo].[usp_cuota_avance_venta_linea]
	@anio [int],
	@mes [int],
	@fec [datetime]
WITH EXECUTE AS CALLER
AS
--declare @anio int , @mes int, @fec datetime   
--select @anio=2021, @mes=6, @fec='15/06/2021'  
  
set nocount on   
  
declare @total numeric(12,2)  
  
select @total=sum(monto)   
from CUOTAS_SUCURSAL (nolock)  
where anio=@anio and mes=@mes  
  
declare @Rx table (codi_alma char(2), almacen varchar(100), avance numeric(12,2) null, cuota numeric(12,2) null, general numeric(12,2),  
     codlinea char(2) null, desc_linea varchar(100) null, cuotalinea numeric(12,2) null )  
  
--insert @Rx  
/*select  codi_alma,   
  (select nemo_alma from almacen A (nolock) where A.codi_alma=F.codi_alma) Almacen,  
  sum(f.TOTA_FACT*case when codi_mone='01' then 1 else TCAMBIO end ) as total,    
  isnull((select monto from CUOTAS_SUCURSAL S (nolock) where anio=@anio and mes=@mes and  S.codi_alma=F.CODI_ALMA),0) as Cuota,     
  @total as General  
from factura F (nolock)  
where year(FECH_FACT)=@anio and month(FECH_FACT)=@mes and isnull(estado,'')<>'A' and FECH_FACT<dateadd(d,1,@fec)  
group by CODI_ALMA  
order by CODI_ALMA  
*/  
  
insert @Rx  
select codi_alma,   
  (select nemo_alma from almacen A (nolock) where A.codi_alma=SQ.codi_alma) Almacen,  
  sum(importe) as Total,  
  isnull((select sum(monto) from CUOTAS_SUCURSAL S (nolock) where anio=@anio and mes=@mes and  S.codi_alma=SQ.CODI_ALMA),0) as Cuota,     
  @total as General,  
  CodLineaProd,   
  (select  des_lin_pro from LINEA_FAMILIA_PRO L (nolock) where l.cod_lin_pro=SQ.CodLineaProd) LineaProd ,  
  isnull((select monto from CUOTAS_SUCURSAL S (nolock) where anio=@anio and mes=@mes and   
      S.codi_alma=SQ.CODI_ALMA and s.cod_lin_pro=sq.CodLineaProd),0) as CuotaLinea  
from   
  (SELECT factura.codi_alma,  
  (select F.cod_lin_pro  
   from SUB_FAMILIA_PRODUCTO S (nolock)   
   join FAMILIA_PRODUCTO F (nolock)  
   on S.CODI_FAMI_PROD=F.CODI_FAMI_PROD  
    where S.codi_sub_fami_prod=Productos.codi_sub_fami_prod) CodLineaProd,  
  (FACTURA_DETALLE.IMPO_ITEM * (CASE WHEN factura.codi_mone='01' THEN 1 ELSE dbo.f_tc(FACTURA.FECH_FACT,'V','01','02') END)) Importe  
    FROM   
         FACTURA,     
         FACTURA_DETALLE,     
         PRODUCTOS  
   WHERE year(FECH_FACT)=@anio and month(FECH_FACT)=@mes and isnull(estado,'')<>'A' and FECH_FACT<dateadd(d,1,@fec)    
   and ( FACTURA_DETALLE.CODI_FACT = FACTURA.CODI_FACT ) and    
    ( PRODUCTOS.CODI_PROD = FACTURA_DETALLE.CODI_PROD ) ) SQ  
group by codi_alma, CodLineaProd  
    
declare @Ax table (codi_alma char(2), avance numeric(12,2) null)  
  
insert @Ax  
select codi_alma, sum(avance) as AvanceSucur  
from @Rx R  
group by codi_alma  

declare @alma char(2), @lin char(2)

declare cuota_suc cursor for select distinct codi_alma from @Rx --where codi_alma='07' 
open cuota_suc
fetch next from cuota_suc into @alma
 
while @@FETCH_STATUS = 0 
begin
 
 insert @Rx
 select codi_alma, (select nemo_alma from almacen A (nolock) where A.codi_alma=c.codi_alma) Almacen, 0 avance,   
		isnull((select sum(monto) from cuotas_sucursal S(nolock) where S.anio=@anio and S.mes=@mes and S.codi_alma=c.codi_alma),0) as Cuota,     
		@total as General, cod_lin_pro, (select des_lin_pro from linea_familia_pro L(nolock) where L.cod_lin_pro=c.cod_lin_pro) LineaProd,
		isnull((select monto from cuotas_sucursal S(nolock) 
							where S.anio=@anio and S.mes=@mes and S.codi_alma=c.codi_alma and s.cod_lin_pro=c.cod_lin_pro),0) as CuotaLinea  
		
 from cuotas_sucursal c(nolock) 
 where anio=@anio and mes=@mes and codi_alma=@alma and cod_lin_pro not in (select codlinea from @Rx where codi_alma=@alma)
 
fetch next from cuota_suc into @alma
 
end
close cuota_suc  
deallocate cuota_suc


select codi_alma,   
  almacen,   
  avance,   
  cuota,   
  case when isnull(cuota,0)<>0 then round((select avance from @Ax A where A.codi_alma=R.codi_alma)/cuota*100.00,2) else 0 end as PorcTienda,  
  general,  
  round(cuota/general*100,2) as PorEmpre,  
  case when isnull(cuotalinea,0)<>0 then round(avance/cuotalinea*100.00,2) else 0 end as PorcLinea,  
  r.codlinea, r.desc_linea,  
  cuotalinea,  
  (select avance from @Ax A where A.codi_alma=R.codi_alma) as AvanceTienda  
from @Rx R  
order by almacen, desc_linea
GO
