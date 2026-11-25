CREATE PROCEDURE [dbo].[PA_VENTAS_PRODUCTOS_anios_conso]
	@TIPO [varchar](2),
	@CODI_ALMA [char](2),
	@anio_i [char](4),
	@anio_f [char](4),
	@CODI_CLIE_PROV [char](5),
	@SUBFAMILIA [char](4),
	@CODI_PRES [int]
WITH EXECUTE AS CALLER
AS
--declare @TIPO varCHAR(2) , @CODI_ALMA CHAR(2) , @anio_i char(4) , @anio_f char(4)  , @CODI_CLIE_PROV CHAR(5)  , @SUBFAMILIA char(4) , @CODI_PRES INT               
--select @TIPO ='0', @CODI_ALMA ='00' , @anio_i ='2011', @anio_f ='2012', @CODI_CLIE_PROV ='', @SUBFAMILIA ='', @CODI_PRES =0              
              
set nocount on              
set quoted_identifier off               
              
declare @SQLString nvarchar(4000)              
declare @Condi varchar(100) ,@Grup varchar(100)              
declare @ParmString nvarchar(100)              
              
create table #alma (codi_alma char(2) null)              
IF @codi_alma = '00'              
BEGIN              
 set @Grup=""              
 set @Condi="'00' as nemo, "              
 insert #alma               
 Select codi_alma from almacen (nolock)              
END              
ELSE              
BEGIN              
 set @Condi=" SUC.NEMO_ALMA , "              
 set @Grup=" SUC.NEMO_ALMA , "              
 insert #alma               
 Select codi_alma from almacen  (nolock) where codi_alma = @codi_alma              
END              
              
set nocount on              
--- TODO ESTA POR SUCURSAL Y ENTRE FECHAS --------------              
              
IF @TIPO='1' ---- SOLO POR LABORATORIO               
              
BEGIN           
 create table #TX ( alma varchar(30) null, codi_clie_prov char(5) null, laboratorio varchar(200) null,        
  desc_sub_fami varchar(150) null, desc_prod varchar(200) null,         
  desc_pres  varchar(20) null,       
  vent_cant_cont numeric(12,4) null,vent_valor_cont numeric(12,4) null,vent_costo_cont numeric(12,4) null,        
  vent_cant_cred numeric(12,4) null,vent_valor_cred numeric(12,4) null,vent_cost_cred numeric(12,4) null,      
anio int)      
        
         
 set @Parmstring = "@anio_i char(4) ,@anio_f char(4)"              
              
 set @SQLString = "              
 select " +@Condi+" CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
      year( FAC.fech_fact ) anio                 
               
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA  as FAC  (nolock) on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE  as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrog.dbo.PRODUCTOS  as PROD  (nolock)on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION  AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
              
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year( FAC.fech_fact ) between @anio_i and @anio_F)               
  and CP.CODI_CLIE_PROV ='"+@CODI_CLIE_PROV+"' AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
 group by   " +@Grup+" CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES ,year( FAC.fech_fact )             
 order by desc_prod "              
       
 insert #TX               
 execute sp_executesql @SQLString, @ParmString, @anio_i =@anio_i , @anio_f =@anio_f              
      
 set @SQLString = "              
 select " +@Condi+" CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
      year( FAC.fech_fact ) anio                 
               
 FROM SI_agrom.dbo.ALMACEN as SUC inner join SI_agrom.dbo.FACTURA  as FAC  (nolock) on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE  as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS  as PROD  (nolock)on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION  AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
              
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year( FAC.fech_fact ) between @anio_i and @anio_F)               
  and CP.CODI_CLIE_PROV ='"+@CODI_CLIE_PROV+"' AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
 group by   " +@Grup+" CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES ,year( FAC.fech_fact )             
 order by desc_prod "        
      
 insert #TX               
 execute sp_executesql @SQLString, @ParmString, @anio_i =@anio_i , @anio_f =@anio_f              
        
select alma,codi_clie_prov,laboratorio,desc_sub_fami,desc_prod,      
desc_pres, sum(vent_cant_cont)vent_cant_cont,sum(vent_valor_cont)vent_valor_cont,      
sum(vent_costo_cont)vent_costo_cont,  sum(vent_cant_cred)vent_cant_cred ,      
 sum(vent_valor_cred)vent_valor_cred, sum(vent_cost_cred)vent_cost_cred      
from #Tx      
group by alma,codi_clie_prov,laboratorio,desc_sub_fami,desc_prod,desc_pres,anio      
      
---select * from #Tx      
      
 drop table #Tx        
      
end              
              
else if @tipo='2' --- PROVEEDOR Y SUBFAMILIA              
              
BEGIN      select nemo_alma,codi_clie_prov,laboratorio,desc_sub_fami_prod,desc_prod,desc_pres,      
sum(venta_cant_conta),sum(venta_valor_conta),sum(venta_costo_conta),sum(venta_cant_cred),      
 sum(venta_valor_cred),sum(venta_costo_cred),anio      
