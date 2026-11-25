CREATE PROCEDURE [dbo].[usp_cuota_avance_venta_linea_sema_ld]
	@anio [int],
	@mes [int],
	@fec [datetime]
WITH EXECUTE AS CALLER
AS
--declare @anio int , @mes int, @fec datetime   
--select @anio=2017 , @mes=10, @fec='31/10/2017'  
  
set nocount on   
  
declare @total numeric(12,2)  
declare @ultidia int   
declare @Vx table (codi_alma char(2), cod_lin_pro char(2), monto numeric(12,2) null, valordia numeric(12,4) null)  
  
set @ultidia=dbo.f_ulti_dia(@anio, @mes)  
  
select @total=sum(monto)   
from CUOTAS_SUCURSAL (nolock)  
where anio=@anio and mes=@mes  
  
insert @Vx  
select codi_alma, cod_lin_pro ,monto, cast(monto/ @ultidia  as numeric(12,4))  
from CUOTAS_SUCURSAL (nolock)  
where anio=@anio and mes=@mes and monto<>0  
  
declare @Fx table (idd int identity, inicio datetime, fin datetime)  
declare @l_ct int , @l_b int   
  
/*  
set @l_ct=1  
set @l_b= @ultidia / 7  
  
select datename(dw,right('0' + cast(1 + 7 *( @l_ct - 1 ) as varchar),2) +'/'+right('0'+cast(@mes as varchar),2) + '/'+ cast(@anio as varchar)),  
  datepart(dw,right('0' + cast(1 + 7 *( @l_ct - 1 ) as varchar),2) +'/'+right('0'+cast(@mes as varchar),2) + '/'+ cast(@anio as varchar)),  
  @ultidia  
*/  
set @l_ct=1  
set @l_b=1  
  
while @l_ct <=@ultidia  
begin  
 if datepart(dw,right('0' + cast(@l_ct as varchar),2) +'/'+right('0'+cast(@mes as varchar),2) + '/'+ cast(@anio as varchar)) = 7  
 begin  
  insert @Fx  
  select right('0' + cast(@l_b as varchar),2) +'/'+right('0'+cast(@mes as varchar),2) + '/'+ cast(@anio as varchar),   
   right('0' + cast(@l_ct as varchar),2) +'/'+right('0'+cast(@mes as varchar),2) + '/'+ cast(@anio as varchar)  
  set @l_b = @l_ct + 1   
 end  
 set @l_ct= @l_ct + 1   
end  
  
if @l_b< @ultidia  
begin  
 insert @Fx  
 select right('0' + cast(@l_b as varchar),2) +'/'+right('0'+cast(@mes as varchar),2) + '/'+ cast(@anio as varchar),   
   right('0' + cast(@ultidia as varchar),2) +'/'+right('0'+cast(@mes as varchar),2) + '/'+ cast(@anio as varchar)  
end  
  
/*  
while @l_ct <=@l_b + 1   
begin  
   
 insert @Fx  
 select right('0' + cast(1 + 7 *( @l_ct - 1 ) as varchar),2) +'/'+right('0'+cast(@mes as varchar),2) + '/'+ cast(@anio as varchar),   
   right('0'+cast(case when 7 *@l_ct>@ultidia then @ultidia else  7 *@l_ct end  as varchar),2) +'/'+right('0'+cast(@mes as varchar),2) + '/'+ cast(@anio as varchar)  
   
 set @l_ct= @l_ct + 1   
end  
*/  
  
declare @Fac table (codi_alma char(2), fecha datetime, CodLineaProd char(2) ,importe numeric(12,4))  
declare @FacSema table (codi_alma char(2), fecha datetime, CodLineaProd char(2) ,importe numeric(12,4),   
      sema1 numeric(12,4) null, sema2 numeric(12,4) null, sema3 numeric(12,4) null,   
      sema4 numeric(12,4) null, sema5 numeric(12,4) null, sema6 numeric(12,4) null)  
  
insert @Fac  
SELECT factura.codi_alma, cast(convert(char(10),fech_fact,103) as datetime ) as fecha,  
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
    ( PRODUCTOS.CODI_PROD = FACTURA_DETALLE.CODI_PROD )  
      
insert @facsema      
select codi_alma, fecha, codlineaprod, importe,  
  isnull((select a.importe from @Fx F where A.fecha between inicio and fin and idd=1),0) as Sema1,  
  isnull((select a.importe from @Fx F where A.fecha between inicio and fin and idd=2),0) as Sema2,  
  isnull((select a.importe from @Fx F where A.fecha between inicio and fin and idd=3),0) as Sema3,  
  isnull((select a.importe from @Fx F where A.fecha between inicio and fin and idd=4),0) as Sema4,  
  isnull((select a.importe from @Fx F where A.fecha between inicio and fin and idd=5),0) as Sema5,  
  isnull((select a.importe from @Fx F where A.fecha between inicio and fin and idd=6),0) as Sema6  
from @Fac A   
  
