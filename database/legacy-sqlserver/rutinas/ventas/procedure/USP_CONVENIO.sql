CREATE PROCEDURE [dbo].[USP_CONVENIO]
	@codi_conv [numeric](18, 0)
WITH EXECUTE AS CALLER
AS
--declare @codi_conv numeric        
--select @codi_conv=2        
                    
              
declare @f table(codi_fact char(10) null ,desc_item varchar(150) null, cant_item numeric(18,3))                    
insert @f                    
select d.codi_fact,desc_item,cant_item                     
from factura_detalle d join convenio cn on d.codi_fact=cn.codi_fact              
where codi_conv=@codi_conv                    
                          
      
      
      
/*Toda la factura**/      
DECLARE @x VARCHAR(5000)                          
declare @cf char(10),@di varchar(100),@ci numeric(18,2)                    
                          
set @x=''                    
DECLARE c1 CURSOR FOR                     
 SELECT * from @f                     
 OPEN c1                     
 FETCH NEXT FROM c1 INTO @cf, @di, @ci                    
 WHILE @@FETCH_STATUS = 0                     
 BEGIN                     
 if @x=''                     
  set @x=@x+(select  cast( @ci as varchar(20))+' '+@di )                    
 else                     
  set @x=@x+'; ' +(select  cast( @ci as varchar(20))+' '+@di )                    
FETCH NEXT FROM c1                     
                    
INTO @cf, @di, @ci                    
                    
END                     
 CLOSE c1                     
 DEALLOCATE c1                     
/*********/        
                   
/****/      
DECLARE @xx VARCHAR(5000)                          
declare @dii varchar(100),@cii numeric(18,2)                    
                          
set @xx=''                    
DECLARE c2 CURSOR FOR                     
 select sum(cantidad),descripcion       
 from convenio_detalle      
 where codi_conv=@codi_conv                    
 group by descripcion      
 OPEN c2                     
 FETCH NEXT FROM c2 INTO  @cii,@dii                    
 WHILE @@FETCH_STATUS = 0                     
 BEGIN                     
 if @xx=''                     
  set @xx=@xx+(select  cast( @cii as varchar(20))+' '+@dii )                    
 else                     
  set @xx=@xx+'; ' +(select  cast( @cii as varchar(20))+' '+@dii )                    
FETCH NEXT FROM c2                     
                    
INTO  @cii,@dii      
                    
END                     
 CLOSE c2                     
 DEALLOCATE c2                     
--select @xx      
/***/      
       
SELECT   distinct                  
rtrim((select  Razon_Social from Empresa)) empresa_agro,                     
rtrim((select  ruc from Empresa)) ruc_agro,                    
rtrim(a.direccion) direccion_agro,                    
  case when a.codi_alma='01' then 'CHIMBOTE' else nemo_alma end sucursal,                    
isnull(p.apel_1,'')+isnull(' '+p.apel_2,'')+isnull(' '+p.nomb_1,'')+isnull(' '+p.nomb_2,'')  representante,                    
isnull(ti.nemo,'') tipo_dcto_identidad,isnull(nro_docu_iden,'') nro_dcto_identidad,                    
isnull(p.direccion,''),                    
(select case when denominacion is null or rtrim(denominacion)='' then razo_soci else denominacion end denominacion) cliente,                    
(select nemo from tipo_docu_iden                    
where codi_tipo_docu_iden=(select codi_tipo_docu_iden from cliente_proveedor where codi_clie_prov= cp.codi_clie_prov)) dcto_cliente,                    
convert(char(10),fech_fact,103) fecha_factura,                    
td.nemo b_f, rtrim(ser_fact)+'-'+rtrim(nro_fact) nro_dcto, tota_fact,desc_mone moneda,@x,                  
cp.ruc nro_dcto_cliente,                  
CP.DIRECCION, desc_tipo_docu,left(convert(char(10),cn.fecha,103),2) dia,                   
case month(cn.fecha) when  1 then 'ENERO'                   
    when  2 then 'FEBRERO'                  
    when  3 then 'MARZO'                    
    when  4 then 'ABRIL'                   
    when  5 then 'MAYO'                   
    when  6 then 'JUNIO'                   
    when  7 then 'JULIO'                  
    when  8 then 'AGOSTO'                   
   when  9 then 'SETIEMBRE'                   
    when  10 then 'OCTUBRE'                   
    when  11 then 'NOVIEMBRE'                   
    when  12 then 'DICIEMBRE'                   
END MES,                  
right(convert(char(10),cn.fecha,103),4) anio  ,              
nro,@xx as prod_convenio      
from factura f (nolock) right join almacen a (nolock) on a.codi_alma=f.codi_alma                    
   left  join personal p (nolock) on p.codi_pers=a.representante                    
   full join  tipo_docu_iden ti (nolock) on ti.codi_tipo_docu_iden=p.codi_tipo_docu_iden                    
   full join  cliente_proveedor cp (nolock) on cp.codi_clie_prov=f.codi_clie_prov                    
   join factura_detalle fd (nolock) on f.codi_fact=fd.codi_fact                    
   right join tipo_documento td (nolock) on td.codi_tipo_docu=f.codi_tipo_docu                    
   right join monedas m (nolock) on m.codi_mone=f.codi_mone                
   join convenio cn on cn.codi_fact=f.codi_fact                  
where cn.codi_conv=@codi_conv
GO