from(            
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,              
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,               
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) ,            
  year( FAC.fech_fact ) anio                          
               
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE  as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrog.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime)) between @anio_i and @anio_f            
  and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
  and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA              
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES  ,  year( FAC.fech_fact )                
      
union all        
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,              
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,               
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) ,            
  year( FAC.fech_fact ) anio                          
               
 FROM SI_agrom.dbo.ALMACEN as SUC inner join SI_agrom.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE  as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime)) between @anio_i and @anio_f            
  and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
  and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA              
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES  ,  year( FAC.fech_fact )) SQL        
      
group by nemo_alma, laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES , CODI_CLIE_PROV,anio               
      
      
              
end              
              
else if @tipo='3' --- SUBFAMILIA              
              
BEGIN            
      
select nemo_alma,codi_clie_prov,laboratorio,desc_sub_fami_prod,desc_prod,desc_pres,      
sum(venta_cant_conta),sum(venta_valor_conta),sum(venta_costo_conta),sum(venta_cant_cred),      
 sum(venta_valor_cred),sum(venta_costo_cred),anio      
from(        
        
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
  year( FAC.fech_fact ) anio                           
               
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE  as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)            
  inner join SI_agrog.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f )              
  and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES,  year( FAC.fech_fact )                  
      
 union all      
      
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
  year( FAC.fech_fact ) anio                           
               
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE  as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f )              
  and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES,  year( FAC.fech_fact )) SQL        
 group by nemo_alma,  laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES ,codi_clie_prov,anio                
              
end              
              
else if @tipo='4' --- PRESETANCION              
              
BEGIN             
      
 select nemo_alma,codi_clie_prov,laboratorio,desc_sub_fami_prod,desc_prod,desc_pres,      
sum(venta_cant_conta),sum(venta_valor_conta),sum(venta_costo_conta),sum(venta_cant_cred),      
 sum(venta_valor_cred),sum(venta_costo_cred) ,anio     
from(       
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) ,            
  year( FAC.fech_fact ) anio                          
              
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE   as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrog.dbo.PRODUCTOS   as PROD  (nolock)on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION   AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact)  between @anio_i and @anio_f)               
  and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES,  year( FAC.fech_fact )               
           
 union all      
      
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) ,            
  year( FAC.fech_fact ) anio                          
              
 FROM SI_agrom.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE   as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS   as PROD  (nolock)on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION   AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact)  between @anio_i and @anio_f)               
  and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES,  year( FAC.fech_fact ) ) SQL        
      
group by nemo_alma, laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES , CODI_CLIE_PROV,anio                 
              
        
         
end              
              
else if @tipo='5' --- LABORATORIO Y PRESETANCION              
              
BEGIN         
  select nemo_alma,codi_clie_prov,laboratorio,desc_sub_fami_prod,desc_prod,desc_pres,      
sum(venta_cant_conta),sum(venta_valor_conta),sum(venta_costo_conta),sum(venta_cant_cred),      
 sum(venta_valor_cred),sum(venta_costo_cred) ,anio     
from(      
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) ,            
  year( FAC.fech_fact ) anio                          
               
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE   as FD on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrog.dbo.PRODUCTOS   as PROD on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION   AS PRES ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )        
   and  (year( FAC.fech_fact) between @anio_i and @anio_f)               
  and CP.codi_clie_prov=@CODI_CLIE_PROV              
  and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES ,  year( FAC.fech_fact )              
       
 union all    
    
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) ,            
  year( FAC.fech_fact ) anio                          
               
 FROM SI_agrom.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE   as FD on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS   as PROD on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION   AS PRES ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year( FAC.fech_fact) between @anio_i and @anio_f)               
  and CP.codi_clie_prov=@CODI_CLIE_PROV              
  and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES ,  year( FAC.fech_fact ) ) SQL        
      
group by nemo_alma, laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES , CODI_CLIE_PROV ,anio                
                       
       
      
    
             
end              
              
else if @tipo='6' --- SUB FAMILIA Y PRESENTACION              
              
BEGIN        
select nemo_alma,codi_clie_prov,laboratorio,desc_sub_fami_prod,desc_prod,desc_pres,      
sum(venta_cant_conta),sum(venta_valor_conta),sum(venta_costo_conta),sum(venta_cant_cred),      
sum(venta_valor_cred),sum(venta_costo_cred) ,anio     
from(      
          
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
  year( FAC.fech_fact ) anio               
               
  FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE   as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrog.dbo.PRODUCTOS   as PROD  (nolock)on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION   AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year( FAC.fech_fact)  between @anio_i and @anio_f)               
  and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA              
  and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES, year( FAC.fech_fact)            
     
  union all    
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
  year( FAC.fech_fact ) anio                           
               
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE   as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS   as PROD  (nolock)on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION   AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year( FAC.fech_fact)  between @anio_i and @anio_f)               
  and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA              
  and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES, year( FAC.fech_fact) ) SQL        
      
