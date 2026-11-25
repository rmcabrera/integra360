CREATE PROCEDURE [dbo].[usp_reporte_odc_all]
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime, @fec2 datetime
--select @fec1='01/11/2010', @fec2='01/12/2010'

set nocount on 
select p.codi_orden_des, p.nro_orden_des, p.codi_orden_soli,   
         p.tipo, p.fecha,
	(select isnull(desc_unid_oper,'') from dbo.unid_oper u(nolock) where u.codi_unid_oper=d.codi_tracto) desc_tracto,  
	(select isnull(desc_trans,'') from dbo.transportistas x(nolock)  where x.codi_trans=d.codi_trans) desc_chofer,
	(select isnull(desc_prod,'') from dbo.productos p(nolock) where p.codi_prod=d.codi_prod) desc_prod, 
	 cantidad, precio, 
	(select case when codi_mone='01' then importe else 0 end) importe_s,
	(select case when codi_mone='02' then importe else 0 end) importe_d
from dbo.ORDEN_DESPACHO_COMBUSTIBLE p(nolock)
join dbo.ORDEN_DESPACHO_COMBUSTIBLE_DETA d(nolock)
on p.codi_orden_des=d.codi_orden_des
where cast(convert(char(10),getdate(),103) as smalldatetime) between @fec1 and @fec2
GO
