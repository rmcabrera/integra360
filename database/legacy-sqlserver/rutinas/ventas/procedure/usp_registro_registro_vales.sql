CREATE PROCEDURE [dbo].[usp_registro_registro_vales]
	@tipo [char](1),
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_vale_docu [varchar](5),
	@codi_clie_prov [varchar](5),
	@nro_vale_docu_fact [varchar](8)
WITH EXECUTE AS CALLER
AS
--declare @tipo as char(1) , @codi_alma char(2)  , @fec1 datetime , @fec2 datetime , @nro_vale_docu varchar(5) , @codi_clie_prov varchar(5), @nro_vale_docu_fact varchar(8)           
--select @tipo ='', @codi_alma ='06', @fec1 ='01/01/2015', @fec2 ='11/05/2015', @nro_vale_docu ='2246', @codi_clie_prov ='11311',@nro_vale_docu_fact  =''               
        
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
        
if @tipo='N'  --POR nro_vale DOCUMENTO          
begin        
        
 select codi_vale,nro_vale,c.codi_alma,fecha,c.codi_clie_prov,denominacion,f.codi_fact,  
    case when isnull(c.codi_fact,'')<>'' then
		rtrim(td.nemo)+' '+ cast(ser_fact as varchar )+ '-' +cast(rtrim(nro_fact) as varchar) 
	else
		/*(select codi_depo from CAJA_CHICA_DEPO where tipo_rela='S' and codi_docu=c.codi_vale)*/
		dbo.uf_nro_depo_x_vale_cred(c.codi_vale)
	end	as nro_factura,  
    c.codi_mone,c.tcambio,tp.desc_tipo_medio_pago   , 
    case when c.estado='N' then 0 else C.valo_fact end valo_fact,
    case when c.estado='N' then 0 else C.subtota_fact end subtota_fact , 
    case when c.estado='N' then 0 else C.igv_fact end igv_fact, 
    case when c.estado='N' then 0 else C.tota_Fact end tota_fact,
    (case when c.estado='N' then 0 else C.tota_exonerado end) tota_exonerado,
    c.estado 
      
 from registro_vale c (nolock)  join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov     
     left join factura f (nolock) on c.codi_fact=f.codi_fact   
       left join tipo_documento td (nolock) on f.codi_tipo_docu=td.codi_tipo_docu        
       left join dbo.tipo_pago TP (nolock) on c.codi_tipo_pago=TP.codi_tipo_medio_pago      
 where c.codi_alma in (select codi_alma from @alma)        
     and cast(nro_vale as varchar(10))= (@nro_vale_docu)        
 order by c.codi_alma, nro_vale        
         
end        
        
else if @tipo='C'  -- POR CLIENTE          
begin          
    select codi_vale,nro_vale,c.codi_alma,fecha,c.codi_clie_prov,denominacion ,f.codi_fact,  
    case when isnull(c.codi_fact,'')<>'' then
		rtrim(td.nemo)+' '+ cast(ser_fact as varchar )+ '-' +cast(rtrim(nro_fact) as varchar) 
	else
		/*(select codi_depo from CAJA_CHICA_DEPO where tipo_rela='S' and codi_docu=c.codi_vale)*/
		dbo.uf_nro_depo_x_vale_cred(c.codi_vale)
	end	as nro_factura,  
    c.codi_mone,c.tcambio,tp.desc_tipo_medio_pago   , 
    --C.valo_fact,C.subtota_fact , C.igv_fact , C.tota_Fact,
    case when c.estado='N' then 0 else C.valo_fact end valo_fact,
    case when c.estado='N' then 0 else C.subtota_fact end subtota_fact , 
    case when c.estado='N' then 0 else C.igv_fact end igv_fact, 
    case when c.estado='N' then 0 else C.tota_Fact end tota_fact,
    (case when c.estado='N' then 0 else C.tota_exonerado end) tota_exonerado,
	c.estado  
	  
    from registro_vale c (nolock)  join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov   
     left join factura f (nolock) on c.codi_fact=f.codi_fact   
       left join tipo_documento td (nolock) on f.codi_tipo_docu=td.codi_tipo_docu        
       left join dbo.tipo_pago TP (nolock) on c.codi_tipo_pago=TP.codi_tipo_medio_pago        
    where c.codi_alma in (select codi_alma from @alma)        
    and (convert(varchar(10), fecha , 103) between @fec1 and @fec2)          
    and c.codi_clie_prov=@codi_clie_prov        
    order by c.codi_alma, nro_vale        
        
