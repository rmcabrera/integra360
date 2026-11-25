CREATE PROCEDURE [dbo].[PA_VENTAS_SUCUR_LABO_PRODUC]
	@TIPO [int],
	@tipo_pago [int],
	@ANIO [int],
	@CODI_CLIE_PROV [char](5),
	@CODI_ALMA [char](2)
WITH EXECUTE AS CALLER
AS
if @tipo = 1
begin -- SUCURSAL POR LABORATORIO  / contado - credito
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, PROD.DESC_PROD , PRES.DESC_PRES ,
	
	    SUM(case month(FAC.FECH_FACT) when '1' then FD.CANT_ITEM else 0 end) as CANT_ENERO,
	    SUM(case month(FAC.FECH_FACT) when '2' then FD.CANT_ITEM else 0 end) as CANT_FEBRERO,
	    SUM(case month(FAC.FECH_FACT) when '3' then FD.CANT_ITEM else 0 end) as CANT_MARZO,
	    SUM(case month(FAC.FECH_FACT) when '4' then FD.CANT_ITEM else 0 end) as CANT_ABRIL,
	    SUM(case month(FAC.FECH_FACT) when '5' then FD.CANT_ITEM else 0 end) as CANT_MAYO,
	    SUM(case month(FAC.FECH_FACT) when '6' then FD.CANT_ITEM else 0 end) as CANT_JUNIO,
	    SUM(case month(FAC.FECH_FACT) when '7' then FD.CANT_ITEM else 0 end) as CANT_JULIO,
	    SUM(case month(FAC.FECH_FACT) when '8' then FD.CANT_ITEM else 0 end) as CANT_AGOSTO,
	    SUM(case month(FAC.FECH_FACT) when '9' then FD.CANT_ITEM else 0 end) as CANT_SETIEMBRE,
	    SUM(case month(FAC.FECH_FACT) when '10' then FD.CANT_ITEM else 0 end) as CANT_OCTUBRE,
	    SUM(case month(FAC.FECH_FACT) when '11' then FD.CANT_ITEM else 0 end) as CANT_NOVIEMBRE,
	    SUM(case month(FAC.FECH_FACT) when '12' then FD.CANT_ITEM else 0 end) as CANT_DICIEMBRE ,
	    ---Valor Venta--------------------	
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
	    ---fin de valor venta ------------
	    ---Valor costo--------------------	
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
	    SUM(case month(FAC.FECH_FACT) when '12' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC
	    ---fin de valor costo ------------
	  	 
	   FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP on PROD.codi_clie_prov = CP.CODI_CLIE_PROV

	    where SUC.CODI_ALMA=@CODI_ALMA AND year(FAC.FECH_FACT)=@ANIO   and  CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		AND FAC.CODI_TIPO_PAGO=@tipo_pago
	
	 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , PROD.DESC_PROD , PRES.DESC_PRES

end 


ELSE if @tipo = 2
begin -- SOLO POR SUCURSAL - CONTADO / credito
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, PROD.DESC_PROD , PRES.DESC_PRES ,
	
	    SUM(case month(FAC.FECH_FACT) when '1' then FD.CANT_ITEM else 0 end) as CANT_ENERO,
	    SUM(case month(FAC.FECH_FACT) when '2' then FD.CANT_ITEM else 0 end) as CANT_FEBRERO,
	    SUM(case month(FAC.FECH_FACT) when '3' then FD.CANT_ITEM else 0 end) as CANT_MARZO,
	    SUM(case month(FAC.FECH_FACT) when '4' then FD.CANT_ITEM else 0 end) as CANT_ABRIL,
	    SUM(case month(FAC.FECH_FACT) when '5' then FD.CANT_ITEM else 0 end) as CANT_MAYO,
	    SUM(case month(FAC.FECH_FACT) when '6' then FD.CANT_ITEM else 0 end) as CANT_JUNIO,
	    SUM(case month(FAC.FECH_FACT) when '7' then FD.CANT_ITEM else 0 end) as CANT_JULIO,
	    SUM(case month(FAC.FECH_FACT) when '8' then FD.CANT_ITEM else 0 end) as CANT_AGOSTO,
	    SUM(case month(FAC.FECH_FACT) when '9' then FD.CANT_ITEM else 0 end) as CANT_SETIEMBRE,
	    SUM(case month(FAC.FECH_FACT) when '10' then FD.CANT_ITEM else 0 end) as CANT_OCTUBRE,
	    SUM(case month(FAC.FECH_FACT) when '11' then FD.CANT_ITEM else 0 end) as CANT_NOVIEMBRE,
	    SUM(case month(FAC.FECH_FACT) when '12' then FD.CANT_ITEM else 0 end) as CANT_DICIEMBRE ,
	    ---Valor Venta--------------------	
	    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_ENERO ,
	    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_FEBRERO,
	    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_MAR,
	    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_ABRIL,
	    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_MAYO,
	    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_JUNIO,
	    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_JULIO,
	    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_AGOS,
	    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_SET,
	    SUM(case month(FAC.FECH_FACT) when '10' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_OCT,
	    SUM(case month(FAC.FECH_FACT) when '11' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_NOV,
	    SUM(case month(FAC.FECH_FACT) when '12' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * ( ( FD.PREC_ITEM / ( 1 + ROUND((FD.igv /100) ,2) ))   ) )  else 0 end) as VALO_VENTA_DIC,
	    ---fin de valor venta ------------
	    ---Valor costo--------------------	
	    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ENERO ,
	    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_FEBRERO,
	    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAR,
	    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ABRIL,
	    SUM(case month(FAC.FECH_FACT) when '5' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAYO,
	    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JUNIO,
	    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JULIO,
	    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_AGOS,
	    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_SET,
	    SUM(case month(FAC.FECH_FACT) when '10' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_OCT,
	    SUM(case month(FAC.FECH_FACT) when '11' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_NOV,
	    SUM(case month(FAC.FECH_FACT) when '12' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 1 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC
	    ---fin de valor costo ------------
	  	 
	   FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP on PROD.codi_clie_prov = CP.CODI_CLIE_PROV

	    where SUC.CODI_ALMA=@CODI_ALMA AND year(FAC.FECH_FACT)=@ANIO   and ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		AND FAC.CODI_TIPO_PAGO=@tipo_pago
	
	 group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , PROD.DESC_PROD , PRES.DESC_PRES

end
GO
