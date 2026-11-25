CREATE PROCEDURE [dbo].[cumplexanho]
WITH EXECUTE AS CALLER
AS
(select apel_1, apel_2,nomb_1,nomb_2 ,fech_naci , empresa.inicial , 
datename(mm,fech_naci) mes, empresa.grupo
from personal , empresa
where esta_Acti='1'  )
order by mes
GO
