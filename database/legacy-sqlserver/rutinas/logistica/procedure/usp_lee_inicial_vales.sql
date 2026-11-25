CREATE PROCEDURE [dbo].[usp_lee_inicial_vales]
WITH EXECUTE AS CALLER
AS
set nocount on
declare @Fech datetime
set @fech = cast(convert(char(10),getdate(),103) as smalldatetime)

select codi_prod, desc_prod,
	 round(prec_prov * ( 1 -  descto_porcenta / 100 ) ,2)* case when codi_mone='02' then isnull(tcambio ,1) else 1 end COSTO
from dbo.productos (nolock) 
order by 2
GO
