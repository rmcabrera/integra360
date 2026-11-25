CREATE PROCEDURE [dbo].[usp_registro_orden_de_compra]
	@tipo [char](1),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](12),
	@codi_clie [char](5)
WITH EXECUTE AS CALLER
AS
--declare @tipo char(1), @fec1 datetime, @fec2 datetime, @nro_docu varchar(12), @codi_clie char(5)  
--select @tipo='F', @fec1='01/01/2017', @fec2='25/04/2018', @nro_docu='', @codi_clie=''  
  
set nocount on  
  
if @tipo='N'  --POR NRO DOCUMENTO  
begin  
select oc.codi_orde_comp, oc.nro_orde_comp, oc.fecha,       
 (select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end  
  from dbo.cliente_proveedor c(nolock) where c.codi_clie_prov=oc.codi_clie_prov) cliente,  
 (select desc_unid_oper from dbo.unid_oper u(nolock) where u.codi_unid_oper=oc.codi_unid_oper_soli) unid_oper_soli,   
 (select desc_unid_oper from dbo.unid_oper u(nolock) where u.codi_unid_oper=oc.codi_unid_oper_dest) unid_oper_dest,      
         oc.luga_entr, oc.fech_entr, isnull(oc.pedi_trab,'') pedi_trab, codi_mone, 
 case when isnull(estado,'')='N' then 0 else (case when codi_mone='01' then oc.total else 0 end) end total,  
 case when isnull(estado,'')='N' then 0 else (case when codi_mone='01' then 0  else  oc.total end) end total_d,  
  
(case when (select isnull(sum(cantidad),0) from dbo.detalle_orden_compra x(nolock) where x.codi_orde_comp=oc.codi_orde_comp) <=  
     (select isnull(sum(cantidad),0) from detalle_nota_ingreso D(nolock) where left(D.codi_deta_orde_comp,10)=oc.codi_orde_comp) or oc.estado='T' then 'TOTAL' else  
 (case when (select isnull(sum(cantidad),0) from dbo.detalle_orden_compra x(nolock) where x.codi_orde_comp=oc.codi_orde_comp) -  
      (select isnull(sum(cantidad),0) from detalle_nota_ingreso D(nolock) where left(D.codi_deta_orde_comp,10)=oc.codi_orde_comp) =   
     (select isnull(sum(cantidad),0) from dbo.detalle_orden_compra x(nolock) where x.codi_orde_comp=oc.codi_orde_comp) then 'NO ATENDIDO' else 'PARCIAL' end) end) condicion,  
  
 (select nro_nota_ingr from dbo.nota_ingreso A(nolock) where A.codi_nota_ingr in  
  (select max(codi_nota_ingr) from dbo.detalle_nota_ingreso D(nolock) where left(D.codi_deta_orde_comp,10)=oc.codi_orde_comp)) nro_ni,  
 /*(select isnull(descripcion,'') from sedes_oficina S(nolock) where s.codi_ofi=oc.codi_ofi)*/'' oficina, estado, apro_por,  
  (select apel_1+isnull(' '+apel_2,'') + isnull(' ' +nomb_1,'') + isnull(' '+nomb_2,'')   
  from usuarios U (nolock) where u.codi_usua=hech_por) hech_por, anulado , afec_rete, obse_2  
  
from dbo.orden_de_compra oc(nolock)  
where oc.nro_orde_comp = @nro_docu and oc.pedi_trab = 'P'      
order by oc.nro_orde_comp  
end  
  
else if @tipo='C'  --POR UO SOLICITA  
begin  
  
select oc.codi_orde_comp, oc.nro_orde_comp, oc.fecha,       
 (select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end  
  from dbo.cliente_proveedor c(nolock) where c.codi_clie_prov=oc.codi_clie_prov) cliente,   
 (select desc_unid_oper from dbo.unid_oper u(nolock) where u.codi_unid_oper=oc.codi_unid_oper_soli) unid_oper_soli,   
 (select desc_unid_oper from dbo.unid_oper u(nolock) where u.codi_unid_oper=oc.codi_unid_oper_dest) unid_oper_dest,      
         oc.luga_entr, oc.fech_entr, isnull(oc.pedi_trab,'') pedi_trab, codi_mone, 
         
 case when isnull(estado,'')='N' then 0 else (case when codi_mone='01' then oc.total else 0 end) end total,  
 case when isnull(estado,'')='N' then 0 else (case when codi_mone='01' then 0  else  oc.total end) end total_d,  
 
