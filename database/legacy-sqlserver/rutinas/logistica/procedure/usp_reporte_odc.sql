CREATE PROCEDURE [dbo].[usp_reporte_odc]
	@id [int]
WITH EXECUTE AS CALLER
AS
--declare @id int
--select @id=2
set nocount on 
select p.codi_orden_des, p.nro_orden_des, p.codi_orden_soli,   
         p.tipo, p.fecha,
	(select isnull(desc_unid_oper,'') from dbo.unid_oper u(nolock) where u.codi_unid_oper=d.codi_tracto) desc_tracto,  
	(select isnull(desc_trans,'') from dbo.transportistas x(nolock)  where x.codi_trans=d.codi_trans) desc_chofer,
	(select isnull(desc_prod,'') from dbo.productos p(nolock) where p.codi_prod=d.codi_prod) desc_prod, 
	cantidad, precio, p.autoriza_por, p.elabora_por, p.codi_clie_prov,
	(select isnull(desc_mone,'') from dbo.monedas m(nolock) where m.codi_mone=p.codi_mone) desc_mone
from dbo.ORDEN_DESPACHO_COMBUSTIBLE p(nolock)
join dbo.ORDEN_DESPACHO_COMBUSTIBLE_DETA d(nolock)
on p.codi_orden_des=d.codi_orden_des   
where p.codi_orden_des=@id
GO
