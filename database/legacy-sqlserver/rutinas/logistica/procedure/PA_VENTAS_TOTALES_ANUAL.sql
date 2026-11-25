CREATE PROCEDURE [dbo].[PA_VENTAS_TOTALES_ANUAL]
	@ANIO [int],
	@TIPO [int]
WITH EXECUTE AS CALLER
AS
begin

if @tipo=1 or @tipo=4

begin
	select   SUC.NEMO_ALMA , 'VALOR_VENTA' TIPO ,
	 sum((CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )) monto

	 FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
	 where year(FAC.FECH_FACT) = @anio   and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)	and FAC.CODI_TIPO_PAGO=@tipo
	 group by  SUC.NEMO_ALMA , YEAR(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO 
	
	UNION ALL
	
	select  SUC.NEMO_ALMA, 'VALOR_COSTO' TIPO,
	sum((CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO )) monto

	FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		inner join PRODUCTOS as PROD on FD.codi_prod=PROD.codi_prod
		where year(FAC.FECH_FACT)= @anio  and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL) and FAC.CODI_TIPO_PAGO = @tipo
	group by  SUC.NEMO_ALMA , YEAR(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO
	
	UNION ALL
	
	select SUC.NEMO_ALMA, 'UTILIDAD' TOTAL,
		sum((CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM )) - 
		sum((CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO) ) monto
				
	FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		inner join PRODUCTOS as PROD on FD.codi_prod=PROD.codi_prod
		where year(FAC.FECH_FACT) = @anio and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL) and FAC.CODI_TIPO_PAGO=@tipo
	group by  SUC.NEMO_ALMA , YEAR(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO

end 

else


select   SUC.NEMO_ALMA , 'VALOR_VENTA' TIPO,
	 sum((CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )) monto

	 FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
	 where year(FAC.FECH_FACT) = @anio   and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	 group by  SUC.NEMO_ALMA , YEAR(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO 
	
	UNION ALL
	
	select  SUC.NEMO_ALMA, 'VALOR_COSTO' TIPO,
	sum((CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO )) monto

	FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		inner join PRODUCTOS as PROD on FD.codi_prod=PROD.codi_prod
		where year(FAC.FECH_FACT)= @anio  and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by  SUC.NEMO_ALMA , YEAR(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO
	
	UNION ALL
	
	select SUC.NEMO_ALMA, 'UTILIDAD' TOTAL,
		sum((CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM )) - 
		sum((CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO) ) monto
				
	FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		inner join PRODUCTOS as PROD on FD.codi_prod=PROD.codi_prod
		where year(FAC.FECH_FACT) = @anio and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by  SUC.NEMO_ALMA , YEAR(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO

end
GO
