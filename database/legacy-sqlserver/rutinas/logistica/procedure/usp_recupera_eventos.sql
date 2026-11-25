CREATE PROCEDURE [dbo].[usp_recupera_eventos]
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@tipo [varchar](20)
WITH EXECUTE AS CALLER
AS
--declare @codi_alma char(2), @fec1 datetime , @fec2 datetime, @tipo varchar(20)
--select @codi_alma='00' , @fec1 ='01/01/2010' , @fec2 ='02/11/2010', @tipo = 'OPERATIVO'

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

select codi_plan, fecha, h_ini, h_fin, evento,notas
from evento (nolock)
where tipo =@tipo and fecha between @fec1 and @fec2
	and isnull(codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
GO
