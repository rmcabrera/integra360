CREATE PROCEDURE [dbo].[usp_saldos_mercaderia]
	@per [char](4),
	@fec1 [datetime],
	@clie [char](5),
	@tipo_repo [char](1),
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @per char(4), @fec1 datetime , @clie char(5), @tipo_repo char(1), @codi_alma char(2)
--select  @per ='2017', @fec1 ='29/05/2017 23:59:59' , @clie ='', @tipo_repo ='3', @codi_alma ='14'

set nocount on

create table #Rx (codi_prod char(8) , ingresos numeric(12,4), salidas numeric(12,4) , valo_ingr numeric(12,2) null, valo_sali numeric(12,2) null,
					promedio numeric(12,4) null, desc_prod varchar(200) , codi_unid_medi char(2) null, nro_cuen char(7) null, nro_sub_cuen char(7) null,
					empresa varchar(200) null, sucursal varchar(50) null, codi_mone char(2) null, 
					codi_sub_fami_prod char(4) null, subfamilia varchar(250) null, linea char(2) null,
					tipo varchar(50) null,
					deslinea varchar(100) null)

insert #Rx					
select codi_prod,sum(cant_ingr) as Ingresos , sum(cant_sali) as Salidas,
	 sum(valo_ingr_alma) as Valo_Ingr, sum(valo_sali_alma) as Valo_sali,
	(SELECT PREC_PROM_ALMA FROM KARDEX as PP WHERE CODI_KARD IN 
		(SELECT MAX(CODI_KARD) FROM KARDEX  as P1
		WHERE P1.CODI_ALMA=@CODI_ALMA AND p1.CODI_PROD =kf.codi_prod AND p1.FECH_TRAN in 
		(select max(fech_tran) from kardex as P2 
			where p2.codi_alma=@codi_alma and p2.codi_prod = Kf.codi_prod and p2.fech_tran < =@fec1))) as Prom,
	(select desc_prod from productos where codi_prod=kf.codi_prod) as Desc_prod,
	(select codi_unid_medi from productos where codi_prod=kf.codi_prod) as Codi_Unid_Medi,
	(select cuentas_contable.nro_cuen from cuentas_contable , productos where
		cuentas_contable.nro_cuen= productos.nro_cuen and codi_prod=kf.codi_prod) as Nro_cuen,
	(select cuentas_contable.nro_sub_cuen from cuentas_contable , productos where
		cuentas_contable.nro_cuen= productos.nro_cuen and codi_prod=kf.codi_prod) as Nro_sub_cuen, 
	(Select razon_social from empresa ) as rs_empr ,
	(select nemo_alma from almacen where codi_alma=@CODI_ALMA) SUCURSAL,
	'01' as Codi_mone,

	(select codi_sub_fami_prod 	from productos P (nolock) where P.codi_prod=kf.codi_prod)  codi_sub_fami_prod, 

	(select (select desc_sub_fami_prod from sub_familia_producto S (nolock) where S.codi_sub_fami_prod =p.codi_sub_fami_prod) 
			from productos P (nolock) where P.codi_prod=kf.codi_prod)  Subfamilia , 

	(select (select (select cod_lin_pro from familia_producto F (nolock) where F.codi_fami_prod =s.codi_fami_prod) 
			from sub_familia_producto S (nolock) where S.codi_sub_fami_prod =p.codi_sub_fami_prod) 
			from productos P (nolock) where P.codi_prod=kf.codi_prod)  linea,

	(select case when cod_impuesto=1 then 'Afecto' when cod_impuesto=3 then 'Exonerado' end
	 from dbo.productos A(nolock) where A.codi_prod=kf.codi_prod) tipo,

	(select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where L.cod_lin_pro in
			(select cod_lin_pro from FAMILIA_PRODUCTO FP(nolock) where FP.codi_fami_prod in 
			(select codi_fami_prod from SUB_FAMILIA_PRODUCTO SF(nolock) where SF.codi_sub_fami_prod in
				(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=KF.codi_prod) )	) ) Deslinea

from kardex as KF 
where CODI_ALMA = @CODI_ALMA AND fech_tran<=@fec1 and
			left((select cuentas_contable.nro_cuen from cuentas_contable , productos where 
				cuentas_contable.nro_cuen= productos.nro_cuen and codi_prod=kf.codi_prod),2)<>'33'
and periodo=@per 
group by codi_prod

select linea, max(deslinea) as NomLinea,  sum(valo_ingr - valo_sali) as Saldo
from #Rx
group by linea
order by 2

drop table #Rx
GO
