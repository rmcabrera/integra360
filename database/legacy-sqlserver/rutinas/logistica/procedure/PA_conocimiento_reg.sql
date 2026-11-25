CREATE PROCEDURE [dbo].[PA_conocimiento_reg]
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
select codi_con_mer, fecha, codi_alma, cultivo, variedad, epoca,
       periodo, zona, sector, area, rendimiento, 
       (select isnull(desc_alma,'') from dbo.almacen a(nolock) where a.codi_alma=conocimiento.codi_alma) sucursal, precio
from dbo.CONOCIMIENTO (nolock)
where fecha between @fec1 and @fec2 and isnull(codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
GO
