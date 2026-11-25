CREATE PROCEDURE [dbo].[PA_captacion_clie_reg]
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @codi_alma char(2), @fec1 datetime , @fec2 datetime
--select @codi_alma='00' , @fec1 ='17/10/2014' , @fec2 ='25/10/2014'

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

set nocount on 
select c.codi_cap, c.nro_doc,   
	(select case when tipo_pers='Natural' then isnull(nomb_1,'') + isnull(' ' + nomb_2,'') + isnull(' ' + apel_1,'') + isnull(' ' + apel_2,'') else
		(select case when cliente is null or rtrim(cliente)='' then denominacion else cliente end) end) as cliente,
         c.zona, c.cultivo, c.area,   
         c.etapa, c.captado, c.observaciones,   
         (select isnull(apel_1,'')+isnull(' ' + apel_2,'')+isnull(' ' + nomb_1,'')+isnull(' ' + nomb_2,'') from dbo.usuarios u(nolock)
	where u.codi_usua=c.codi_usua) codi_usua, 
	  cast(convert(char(10),fecha,103) as datetime) fecha, tipo_pers, codi_clie_prov, codi_alma,
	(case frecuencia when 'AL' then 'ALTA' 
	     when 'ME' then 'MEDIA'
	     when 'BA' then 'BAJA'
	     when '' then '' end) as frecuencia
from dbo.CAPTACION c(nolock)
where fecha between @fec1 and @fec2 and isnull(codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
GO
