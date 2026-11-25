CREATE PROCEDURE [dbo].[usp_productos_lista_precios_venta_fact]
	@alma [char](2),
	@id_probl [numeric](18, 0)
WITH EXECUTE AS CALLER
AS
--declare @alma char(2), @id_probl numeric(18)
--select @alma='03', @id_probl =2

set nocount on 

create table #Rx (rot int, codi_prod char(8) )
create table #Vx (codi_prod char(8) , cantidad_descontar numeric(12,4) null)
create table #RxD (rotd int, codi_prod char(8) )

insert #rx
select count(FD.codi_prod) rot, FD.CODI_PROd
	FROM FACTURA as FAC  (nolock) 
			inner join FACTURA_DETALLE  as FD (nolock)
			on FAC.codi_fact = FD.codi_fact  
	where FAc.codi_alma =@alma
			and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) 
			between (DATEADD (DD , -30 , CAST(CONVERT(CHAR(10),GETDATE(),103) AS VARCHAR) )) and (CAST(CONVERT(CHAR(10),GETDATE(),103) AS VARCHAR)))   
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)  
		group by FD.codi_prod
		
insert #RxD	
select (datediff(d, '01/01/' + cast(year(getdate()) as char(4)), cast(convert(char(10),getdate(),103) as datetime)) + 1 ) / 
		count(distinct convert(char(10),fac.fech_fact,103)), FD.codi_prod
	from almacen as suc inner join factura as fac  (nolock)on suc.codi_alma=FAC.codi_alma
	inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
	inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
	inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
	INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
	inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
	INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
where year(FAC.fech_fact)= year(getdate()) and ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL) and FAC.codi_alma=@alma
		 --and FD.codi_prod='00010003'
group by FD.codi_prod, CP.codi_clie_prov
		
/*
insert #VX
select codi_prod,sum(cantidad) 
		from registro_vale_detalle d (nolock) join registro_vale c (nolock)  on c.codi_vale=d.codi_vale
		where d.codi_alma=@alma and (codi_fact is null or codi_fact='') and  isnull(c.estado,'')<>'N'
		group by codi_prod
		*/
/*	
select codi_prod, desc_prod, codi_mone, desc_pres, desc_sub_fami_prod, cod_impuesto, nro_decim_precio,
       prec_prov, descto_porcenta, tcambio, stock_alma, prec_porc_uti_men, prec_porc_uti_may, 
       prec_porc_uti_esp, igv, costo_oper, prec_costo, rot
from(*/
SELECT  p.codi_prod , p.desc_prod , p.codi_mone, 
		(select desc_pres from presentacion x (nolock) where x.cod_pres=P.cod_pres) as desc_pres , 
		P.codi_sub_fami_prod,
		(select desc_sub_fami_prod from sub_familia_producto S (nolock) where s.codi_sub_fami_proD=P.codi_sub_fami_prod) as desc_sub_fami_prod ,
		p.cod_impuesto, p.nro_decim_precio,  prec_prov,p.descto_porcenta, p.tcambio, 
		ap.stock_alma  -  isnull(cantidad_descontar,0) stock_alma, 
		ap.prec_porc_uti_men,ap.prec_porc_uti_may,ap.prec_porc_uti_esp ,
		(SELECT valor FROM valores_unitarios_anuales (nolock) where codi_valo_unit=2 and esta_acti=1) as igv,
		costo_oper, prec_costo,isnull(ROT,0) rot,
		
		case when (select count(*) from PRODUCTO_ALMACEN_LOTE L (nolock)
				where l.codi_prod=p.codi_prod and L.codi_alma=ap.codi_alma and l.stock<>0) = 1  then 
				( select	case when getdate()>fec_vence then 'R' 
								else case when datediff(m, getdate(), fec_vence) <= 2 then 'A' else 'N' end 
						end 
						from PRODUCTO_ALMACEN_LOTE L (nolock)
					where l.codi_prod=p.codi_prod and L.codi_alma=ap.codi_alma and l.stock<>0)
				else '' end VENC, rotd,
		case when rotd>= 0 and rotd<=60 then 'ALTA'
			 when rotd>=61 and rotd<=90 then 'MEDIANA'
			 when rotd>=91 or rotd is null then 'BAJA' end as condicion,
		dbo.uf_descr_problemas(P.codi_sub_fami_prod) problema,
		case when isnull(@id_probl,0)=0 then '' else
			(select opcion from control_problemas_detalle c(nolock) where c.id_control=@id_probl and id_sub_fami_prod=P.codi_sub_fami_prod) end as opcion,
		case when isnull(@id_probl,0)=0 then '' else
			(select dosis from control_problemas_detalle c(nolock) where c.id_control=@id_probl and id_sub_fami_prod=P.codi_sub_fami_prod) end as dosis	
			   

FROM PRODUCTOS P (nolock) 
INNER JOIN ALMACEN_PRODUCTO AP (nolock) 
	ON AP.CODI_ALMA=@alma and P.CODI_PROD=AP.CODI_PROD
LEFT JOIN #Rx as sql 
	ON P.CODI_PROD=SQL.CODI_PROD
left join #Vx as  sqld 
	on p.codi_prod=sqld.codi_prod--) as SQL
left join #RxD as RD 
	on RD.codi_prod=P.codi_prod
	where  not(prec_porc_uti_men=0 and prec_porc_uti_may=0 and prec_porc_uti_esp=0)
	and (isnull(@id_probl,0)=0 or P.codi_sub_fami_prod in (select distinct c.id_sub_fami_prod from control_problemas_detalle c(nolock) where id_control=@id_probl))
	--and P.codi_prod=82025
--where p.codi_prod=	80660		---isnull(SQL.stock_alma,0)<>0

drop table #rx
drop table #vx
drop table #RxD
GO
