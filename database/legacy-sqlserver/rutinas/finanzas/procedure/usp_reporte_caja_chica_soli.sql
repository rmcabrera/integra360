CREATE PROCEDURE [dbo].[usp_reporte_caja_chica_soli]
	@F1 [datetime],
	@F2 [datetime],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @F1 datetime, @F2 datetime, @codi_alma char(2)
--select @F1='01/01/2011', @F2='10/03/2011', @codi_alma='02'

set nocount on
declare @alma table (codi_alma char(2) null)
if @codi_alma = '00'
begin
	insert @alma
	Select codi_alma from dbo.almacen (nolock)
end 
else
begin	insert @alma
	Select codi_alma from dbo.almacen (nolock) where codi_alma = @codi_alma
end

select 
	(select nemo_alma from dbo.almacen x(nolock) where x.codi_alma=CAJA_CHICA.codi_alma) almacen,
         nro_recibo, fecha, codi_mone,     
	(select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end
	 from dbo.cliente_proveedor c(nolock) where c.codi_clie_prov=CAJA_CHICA.codi_clie_prov) razon,
         CAJA_CHICA.glosa,      
	(select nemo from dbo.tipo_documento T(nolock) where T.codi_tipo_docu=CAJA_CHICA.codi_tipo_docu) docu,
         serie, nro_docu,   
     	(select isnull(desc_reemb,'') from dbo.tipo_reembolso A(nolock) where A.tipo_reemb=CAJA_CHICA.tipo_contab) concepto,
         case when codi_mone='01' then importe else 0 end importe,   
         case when codi_mone='02' then importe else 0 end importe_d,   
	(case when tipo_io=1 then 'INGRESOS' else 'EGRESOS' end) tipo_io,
         CAJA_CHICA.codi_usua_soli,
	 (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'')
	 from dbo.usuarios U(nolock) where U.codi_usua= CAJA_CHICA.codi_usua_soli) solicitante
from CAJA_CHICA (nolock)  
where 
cast( convert(char(10),CAJA_CHICA.fecha,103) as datetime) between @F1 and @F2 
and isnull(codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
GO