(case when (select isnull(sum(cantidad),0) from dbo.detalle_orden_compra x(nolock) where x.codi_orde_comp=oc.codi_orde_comp) <=  
     (select isnull(sum(cantidad),0) from detalle_nota_ingreso D(nolock) where left(D.codi_deta_orde_comp,10)=oc.codi_orde_comp) or oc.estado='T' then 'TOTAL' else  
 (case when (select isnull(sum(cantidad),0) from dbo.detalle_orden_compra x(nolock) where x.codi_orde_comp=oc.codi_orde_comp) -  
      (select isnull(sum(cantidad),0) from detalle_nota_ingreso D(nolock) where left(D.codi_deta_orde_comp,10)=oc.codi_orde_comp) =   
     (select isnull(sum(cantidad),0) from dbo.detalle_orden_compra x(nolock) where x.codi_orde_comp=oc.codi_orde_comp) then 'NO ATENDIDO' else 'PARCIAL' end) end) condicion,  
 (select nro_nota_ingr from dbo.nota_ingreso A(nolock) where A.codi_nota_ingr in  
  (select max(codi_nota_ingr) from dbo.detalle_nota_ingreso D(nolock) where left(D.codi_deta_orde_comp,10)=oc.codi_orde_comp)) nro_ni,  
 /*(select isnull(descripcion,'') from sedes_oficina S(nolock) where s.codi_ofi=oc.codi_ofi)*/'' oficina, estado, apro_por,  
  (select apel_1+isnull(' '+apel_2,'') + isnull(' ' +nomb_1,'') + isnull(' '+nomb_2,'')   
  from usuarios U (nolock) where u.codi_usua=hech_por) hech_por, anulado  , afec_rete, obse_2
  
from dbo.orden_de_compra oc(nolock)  
where isnull(oc.codi_clie_prov,'')=@codi_clie and oc.pedi_trab = 'P'      
order by oc.nro_orde_comp  
end  
  
else  
  
select oc.codi_orde_comp, oc.nro_orde_comp, oc.fecha,       
 (select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end  
  from dbo.cliente_proveedor c(nolock) where c.codi_clie_prov=oc.codi_clie_prov) cliente,  
 (select desc_unid_oper from dbo.unid_oper u(nolock) where u.codi_unid_oper=oc.codi_unid_oper_soli) unid_oper_soli,   
 (select desc_unid_oper from dbo.unid_oper u(nolock) where u.codi_unid_oper=oc.codi_unid_oper_dest) unid_oper_dest,      
         oc.luga_entr, oc.fech_entr, isnull(oc.pedi_trab,'') pedi_trab, codi_mone, 
 case when isnull(estado,'')='N' then 0 else (case when codi_mone='01' then oc.total else 0 end) end total,  
 case when isnull(estado,'')='N' then 0 else (case when codi_mone='01' then 0  else  oc.total end) end total_d,  

case when oc.estado='T' then 'TOTAL'
	else
		case (select isnull(sum(cantidad),0) from dbo.detalle_orden_compra x(nolock) where x.codi_orde_comp=oc.codi_orde_comp) -  
			(select isnull(sum(cantidad),0) from detalle_nota_ingreso D(nolock) where left(D.codi_deta_orde_comp,10)=oc.codi_orde_comp) 
			when 0 then 'TOTAL' 
			when (select isnull(sum(cantidad),0) from dbo.detalle_orden_compra x(nolock) where x.codi_orde_comp=oc.codi_orde_comp) then 'NO ATENDIDO' 
			else 'PARCIAL' end
	end	condicion,
/*	
(case when (select isnull(sum(cantidad),0) from dbo.detalle_orden_compra x(nolock) where x.codi_orde_comp=oc.codi_orde_comp) <=  
     (select isnull(sum(cantidad),0) from detalle_nota_ingreso D(nolock) where left(D.codi_deta_orde_comp,10)=oc.codi_orde_comp) or oc.estado='T' 
  then 'TOTAL' 
  else  
	(case when (select isnull(sum(cantidad),0) from dbo.detalle_orden_compra x(nolock) where x.codi_orde_comp=oc.codi_orde_comp) -  
		  (select isnull(sum(cantidad),0) from detalle_nota_ingreso D(nolock) where left(D.codi_deta_orde_comp,10)=oc.codi_orde_comp) =   
		(select isnull(sum(cantidad),0) from dbo.detalle_orden_compra x(nolock) where x.codi_orde_comp=oc.codi_orde_comp) then 'NO ATENDIDO' else 'PARCIAL' end) end) condicion, */ 
         
 /*(select nro_nota_ingr from dbo.nota_ingreso A(nolock) 
	where A.codi_nota_ingr in  
		(select max(codi_nota_ingr) from dbo.detalle_nota_ingreso D(nolock) 
			where left(D.codi_deta_orde_comp,10)=oc.codi_orde_comp)) nro_ni,  */
 
 (select distinct top 1 nro_nota_ingr from dbo.nota_ingreso A(nolock) 
	join NOTA_INGR_POR_ORDE_COMP N (nolock) 
	on A.codi_nota_ingr =N.codi_nota_ingr 
	where N.codi_orde_comp=oc.codi_orde_comp) as nro_ni,
 
   '' oficina, estado, apro_por,  
  (select apel_1+isnull(' '+apel_2,'') + isnull(' ' +nomb_1,'') + isnull(' '+nomb_2,'')   
		from usuarios U (nolock) where u.codi_usua=hech_por) hech_por, 
   anulado, afec_rete, obse_2
from dbo.orden_de_compra oc(nolock)  
where oc.pedi_trab = 'P'   and convert(varchar(10),oc.fecha,103) between @fec1 and @fec2
--and NRO_ORDE_COMP=3032
order by oc.nro_orde_comp
GO
