CREATE PROCEDURE [dbo].[usp_registro_orden_de_pedido_deta_OC_saldo]
	@tipo [char](1),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](12),
	@codi_soli [char](5),
	@codi_alma [char](2),
	@peri [int]
WITH EXECUTE AS CALLER
AS
--declare @tipo char(1), @fec1 datetime, @fec2 datetime, @nro_docu varchar(12), @codi_soli char(5), @codi_alma char(2), @peri int
--select @tipo='F', @fec1='01/08/2018', @fec2='01/08/2018', @nro_docu='0000000001', @codi_soli='', @codi_alma='01', @peri='2018'

create table #Tx (codi_orde_pedi char(10) null, codi_deta_orde_pedi char(12) null , chec char(1) null, almacen varchar(20) null, nro_orde_pedi char(10) null, 
          fech_pedi smalldatetime null, item char(2) null, desc_prod varchar(150) null, simb_unid_medi char(3) null, cantidad numeric(18,4) null, 
		  stock numeric(18,4) null, responsable varchar(150) null, destino varchar(100) null, solicita varchar(100), condicion varchar(100) null, 
		  codi_alma char(2) null, cantidad_aux_vs numeric(18,4) null, cantidad_aux_oc numeric(18,4) null, saldo numeric(18,4) null, 
		  saldo_vs numeric(18,4) null, cant_oc numeric(18,4) null, codi_prod char(8) null)

set nocount on

if @tipo='N'  
begin

	insert #Tx
	select A.codi_orde_pedi, B.codi_deta_orde_pedi, '0' chec, 
           (select nemo_alma from almacen AA(nolock) where AA.codi_alma=A.codi_alma) almacen,
	        nro_orde_pedi, cast(convert(char(10),fech_pedi,103) as smalldatetime) fech_pedi, right(codi_deta_orde_pedi,2) item,
	       (select desc_prod from productos P(nolock) where P.codi_prod=B.codi_prod) desc_prod,
	       (select simb_unid_medi from unidad_medida U(nolock) where U.codi_unid_medi in
				(select codi_unid_medi from productos P(nolock) where P.codi_prod = B.codi_prod)) simb_unid_medi,
		    isnull(cantidad,0) cantidad,
		    (select isnull(sum(cant_ingr),0) - isnull(sum(cant_sali),0) from kardex K(nolock) 
		     where K.periodo=@peri and K.codi_alma=@codi_alma and K.codi_prod=B.codi_prod) stock,		
			(select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') 
			 from usuarios U(nolock) where U.codi_usua=codi_pers_resp) responsable,
			(select desc_unid_oper from unid_oper uo(nolock) where uo.codi_unid_oper=codi_unid_oper_dest) destino,
			(select desc_unid_oper from unid_oper uo(nolock) where uo.codi_unid_oper=codi_unid_oper_soli) solicita,
			
			null condicion, A.codi_alma, 0.00 cantidad_aux_vs, 0.00 cantidad_aux_oc,
			
			isnull(cantidad,0) - isnull((select isnull(sum(cantidad),0) from detalle_orden_compra D(nolock) 
					where D.codi_deta_orde_pedi = B.codi_deta_orde_pedi and D.codi_prod=B.codi_prod),0) -
					isnull((select isnull(sum(cantidad),0) from guia_detalle GD(nolock) 
					where GD.codi_deta_orde_pedi=B.codi_deta_orde_pedi and GD.codi_prod=B.codi_prod),0) saldo,

			isnull(cantidad,0) - isnull((select isnull(sum(cantidad),0) from detalle_orden_compra D(nolock) 
					where D.codi_deta_orde_pedi = B.codi_deta_orde_pedi and D.codi_prod=B.codi_prod),0) -
					isnull((select isnull(sum(cantidad),0) from guia_detalle GD(nolock) 
					where GD.codi_deta_orde_pedi=B.codi_deta_orde_pedi and GD.codi_prod=B.codi_prod),0) saldo_vs,
					
			isnull((select sum(cantidad) from detalle_orden_compra D(nolock) 
			where D.codi_deta_orde_pedi=B.codi_deta_orde_pedi and D.codi_prod=B.codi_prod),0) cant_oc, B.codi_prod

	from orden_de_pedido A(nolock)
	join detalle_orden_de_pedido B(nolock)
	on A.codi_orde_pedi = B.codi_orde_pedi   
	where A.codi_orde_pedi = @nro_docu --and not(apro_por is null or rtrim(apro_por)='')
	and B.codi_deta_orde_pedi in 
		(select D.codi_deta_orde_pedi from detalle_orden_compra D(nolock) where isnull(codi_deta_orde_pedi,'')<>'')
	order by A.codi_alma, nro_orde_pedi, fech_pedi, item
