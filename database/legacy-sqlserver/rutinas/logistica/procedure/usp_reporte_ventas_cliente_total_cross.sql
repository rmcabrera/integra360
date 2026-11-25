CREATE PROCEDURE [dbo].[usp_reporte_ventas_cliente_total_cross]
	@calma [char](2),
	@FI [datetime],
	@FF [datetime]
WITH EXECUTE AS CALLER
AS
--declare @calma char(2), @FI datetime, @FF datetime
--select @calma ='04', @FI ='01/01/2018', @FF ='31/12/2019'

set nocount on 

declare @alma table (codi_alma char(2) null)
IF @calma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock)
END
ELSE
BEGIN
	insert @alma
	Select @calma
END

declare @Tx table ( idx int identity , cliente varchar(200) null, vcostocont numeric(18,6) null  , vventacont numeric(18,6) null,
			        codi_clie_prov char(5) null, anio char(4) null)

declare @Rx table (idx int, cliente varchar(200) null, vcostocont numeric(18,6) null, vventacont numeric(18,6) null,
		            codi_clie_prov char(5) null, anio char(4) null)

insert @tx
SELECT 
	(Select isnull(denominacion,'NO DEFINIDO') from cliente_proveedor (nolock) 
		where codi_clie_prov=FACTURA.CODI_CLIE_PROV) CLIENTE,   
	SUM((case when codi_tipo_pago=1 then (CANT_ITEM * PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end)) else 0 end)) VCOSTOCONT,
	SUM((case when codi_tipo_pago=1 then (CANT_ITEM * PREC_ITEM * (CASE WHEN factura.codi_mone='01' THEN 1 ELSE factura.tcambio END)) else 0 end)) VVENTACONT,
	FACTURA.codi_clie_prov, year(fech_fact) anio
	
FROM FACTURA (nolock)
	 JOIN FACTURA_DETALLE (nolock)
	 ON FACTURA_DETALLE.CODI_FACT = FACTURA.CODI_FACT
	 RIGHT JOIN PRODUCTOS (nolock)
	 ON PRODUCTOS.CODI_PROD = FACTURA_DETALLE.CODI_PROD
WHERE (cast(convert(varchar(10), FACTURA.fech_fact , 103) as smalldatetime) between @FI and @FF) and ( ISNULL(FACTURA.ESTADO,'')<>'A') 
	   and FACTURA.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
GROUP BY year(FECH_FACT), FACTURA.CODI_CLIE_PROV
order by vventacont desc

insert @RX
select idx, cliente , vcostocont , vventacont , codi_clie_prov, anio
from @tx T

select anio, cliente, vcostocont, vventacont,  round(vventacont  -  vcostocont,2) as util,
	   case when isnull(vventacont,0)=0 then 0 else
	   round((vventacont  -  vcostocont)/vventacont*100,2) end porcen,
       codi_clie_prov
from @Rx T
--where codi_clie_prov='75173'
order by anio, cliente
GO
