CREATE PROCEDURE [dbo].[usp_repo_pendientes_convenio]
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @codi_alma char(2) 
--select  @codi_alma ='06'
             
select c.codi_conv,rtrim(nemo)  +' '+rtrim(ser_fact) +'-'+rtrim(nro_fact) as nro_factura,  
nro,saldo cantidad,d.codi_prod,desc_prod,d.fecha,denominacion, f.fech_fact,
	(select isnull(apel_1,'') + isnull(' '+apel_2,'') + isnull(' '+nomb_1,'') + isnull(' '+nomb_2 ,'')
		from usuarios (nolock) where codi_usua=cod_usua_vende) as vendedor

from convenio c (nolock)  join cliente_proveedor cp (nolock) on cp.codi_clie_prov=c.codi_clie_prov            
left join  factura f (nolock) on f.codi_fact=c.codi_fact            
left join tipo_documento td (nolock) on td.codi_tipo_docu=f.codi_tipo_docu            
join convenio_detalle d (nolock) on d.codi_conv=c.codi_conv  
join productos pdt (nolock) on pdt.codi_prod=d.codi_prod  
 where c.codi_alma = @codi_alma            
--and (cast(convert(varchar(10), c.fecha , 103)as datetime) <= cast(convert(char(10),getdate(),103)as datetime) )
and (c.estado is null or c.estado='')  
and (d.estado=0)  
order by c.codi_alma, nro
GO
