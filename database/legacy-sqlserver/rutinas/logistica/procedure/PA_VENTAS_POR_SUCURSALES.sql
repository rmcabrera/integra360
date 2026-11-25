CREATE PROCEDURE [dbo].[PA_VENTAS_POR_SUCURSALES]
	@TIPO [char](1),
	@CODI_TIPO_PAGO [numeric](18, 0),
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @TIPO CHAR(1) ,  @ANIO int ,  @CODI_TIPO_PAGO NUMERIC , @f1 datetime , @f2 datetime
--select @TIPO = 2 ,  @ANIO =2010,  @CODI_TIPO_PAGO =4, @f1 ='01/08/2010', @f2 ='30/08/2010'

set nocount on
IF @TIPO='1'
 
BEGIN
	select  SUC.NEMO_ALMA , 
	    ( CASE  FAC.CODI_TIPO_PAGO WHEN 1 THEN 'CONTADO' WHEN 4 THEN 'CREDITO' ELSE '' END) AS 'TIPO_VENTA' ,
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
	    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ENERO ,
	    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_FEBRERO,
	    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAR,
	    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ABRIL,
	    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAYO,
	    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JUNIO,
	    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JULIO,
	    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_AGOS,
	    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_SET,
	    SUM(case month(FAC.FECH_FACT) when '10' then (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_OCT,
	    SUM(case month(FAC.FECH_FACT) when '11' then (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_NOV,
	    SUM(case month(FAC.FECH_FACT) when '12' then (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC
	    ---fin de valor costo ------------
	
	   FROM dbo.ALMACEN as SUC (nolock)  
		inner join dbo.FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma
		inner join dbo.FACTURA_DETALLE as FD (nolock)  on FAC.codi_fact = FD.codi_fact 
		inner join dbo.PRODUCTOS as P (nolock) on FD.codi_prod=P.Codi_prod
	   where FAC.CODI_TIPO_PAGO= @CODI_TIPO_PAGO and  
		 cast(convert(char(10), fac.fech_fact,103) as datetime) between @f1 and @f2 and  
		( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
--		year(FAC.FECH_FACT)=@ANIO   		
	 group by  SUC.NEMO_ALMA , FAC.CODI_TIPO_PAGO


END 

ELSE

BEGIN
	select  SUC.NEMO_ALMA , 
	    --( CASE  FAC.CODI_TIPO_PAGO WHEN 1 THEN 'CONTADO' WHEN 4 THEN 'CREDITO' ELSE '' END) AS 'TIPO_VENTA' ,
 	     '',
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
	    SUM(case month(FAC.FECH_FACT) when '1' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ENERO ,
	    SUM(case month(FAC.FECH_FACT) when '2' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_FEBRERO,
	    SUM(case month(FAC.FECH_FACT) when '3' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAR,
	    SUM(case month(FAC.FECH_FACT) when '4' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_ABRIL,
	    SUM(case month(FAC.FECH_FACT) when '5' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_MAYO,
	    SUM(case month(FAC.FECH_FACT) when '6' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JUNIO,
	    SUM(case month(FAC.FECH_FACT) when '7' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_JULIO,
	    SUM(case month(FAC.FECH_FACT) when '8' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_AGOS,
	    SUM(case month(FAC.FECH_FACT) when '9' then  (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_SET,
	    SUM(case month(FAC.FECH_FACT) when '10' then (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_OCT,
	    SUM(case month(FAC.FECH_FACT) when '11' then (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_NOV,
	    SUM(case month(FAC.FECH_FACT) when '12' then (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC
	    ---fin de valor costo ------------
	
	   FROM dbo.ALMACEN as SUC (nolock)  
		inner join dbo.FACTURA as FAC (nolock)  on suc.codi_alma=FAC.codi_alma
		inner join dbo.FACTURA_DETALLE as FD (nolock)  on FAC.codi_fact = FD.codi_fact
		inner join dbo.PRODUCTOS as P (nolock) on FD.codi_prod=P.Codi_prod
	   where --year(FAC.FECH_FACT)=@ANIO   
		 cast(convert(char(10), fac.fech_fact,103) as datetime) between @f1 and @f2 and  
		( isnull(FAC.ESTADO,'')<>'A')
	 group by  SUC.NEMO_ALMA--, FAC.CODI_TIPO_PAGO

END
GO
