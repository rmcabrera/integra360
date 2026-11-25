CREATE PROCEDURE [dbo].[usp_ventas_x_linea]
	@TIPO [int],
	@codi_alma [char](2),
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @TIPO INT , @codi_alma char(2) ,  @f1 datetime , @f2 datetime
--select @TIPO =0  , @codi_alma ='00', @f1 ='01/08/2010', @f2 ='30/08/2010'


set nocount on 

declare @alma table (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock)
END
ELSE
BEGIN
	insert @alma
	Select @codi_alma
END
declare @pago table (codi_tipo_pago char(2) null)
IF @tipo = 0
BEGIN
	insert @pago
	Select codi_tipo_medio_pago from tipo_pago (nolock)
END
ELSE
BEGIN
	insert @pago
	Select @tipo
END

set nocount on
select  l.cod_lin_pro, l.des_lin_pro as laboratorio , 
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
	    SUM(case month(FAC.FECH_FACT) when '12' then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC
    ---fin de valor costo ------------

   FROM ALMACEN as SUC (nolock)  
	inner join FACTURA  as FAC (nolock) on suc.codi_alma=FAC.codi_alma
	left join FACTURA_DETALLE  as FD (nolock) on FAC.codi_fact = FD.codi_fact
	left join ALMACEN_PRODUCTO as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
	left join PRODUCTOS as PROD (nolock)  on AP.codi_prod = PROD.codi_prod
	left join PRESENTACION 	  AS PRES (nolock)  ON PROD.COD_PRES=PRES.COD_PRES
	left join CLIENTE_PROVEEDOR  as CP (nolock)  on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
	left JOIN SUB_FAMILIA_PRODUCTO   AS SF (nolock)  ON PROD.CODI_SUB_FAMI_PROD = SF.CODI_SUB_FAMI_PROD
	left JOIN FAMILIA_PRODUCTO AS F  (nolock)  ON SF.CODI_FAMI_PROD = F.CODI_FAMI_PROD
	left join LINEA_FAMILIA_PRO  L (nolock) on f.cod_lin_pro=l.cod_lin_pro
    where --year(FAC.FECH_FACT)=@ANIO   and   
	cast(convert(char(10), fac.fech_fact,103) as datetime) between @f1 and @f2 and	
	 ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	AND FAC.CODI_TIPO_PAGO  in (Select codi_tipo_pago from @PAGO)
	AND SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
 group by   l.cod_lin_pro, l.des_lin_pro
GO
