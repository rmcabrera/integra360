CREATE PROCEDURE [dbo].[usp_VENTAS_SUCUR_LABO_PRODUC_all]
	@TIPO [int],
	@tipo_pago [int],
	@ANIO [int],
	@CODI_CLIE_PROV [char](5),
	@CODI_ALMA [char](2)
WITH EXECUTE AS CALLER
AS
--declare @TIPO INT , @tipo_pago int , @ANIO INT, @CODI_CLIE_PROV CHAR(5) , @CODI_ALMA CHAR(2)  
--select @TIPO =1 , @tipo_pago = 0, @ANIO =2020, @CODI_CLIE_PROV ='66296', @CODI_ALMA ='00'

set nocount on
if @tipo = 1
begin -- SUCURSAL POR LABORATORIO  / contado - credito
	if @tipo_pago=0 and @codi_alma<>'00'
		select suc.nemo_alma , cp.codi_clie_prov, cp.denominacion as laboratorio, prod.desc_prod , pres.desc_pres ,
		    sum(case month(fac.fech_fact) when '1' then fd.cant_item else 0 end) as cant_enero,
		    sum(case month(fac.fech_fact) when '2' then fd.cant_item else 0 end) as cant_febrero,
		    sum(case month(fac.fech_fact) when '3' then fd.cant_item else 0 end) as cant_marzo,
		    sum(case month(fac.fech_fact) when '4' then fd.cant_item else 0 end) as cant_abril,
		    sum(case month(fac.fech_fact) when '5' then fd.cant_item else 0 end) as cant_mayo,
		    sum(case month(fac.fech_fact) when '6' then fd.cant_item else 0 end) as cant_junio,
		    sum(case month(fac.fech_fact) when '7' then fd.cant_item else 0 end) as cant_julio,
		    sum(case month(fac.fech_fact) when '8' then fd.cant_item else 0 end) as cant_agosto,
		    sum(case month(fac.fech_fact) when '9' then fd.cant_item else 0 end) as cant_setiembre,
		    sum(case month(fac.fech_fact) when '10' then fd.cant_item else 0 end) as cant_octubre,
		    sum(case month(fac.fech_fact) when '11' then fd.cant_item else 0 end) as cant_noviembre,
		    sum(case month(fac.fech_fact) when '12' then fd.cant_item else 0 end) as cant_diciembre ,
		    ---valor venta--------------------	
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JULIO,
		    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_DIC,
		    ---fin de valor venta ----------
		    ---Valor costo------------------
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JULIO,
		    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC,
                    dbo.f_saldo_mes(@anio, '01', prod.codi_prod,@CODI_ALMA) as kard_ene,		
		    dbo.f_saldo_mes(@anio, '02', prod.codi_prod,@CODI_ALMA) as kard_feb,
		    dbo.f_saldo_mes(@anio, '03', prod.codi_prod,@CODI_ALMA) as kard_mar,
		    dbo.f_saldo_mes(@anio, '04', prod.codi_prod,@CODI_ALMA) as kard_abr,
		    dbo.f_saldo_mes(@anio, '05', prod.codi_prod,@CODI_ALMA) as kard_may,
		    dbo.f_saldo_mes(@anio, '06', prod.codi_prod,@CODI_ALMA) as kard_jun,
		    dbo.f_saldo_mes(@anio, '07', prod.codi_prod,@CODI_ALMA) as kard_jul,
		    dbo.f_saldo_mes(@anio, '08', prod.codi_prod,@CODI_ALMA) as kard_ago,
		    dbo.f_saldo_mes(@anio, '09', prod.codi_prod,@CODI_ALMA) as kard_sep,
		    dbo.f_saldo_mes(@anio, '10', prod.codi_prod,@CODI_ALMA) as kard_oct,
		    dbo.f_saldo_mes(@anio, '11', prod.codi_prod,@CODI_ALMA) as kard_nov,
		    dbo.f_saldo_mes(@anio, '12', prod.codi_prod,@CODI_ALMA) as kard_dic,
			prod.CODI_PROD,
			(select des_lin_pro from LINEA_FAMILIA_PRO where cod_lin_pro in (
				select cod_lin_pro from FAMILIA_PRODUCTO 
					where CODI_FAMI_PROD in ( select CODI_FAMI_PROD 
						from sub_familia_producto 
								where codi_sub_fami_prod =max(prod.CODI_SUB_FAMI_PROD)))) as Linea

		    ---fin de valor costo ------------	  	 
		   from almacen as suc inner join factura as fac on suc.codi_alma=fac.codi_alma
			inner join factura_detalle 	as fd on fac.codi_fact = fd.codi_fact
			inner join almacen_producto 	as ap on (fd.codi_alma=ap.codi_alma and fd.codi_prod=ap.codi_prod)
			inner join productos		as prod on ap.codi_prod = prod.codi_prod
			inner join presentacion 	as pres on prod.cod_pres=pres.cod_pres
			inner join cliente_proveedor 	as cp on prod.codi_clie_prov = cp.codi_clie_prov
	
		    where suc.codi_alma=@codi_alma and year(fac.fech_fact)=@anio   and  cp.codi_clie_prov=@codi_clie_prov and ( fac.estado not in ('a') or fac.estado is null)
		 group by   suc.nemo_alma , cp.codi_clie_prov, cp.denominacion  ,prod.codi_prod, prod.desc_prod , pres.desc_pres


	if @tipo_pago<>0 and @codi_alma='00'
		select '' nemo_alma , cp.codi_clie_prov, cp.denominacion as laboratorio, prod.desc_prod , pres.desc_pres ,
		    sum(case month(fac.fech_fact) when '1' then fd.cant_item else 0 end) as cant_enero,
		    sum(case month(fac.fech_fact) when '2' then fd.cant_item else 0 end) as cant_febrero,
		    sum(case month(fac.fech_fact) when '3' then fd.cant_item else 0 end) as cant_marzo,
		    sum(case month(fac.fech_fact) when '4' then fd.cant_item else 0 end) as cant_abril,
		    sum(case month(fac.fech_fact) when '5' then fd.cant_item else 0 end) as cant_mayo,
		    sum(case month(fac.fech_fact) when '6' then fd.cant_item else 0 end) as cant_junio,
		    sum(case month(fac.fech_fact) when '7' then fd.cant_item else 0 end) as cant_julio,
		    sum(case month(fac.fech_fact) when '8' then fd.cant_item else 0 end) as cant_agosto,
		    sum(case month(fac.fech_fact) when '9' then fd.cant_item else 0 end) as cant_setiembre,
		    sum(case month(fac.fech_fact) when '10' then fd.cant_item else 0 end) as cant_octubre,
		    sum(case month(fac.fech_fact) when '11' then fd.cant_item else 0 end) as cant_noviembre,
		    sum(case month(fac.fech_fact) when '12' then fd.cant_item else 0 end) as cant_diciembre ,
		    ---valor venta--------------------	
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JULIO,
		    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_DIC,
		    ---fin de valor venta ----------
		    ---Valor costo------------------
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JULIO,
		   SUM(case month(FAC.FECH_FACT) when '8' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC,
                    dbo.f_saldo_mes(@anio, '01', prod.codi_prod,@CODI_ALMA) as kard_ene,		
		    dbo.f_saldo_mes(@anio, '02', prod.codi_prod,@CODI_ALMA) as kard_feb,
		    dbo.f_saldo_mes(@anio, '03', prod.codi_prod,@CODI_ALMA) as kard_mar,
		    dbo.f_saldo_mes(@anio, '04', prod.codi_prod,@CODI_ALMA) as kard_abr,
		    dbo.f_saldo_mes(@anio, '05', prod.codi_prod,@CODI_ALMA) as kard_may,
		    dbo.f_saldo_mes(@anio, '06', prod.codi_prod,@CODI_ALMA) as kard_jun,
		    dbo.f_saldo_mes(@anio, '07', prod.codi_prod,@CODI_ALMA) as kard_jul,
		    dbo.f_saldo_mes(@anio, '08', prod.codi_prod,@CODI_ALMA) as kard_ago,
		    dbo.f_saldo_mes(@anio, '09', prod.codi_prod,@CODI_ALMA) as kard_sep,
		    dbo.f_saldo_mes(@anio, '10', prod.codi_prod,@CODI_ALMA) as kard_oct,
		    dbo.f_saldo_mes(@anio, '11', prod.codi_prod,@CODI_ALMA) as kard_nov,
		    dbo.f_saldo_mes(@anio, '12', prod.codi_prod,@CODI_ALMA) as kard_dic,
			prod.CODI_PROD,
			(select des_lin_pro from LINEA_FAMILIA_PRO where cod_lin_pro in (
				select cod_lin_pro from FAMILIA_PRODUCTO 
					where CODI_FAMI_PROD in ( select CODI_FAMI_PROD 
						from sub_familia_producto 
								where codi_sub_fami_prod =max(prod.CODI_SUB_FAMI_PROD)))) as Linea		    

		    ---fin de valor costo ------------	  	 
		   from almacen as suc inner join factura as fac on suc.codi_alma=fac.codi_alma
			inner join factura_detalle 	as fd on fac.codi_fact = fd.codi_fact
			inner join almacen_producto 	as ap on (fd.codi_alma=ap.codi_alma and fd.codi_prod=ap.codi_prod)
			inner join productos		as prod on ap.codi_prod = prod.codi_prod
			inner join presentacion 	as pres on prod.cod_pres=pres.cod_pres
			inner join cliente_proveedor 	as cp on prod.codi_clie_prov = cp.codi_clie_prov
	
		    where year(fac.fech_fact)=@anio   and  cp.codi_clie_prov=@codi_clie_prov and ( fac.estado not in ('a') or fac.estado is null)
			and fac.codi_tipo_pago=@tipo_pago
		 group by  cp.codi_clie_prov, cp.denominacion  , prod.codi_prod,prod.desc_prod , pres.desc_pres


	if @tipo_pago=0 and @codi_alma='00'
		declare @Px table(prod char(8) null)
		
		insert @Px
		select prod.codi_prod
		   from almacen as suc inner join factura as fac on suc.codi_alma=fac.codi_alma
			inner join factura_detalle 	as fd on fac.codi_fact = fd.codi_fact
			inner join almacen_producto 	as ap on (fd.codi_alma=ap.codi_alma and fd.codi_prod=ap.codi_prod)
			inner join productos		as prod on ap.codi_prod = prod.codi_prod
			inner join presentacion 	as pres on prod.cod_pres=pres.cod_pres
			inner join cliente_proveedor 	as cp on prod.codi_clie_prov = cp.codi_clie_prov
		    where year(fac.fech_fact)=@anio   and  cp.codi_clie_prov=@codi_clie_prov and ( fac.estado not in ('a') or fac.estado is null)
			--and prod.codi_prod='00010992'	
		 group by  cp.codi_clie_prov, cp.denominacion  , prod.desc_prod , pres.desc_pres, prod.codi_prod
		 
		select 
		    '' nemo_alma , cp.codi_clie_prov, cp.denominacion as laboratorio, prod.desc_prod , pres.desc_pres ,
		    sum(case month(fac.fech_fact) when '1' then fd.cant_item else 0 end) as cant_enero,
		    sum(case month(fac.fech_fact) when '2' then fd.cant_item else 0 end) as cant_febrero,
		    sum(case month(fac.fech_fact) when '3' then fd.cant_item else 0 end) as cant_marzo,
		    sum(case month(fac.fech_fact) when '4' then fd.cant_item else 0 end) as cant_abril,
		    sum(case month(fac.fech_fact) when '5' then fd.cant_item else 0 end) as cant_mayo,
		    sum(case month(fac.fech_fact) when '6' then fd.cant_item else 0 end) as cant_junio,
		    sum(case month(fac.fech_fact) when '7' then fd.cant_item else 0 end) as cant_julio,
		    sum(case month(fac.fech_fact) when '8' then fd.cant_item else 0 end) as cant_agosto,
		    sum(case month(fac.fech_fact) when '9' then fd.cant_item else 0 end) as cant_setiembre,
		    sum(case month(fac.fech_fact) when '10' then fd.cant_item else 0 end) as cant_octubre,
		    sum(case month(fac.fech_fact) when '11' then fd.cant_item else 0 end) as cant_noviembre,
		    sum(case month(fac.fech_fact) when '12' then fd.cant_item else 0 end) as cant_diciembre ,
		    ---valor venta--------------------	
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JULIO,
		    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_DIC,
		    ---fin de valor venta ----------
		    ---Valor costo------------------
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JULIO,
		    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC,

                    dbo.f_saldo_mes(@anio, '01', prod.codi_prod,@CODI_ALMA) as kard_ene,		
		    dbo.f_saldo_mes(@anio, '02', prod.codi_prod,@CODI_ALMA) as kard_feb,
		    dbo.f_saldo_mes(@anio, '03', prod.codi_prod,@CODI_ALMA) as kard_mar,
		    dbo.f_saldo_mes(@anio, '04', prod.codi_prod,@CODI_ALMA) as kard_abr,
		    dbo.f_saldo_mes(@anio, '05', prod.codi_prod,@CODI_ALMA) as kard_may,
		    dbo.f_saldo_mes(@anio, '06', prod.codi_prod,@CODI_ALMA) as kard_jun,
		    dbo.f_saldo_mes(@anio, '07', prod.codi_prod,@CODI_ALMA) as kard_jul,
		    dbo.f_saldo_mes(@anio, '08', prod.codi_prod,@CODI_ALMA) as kard_ago,
		    dbo.f_saldo_mes(@anio, '09', prod.codi_prod,@CODI_ALMA) as kard_sep,
		    dbo.f_saldo_mes(@anio, '10', prod.codi_prod,@CODI_ALMA) as kard_oct,
		    dbo.f_saldo_mes(@anio, '11', prod.codi_prod,@CODI_ALMA) as kard_nov,
		    dbo.f_saldo_mes(@anio, '12', prod.codi_prod,@CODI_ALMA) as kard_dic, 
			prod.CODI_PROD,
			(select des_lin_pro from LINEA_FAMILIA_PRO where cod_lin_pro in (
				select cod_lin_pro from FAMILIA_PRODUCTO 
					where CODI_FAMI_PROD in ( select CODI_FAMI_PROD 
						from sub_familia_producto 
								where codi_sub_fami_prod =max(prod.CODI_SUB_FAMI_PROD)))) as Linea

	
		    ---fin de valor costo ------------	  	 
		   from almacen as suc inner join factura as fac on suc.codi_alma=fac.codi_alma
			inner join factura_detalle 	as fd on fac.codi_fact = fd.codi_fact
			inner join almacen_producto 	as ap on (fd.codi_alma=ap.codi_alma and fd.codi_prod=ap.codi_prod)
			inner join productos		as prod on ap.codi_prod = prod.codi_prod
			inner join presentacion 	as pres on prod.cod_pres=pres.cod_pres
			inner join cliente_proveedor 	as cp on prod.codi_clie_prov = cp.codi_clie_prov
		    where year(fac.fech_fact)=@anio   and  cp.codi_clie_prov=@codi_clie_prov and ( fac.estado not in ('a') or fac.estado is null)
			--and prod.codi_prod='00010992'	
		 group by  cp.codi_clie_prov, cp.denominacion  , prod.desc_prod , pres.desc_pres, prod.codi_prod

		union all
		
		select 
		    '' nemo_alma , cp.codi_clie_prov, cp.denominacion as laboratorio, prod.desc_prod , pres.desc_pres ,
		    /*sum(case month(fac.fech_fact) when '1' then fd.cant_item else 0 end)*/ 0 as cant_enero,
		    /*sum(case month(fac.fech_fact) when '2' then fd.cant_item else 0 end)*/ 0 as cant_febrero,
		    /*sum(case month(fac.fech_fact) when '3' then fd.cant_item else 0 end)*/ 0 as cant_marzo,
		    /*sum(case month(fac.fech_fact) when '4' then fd.cant_item else 0 end)*/ 0 as cant_abril,
		    /*sum(case month(fac.fech_fact) when '5' then fd.cant_item else 0 end)*/ 0 as cant_mayo,
		    /*sum(case month(fac.fech_fact) when '6' then fd.cant_item else 0 end)*/ 0 as cant_junio,
		    /*sum(case month(fac.fech_fact) when '7' then fd.cant_item else 0 end)*/ 0 as cant_julio,
		    /*sum(case month(fac.fech_fact) when '8' then fd.cant_item else 0 end)*/ 0 as cant_agosto,
		    /*sum(case month(fac.fech_fact) when '9' then fd.cant_item else 0 end)*/ 0 as cant_setiembre,
		    /*sum(case month(fac.fech_fact) when '10' then fd.cant_item else 0 end)*/ 0 as cant_octubre,
		    /*sum(case month(fac.fech_fact) when '11' then fd.cant_item else 0 end)*/ 0 as cant_noviembre,
		    /*sum(case month(fac.fech_fact) when '12' then fd.cant_item else 0 end)*/ 0 as cant_diciembre ,
		    ---valor venta--------------------	
		    /*SUM(case month(FAC.FECH_FACT) when '1' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_ENERO ,
		    /*SUM(case month(FAC.FECH_FACT) when '2' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_FEBRERO,
		    /*SUM(case month(FAC.FECH_FACT) when '3' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_MAR,
		    /*SUM(case month(FAC.FECH_FACT) when '4' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_ABRIL,
		    /*SUM(case month(FAC.FECH_FACT) when '5' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_MAYO,
		    /*SUM(case month(FAC.FECH_FACT) when '6' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_JUNIO,
		    /*SUM(case month(FAC.FECH_FACT) when '7' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_JULIO,
		    /*SUM(case month(FAC.FECH_FACT) when '8' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_AGOS,
		    /*SUM(case month(FAC.FECH_FACT) when '9' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_SET,
		    /*SUM(case month(FAC.FECH_FACT) when '10' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_OCT,
		    /*SUM(case month(FAC.FECH_FACT) when '11' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_NOV,
		    /*SUM(case month(FAC.FECH_FACT) when '12' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end)*/ 0 as VALO_VENTA_DIC,
		    ---fin de valor venta ----------
		    ---Valor costo------------------
		    /*SUM(case month(FAC.FECH_FACT) when '1' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_ENERO ,
		    /*SUM(case month(FAC.FECH_FACT) when '2' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_FEBRERO,
		    /*SUM(case month(FAC.FECH_FACT) when '3' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_MAR,
		    /*SUM(case month(FAC.FECH_FACT) when '4' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_ABRIL,
		    /*SUM(case month(FAC.FECH_FACT) when '5' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_MAYO,
		    /*SUM(case month(FAC.FECH_FACT) when '6' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_JUNIO,
		    /*SUM(case month(FAC.FECH_FACT) when '7' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_JULIO,
		    /*SUM(case month(FAC.FECH_FACT) when '8' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_AGOS,
		    /*SUM(case month(FAC.FECH_FACT) when '9' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_SET,
		    /*SUM(case month(FAC.FECH_FACT) when '10' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_OCT,
		    /*SUM(case month(FAC.FECH_FACT) when '11' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_NOV,
		    /*SUM(case month(FAC.FECH_FACT) when '12' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)*/ 0 as VALO_COSTO_DIC,

            dbo.f_saldo_mes(@anio, '01', prod.codi_prod,@CODI_ALMA) as kard_ene,		
		    dbo.f_saldo_mes(@anio, '02', prod.codi_prod,@CODI_ALMA) as kard_feb,
		    dbo.f_saldo_mes(@anio, '03', prod.codi_prod,@CODI_ALMA) as kard_mar,
		    dbo.f_saldo_mes(@anio, '04', prod.codi_prod,@CODI_ALMA) as kard_abr,
		    dbo.f_saldo_mes(@anio, '05', prod.codi_prod,@CODI_ALMA) as kard_may,
		    dbo.f_saldo_mes(@anio, '06', prod.codi_prod,@CODI_ALMA) as kard_jun,
		    dbo.f_saldo_mes(@anio, '07', prod.codi_prod,@CODI_ALMA) as kard_jul,
		    dbo.f_saldo_mes(@anio, '08', prod.codi_prod,@CODI_ALMA) as kard_ago,
		    dbo.f_saldo_mes(@anio, '09', prod.codi_prod,@CODI_ALMA) as kard_sep,
		    dbo.f_saldo_mes(@anio, '10', prod.codi_prod,@CODI_ALMA) as kard_oct,
		    dbo.f_saldo_mes(@anio, '11', prod.codi_prod,@CODI_ALMA) as kard_nov,
		    dbo.f_saldo_mes(@anio, '12', prod.codi_prod,@CODI_ALMA) as kard_dic, 
			prod.CODI_PROD,
			(select des_lin_pro from LINEA_FAMILIA_PRO where cod_lin_pro in (
				select cod_lin_pro from FAMILIA_PRODUCTO 
					where CODI_FAMI_PROD in ( select CODI_FAMI_PROD 
						from sub_familia_producto 
								where codi_sub_fami_prod =max(prod.CODI_SUB_FAMI_PROD)))) as Linea

	
		    ---fin de valor costo ------------	  	 
		   from almacen as suc 
		    --inner join factura as fac on suc.codi_alma=fac.codi_alma
			--inner join factura_detalle 	as fd on fac.codi_fact = fd.codi_fact
			inner join almacen_producto 	as ap on (suc.codi_alma=ap.codi_alma /*and fd.codi_prod=ap.codi_prod*/)
			inner join productos		as prod on ap.codi_prod = prod.codi_prod
			inner join presentacion 	as pres on prod.cod_pres=pres.cod_pres
			inner join cliente_proveedor 	as cp on prod.codi_clie_prov = cp.codi_clie_prov
		    where /*year(fac.fech_fact)=@anio and*/ cp.codi_clie_prov=@codi_clie_prov --and ( fac.estado not in ('a') or fac.estado is null)
		      and prod.codi_prod not in (select prod from @Px)
			--and prod.codi_prod='00010992'	
		 group by  cp.codi_clie_prov, cp.denominacion  , prod.desc_prod , pres.desc_pres, prod.codi_prod
		 
end 


ELSE if @tipo = 2
begin -- SOLO POR SUCURSAL - CONTADO / credito
	if @tipo_pago=0 and @codi_alma<>'00'
		select suc.nemo_alma , cp.codi_clie_prov, cp.denominacion as laboratorio, prod.desc_prod , pres.desc_pres ,
		    sum(case month(fac.fech_fact) when '1' then fd.cant_item else 0 end) as cant_enero,
		    sum(case month(fac.fech_fact) when '2' then fd.cant_item else 0 end) as cant_febrero,
		    sum(case month(fac.fech_fact) when '3' then fd.cant_item else 0 end) as cant_marzo,
		    sum(case month(fac.fech_fact) when '4' then fd.cant_item else 0 end) as cant_abril,
		    sum(case month(fac.fech_fact) when '5' then fd.cant_item else 0 end) as cant_mayo,
		    sum(case month(fac.fech_fact) when '6' then fd.cant_item else 0 end) as cant_junio,
		    sum(case month(fac.fech_fact) when '7' then fd.cant_item else 0 end) as cant_julio,
		    sum(case month(fac.fech_fact) when '8' then fd.cant_item else 0 end) as cant_agosto,
		    sum(case month(fac.fech_fact) when '9' then fd.cant_item else 0 end) as cant_setiembre,
		    sum(case month(fac.fech_fact) when '10' then fd.cant_item else 0 end) as cant_octubre,
		    sum(case month(fac.fech_fact) when '11' then fd.cant_item else 0 end) as cant_noviembre,
		    sum(case month(fac.fech_fact) when '12' then fd.cant_item else 0 end) as cant_diciembre ,
		    ---valor venta--------------------	
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JULIO,
		    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_DIC,
		    ---fin de valor venta ----------
		    ---Valor costo------------------
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JULIO,
		    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC,
                    dbo.f_saldo_mes(@anio, '01', prod.codi_prod,@CODI_ALMA) as kard_ene,		
		    dbo.f_saldo_mes(@anio, '02', prod.codi_prod,@CODI_ALMA) as kard_feb,
		    dbo.f_saldo_mes(@anio, '03', prod.codi_prod,@CODI_ALMA) as kard_mar,
		    dbo.f_saldo_mes(@anio, '04', prod.codi_prod,@CODI_ALMA) as kard_abr,
		    dbo.f_saldo_mes(@anio, '05', prod.codi_prod,@CODI_ALMA) as kard_may,
		    dbo.f_saldo_mes(@anio, '06', prod.codi_prod,@CODI_ALMA) as kard_jun,
		    dbo.f_saldo_mes(@anio, '07', prod.codi_prod,@CODI_ALMA) as kard_jul,
		    dbo.f_saldo_mes(@anio, '08', prod.codi_prod,@CODI_ALMA) as kard_ago,
		    dbo.f_saldo_mes(@anio, '09', prod.codi_prod,@CODI_ALMA) as kard_sep,
		    dbo.f_saldo_mes(@anio, '10', prod.codi_prod,@CODI_ALMA) as kard_oct,
		    dbo.f_saldo_mes(@anio, '11', prod.codi_prod,@CODI_ALMA) as kard_nov,
		    dbo.f_saldo_mes(@anio, '12', prod.codi_prod,@CODI_ALMA) as kard_dic,
			prod.CODI_PROD,
			(select des_lin_pro from LINEA_FAMILIA_PRO where cod_lin_pro in (
				select cod_lin_pro from FAMILIA_PRODUCTO 
					where CODI_FAMI_PROD in ( select CODI_FAMI_PROD 
						from sub_familia_producto 
								where codi_sub_fami_prod =max(prod.CODI_SUB_FAMI_PROD)))) as Linea
	    

		    ---fin de valor costo ------------		  	 
		   from almacen as suc inner join factura as fac on suc.codi_alma=fac.codi_alma
			inner join factura_detalle 	as fd on fac.codi_fact = fd.codi_fact
			inner join almacen_producto 	as ap on (fd.codi_alma=ap.codi_alma and fd.codi_prod=ap.codi_prod)
			inner join productos		as prod on ap.codi_prod = prod.codi_prod
			inner join presentacion 	as pres on prod.cod_pres=pres.cod_pres
			inner join cliente_proveedor 	as cp on prod.codi_clie_prov = cp.codi_clie_prov
		    where suc.codi_alma=@codi_alma and year(fac.fech_fact)=@anio  and ( fac.estado not in ('a') or fac.estado is null)
		 group by   suc.nemo_alma , cp.codi_clie_prov, cp.denominacion  , prod.codi_prod, prod.desc_prod , pres.desc_pres


	if @tipo_pago<>0 and @codi_alma='00'
		select  '' nemo_alma , cp.codi_clie_prov, cp.denominacion as laboratorio, prod.desc_prod , pres.desc_pres ,
		    sum(case month(fac.fech_fact) when '1' then fd.cant_item else 0 end) as cant_enero,
		    sum(case month(fac.fech_fact) when '2' then fd.cant_item else 0 end) as cant_febrero,
		    sum(case month(fac.fech_fact) when '3' then fd.cant_item else 0 end) as cant_marzo,
		    sum(case month(fac.fech_fact) when '4' then fd.cant_item else 0 end) as cant_abril,
		    sum(case month(fac.fech_fact) when '5' then fd.cant_item else 0 end) as cant_mayo,
		    sum(case month(fac.fech_fact) when '6' then fd.cant_item else 0 end) as cant_junio,
		    sum(case month(fac.fech_fact) when '7' then fd.cant_item else 0 end) as cant_julio,
		    sum(case month(fac.fech_fact) when '8' then fd.cant_item else 0 end) as cant_agosto,
		    sum(case month(fac.fech_fact) when '9' then fd.cant_item else 0 end) as cant_setiembre,
		    sum(case month(fac.fech_fact) when '10' then fd.cant_item else 0 end) as cant_octubre,
		    sum(case month(fac.fech_fact) when '11' then fd.cant_item else 0 end) as cant_noviembre,
		    sum(case month(fac.fech_fact) when '12' then fd.cant_item else 0 end) as cant_diciembre ,
		    ---valor venta--------------------	
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JULIO,
		    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_DIC,
		    ---fin de valor venta ----------
		    ---Valor costo------------------
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JULIO,
		    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC,
                    dbo.f_saldo_mes(@anio, '01', prod.codi_prod,@CODI_ALMA) as kard_ene,		
		    dbo.f_saldo_mes(@anio, '02', prod.codi_prod,@CODI_ALMA) as kard_feb,
		    dbo.f_saldo_mes(@anio, '03', prod.codi_prod,@CODI_ALMA) as kard_mar,
		    dbo.f_saldo_mes(@anio, '04', prod.codi_prod,@CODI_ALMA) as kard_abr,
		    dbo.f_saldo_mes(@anio, '05', prod.codi_prod,@CODI_ALMA) as kard_may,
		    dbo.f_saldo_mes(@anio, '06', prod.codi_prod,@CODI_ALMA) as kard_jun,
		    dbo.f_saldo_mes(@anio, '07', prod.codi_prod,@CODI_ALMA) as kard_jul,
		    dbo.f_saldo_mes(@anio, '08', prod.codi_prod,@CODI_ALMA) as kard_ago,
		    dbo.f_saldo_mes(@anio, '09', prod.codi_prod,@CODI_ALMA) as kard_sep,
		    dbo.f_saldo_mes(@anio, '10', prod.codi_prod,@CODI_ALMA) as kard_oct,
		    dbo.f_saldo_mes(@anio, '11', prod.codi_prod,@CODI_ALMA) as kard_nov,
		    dbo.f_saldo_mes(@anio, '12', prod.codi_prod,@CODI_ALMA) as kard_dic,
			prod.CODI_PROD,
			(select des_lin_pro from LINEA_FAMILIA_PRO where cod_lin_pro in (
				select cod_lin_pro from FAMILIA_PRODUCTO 
					where CODI_FAMI_PROD in ( select CODI_FAMI_PROD 
						from sub_familia_producto 
								where codi_sub_fami_prod =max(prod.CODI_SUB_FAMI_PROD)))) as Linea

		    ---fin de valor costo ------------		  	 
		   from almacen as suc inner join factura as fac on suc.codi_alma=fac.codi_alma
			inner join factura_detalle 	as fd on fac.codi_fact = fd.codi_fact
			inner join almacen_producto 	as ap on (fd.codi_alma=ap.codi_alma and fd.codi_prod=ap.codi_prod)
			inner join productos		as prod on ap.codi_prod = prod.codi_prod
			inner join presentacion 	as pres on prod.cod_pres=pres.cod_pres
			inner join cliente_proveedor 	as cp on prod.codi_clie_prov = cp.codi_clie_prov
		    where year(fac.fech_fact)=@anio   and ( fac.estado not in ('a') or fac.estado is null)
			and fac.codi_tipo_pago=@tipo_pago	
		 group by  cp.codi_clie_prov, cp.denominacion  , prod.codi_prod, prod.desc_prod , pres.desc_pres

	if @tipo_pago=0 and @codi_alma='00'
		select '' nemo_alma , cp.codi_clie_prov, cp.denominacion as laboratorio, prod.desc_prod , pres.desc_pres ,
		    sum(case month(fac.fech_fact) when '1' then fd.cant_item else 0 end) as cant_enero,
		    sum(case month(fac.fech_fact) when '2' then fd.cant_item else 0 end) as cant_febrero,
		    sum(case month(fac.fech_fact) when '3' then fd.cant_item else 0 end) as cant_marzo,
		    sum(case month(fac.fech_fact) when '4' then fd.cant_item else 0 end) as cant_abril,
		    sum(case month(fac.fech_fact) when '5' then fd.cant_item else 0 end) as cant_mayo,
		    sum(case month(fac.fech_fact) when '6' then fd.cant_item else 0 end) as cant_junio,
		    sum(case month(fac.fech_fact) when '7' then fd.cant_item else 0 end) as cant_julio,
		    sum(case month(fac.fech_fact) when '8' then fd.cant_item else 0 end) as cant_agosto,
		    sum(case month(fac.fech_fact) when '9' then fd.cant_item else 0 end) as cant_setiembre,
		    sum(case month(fac.fech_fact) when '10' then fd.cant_item else 0 end) as cant_octubre,
		    sum(case month(fac.fech_fact) when '11' then fd.cant_item else 0 end) as cant_noviembre,
		    sum(case month(fac.fech_fact) when '12' then fd.cant_item else 0 end) as cant_diciembre ,
		    ---valor venta--------------------	
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_JULIO,
		    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM ) else 0 end) as VALO_VENTA_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM ) else 0 end) as VALO_VENTA_DIC,
		    ---fin de valor venta ----------
		    ---Valor costo------------------
		    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ENERO ,
		    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_FEBRERO,
		    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAR,
		    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ABRIL,
		    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAYO,
		    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JUNIO,
		    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JULIO,
		    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_AGOS,
		    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_SET,
		    SUM(case month(FAC.FECH_FACT) when '10' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_OCT,
		    SUM(case month(FAC.FECH_FACT) when '11' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_NOV,
		    SUM(case month(FAC.FECH_FACT) when '12' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC,
                    dbo.f_saldo_mes(@anio, '01', prod.codi_prod,@CODI_ALMA) as kard_ene,		
		    dbo.f_saldo_mes(@anio, '02', prod.codi_prod,@CODI_ALMA) as kard_feb,
		    dbo.f_saldo_mes(@anio, '03', prod.codi_prod,@CODI_ALMA) as kard_mar,
		    dbo.f_saldo_mes(@anio, '04', prod.codi_prod,@CODI_ALMA) as kard_abr,
		    dbo.f_saldo_mes(@anio, '05', prod.codi_prod,@CODI_ALMA) as kard_may,
		    dbo.f_saldo_mes(@anio, '06', prod.codi_prod,@CODI_ALMA) as kard_jun,
		    dbo.f_saldo_mes(@anio, '07', prod.codi_prod,@CODI_ALMA) as kard_jul,
		    dbo.f_saldo_mes(@anio, '08', prod.codi_prod,@CODI_ALMA) as kard_ago,
		    dbo.f_saldo_mes(@anio, '09', prod.codi_prod,@CODI_ALMA) as kard_sep,
		    dbo.f_saldo_mes(@anio, '10', prod.codi_prod,@CODI_ALMA) as kard_oct,
		    dbo.f_saldo_mes(@anio, '11', prod.codi_prod,@CODI_ALMA) as kard_nov,
		    dbo.f_saldo_mes(@anio, '12', prod.codi_prod,@CODI_ALMA) as kard_dic,
			prod.CODI_PROD,
			(select des_lin_pro from LINEA_FAMILIA_PRO where cod_lin_pro in (
				select cod_lin_pro from FAMILIA_PRODUCTO 
					where CODI_FAMI_PROD in ( select CODI_FAMI_PROD 
						from sub_familia_producto 
								where codi_sub_fami_prod =max(prod.CODI_SUB_FAMI_PROD)))) as Linea

		    ---fin de valor costo ------------		  	 
		   from almacen as suc inner join factura as fac on suc.codi_alma=fac.codi_alma
			inner join factura_detalle 	as fd on fac.codi_fact = fd.codi_fact
			inner join almacen_producto 	as ap on (fd.codi_alma=ap.codi_alma and fd.codi_prod=ap.codi_prod)
			inner join productos		as prod on ap.codi_prod = prod.codi_prod
			inner join presentacion 	as pres on prod.cod_pres=pres.cod_pres
			inner join cliente_proveedor 	as cp on prod.codi_clie_prov = cp.codi_clie_prov
		    where year(fac.fech_fact)=@anio   and ( fac.estado not in ('a') or fac.estado is null)
		 group by  cp.codi_clie_prov, cp.denominacion  , prod.codi_prod, prod.desc_prod , pres.desc_pres

end
GO
