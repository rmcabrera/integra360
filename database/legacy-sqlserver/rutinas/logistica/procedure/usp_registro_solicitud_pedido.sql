CREATE PROCEDURE [dbo].[usp_registro_solicitud_pedido]
	@tipo [char](1),
	@fec1 [datetime],
	@fec2 [datetime],
	@codi_alma [char](2),
	@nro_docu [int],
	@codi_uo [char](5)
WITH EXECUTE AS CALLER
AS
--declare @tipo char(1), @fec1 datetime, @fec2 datetime, @codi_alma char(2), @nro_docu int, @codi_uo char(5)  
--select @tipo='F', @fec1='01/01/2012', @fec2='03/07/2012', @codi_alma ='00', @nro_docu=972, @codi_uo='00006'
  
set nocount on  

declare @alma table (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock)
END
ELSE
BEGIN
	insert @alma
	Select codi_alma from almacen  (nolock) where codi_alma = @codi_alma
END


  
if @tipo='N'  --POR NRO DOCUMENTO  
begin  
select oc.codi_orden_pedi, oc.fecha,       
	 (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') 
	from usuarios U(nolock) where U.codi_usua=codi_pers_resp) responsable,  
	 (select desc_alma from almacen u(nolock) where u.codi_alma=oc.codi_unid_oper_soli) unid_oper_soli,   
	 (select desc_alma from almacen u(nolock) where u.codi_alma=oc.codi_unid_oper_dest) unid_oper_dest,         
	motivo, observacion, estado, dbo.uf_nro_guia_x_pedi(codi_orden_pedi) codi_guia, codi_unid_oper_soli, envio
from dbo.REGISTRO_ORDEN_PEDIDO oc(nolock)  
where oc.codi_orden_pedi = @nro_docu and codi_unid_oper_soli collate sql_latin1_general_cp1_ci_as in 
						(Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
order by oc.codi_orden_pedi
end  
  
else if @tipo='C'  --POR UO SOLICITA  
begin  
  
select oc.codi_orden_pedi, oc.fecha,       
	 (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') 
	from usuarios U(nolock) where U.codi_usua=codi_pers_resp) responsable,  
	 (select desc_alma from almacen u(nolock) where u.codi_alma=oc.codi_unid_oper_soli) unid_oper_soli,   
	 (select desc_alma from almacen u(nolock) where u.codi_alma=oc.codi_unid_oper_dest) unid_oper_dest,      
	motivo, observacion, estado, dbo.uf_nro_guia_x_pedi(codi_orden_pedi) codi_guia, codi_unid_oper_soli, envio
from dbo.REGISTRO_ORDEN_PEDIDO oc(nolock) 
where isnull(oc.codi_pers_resp,'')=@codi_uo and codi_unid_oper_soli collate sql_latin1_general_cp1_ci_as in 
						(Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)  
order by codi_orden_pedi
end  
  
else  
  
select oc.codi_orden_pedi, oc.fecha,       
	 (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') 
	from usuarios U(nolock) where U.codi_usua=codi_pers_resp) responsable,  
	 (select desc_alma from almacen u(nolock) where u.codi_alma=oc.codi_unid_oper_soli) unid_oper_soli,   
	 (select desc_alma from almacen u(nolock) where u.codi_alma=oc.codi_unid_oper_dest) unid_oper_dest,         
	motivo, observacion, estado, dbo.uf_nro_guia_x_pedi(codi_orden_pedi) codi_guia, codi_unid_oper_soli, envio
from dbo.REGISTRO_ORDEN_PEDIDO oc(nolock) 
where cast(convert(char(10),oc.fecha,103) as datetime) between @fec1 and @fec2 and codi_unid_oper_soli collate sql_latin1_general_cp1_ci_as in 
						(Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
order by oc.codi_orden_pedi
GO
