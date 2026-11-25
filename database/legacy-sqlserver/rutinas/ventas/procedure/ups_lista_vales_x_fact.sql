CREATE PROCEDURE [dbo].[ups_lista_vales_x_fact]
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @alma char(2)
--select @alma='02'

set nocount on     
    
select nro_vale , codi_clie_prov, fecha, nro_vale, codi_vale,    
 isnull((select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end    
    from dbo.cliente_proveedor C (nolock)    
  where c.codi_clie_prov= R.codi_clie_prov),'') Razon,'0' chec,    
 isnull((select ruc from dbo.cliente_proveedor C (nolock) where c.codi_clie_prov= R.codi_clie_prov),'') RUC  
from dbo.registro_vale R (nolock) 
where  ( (codi_Fact is null or rtrim(codi_Fact)='')  )  and codi_tipo_pago='4' and codi_alma=@alma and isnull(estado,'')=''
--and nro_vale in (2476,2477)
GO
