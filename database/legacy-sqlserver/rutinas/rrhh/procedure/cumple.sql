CREATE PROCEDURE [dbo].[cumple]
	@mes [varchar](2) = null
WITH EXECUTE AS CALLER
AS
if not @mes is null 
(select apel_1, apel_2, nomb_1, nomb_2 ,fech_naci , empresa.inicial , 
datename(mm,fech_naci) mes, empresa.grupo
from personal , empresa
where esta_Acti='1'  and datepart(mm, fech_naci)=@mes)
order by datepart(dd,fech_naci)
GO