end

else

	insert #Tx
	select A.codi_orde_pedi, B.codi_deta_orde_pedi, '0' chec, 
           (select nemo_alma from almacen AA(nolock) where AA.codi_alma=A.codi_alma) almacen,
	        nro_orde_pedi, cast(convert(char(10),fech_pedi,103) as smalldatetime) fech_pedi, right(codi_deta_orde_pedi,2) item,
	       (select desc_prod from productos P(nolock) where P.codi_prod=B.codi_prod) desc_prod,
	       (select simb_unid_medi from unidad_medida U(nolock) where U.codi_unid_medi in
				(select codi_unid_medi from productos P(nolock) where P.codi_prod = B.codi_prod)) simb_unid_medi,
		    isnull(cantidad,0) cantidad,
		    (select isnull(sum(cant_ingr),0) - isnull(sum(cant_sali),0) from kardex K(nolock) 
		     where K.periodo=@peri and K.codi_alma=@codi_alma and K.codi_prod=B.codi_prod) stock,		
			(select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') 
			 from usuarios U(nolock) where U.codi_usua=codi_pers_resp) responsable,
			(select desc_unid_oper from unid_oper uo(nolock) where uo.codi_unid_oper=codi_unid_oper_dest) destino,
			(select desc_unid_oper from unid_oper uo(nolock) where uo.codi_unid_oper=codi_unid_oper_soli) solicita,
			
			null condicion, A.codi_alma, 0.00 cantidad_aux_vs, 0.00 cantidad_aux_oc,
			
			isnull(cantidad,0) - isnull((select isnull(sum(cantidad),0) from detalle_orden_compra D(nolock) 
					where D.codi_deta_orde_pedi = B.codi_deta_orde_pedi and D.codi_prod=B.codi_prod),0) -
					isnull((select isnull(sum(cantidad),0) from guia_detalle GD(nolock) 
					where GD.codi_deta_orde_pedi=B.codi_deta_orde_pedi and GD.codi_prod=B.codi_prod),0) saldo,

			isnull(cantidad,0) - isnull((select isnull(sum(cantidad),0) from detalle_orden_compra D(nolock) 
					where D.codi_deta_orde_pedi = B.codi_deta_orde_pedi and D.codi_prod=B.codi_prod),0) -
					isnull((select isnull(sum(cantidad),0) from guia_detalle GD(nolock) 
					where GD.codi_deta_orde_pedi=B.codi_deta_orde_pedi and GD.codi_prod=B.codi_prod),0) saldo_vs,
					
			isnull((select sum(cantidad) from detalle_orden_compra D(nolock) 
			where D.codi_deta_orde_pedi=B.codi_deta_orde_pedi and D.codi_prod=B.codi_prod),0) +
			isnull((select isnull(sum(cantidad),0) from guia_detalle GD(nolock) 
			where GD.codi_deta_orde_pedi=B.codi_deta_orde_pedi and GD.codi_prod=B.codi_prod),0) cant_oc, 
			
			B.codi_prod

	from orden_de_pedido A(nolock)
	join detalle_orden_de_pedido B(nolock)
	on A.codi_orde_pedi = B.codi_orde_pedi
	where cast(convert(char(10),A.fech_pedi,103) as datetime) between @fec1 and @fec2 --and not(apro_por is null or rtrim(apro_por)='')
	and B.codi_deta_orde_pedi in 
		(select D.codi_deta_orde_pedi from detalle_orden_compra D(nolock) where isnull(codi_deta_orde_pedi,'')<>'')
	order by A.codi_alma, nro_orde_pedi, fech_pedi, item

select codi_orde_pedi, codi_deta_orde_pedi, chec, almacen, nro_orde_pedi, fech_pedi,
       item, desc_prod, simb_unid_medi, cantidad, stock, responsable, destino, solicita, 
       condicion, codi_alma, cantidad_aux_vs, cantidad_aux_oc, saldo, saldo_vs, cant_oc,
       (select denominacion from cliente_proveedor c(nolock) where c.codi_clie_prov in 
			(select P.codi_clie_prov from productos P(nolock) where P.codi_prod=T.codi_prod)) laboratorio, 
	   (select desc_sub_fami_prod from sub_familia_producto s(nolock) where s.codi_sub_fami_prod in
			(select P.codi_sub_fami_prod from productos P(nolock) where P.codi_prod=T.codi_prod)) sub_familia
       
from #Tx T
where T.saldo_vs >0

drop table #Tx
GO
