CREATE PROCEDURE [dbo].[usp_resumen_oc]
	@alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @alma char(2) , @fec1 datetime , @fec2 datetime , @prod char(8)  
--select @alma ='01' , @fec1='29/03/2017' , @fec2='29/03/2017', @prod='00012323' --@prod='00010846'  

set nocount on  

declare @Tx table (codi char(10), nro numeric(12), cliente char(5) null, fecha datetime null, codi_mone char(2) null,   
   total numeric(12,2) null, codi_deta char(12) null, codi_prod char(8) null,  
   cantidad numeric(12,4) null, precio numeric(12,4) null, atendido numeric(12,4) null,   
   tipo varchar(100) null, igv numeric(12,4) null, valo_vent int null, afe_exo int null, finaliza char(1) null)  
  
insert @Tx  
select O.codi_orde_comp, nro_orde_comp, codi_clie_prov, fecha, O.codi_mone, total,   
 codi_Deta_orde_comp, codi_prod, cantidad, precio,  
 (select sum(cantidad)   
  from detalle_nota_ingreso X (nolock) 
		join NOTA_INGRESO Y (nolock)
		on x.CODI_NOTA_INGR=Y.CODI_NOTA_INGR
		where X.codi_deta_orde_comp = D.codi_deta_orde_comp and X.codi_prod=D.codi_prod
				/*and cast(convert(char(10), y.FECH_NOTA_INGR,103) as datetime) between @fec1 and @fec2*/   ) Atendido,  
 (select desc_tipo_is from tipo_ingr_sali T(nolock) where T.codi_tipo_is in   
  (select tipo_nota_ingr from nota_ingreso N(nolock) where N.codi_nota_ingr in  
   (select max(codi_nota_ingr) from detalle_nota_ingreso Z(nolock) where Z.codi_deta_orde_comp = D.codi_deta_orde_comp))) tipo,  
 igv, valo_vent, (select cod_impuesto from productos P(nolock) where P.codi_prod=D.codi_prod) afe_exo     , isnull(O.estado,'')
from orden_de_compra  O (nolock)  
join DETALLE_ORDEN_COMPRA D (nolock)  
on O.codi_orde_comp=d.codi_orde_comp  
where PEDI_TRAB='P' and O.codi_alma=@alma and --nro_orde_comp=4726 and --codi_prod=@prod and   
 cast(convert(char(10), fecha,103) as datetime) between @fec1 and @fec2  
  
select codi , nro,cliente , fecha , codi_mone , total , codi_deta , codi_prod , cantidad , precio , atendido, tipo,  
 (select razon_social from empresa (nolock)) Empresa,  
 (select denominacion from cliente_proveedor c (nolock) where c.codi_clie_prov COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS=t.cliente) Razclie,  
 (SELECT desc_prod from productos P (nolock) where P.codi_prod COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS=T.codi_prod) Producto,  
 cantidad - atendido as saldo,  
 (select nemo_alma from almacen A (nolock) where A.codi_alma=@alma) almacen,  
 (select p.codi_clie_prov from productos P (nolock) where p.codi_prod COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS=T.codi_prod) codi_labo,   
 (select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end  
  from cliente_proveedor c ( nolock) where C.codi_clie_prov in (  
  select p.codi_clie_prov from productos P (nolock) where p.codi_prod COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS =T.codi_prod)) Labora,  
  (case when isnull(finaliza,'')='T' then 'AT. TOTAL' else
	 (case when ISNULL(cantidad,0) = ISNULL(atendido,0) then 'AT. TOTAL' else  
		  (case when isnull(atendido,0) = 0 then 'POR AT.' else 'AT. PARCIAL' end) end) end)estado,   

 (case when (select cod_impuesto from productos P(nolock) where P.codi_prod=T.codi_prod)=1 then 'AFECTO' else    
  (case when (select cod_impuesto from productos P(nolock) where P.codi_prod=T.codi_prod)=2 then 'ARANCEL' else 'EXONERADO' end) end) impuesto, igv ,
  round( (case when afe_exo=1 then (cantidad * precio) * (dbo.f_igv(fecha)/100) else 0 end),2) igv_item,
  round((cantidad * precio) + round( (case when afe_exo=1 then (cantidad * precio) * (dbo.f_igv(fecha)/100) else 0 end),2),2) total_item
from @tx T  
order by producto, fecha
GO
