CREATE PROCEDURE [dbo].[usp_formato_74_activos]
	@anio [int]
WITH EXECUTE AS CALLER
AS
--declare @anio int
--select @anio = 2013

set nocount on 

declare @Fec char(6)
set @Fec = cast(@anio as varchar) + '12'

select A.FECHA_CONTRATO, A.NRO_CON_ARRE, A.FECHA_INI_ARRE,A.NRO_CUOTAS,A.MONTO_ARRE,	
	(Select razon_social from empresa (nolock)) Empresa,
	(Select ruc from empresa (nolock)) ruc
from activos A (nolock) 
--join detalle_calc_af B (nolock)
--on A.codi_Activo=B.codi_Activo
where year(FECHA_CONTRATO) <= @anio
GO
