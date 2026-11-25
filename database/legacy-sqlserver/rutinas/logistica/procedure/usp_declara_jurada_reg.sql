CREATE PROCEDURE [dbo].[usp_declara_jurada_reg]
	@tipo [char](1),
	@fec1 [datetime],
	@fec2 [datetime],
	@codi_clie_prov [varchar](5),
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @tipo as char(1), @fec1 datetime, @fec2 datetime, @codi_clie_prov varchar(5), @codi_alma char(2)
--select @tipo ='F', @fec1 ='01/01/2017', @fec2 ='29/06/2017', @codi_clie_prov =1, @codi_alma='00'

set nocount on 

declare @alma table (codi_alma char(2) null)

if @codi_alma = '00'
begin
	insert @alma
	Select codi_alma from almacen (nolock)
end
else
begin
	insert @alma
	Select codi_alma from almacen (nolock) where codi_alma = @codi_alma
end

if @tipo='C'  --POR CÓDIGO
begin
	
select codi_decla,
       (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'')
       from personal p(nolock) where p.codi_pers=D.codi_pers) personal,
	   codi_alma, (select desc_alma from almacen a(nolock) where a.codi_alma=D.codi_alma) almacen,
	   fecha_decla, direccion, lugar
	
from declara_jurada D(nolock)
where D.codi_alma in (select A.codi_alma from @alma A) and codi_decla = cast(@codi_clie_prov as numeric(18))
end
else

-- ENTRE FECHAS

select codi_decla,
       (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'')
       from personal p(nolock) where p.codi_pers=D.codi_pers) personal,
	   codi_alma, (select desc_alma from almacen a(nolock) where a.codi_alma=D.codi_alma) almacen,
	   fecha_decla, direccion, lugar
         
from declara_jurada D(nolock)
where D.codi_alma in (select A.codi_alma from @alma A) and
convert(char(10),fecha_decla,103) between @fec1 and @fec2
GO
