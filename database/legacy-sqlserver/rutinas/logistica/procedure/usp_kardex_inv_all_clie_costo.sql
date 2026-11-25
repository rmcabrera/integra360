CREATE PROCEDURE [dbo].[usp_kardex_inv_all_clie_costo]
	@fec1 [datetime],
	@per [char](4),
	@clie [char](5),
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @per char(4), @fec1 datetime , @clie char(5), @codi_alma char(2)
--select @per ='2024', @fec1 ='08/04/2024' , @clie ='', @codi_alma ='00'

set nocount on

create table #alma (codi_alma char(2) null)

if @codi_alma='00'
	insert #alma
	select codi_alma from almacen(nolock)
else
	insert #alma
	select @codi_alma

create table #Tx(codi_prod char(8) null, desc_prod varchar(150) null, linea varchar(150) null, laboratorio varchar(150) null, 
			     tipo varchar(50) null, unid_medi varchar(5) null, codi_mone varchar(2) null, stock numeric(18,2) null, 
			     p_unit numeric(18,2) null, precio_s numeric(18,2) null, total numeric(18,2) null, rs_empr varchar(50) null, 
			     sucursal varchar(100) null, subfamilia varchar(150) null/*, codi_alma char(2) null*/)

insert #Tx
select codi_prod, desc_prod, linea, laboratorio, tipo, unid_medi, codi_mone, stock, 
       p_unit, precio_s, round(stock * precio_s,2) total, rs_empr, sucursal, subfamilia--, codi_alma
from(
select codi_prod, 
      (select desc_prod from productos P(nolock) where P.codi_prod = kf.codi_prod) as desc_prod,
      (select des_lin_pro from linea_familia_pro L(nolock) where L.cod_lin_pro in
			(select cod_lin_pro from familia_producto FP(nolock) where FP.codi_fami_prod in 
				(select codi_fami_prod from sub_familia_producto SF(nolock) where SF.codi_sub_fami_prod in
					(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=KF.codi_prod)))) linea,
	   case when isnull(@clie,'')='' then 
		(select denominacion from cliente_proveedor cp(nolock) where cp.codi_clie_prov in
				(select P.codi_clie_prov from productos P(nolock) where P.codi_prod = KF.codi_prod))	
			else
	  (select denominacion from cliente_proveedor (nolock) where codi_clie_prov=@clie) end as laboratorio,
	  (select case when cod_impuesto=1 then 'Afecto' when cod_impuesto=3 then 'Exonerado' end
	   from productos A(nolock) where A.codi_prod=kf.codi_prod) tipo,
	  (select simb_unid_medi from unidad_medida U(nolock) where U.codi_unid_medi in
		(select P.codi_unid_medi from productos P(nolock) where codi_prod=kf.codi_prod)) as unid_medi,
	  (select codi_mone from productos P(nolock) where P.codi_prod=kf.codi_prod) codi_mone,
	  sum(cant_ingr - cant_sali) as stock,
	  
	  --isnull((select prec_costo from almacen_producto AP(nolock) where AP.codi_prod=kf.codi_prod and AP.codi_alma=@codi_alma),0) p_unit,
	  --dbo.uf_ulti_prec_compr_real(codi_prod) as p_unit,
	  (select round(prec_prov * ( 1 -  descto_porcenta / 100 ) +  case when costo_oper is null then 0 else costo_oper end,2) from productos P(nolock) where P.codi_prod=KF.codi_prod) as p_unit,
	  
	  /*(case when (select codi_mone from productos P(nolock) where P.codi_prod=kf.codi_prod)='01' then 1 
	  else dbo.f_tc(convert(char(10),getdate(),103),'V','01','02') end) * */
	  --dbo.uf_ulti_prec_compr_tc(codi_prod) precio_s,
	  (select round(prec_prov * ( 1 -  descto_porcenta / 100 ) +  case when costo_oper is null then 0 else costo_oper end,2) from productos P(nolock) where P.codi_prod=KF.codi_prod) as precio_s,
	  
	  case when @codi_alma='00' then 'TODOS' 
	  else (select nemo_alma from almacen A (nolock) where A.codi_alma=@codi_alma) end sucursal,
	  (select razon_social from empresa (nolock) ) as rs_empr,
	  (select upper(desc_sub_fami_prod) from sub_familia_producto SF(nolock) where SF.codi_sub_fami_prod in
					(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=KF.codi_prod)) subfamilia--, codi_alma
	 
from kardex as KF (nolock)
where fech_tran<=@fec1 and
			left((select cuentas_contable.nro_cuen from cuentas_contable , productos where 
				cuentas_contable.nro_cuen= productos.nro_cuen and codi_prod=kf.codi_prod),2)<>'33'
		and periodo=@per and codi_prod in (select codi_prod from productos where isnull(@clie,'')='' or codi_clie_prov=@clie)
		--and codi_prod='00081554'
		and codi_alma in (select A.codi_alma from #Alma A)
	 group by codi_prod) as SQL

create table  #Prec (codi_alma char(2) null, codi_prod char(8), prec_venta numeric(12,2) null)

insert #Prec
select distinct '' as codi_alma, a.codi_prod, 
	max(round( case when P.codi_mone='01' then 
			(prec_costo * ( 1 +  prec_porc_uti_esp / 100) *  case when  cod_impuesto=3 then 1 else  (1 + dbo.f_igv(getdate())/100.00) end  ) 
		else 
			(prec_costo * ( 1 +  prec_porc_uti_esp / 100) *  case when cod_impuesto=3 then 1 else (1 + dbo.f_igv(getdate())/100.00) end  )* tcambio 
		end , nro_decim_precio ) ) as precio_venta
	
from #Tx A
join almacen_producto B(nolock)
on A.codi_prod=B.codi_prod
join productos P (nolock)
on P.codi_prod=A.codi_prod
where B.codi_alma in (select AL.codi_alma from almacen AL(nolock) where isnull(AL.activo,'')='1')
group by a.codi_prod

select T.codi_prod, desc_prod, linea, laboratorio, tipo, unid_medi, codi_mone, stock,
	   --p_unit, precio_s, total, reemplazo solicitado por Leo 08-04-24
	   case when codi_mone='02' then p_unit else 0 end as p_unit,
	   case when codi_mone='01' then precio_s else 0 end as precio_s,
	   case when codi_mone='02' then p_unit else 0 end * stock as total_d,
	   case when codi_mone='01' then precio_s else 0 end * stock as total,
	   rs_empr, sucursal, subfamilia, prec_venta, 
	   '01' as codi_mone_v, round(stock * prec_venta,2) as total_v
	   
from #Tx T 
join #Prec P
on T.codi_prod=P.codi_prod
--where T.codi_prod='00082044'

drop table #alma 
drop table #Tx
drop table #Prec
GO
