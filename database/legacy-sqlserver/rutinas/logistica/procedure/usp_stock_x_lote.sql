CREATE PROCEDURE [dbo].[usp_stock_x_lote]
	@Alm [char](2)
WITH EXECUTE AS CALLER
AS
--declare @Alm char(2)
--select @Alm ='02'

set nocount on
set quoted_identifier off

declare @SQLSTRING nvarchar(4000)
declare @Condi varchar(100)

if @alm='00' set @Condi=" " else set @Condi =" and codi_alma="+@alm
 
set @SQLString = "select codi_prod, (select desc_prod from productos P (nolock) where P.codi_prod=L.codi_prod) descp,
			lote, fec_vence, stock , (select razon_social from empresa (nolock)) empresa, codi_alma,
			(select nemo_alma from almacen A (nolock) where A.codi_alma=L.codi_alma) almacen
		from producto_almacen_lote L (nolock) 
		where stock<>0 "+ @Condi + " order by 2 "

execute sp_executesql @Sqlstring

set quoted_identifier on
GO
