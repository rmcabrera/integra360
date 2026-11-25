CREATE PROCEDURE [dbo].[usp_registro_control_problemas]
	@F1 [datetime],
	@F2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @F1 datetime, @F2 datetime
--select @F1 ='01/07/2024', @F2 ='30/11/2024'

set nocount on

select A.id_control, A.nro_control, fecha,
	   descripcion,
	   (select apel_1 + isnull(' '+apel_2,'') + isnull(' '+nomb_1,'') from usuarios (nolock) where codi_usua=hecho_por) responsable
		
from CONTROL_PROBLEMAS A(nolock)
where cast(convert(char(10),fecha,103) as datetime) between @F1 and @F2
order by fecha
GO
