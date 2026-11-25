CREATE PROCEDURE [dbo].[usp_recupera_eventos_ruta]
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@user [char](5)
WITH EXECUTE AS CALLER
AS
--declare @codi_alma char(2), @fec1 datetime , @fec2 datetime, @user varchar(20)
--select @codi_alma='00' , @fec1 ='01/01/2010' , @fec2 ='25/11/2010', @user = '00000'

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

select codi_ruta, zona, cliente, cultivo, area, fecha, codi_alma, zona_aux
from dbo.ruta_semanal (nolock)
where codi_usua =@user and fecha between @fec1 and @fec2
	and isnull(codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
GO
