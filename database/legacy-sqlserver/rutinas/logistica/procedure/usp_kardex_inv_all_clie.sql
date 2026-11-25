CREATE PROCEDURE [dbo].[usp_kardex_inv_all_clie]
	@fec1 [datetime],
	@per [char](4),
	@clie [char](5),
	@tipo_repo [char](1),
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @per char(4), @fec1 datetime , @clie char(5), @tipo_repo char(1), @codi_alma char(2)
--select  @per ='2019', @fec1 ='31/12/2019' , @clie ='00339', @tipo_repo ='0', @codi_alma ='00'

set nocount on

create table #alma (codi_alma char(2) null)
if @codi_alma='00'
	insert #alma
	select codi_alma from almacen(nolock)
else
	insert #alma
	select @codi_alma

declare @cont int

select @cont = isnull(count(*),0) from productos (nolock) where codi_clie_prov=@clie
if @cont is null set @cont=0
--select @cont
if (@clie is null or @clie='') or @cont > 0
begin

	select codi_prod, sum(cant_ingr) as Ingresos , sum(cant_sali) as Salidas,
		 sum(valo_ingr) as Valo_Ingr, sum(valo_sali) as Valo_sali,
		(SELECT PREC_PROM FROM KARDEX as PP WHERE CODI_KARD IN 
			(SELECT MAX(CODI_KARD) FROM KARDEX  as P1
			WHERE p1.CODI_PROD = kf.codi_prod AND p1.FECH_TRAN in 
				(select max(fech_tran) from kardex as P2 where p2.codi_prod = Kf.codi_prod and
					p2.fech_tran < =@fec1))) as Prom,
		(select desc_prod from productos where codi_prod=kf.codi_prod) as Desc_prod, 
		(select codi_unid_medi from productos where codi_prod=kf.codi_prod) as Codi_Unid_Medi,
		(select cuentas_contable.nro_cuen from cuentas_contable , productos where
			cuentas_contable.nro_cuen=* productos.nro_cuen and codi_prod=kf.codi_prod) as Nro_cuen,
		(select cuentas_contable.nro_sub_cuen from cuentas_contable , productos where
			cuentas_contable.nro_cuen=* productos.nro_cuen and codi_prod=kf.codi_prod) as Nro_sub_cuen, 
		(Select razon_social from empresa ) as rs_empr ,
		case when @codi_alma='00' then 'TODOS' 
			else
			(select nemo_alma from almacen A (nolock) where A.codi_alma=@codi_alma) end SUCURSAL ,
		case when isnull(@clie,'')='' then 
			(select denominacion from cliente_proveedor cp(nolock) where cp.codi_clie_prov in
					(select P.codi_clie_prov from productos P(nolock) where P.codi_prod = KF.codi_prod))	
				else
			(select denominacion from cliente_proveedor where codi_clie_prov=@clie) end as laboratorio,
		'01' as Codi_mone,
		(select case when cod_impuesto=1 then 'Afecto' when cod_impuesto=3 then 'Exonerado' end
		 from dbo.productos A(nolock) where A.codi_prod=kf.codi_prod) tipo,

		case @tipo_repo  when '0' then ''
			when '1' then ( Select (Select desc_fami_prod from familia_producto F where F.codi_fami_prod= S.codi_fami_prod) from sub_familia_producto S 
						where S.codi_sub_fami_prod in ( select P.codi_sub_fami_prod from Productos P where P.codi_prod=KF.codi_prod) ) 
			when '2' then 	( Select S.desc_sub_fami_prod from sub_familia_producto S 
				where S.codi_sub_fami_prod in ( select P.codi_sub_fami_prod from Productos P where P.codi_prod=KF.codi_prod) ) 
			when '3' then 
	 			(select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where L.cod_lin_pro in
				(select cod_lin_pro from FAMILIA_PRODUCTO FP(nolock) where FP.codi_fami_prod in 
					(select codi_fami_prod from SUB_FAMILIA_PRODUCTO SF(nolock) where SF.codi_sub_fami_prod in
						(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=KF.codi_prod) )	) ) end familia,
		sum(cant_ingr) - sum(cant_sali) as sfisico, sum(valo_ingr) - sum(valo_sali) as svalorizado
		
	from kardex as KF (nolock)
	where fech_tran<=@fec1 and
				left((select cuentas_contable.nro_cuen from cuentas_contable , productos where 
					cuentas_contable.nro_cuen=* productos.nro_cuen and codi_prod=kf.codi_prod),2)<>'33'
			and periodo=@per and codi_prod in (select codi_prod from productos where isnull(@clie,'')='' or codi_clie_prov=@clie)
			and codi_alma in (select A.codi_alma from #Alma A)
		 group by codi_prod
	 
end
else
begin
	select codi_prod, sum(cant_ingr) as Ingresos, sum(cant_sali) as Salidas,
		   sum(valo_ingr) as Valo_Ingr, sum(valo_sali) as Valo_sali,
		   (SELECT PREC_PROM FROM KARDEX as PP(nolock) WHERE CODI_KARD IN 
			(SELECT MAX(CODI_KARD) FROM KARDEX  as P1(nolock)
			WHERE p1.CODI_PROD = SQL.codi_prod AND p1.FECH_TRAN in 
				(select max(fech_tran) from kardex as P2(nolock) where p2.codi_prod = SQL.codi_prod and
					p2.fech_tran < =@fec1))) as Prom,
		(select desc_prod from productos (nolock) where codi_prod=SQL.codi_prod) as Desc_prod, 
		(select codi_unid_medi from productos (nolock) where codi_prod=SQL.codi_prod) as Codi_Unid_Medi,
		(select cuentas_contable.nro_cuen from cuentas_contable (nolock), productos (nolock) where
			cuentas_contable.nro_cuen=* productos.nro_cuen and codi_prod=SQL.codi_prod) as Nro_cuen,
		(select cuentas_contable.nro_sub_cuen from cuentas_contable (nolock), productos (nolock) where
			cuentas_contable.nro_cuen=* productos.nro_cuen and codi_prod=SQL.codi_prod) as Nro_sub_cuen, 
		(Select razon_social from empresa (nolock) ) as rs_empr ,
		case when @codi_alma='00' then 'TODOS' 
			else
			(select nemo_alma from almacen A (nolock) where A.codi_alma=@codi_alma) end SUCURSAL ,
		case when isnull(@clie,'')='' then 
			(select denominacion from cliente_proveedor cp(nolock) where cp.codi_clie_prov in
					(select P.codi_clie_prov from productos P(nolock) where P.codi_prod = SQL.codi_prod))	
				else
			(select denominacion from cliente_proveedor (nolock) where codi_clie_prov=@clie) end as laboratorio,
		'01' as Codi_mone,
		(select case when cod_impuesto=1 then 'Afecto' when cod_impuesto=3 then 'Exonerado' end
		 from dbo.productos A(nolock) where A.codi_prod=SQL.codi_prod) tipo,

		case @tipo_repo  when '0' then ''
			when '1' then ( Select (Select desc_fami_prod from familia_producto F(nolock) where F.codi_fami_prod= S.codi_fami_prod) from sub_familia_producto S 
						where S.codi_sub_fami_prod in ( select P.codi_sub_fami_prod from Productos P(nolock) where P.codi_prod=SQL.codi_prod) ) 
			when '2' then 	( Select S.desc_sub_fami_prod from sub_familia_producto S(nolock) 
				where S.codi_sub_fami_prod in ( select P.codi_sub_fami_prod from Productos P(nolock) where P.codi_prod=SQL.codi_prod) ) 
			when '3' then 
	 			(select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where L.cod_lin_pro in
				(select cod_lin_pro from FAMILIA_PRODUCTO FP(nolock) where FP.codi_fami_prod in 
					(select codi_fami_prod from SUB_FAMILIA_PRODUCTO SF(nolock) where SF.codi_sub_fami_prod in
						(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=SQL.codi_prod) )	) ) end familia,
		 
		 sum(sfisico) as sfisico, sum(svalorizado) as svalorizado
		 
	from(
	select codi_prod, cant_ingr, cant_sali, valo_ingr, valo_sali,
	       case when i_o='1' then
				(select codi_clie_prov from nota_ingreso N(nolock) where N.codi_nota_ingr=KF.codi_docu_i_o)
		   else
				(select codi_clie_prov from docu_sali_mate D(nolock) where D.codi_docu_sali=KF.codi_docu_i_o)
		   end codi_clie_prov, 
		   cant_ingr - cant_sali as sfisico, valo_ingr - valo_sali as svalorizado
		
	from kardex as KF (nolock)
	where fech_tran<=@fec1 and
				left((select cuentas_contable.nro_cuen from cuentas_contable , productos where 
					cuentas_contable.nro_cuen=* productos.nro_cuen and codi_prod=kf.codi_prod),2)<>'33'
			and periodo=@per and codi_alma in (select A.codi_alma from #Alma A)
	) as SQL
	
	where SQL.codi_clie_prov=@clie
	group by SQL.codi_prod		
	
end

drop table #alma
GO
