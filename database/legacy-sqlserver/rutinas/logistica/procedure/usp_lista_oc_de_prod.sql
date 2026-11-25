CREATE PROCEDURE [dbo].[usp_lista_oc_de_prod]
	@f1 [datetime],
	@F2 [datetime],
	@codi_prod [char](8)
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime , @F2 datetime , @codi_prod char(8)
--select @f1='01/01/2014', @f2='31/10/2014', @codi_prod='00081216'

set nocount on


select A.codi_orde_comp,codi_clie_prov, dbo.f_cliente_proveedor(codi_Clie_prov) Cliente,
	fecha, cantidad, precio ,  cantidad*precio total, nro_orde_comp, codi_prod
from orden_de_compra A(nolock)
join detalle_orden_compra B (nolock)
on A.codi_orde_comp= B.codi_orde_comp
where cast(convert(char(10),fecha,103) as datetime) between @f1 and @F2 and pedi_trab='P'
	and codi_prod=@codi_prod
GO