end        
        
else if @tipo='F'  --POR nro_vale DOCUMENTO    
begin        
        
  select codi_vale,nro_vale,c.codi_alma,fecha,c.codi_clie_prov,denominacion,f.codi_fact,  
    case when isnull(c.codi_fact,'')<>'' then
		rtrim(td.nemo)+' '+ cast(ser_fact as varchar )+ '-' +cast(rtrim(nro_fact) as varchar) 
	else
		/*(select codi_depo from CAJA_CHICA_DEPO where tipo_rela='S' and codi_docu=c.codi_vale)*/
		dbo.uf_nro_depo_x_vale_cred(c.codi_vale)
	end	as nro_factura,  
    c.codi_mone,c.tcambio,tp.desc_tipo_medio_pago   , 
    --C.valo_fact,C.subtota_fact , C.igv_fact , C.tota_Fact,
    case when c.estado='N' then 0 else C.valo_fact end valo_fact,
    case when c.estado='N' then 0 else C.subtota_fact end subtota_fact , 
    case when c.estado='N' then 0 else C.igv_fact end igv_fact, 
    case when c.estado='N' then 0 else C.tota_Fact end tota_fact,
    (case when c.estado='N' then 0 else C.tota_exonerado end) tota_exonerado,
    c.estado  
  from registro_vale c (nolock)  join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov   
      left join factura f (nolock) on c.codi_fact=f.codi_fact   
       left join tipo_documento td (nolock) on f.codi_tipo_docu=td.codi_tipo_docu        
       left join dbo.tipo_pago TP (nolock) on c.codi_tipo_pago=TP.codi_tipo_medio_pago         
where c.codi_alma in (select codi_alma from @alma)        
     and nro_vale= @nro_vale_docu_fact        
 order by c.codi_alma, nro_vale        
         
end        
        
else  ---Solo entre Fechas        
        
   select codi_vale, nro_vale,c.codi_alma,fecha,c.codi_clie_prov,denominacion,f.codi_fact,  
   case when isnull(c.codi_fact,'')<>'' then
		rtrim(td.nemo)+' '+ cast(ser_fact as varchar )+ '-' +cast(rtrim(nro_fact) as varchar) 
	else
		/*(select codi_depo from CAJA_CHICA_DEPO where tipo_rela='S' and codi_docu=c.codi_vale)*/
		dbo.uf_nro_depo_x_vale_cred(c.codi_vale)
	end	as nro_factura,  
    c.codi_mone,c.tcambio,tp.desc_tipo_medio_pago   , 
    --C.valo_fact,C.subtota_fact , C.igv_fact , C.tota_Fact,
    case when c.estado='N' then 0 else C.valo_fact end valo_fact,
    case when c.estado='N' then 0 else C.subtota_fact end subtoa_fact , 
    case when c.estado='N' then 0 else C.igv_fact end igv_fact, 
    case when c.estado='N' then 0 else C.tota_Fact end tota_fact,
    (case when c.estado='N' then 0 else C.tota_exonerado end) tota_exonerado,
    c.estado
      
    from registro_vale c (nolock)  left join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov       
              left join factura f (nolock) on c.codi_fact=f.codi_fact   
       left join tipo_documento td (nolock) on f.codi_tipo_docu=td.codi_tipo_docu        
       left join dbo.tipo_pago TP (nolock) on c.codi_tipo_pago=TP.codi_tipo_medio_pago    
    where c.codi_alma in (select codi_alma from @alma)        
    and (convert(varchar(10), fecha , 103) between @fec1 and @fec2)   
    --and c.codi_clie_prov='07966'       
    order by c.codi_alma, nro_vale
GO