group by nemo_alma, laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES , CODI_CLIE_PROV   ,anio                     
end              
              
else if @tipo='7' --- LABORATORIO , SUB FAMILIA ,  PRESENTACION              
              
    
BEGIN              
select nemo_alma,codi_clie_prov,laboratorio,desc_sub_fami_prod,desc_prod,desc_pres,      
sum(venta_cant_conta),sum(venta_valor_conta),sum(venta_costo_conta),sum(venta_cant_cred),      
sum(venta_valor_cred),sum(venta_costo_cred) ,anio     
from(      
          
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
  year( FAC.fech_fact ) anio                           
               
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE   as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrog.dbo.PRODUCTOS   as PROD  (nolock)on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION   AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA and CP.codi_clie_prov=@CODI_CLIE_PROV              
  and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES  ,year( FAC.fech_fact)            
    
union all    
    
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
  year( FAC.fech_fact ) anio                           
               
 FROM SI_agrom.dbo.ALMACEN as SUC inner join SI_agrom.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE   as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS   as PROD  (nolock)on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION   AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA and CP.codi_clie_prov=@CODI_CLIE_PROV              
  and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES  ,year( FAC.fech_fact)) SQL        
      
group by nemo_alma, laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES , CODI_CLIE_PROV ,anio                               
    
       
end              
              
else if @tipo='8' --- PROVEEDOR Y FAMILIA              
              
BEGIN      
select nemo_alma,codi_clie_prov,laboratorio,desc_sub_fami_prod,desc_prod,desc_pres,      
sum(venta_cant_conta),sum(venta_valor_conta),sum(venta_costo_conta),sum(venta_cant_cred),      
sum(venta_valor_cred),sum(venta_costo_cred),anio      
from(      
            
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,           
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) ,            
  year( FAC.fech_fact ) anio                          
               
 FROM SI_agrom.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE  as FD (nolock) on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrog.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD              
  INNER JOIN SI_agrog.dbo.FAMILIA_PRODUCTO AS SF (nolock) ON  SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD              
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
  and SF.CODI_FAMI_PROD = @SUBFAMILIA              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES,year( FAC.fech_fact)              
    
union all    
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) ,            
  year( FAC.fech_fact ) anio                          
               
 FROM SI_agrom.dbo.ALMACEN as SUC inner join SI_agrom.dbo.FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE  as FD (nolock) on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD              
  INNER JOIN SI_agrom.dbo.FAMILIA_PRODUCTO AS SF (nolock) ON  SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD              
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
  and SF.CODI_FAMI_PROD = @SUBFAMILIA              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES,year( FAC.fech_fact)) SQL        
      
group by nemo_alma, laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES , CODI_CLIE_PROV,anio                                          
              
end              
              
              
else if @tipo='9' --- FAMILIA              
              
BEGIN          
select nemo_alma,codi_clie_prov,laboratorio,desc_sub_fami_prod,desc_prod,desc_pres,      
sum(venta_cant_conta),sum(venta_valor_conta),sum(venta_costo_conta),sum(venta_cant_cred),      
sum(venta_valor_cred),sum(venta_costo_cred) ,anio     
from(    
        
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
  year( FAC.fech_fact ) anio                           
               
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrom.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE  as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrog.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION  AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD              
  INNER JOIN SI_agrog.dbo.FAMILIA_PRODUCTO AS SF  (nolock)ON  SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD              
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  and SF.CODI_FAMI_PROD = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES,year( FAC.fech_fact)              
    
 union all    
    
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
  year( FAC.fech_fact ) anio             
               
 FROM SI_agrom.dbo.ALMACEN as SUC inner join SI_agrom.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE  as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION  AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD              
  INNER JOIN SI_agrom.dbo.FAMILIA_PRODUCTO AS SF  (nolock)ON  SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD              
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  and SF.CODI_FAMI_PROD = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES,year( FAC.fech_fact)) SQL        
      
group by nemo_alma, laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES , CODI_CLIE_PROV ,anio                                         
                        
    
           
end              
else if @tipo='10' --- PROVEEDOR Y linea              
              
