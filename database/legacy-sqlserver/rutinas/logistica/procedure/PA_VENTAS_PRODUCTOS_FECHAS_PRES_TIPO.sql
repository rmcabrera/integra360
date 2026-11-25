CREATE PROCEDURE [dbo].[PA_VENTAS_PRODUCTOS_FECHAS_PRES_TIPO]
	@TIPO [varchar](2),
	@CODI_ALMA [char](2),
	@FEC1 [datetime],
	@FEC2 [datetime],
	@CODI_CLIE_PROV [char](5),
	@SUBFAMILIA [char](4),
	@CODI_PRES [int]
WITH EXECUTE AS CALLER
AS
--declare @TIPO varCHAR(2) , @CODI_ALMA CHAR(2) , @FEC1 DATETIME , @FEC2 DATETIME, @CODI_CLIE_PROV CHAR(5)  , @SUBFAMILIA char(4) , @CODI_PRES INT 
--select @TIPO ='3', @CODI_ALMA ='07' , @FEC1 ='01/06/2019', @FEC2 ='30/12/2019', @CODI_CLIE_PROV ='', @SUBFAMILIA ='0901', @CODI_PRES =0

set nocount on

if @CODI_ALMA='00' set @CODI_ALMA=null

select case when @CODI_ALMA='00' then 'TODOS' else (select nemo_alma from almacen A(nolock) where A.codi_alma=@CODI_ALMA) end nemo_alma, 
	upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD', PRES.DESC_PRES ,

	venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
	venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
	venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

	venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
	venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
	venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)
	
FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
	inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
	inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
	inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
	INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
	inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
	INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD

where (isnull(@CODI_ALMA,'')='' or SUC.codi_alma = @CODI_ALMA)
	 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
	and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)

group by SF.DESC_SUB_FAMI_PROD, PROD.COD_PRES, PRES.DESC_PRES

order by PRES.DESC_PRES
GO
