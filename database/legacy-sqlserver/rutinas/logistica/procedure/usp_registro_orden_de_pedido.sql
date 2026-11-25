CREATE PROCEDURE [dbo].[usp_registro_orden_de_pedido]
	@tipo [char](1),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](12),
	@codi_soli [char](5)
WITH EXECUTE AS CALLER
AS
--declare @tipo char(1), @fec1 datetime, @fec2 datetime, @nro_docu varchar(12), @codi_soli char(5)
--select @tipo='F', @fec1='01/08/2018', @fec2='30/08/2018', @nro_docu='4', @codi_soli=''

set nocount on

if @tipo='N'  --POR NRO DOCUMENTO
begin
	
select o.codi_orde_pedi, o.nro_orde_pedi, o.fech_pedi, o.motivo, o.observacion,     
       (select isnull(desc_unid_oper,'') from dbo.unid_oper u(nolock) where u.codi_unid_oper=o.codi_unid_oper_soli) unid_oper_soli,
       (select isnull(desc_unid_oper,'') from dbo.unid_oper u(nolock) where u.codi_unid_oper=o.codi_unid_oper_dest) unid_oper_dest, 
       (select isnull(apel_1,'') + ' ' + isnull(apel_2,'') + ' ' + isnull(nomb_1,'') + ' ' + isnull(nomb_2,'') from usuarios s(nolock)
	   where s.codi_usua=o.codi_pers_resp) usuarios,
       (select isnull(desc_esta,'') from dbo.estados e(nolock) where e.estado=o.estado) estado, isnull(pedi_trab,'') pedi_trab,
       dbo.uf_nro_pedi_x_oc(codi_orde_pedi) nro_orde_comp,
       (select nemo_alma from almacen A (nolock) where A.codi_alma = o.codi_alma) almacen,
       dbo.uf_nro_pedi_x_guia(codi_orde_pedi) guia_r
       
from dbo.orden_de_pedido o(nolock)
where o.nro_orde_pedi = @nro_docu
order by o.nro_orde_pedi
end

else if @tipo='C'  --POR UO SOLICITA
begin

select o.codi_orde_pedi, o.nro_orde_pedi, o.fech_pedi, o.motivo, o.observacion,     
       (select isnull(desc_unid_oper,'') from dbo.unid_oper u(nolock) where u.codi_unid_oper=o.codi_unid_oper_soli) unid_oper_soli,
       (select isnull(desc_unid_oper,'') from dbo.unid_oper u(nolock) where u.codi_unid_oper=o.codi_unid_oper_dest) unid_oper_dest, 
       (select isnull(apel_1,'') + ' ' + isnull(apel_2,'') + ' ' + isnull(nomb_1,'') + ' ' + isnull(nomb_2,'') from usuarios s(nolock)
	   where s.codi_usua=o.codi_pers_resp) usuarios,
       (select isnull(desc_esta,'') from dbo.estados e(nolock) where e.estado=o.estado) estado, isnull(pedi_trab,'') pedi_trab,
       dbo.uf_nro_pedi_x_oc(codi_orde_pedi) nro_orde_comp,
       (select nemo_alma from almacen A (nolock) where A.codi_alma = o.codi_alma) almacen,
       dbo.uf_nro_pedi_x_guia(codi_orde_pedi) guia_r
       
from dbo.orden_de_pedido o(nolock)
where isnull(o.codi_unid_oper_soli,'')=@codi_soli
order by o.nro_orde_pedi
end

else

select o.codi_orde_pedi, o.nro_orde_pedi, o.fech_pedi, o.motivo, o.observacion,     
       (select isnull(desc_unid_oper,'') from dbo.unid_oper u(nolock) where u.codi_unid_oper=o.codi_unid_oper_soli) unid_oper_soli,
       (select isnull(desc_unid_oper,'') from dbo.unid_oper u(nolock) where u.codi_unid_oper=o.codi_unid_oper_dest) unid_oper_dest, 
       (select isnull(apel_1,'') + ' ' + isnull(apel_2,'') + ' ' + isnull(nomb_1,'') + ' ' + isnull(nomb_2,'') from usuarios s(nolock)
	    where s.codi_usua=o.codi_pers_resp) usuarios,
       (select isnull(desc_esta,'') from dbo.estados e(nolock) where e.estado=o.estado) estado, isnull(pedi_trab,'') pedi_trab,
       dbo.uf_nro_pedi_x_oc(codi_orde_pedi) nro_orde_comp,
	   (select nemo_alma from almacen A (nolock) where A.codi_alma = o.codi_alma) almacen,
	   dbo.uf_nro_pedi_x_guia(codi_orde_pedi) guia_r
       
from dbo.orden_de_pedido o(nolock)
where convert(varchar(10),o.fech_pedi,103) between @fec1 and @fec2
order by o.nro_orde_pedi
GO
