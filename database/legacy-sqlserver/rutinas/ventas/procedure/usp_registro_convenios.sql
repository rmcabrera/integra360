CREATE PROCEDURE [dbo].[usp_registro_convenios]
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
--select @tipo ='', @codi_alma ='00', @fec1 ='01/06/2012', @fec2 ='06/07/2012', @nro_docu ='0', @codi_clie_prov ='15550',@nro_docu_fact  ='166'        
          
        
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
        
if @tipo='N'  --POR NRO DOCUMENTO          
begin        
        
  select c.codi_conv,nro,c.codi_alma,fecha,c.codi_clie_prov,denominacion,rtrim(nemo) tipo_dcto,(ser_fact) serie_fact, rtrim(nro_fact) as nro_factura,c.estado      
 from convenio c (nolock)  join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov        
     left join factura f (nolock) on f.codi_fact=c.codi_fact        
     left join tipo_documento td (nolock) on td.codi_tipo_docu=f.codi_tipo_docu        
 where c.codi_alma in (select codi_alma from @alma)        
     and cast(nro as varchar(10))= (@nro_docu)        
 order by c.codi_alma, nro        
end        
        
else if @tipo='C'  -- POR CLIENTE          
begin          
    select c.codi_conv,nro,c.codi_alma,fecha,c.codi_clie_prov,denominacion,rtrim(nemo) tipo_dcto,(ser_fact) serie_fact, rtrim(nro_fact) as nro_factura,c.estado        
    from convenio c (nolock)  join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov        
    left join factura f (nolock) on f.codi_fact=c.codi_fact        
    left join tipo_documento td (nolock) on td.codi_tipo_docu=f.codi_tipo_docu        
    where c.codi_alma in (select codi_alma from @alma)        
    and (convert(varchar(10), fecha , 103) between @fec1 and @fec2)          
    and c.codi_clie_prov=@codi_clie_prov        
    order by c.codi_alma, nro        
        
end        
        
else if @tipo='F'  --POR NRO DOCUMENTO          
begin        
        
  select c.codi_conv,nro,c.codi_alma,fecha,c.codi_clie_prov,denominacion,rtrim(nemo) tipo_dcto,(ser_fact) serie_fact, rtrim(nro_fact) as nro_factura,c.estado        
 from convenio c (nolock)  join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov        
     left join factura f (nolock) on f.codi_fact=c.codi_fact        
     left join tipo_documento td (nolock) on td.codi_tipo_docu=f.codi_tipo_docu        
 where c.codi_alma in (select codi_alma from @alma)        
     and nro_fact= @nro_docu_fact        
 order by c.codi_alma, nro        
         
end        
        
else  ---Solo entre Fechas        
        
   select c.codi_conv,nro,c.codi_alma,fecha,c.codi_clie_prov,denominacion,rtrim(nemo) tipo_dcto,(ser_fact) serie_fact, rtrim(nro_fact) as nro_factura,c.estado        
    from convenio c (nolock)  join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov        
    left join  factura f (nolock) on f.codi_fact=c.codi_fact        
    left join tipo_documento td (nolock) on td.codi_tipo_docu=f.codi_tipo_docu        
    where c.codi_alma in (select codi_alma from @alma)        
    and (convert(varchar(10), fecha , 103) between @fec1 and @fec2)          
    order by c.codi_alma, nro
GO
