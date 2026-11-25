CREATE PROCEDURE [dbo].[usp_reporte_consoli_vacaciones]
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @alma char(2)  
--select @alma='09'  
  
set nocount on   
  
select codi_pers,   
  (select apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(' '+nomb_2,'') from personal P (nolock) where p.codi_pers=C.codi_pers) as Nombres,  
  min(fech_ingr) as fech_ingr,  
  codi_alma,  
  (select nemo_alma from almacen A (nolock) where A.CODI_ALMA=C.codi_alma) Sucursal,  
  anio_vaca,  
  sum(nro_dias) as Dias  
from CONTROL_VACACIONES as C (nolock)  
where codi_alma=@alma  
group by codi_pers, anio_vaca, codi_alma
GO