declare @Rx table (codi_alma char(2), almacen varchar(100), avance numeric(12,2) null, cuota numeric(12,2) null, general numeric(12,2),  
     codlinea char(2) null, desc_linea varchar(100) null, cuotalinea numeric(12,2) null,  
     sema1 numeric(12,4) null, sema2 numeric(12,4) null, sema3 numeric(12,4) null,   
      sema4 numeric(12,4) null, sema5 numeric(12,4) null ,sema6 numeric(12,4) null ,  
     meta1 numeric(12,4) null, meta2 numeric(12,4) null, meta3 numeric(12,4) null,   
      meta4 numeric(12,4) null, meta5 numeric(12,4) null, meta6 numeric(12,4) null )  
  
insert @Rx  
select codi_alma,   
  (select nemo_alma from almacen A (nolock) where A.codi_alma=SQ.codi_alma) Almacen,  
  sum(importe) as Total,  
  isnull((select sum(monto) from CUOTAS_SUCURSAL S (nolock) where anio=@anio and mes=@mes and  S.codi_alma=SQ.CODI_ALMA),0) as Cuota,     
  @total as General,  
  CodLineaProd,   
  (select  des_lin_pro from LINEA_FAMILIA_PRO L (nolock) where l.cod_lin_pro=SQ.CodLineaProd) LineaProd ,  
  isnull((select monto from CUOTAS_SUCURSAL S (nolock) where anio=@anio and mes=@mes and   
      S.codi_alma=SQ.CODI_ALMA and s.cod_lin_pro=sq.CodLineaProd),0) as CuotaLinea,  
  sum(sema1) as Sema1,  
  sum(sema2) as Sema2,  
  sum(sema3) as Sema3,  
  sum(sema4) as Sema4,  
  sum(sema5) as Sema5,  
  sum(sema6) as Sema6,  
  (select valordia from @Vx V where V.codi_alma=Sq.codi_alma and V.cod_lin_pro=Sq.CodLineaProd)*(select datediff(d,inicio, fin)+1 from @fx where idd=1) MetaSema1,  
  (select valordia from @Vx V where V.codi_alma=Sq.codi_alma and V.cod_lin_pro=Sq.CodLineaProd)*(select datediff(d,inicio, fin)+1 from @fx where idd=2) MetaSema2,  
  (select valordia from @Vx V where V.codi_alma=Sq.codi_alma and V.cod_lin_pro=Sq.CodLineaProd)*(select datediff(d,inicio, fin)+1 from @fx where idd=3) MetaSema3,  
  (select valordia from @Vx V where V.codi_alma=Sq.codi_alma and V.cod_lin_pro=Sq.CodLineaProd)*(select datediff(d,inicio, fin)+1 from @fx where idd=4) MetaSema4,  
  (select valordia from @Vx V where V.codi_alma=Sq.codi_alma and V.cod_lin_pro=Sq.CodLineaProd)*isnull((select datediff(d,inicio, fin)+1 from @fx where idd=5),0) MetaSema5,  
  (select valordia from @Vx V where V.codi_alma=Sq.codi_alma and V.cod_lin_pro=Sq.CodLineaProd)*isnull((select datediff(d,inicio, fin)+1 from @fx where idd=6),0) MetaSema6  
from  @facsema as  SQ  
group by codi_alma, CodLineaProd  
    
declare @Ax table (codi_alma char(2), avance numeric(12,2) null)  
  
insert @Ax  
select codi_alma, sum(avance) as AvanceSucur  
from @Rx R  
group by codi_alma  
  
--select * from @Vx  
  
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
  (select avance from @Ax A where A.codi_alma=R.codi_alma) as AvanceTienda,  
  sema1 , sema2, sema3, sema4 ,sema5, sema6,  
  meta1 , meta2, meta3, meta4 ,meta5, meta6,  
  cast(round(case when meta1<>0 then sema1/meta1 else 0 end,4) *100 as numeric(12,2)) as Avansema1,  
  cast(round(case when meta2<>0 then sema2/meta2 else 0 end,4) *100 as numeric(12,2)) as Avansema2,  
  cast(round(case when meta3<>0 then sema3/meta3 else 0 end,4) *100 as numeric(12,2)) as Avansema3,  
  cast(round(case when meta4<>0 then sema4/meta4 else 0 end,4) *100 as numeric(12,2)) as Avansema4,  
  cast(round(case when meta5<>0 then sema5/meta5 else 0 end,4) *100 as numeric(12,2)) as Avansema5,  
  cast(round(case when meta6<>0 then sema6/meta6 else 0 end,4) *100 as numeric(12,2)) as Avansema6,  
  (select convert(char(10),inicio ,103)+ '  '  + convert(char(10),fin,103) from @Fx where idd=1)  as F1,   
  (select convert(char(10),inicio ,103)+ '  '  + convert(char(10),fin,103) from @Fx where idd=2)  as F2,   
  (select convert(char(10),inicio ,103)+ '  '  + convert(char(10),fin,103) from @Fx where idd=3)  as F3,   
  (select convert(char(10),inicio ,103)+ '  '  + convert(char(10),fin,103) from @Fx where idd=4)  as F4,   
  isnull((select convert(char(10),inicio ,103)+ '  '  + convert(char(10),fin,103) from @Fx where idd=5),'') as F5,  
  isnull((select convert(char(10),inicio ,103)+ '  '  + convert(char(10),fin,103) from @Fx where idd=6),'') as F6  
from @Rx R  
order by almacen, desc_linea
GO