BEGIN            
select nemo_alma,codi_clie_prov,laboratorio,desc_sub_fami_prod,desc_prod,desc_pres,      
sum(venta_cant_conta),sum(venta_valor_conta),sum(venta_costo_conta),sum(venta_cant_cred),      
sum(venta_valor_cred),sum(venta_costo_cred) ,anio     
from(    
       
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
  year( FAC.fech_fact ) anio                           
               
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrom.dbo.FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE  as FD (nolock) on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrog.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD              
  INNER JOIN SI_agrog.dbo.FAMILIA_PRODUCTO AS SF (nolock) ON  SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD              
  inner join SI_agrog.dbo.LINEA_FAMILIA_PRO L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro              
              
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
         and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
  and L.cod_lin_pro = @SUBFAMILIA              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , PROD.DESC_PROD , PRES.DESC_PRES, year( FAC.fech_fact)             
    
union all    
    
select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),            
  year( FAC.fech_fact ) anio                           
               
 FROM SI_agrom.dbo.ALMACEN as SUC inner join SI_agrom.dbo.FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE  as FD (nolock) on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD              
  INNER JOIN SI_agrom.dbo.FAMILIA_PRODUCTO AS SF (nolock) ON  SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD              
  inner join SI_agrom.dbo.LINEA_FAMILIA_PRO L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro              
              
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
         and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
  and L.cod_lin_pro = @SUBFAMILIA              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , PROD.DESC_PROD , PRES.DESC_PRES, year( FAC.fech_fact) ) SQL        
      
group by nemo_alma, laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES , CODI_CLIE_PROV,anio                                                  
    
              
end              
              
              
else if @tipo='11' --- linea              
              
BEGIN          
select nemo_alma,codi_clie_prov,laboratorio,desc_sub_fami_prod,desc_prod,desc_pres,      
sum(venta_cant_conta),sum(venta_valor_conta),sum(venta_costo_conta),sum(venta_cant_cred),      
sum(venta_valor_cred),sum(venta_costo_cred),anio      
from(    
       
       
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,            
  year( FAC.fech_fact ) anio                         
               
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE  as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrog.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION  AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD              
  INNER JOIN SI_agrog.dbo.FAMILIA_PRODUCTO AS SF  (nolock)ON  SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD              
  inner join SI_agrog.dbo.LINEA_FAMILIA_PRO L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro              
              
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  and L.cod_lin_pro = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , PROD.DESC_PROD , PRES.DESC_PRES,year( FAC.fech_fact)              
union all    
 select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,            
  year( FAC.fech_fact ) anio         
               
 FROM SI_agrom.dbo.ALMACEN as SUC inner join SI_agrom.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE  as FD  (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION  AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD              
  INNER JOIN SI_agrom.dbo.FAMILIA_PRODUCTO AS SF  (nolock)ON  SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD              
  inner join SI_agrom.dbo.LINEA_FAMILIA_PRO L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro              
              
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  and L.cod_lin_pro = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
               
 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , PROD.DESC_PROD , PRES.DESC_PRES,year( FAC.fech_fact)) SQL        
      
group by nemo_alma, laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES , CODI_CLIE_PROV ,anio                                                           
              
              
end              
              
else               
               
  ---- TODOS LOS PRODUCTOS SIN TENER EN CUENTA EL LABORATORIO              
              
BEGIN         
select nemo_alma,codi_clie_prov,laboratorio,desc_sub_fami_prod,desc_prod,desc_pres,      
sum(venta_cant_conta),sum(venta_valor_conta),sum(venta_costo_conta),sum(venta_cant_cred),      
sum(venta_valor_cred),sum(venta_costo_cred),anio     
from(         
 select 'TODOS' NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,        
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) ,            
  year( FAC.fech_fact ) anio                          
               
 FROM SI_agrog.dbo.ALMACEN as SUC inner join SI_agrog.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrog.dbo.FACTURA_DETALLE  as FD (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrog.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrog.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrog.dbo.PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrog.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV       
  INNER JOIN SI_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
                
 group by   -- SUC.NEMO_ALMA ,              
    CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES ,year( FAC.fech_fact)    
        
union all    
 select 'TODOS' NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,              
               
  venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,               
  venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                 
  venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,                     
              
  venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,                 
  venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,                
  venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) ,            
  year( FAC.fech_fact ) anio                          
               
 FROM SI_agrom.dbo.ALMACEN as SUC inner join SI_agrom.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma              
  inner join SI_agrom.dbo.FACTURA_DETALLE  as FD (nolock)on FAC.codi_fact = FD.codi_fact              
  inner join SI_agrom.dbo.ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)              
  inner join SI_agrom.dbo.PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod              
  INNER join SI_agrom.dbo.PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES              
  inner join SI_agrom.dbo.CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV              
  INNER JOIN SI_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD              
               
 where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )              
   and  (year(FAC.fech_fact) between @anio_i and @anio_f)               
  AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)              
                
 group by   -- SUC.NEMO_ALMA ,              
    CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES ,year( FAC.fech_fact)             
   ) SQL        
      
group by nemo_alma, laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES , CODI_CLIE_PROV ,anio                                                           
                     
end              
              
drop table #alma               
              
set quoted_identifier on
GO
