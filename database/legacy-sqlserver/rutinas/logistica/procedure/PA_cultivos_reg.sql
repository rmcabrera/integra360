CREATE PROCEDURE [dbo].[PA_cultivos_reg]
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @codi_alma char(2), @fec1 datetime , @fec2 datetime
--select @codi_alma='00' , @fec1 ='01/01/2010' , @fec2 ='02/11/2010'

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
select codi_culti, cultivo, periodo, epoca, zona, rendimiento,
       porc_parti, codi_usua, fecha, nro_peri, codi_alma
from dbo.CULTIVOS_PRINCIPAL (nolock)
where fecha between @fec1 and @fec2 and isnull(codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
GO
