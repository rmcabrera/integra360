CREATE PROCEDURE [dbo].[PA_VENTAS_ANUAL]
	@anio [int],
	@tipo_pago [int]
WITH EXECUTE AS CALLER
AS
if @tipo_pago=1 or @tipo_pago=4
begin
	select nemo_alma, sum(venta_valor_conta) as VVC , sum(venta_costo_conta) VCC ,
	sum(venta_valor_cred) as VVCred , sum(venta_costo_cred) VCCred from 
	
	(select   SUC.NEMO_ALMA , 

	venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
	venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

	venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
	venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)     	  	
	
	   FROM ALMACEN as SUC 
		inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		inner join PRODUCTOS as PROD on FD.codi_prod=PROD.codi_prod
	   where year(FAC.FECH_FACT)=@anio  and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	    and FAC.CODI_TIPO_PAGO=@tipo_pago
	
	group by  SUC.NEMO_ALMA , year(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO ) as VT
	
	group by nemo_alma
end

else

	select nemo_alma, sum(venta_valor_conta) as VVC , sum(venta_costo_conta) VCC ,
	sum(venta_valor_cred) as VVCred , sum(venta_costo_cred) VCCred from 
	
	(select   SUC.NEMO_ALMA , 
	venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
	venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

	venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
	venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)     	  	
	
	   FROM ALMACEN as SUC 
		inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		inner join PRODUCTOS as PROD on FD.codi_prod=PROD.codi_prod
	   where year(FAC.FECH_FACT)=@anio  and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)

	group by  SUC.NEMO_ALMA , year(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO ) as VT
	
	group by nemo_alma
GO
