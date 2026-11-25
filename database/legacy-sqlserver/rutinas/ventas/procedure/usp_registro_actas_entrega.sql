CREATE PROCEDURE [dbo].[usp_registro_actas_entrega]
	@tipo [char](1),
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](5),
	@codi_clie_prov [varchar](5),
	@nro_docu_fact [varchar](8)
WITH EXECUTE AS CALLER
AS
--declare @tipo as char(1) , @codi_alma char(2)  , @fec1 datetime , @fec2 datetime , @nro_docu varchar(5) , @codi_clie_prov varchar(5), @nro_docu_fact varchar(8)               
--select @tipo ='', @codi_alma ='00', @fec1 ='24/07/2012', @fec2 ='27/07/2012', @nro_docu ='0', @codi_clie_prov ='15550',@nro_docu_fact  ='166'            
              
            
set nocount on               
              
declare @alma table (codi_alma char(2) null)              
IF @codi_alma = '00'              
BEGIN              
 insert @alma              
 Select codi_alma from almacen              
END              
ELSE              
BEGIN              
 insert @alma              
 Select codi_alma from almacen (nolock) where codi_alma = @codi_alma              
END      
      
      
DECLARE @x VARCHAR(5000),@xx VARCHAR(5000)      
declare  @c numeric,@n numeric, @n_f varchar(50)      
              
declare @t table(codi_act numeric null , nro numeric null,nro_factura varchar(100))      
      
insert @t      
select distinct d.codi_act, c.nro,rtrim(nemo)+' ' + rtrim(ser_fact) +'-'+ rtrim(nro_fact) as nro_factura      
from acta_entrega_detalle d (nolock) join convenio c (nolock) on c.codi_conv=d.codi_conv      
       left join factura f (nolock) on f.codi_fact=c.codi_fact      
       left join tipo_documento td (nolock) on td.codi_tipo_docu=f.codi_tipo_docu         
       join acta_entrega a (nolock) on a.codi_act=d.codi_act      
where a.codi_alma in (select codi_Alma from @Alma)      
      
     
declare @TT table (codi_act_act numeric, nro_act varchar(4000) null, nro_factura_act varchar(4000) null)      
set @x=''      
set @xx=''      
      
declare c1 cursor for       
select codi_act,nro,nro_factura       
from @t          
open c1      
fetch c1 into @c,@n,@n_f      
while @@Fetch_status=0       
begin      
 set @X=null       
 set @xx=null      
 SELECT @x=COALESCE(@x+', '+ cast(nro as varchar(10)),cast(nro as varchar(30)))       
 FROM @t            
 where codi_act=@c         
      
 SELECT @xx=COALESCE(@xx+', '+ cast(nro_factura as varchar(30)),cast(nro_factura as varchar(30)))       
 FROM @t            
 where codi_act=@c         
      
 insert @tt      
 select @c,@x,@xx         
      
 fetch c1 into @c,@n,@n_f        
end       
close c1      
deallocate c1      
/***/       
      
--select * from @tt      
--select * from  acta_entrega_Detalle      
       
if @tipo='N'  --POR NRO DOCUMENTO              
begin            
 select distinct codi_act,nro,c.codi_alma,fecha,c.codi_clie_prov,denominacion,nro_act as nro_conv, nro_factura_act as fact_asociadas/*,rtrim(nemo) tipo_dcto,(ser_fact) serie_fact, rtrim(nro_fact) as nro_factura,c.estado    */ ,estado     
 from acta_entrega c (nolock)  join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov            
--     left join factura f (nolock) on f.codi_fact=c.codi_fact            
--     left join tipo_documento td (nolock) on td.codi_tipo_docu=f.codi_tipo_docu       
       left join @tt t on t.codi_act_act=c.codi_act      
where c.codi_alma in (select codi_alma from @alma)            
     and cast(nro as varchar(10))= (@nro_docu)            
 order by c.codi_alma, nro            
end            
            
else if @tipo='C'  -- POR CLIENTE              
begin              
    select distinct codi_act,nro,c.codi_alma,fecha,c.codi_clie_prov,denominacion,nro_act as nro_conv, nro_factura_act as fact_asociadas /*,rtrim(nemo) tipo_dcto,(ser_fact) serie_fact, rtrim(nro_fact) as nro_factura,c.estado */,estado           
    from acta_entrega c (nolock)  join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov            
 --   left join factura f (nolock) on f.codi_fact=c.codi_fact            
 --   left join tipo_documento td (nolock) on td.codi_tipo_docu=f.codi_tipo_docu            
  left join @tt t on t.codi_act_act=c.codi_act      
    where c.codi_alma in (select codi_alma from @alma)            
    and (convert(varchar(10), fecha , 103) between @fec1 and @fec2)              
    and c.codi_clie_prov=@codi_clie_prov            
    order by c.codi_alma, nro            
            
end            
            
else  ---Solo entre Fechas            
            
   select distinct codi_act,nro,c.codi_alma,fecha,c.codi_clie_prov,denominacion,nro_act as nro_conv, nro_factura_act as fact_asociadas /*,rtrim(nemo) tipo_dcto,(ser_fact) serie_fact, rtrim(nro_fact) as nro_factura,c.estado      */ ,estado     
    from acta_entrega c (nolock)  join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov            
--    left join  factura f (nolock) on f.codi_fact=c.codi_fact            
--    left join tipo_documento td (nolock) on td.codi_tipo_docu=f.codi_tipo_docu         
   left join @tt t on t.codi_act_act=c.codi_act         
    where c.codi_alma in (select codi_alma from @alma)            
    and (convert(varchar(10), fecha , 103) between @fec1 and @fec2)              
    order by c.codi_alma, nro
GO
