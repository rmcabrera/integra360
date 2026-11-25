CREATE PROCEDURE [dbo].[ups_lista_vales_x_fact_salida]
	@cliente [char](5),
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
set nocount on     
    
select nro_vale, codi_clie_prov, fecha, nro_vale, codi_vale,    
 isnull((select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end    
    from dbo.cliente_proveedor C (nolock)    
  where c.codi_clie_prov= R.codi_clie_prov),'') Razon,'0' chec,    
 isnull((select ruc from dbo.cliente_proveedor C (nolock) where c.codi_clie_prov= R.codi_clie_prov),'') RUC    
from dbo.registro_vale R (nolock)  
where ( (codi_Fact is null or rtrim(codi_Fact)='') ) and codi_clie_prov=@cliente     and codi_alma=@alma
GO
