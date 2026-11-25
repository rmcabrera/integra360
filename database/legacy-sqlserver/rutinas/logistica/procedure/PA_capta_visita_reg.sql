CREATE PROCEDURE [dbo].[PA_capta_visita_reg]
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @codi_alma char(2), @fec1 datetime , @fec2 datetime
--select @codi_alma='01' , @fec1 ='01/01/2010' , @fec2 ='02/11/2010'

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
select codi_capta, fecha, agricultor, zona,
       cultivo, area, etapa, codi_usua, tipo, codi_rec, codi_alma,
       (select isnull(apel_1,'')+isnull(' ' + apel_2,'')+isnull(' ' + nomb_1,'')+isnull(' ' + nomb_2,'') from dbo.usuarios u(nolock)
	where u.codi_usua=CAPTACION_VISITA.codi_usua) responsable, telefono, e_mail, siembra 
from dbo.CAPTACION_VISITA (nolock)
where fecha between @fec1 and @fec2 and isnull(codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
GO
