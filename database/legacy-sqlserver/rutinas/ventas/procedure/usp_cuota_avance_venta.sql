CREATE PROCEDURE [dbo].[usp_cuota_avance_venta]
	@anio [int],
	@mes [int],
	@fec [datetime]
WITH EXECUTE AS CALLER
AS
--declare @anio int , @mes int, @fec datetime   
--select @anio=2016 , @mes=9, @fec='15/09/2016'  
  
set nocount on   
  
declare @total numeric(12,2)  
  
select @total=sum(monto)   
from CUOTAS_SUCURSAL  
  
declare @Rx table (codi_alma char(2), almacen varchar(100), avance numeric(12,2) null, cuota numeric(12,2) null, general numeric(12,2))  
  
insert @Rx  
select  codi_alma,   
  (select nemo_alma from almacen A (nolock) where A.codi_alma=F.codi_alma) Almacen,  
  sum(f.TOTA_FACT*case when codi_mone='01' then 1 else TCAMBIO end ) as total,    
  isnull((select monto from CUOTAS_SUCURSAL S (nolock) where anio=@anio and mes=@mes and  S.codi_alma=F.CODI_ALMA),0) as Cuota,     
  @total as General  
from factura F (nolock)  
where year(FECH_FACT)=@anio and month(FECH_FACT)=@mes and isnull(estado,'')<>'A' and FECH_FACT<dateadd(d,1,@fec)  
group by CODI_ALMA  
order by CODI_ALMA  
  
  
select codi_alma,   
  almacen,   
  avance,   
  cuota,   
  case when isnull(cuota,0)<>0 then round(avance/cuota*100.00,2) else 0 end as PorcTienda,  
  general,  
  round(cuota/general*100,2) as PorEmpre  
from @Rx
GO
