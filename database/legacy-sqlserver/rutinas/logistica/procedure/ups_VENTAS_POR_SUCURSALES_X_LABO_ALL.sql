CREATE PROCEDURE [dbo].[ups_VENTAS_POR_SUCURSALES_X_LABO_ALL]
	@TIPO [char](1),
	@CODI_TIPO_PAGO [int],
	@f1 [datetime],
	@f2 [datetime],
	@Labo [varchar](12)
WITH EXECUTE AS CALLER
AS
--declare @TIPO CHAR(1) ,  @ANIO int ,  @CODI_TIPO_PAGO NUMERIC , @f1 datetime , @f2 datetime, @Labo varchar(12)
--select @TIPO = 1 ,  @ANIO =2011,  @CODI_TIPO_PAGO =1, @f1 ='01/01/2011', @f2 ='30/08/2011', @labo='20137845157'


declare @TX table (nemo_alma varchar(50) null, tipo_venta varchar(20) null, venta_enero numeric(12,6) null ,
		venta_febrero numeric(12,6) null ,venta_marzo numeric(12,6) null ,venta_abril numeric(12,6) null ,
		venta_mayo numeric(12,6) null ,venta_junio numeric(12,6) null ,venta_julio numeric(12,6) null ,
		venta_agosto numeric(12,6) null ,venta_setiembre numeric(12,6) null ,venta_octubre numeric(12,6) null ,
		venta_noviembre numeric(12,6) null ,venta_diciembre numeric(12,6) null , costo_enero numeric(12,6) null , 
		costo_febrero numeric(12,6) null , costo_marzo numeric(12,6) null , costo_abril numeric(12,6) null ,
		costo_mayo numeric(12,6) null , costo_junio numeric(12,6) null , costo_julio numeric(12,6) null ,
		costo_agosto numeric(12,6) null , costo_setiembre numeric(12,6) null , costo_octubre numeric(12,6) null ,
		costo_noviembre numeric(12,6) null , costo_diciembre numeric(12,6) null , cliente varchar(250) null ) 

declare @codi_x char(5)

set nocount on
IF @TIPO='1'
BEGIN
	------------------ siep_agrog
	set @codi_x = isnull(( select codi_clie_prov from siep_agrog.dbo.cliente_proveedor (nolock) where ruc=@labo) ,'')
	
	insert @TX ( nemo_alma , tipo_venta , venta_enero , venta_febrero  ,venta_marzo  ,venta_abril ,
		venta_mayo ,venta_junio ,venta_julio ,	venta_agosto ,venta_setiembre ,venta_octubre ,
		venta_noviembre ,venta_diciembre , costo_enero , costo_febrero , costo_marzo , costo_abril ,
		costo_mayo , costo_junio , costo_julio ,costo_agosto , costo_setiembre , costo_octubre ,
		costo_noviembre , costo_diciembre , cliente ) 
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
	    SUM(case month(FAC.FECH_FACT) when '12' then (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC,
	    ---fin de valor costo ------------
	    (select case when left(tipo_pers,1)='N' then apel_1+isnull(' ' +apel_2,'') + isnull(' '+nomb_1,'') + isnull(' ' +nomb_2,'') 
			else isnull(razo_soci,denominacion) end 
			from siep_agrog.dbo.cliente_proveedor C  (nolock) where c.codi_clie_prov= @codi_x) Cliente
	
	   FROM siep_agrog.dbo.ALMACEN as SUC (nolock)  
		inner join siep_agrog.dbo.FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma
		inner join siep_agrog.dbo.FACTURA_DETALLE as FD (nolock)  on FAC.codi_fact = FD.codi_fact 
		inner join siep_agrog.dbo.PRODUCTOS as P (nolock) on FD.codi_prod=P.Codi_prod
	   where FAC.CODI_TIPO_PAGO= @CODI_TIPO_PAGO and  
		 cast(convert(char(10), fac.fech_fact,103) as datetime) between @f1 and @f2 and  
		( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)  and p.codi_clie_prov=@codi_x
--		year(FAC.FECH_FACT)=@ANIO   		
	 group by  SUC.NEMO_ALMA , FAC.CODI_TIPO_PAGO


	------------------ siep_agrom
	set @codi_x = isnull(( select codi_clie_prov from siep_agrom.dbo.cliente_proveedor (nolock) where ruc=@labo) ,'')

	insert @TX ( nemo_alma , tipo_venta , venta_enero , venta_febrero  ,venta_marzo  ,venta_abril ,
		venta_mayo ,venta_junio ,venta_julio ,	venta_agosto ,venta_setiembre ,venta_octubre ,
		venta_noviembre ,venta_diciembre , costo_enero , costo_febrero , costo_marzo , costo_abril ,
		costo_mayo , costo_junio , costo_julio ,costo_agosto , costo_setiembre , costo_octubre ,
		costo_noviembre , costo_diciembre , cliente ) 
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
	    SUM(case month(FAC.FECH_FACT) when '12' then (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC,
	    ---fin de valor costo ------------
	    (select case when left(tipo_pers,1)='N' then apel_1+isnull(' ' +apel_2,'') + isnull(' '+nomb_1,'') + isnull(' ' +nomb_2,'') 
			else isnull(razo_soci,denominacion) end from siep_agrom.dbo.cliente_proveedor C  (nolock) where c.codi_clie_prov= @codi_x) Cliente
	
	   FROM siep_agrom.dbo.ALMACEN as SUC (nolock)  
		inner join siep_agrom.dbo.FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma
		inner join siep_agrom.dbo.FACTURA_DETALLE as FD (nolock)  on FAC.codi_fact = FD.codi_fact 
		inner join siep_agrom.dbo.PRODUCTOS as P (nolock) on FD.codi_prod=P.Codi_prod
	   where FAC.CODI_TIPO_PAGO= @CODI_TIPO_PAGO and  
		 cast(convert(char(10), fac.fech_fact,103) as datetime) between @f1 and @f2 and  
		( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)  and p.codi_clie_prov=@codi_x
--		year(FAC.FECH_FACT)=@ANIO   		
	 group by  SUC.NEMO_ALMA , FAC.CODI_TIPO_PAGO



	select  nemo_alma , tipo_venta , 
		sum(venta_enero) , sum(venta_febrero)  , sum(venta_marzo)  , sum(venta_abril) ,
		sum(venta_mayo) , sum(venta_junio) , sum(venta_julio) ,	sum(venta_agosto) , sum(venta_setiembre) , sum(venta_octubre) ,
		sum(venta_noviembre) , sum(venta_diciembre) , sum(costo_enero) , sum( costo_febrero) , sum(costo_marzo) , sum(costo_abril) ,
		sum(costo_mayo) , sum(costo_junio) , sum(costo_julio) , sum(costo_agosto) , sum(costo_setiembre) , sum(costo_octubre) ,
		sum(costo_noviembre) , sum(costo_diciembre) , MAX(cliente)
	from @Tx
	group by nemo_alma, tipo_venta

END 

ELSE

BEGIN
	------------------ siep_agrog
	set @codi_x = isnull(( select codi_clie_prov from siep_agrog.dbo.cliente_proveedor (nolock) where ruc=@labo) ,'')
	
	insert @TX ( nemo_alma , tipo_venta , venta_enero , venta_febrero  ,venta_marzo  ,venta_abril ,
		venta_mayo ,venta_junio ,venta_julio ,	venta_agosto ,venta_setiembre ,venta_octubre ,
		venta_noviembre ,venta_diciembre , costo_enero , costo_febrero , costo_marzo , costo_abril ,
		costo_mayo , costo_junio , costo_julio ,costo_agosto , costo_setiembre , costo_octubre ,
		costo_noviembre , costo_diciembre , cliente ) 
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
	    SUM(case month(FAC.FECH_FACT) when '12' then (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC,
	    ---fin de valor costo ------------
	    (select case when left(tipo_pers,1)='N' then apel_1+isnull(' ' +apel_2,'') + isnull(' '+nomb_1,'') + isnull(' ' +nomb_2,'') 
			else isnull(razo_soci,denominacion) end from siep_agrog.dbo.cliente_proveedor C  (nolock) where c.codi_clie_prov= @codi_x) Cliente
	   FROM siep_agrog.dbo.ALMACEN as SUC (nolock)  
		inner join siep_agrog.dbo.FACTURA as FAC (nolock)  on suc.codi_alma=FAC.codi_alma
		inner join siep_agrog.dbo.FACTURA_DETALLE as FD (nolock)  on FAC.codi_fact = FD.codi_fact
		inner join siep_agrog.dbo.PRODUCTOS as P (nolock) on FD.codi_prod=P.Codi_prod
	   where --year(FAC.FECH_FACT)=@ANIO   
		 cast(convert(char(10), fac.fech_fact,103) as datetime) between @f1 and @f2 and  
		( isnull(FAC.ESTADO,'')<>'A') and p.codi_clie_prov=@Codi_x
	 group by  SUC.NEMO_ALMA--, FAC.CODI_TIPO_PAGO

	------------------ siep_agrom
	set @codi_x = isnull(( select codi_clie_prov from siep_agrom.dbo.cliente_proveedor (nolock) where ruc=@labo) ,'')
	
	insert @TX ( nemo_alma , tipo_venta , venta_enero , venta_febrero  ,venta_marzo  ,venta_abril ,
		venta_mayo ,venta_junio ,venta_julio ,	venta_agosto ,venta_setiembre ,venta_octubre ,
		venta_noviembre ,venta_diciembre , costo_enero , costo_febrero , costo_marzo , costo_abril ,
		costo_mayo , costo_junio , costo_julio ,costo_agosto , costo_setiembre , costo_octubre ,
		costo_noviembre , costo_diciembre , cliente ) 
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
	    SUM(case month(FAC.FECH_FACT) when '12' then (CASE P.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end) as VALO_COSTO_DIC,
	    ---fin de valor costo ------------
	    (select case when left(tipo_pers,1)='N' then apel_1+isnull(' ' +apel_2,'') + isnull(' '+nomb_1,'') + isnull(' ' +nomb_2,'') 
			else isnull(razo_soci,denominacion) end from siep_agrom.dbo.cliente_proveedor C  (nolock) where c.codi_clie_prov= @codi_x) Cliente
	   FROM siep_agrom.dbo.ALMACEN as SUC (nolock)  
		inner join siep_agrom.dbo.FACTURA as FAC (nolock)  on suc.codi_alma=FAC.codi_alma
		inner join siep_agrom.dbo.FACTURA_DETALLE as FD (nolock)  on FAC.codi_fact = FD.codi_fact
		inner join siep_agrom.dbo.PRODUCTOS as P (nolock) on FD.codi_prod=P.Codi_prod
	   where --year(FAC.FECH_FACT)=@ANIO   
		 cast(convert(char(10), fac.fech_fact,103) as datetime) between @f1 and @f2 and  
		( isnull(FAC.ESTADO,'')<>'A') and p.codi_clie_prov=@Codi_x
	 group by  SUC.NEMO_ALMA--, FAC.CODI_TIPO_PAGO


	select  nemo_alma , tipo_venta , 
		sum(venta_enero) , sum(venta_febrero)  , sum(venta_marzo)  , sum(venta_abril) ,
		sum(venta_mayo) , sum(venta_junio) , sum(venta_julio) ,	sum(venta_agosto) , sum(venta_setiembre) , sum(venta_octubre) ,
		sum(venta_noviembre) , sum(venta_diciembre) , sum(costo_enero) , sum( costo_febrero) , sum(costo_marzo) , sum(costo_abril) ,
		sum(costo_mayo) , sum(costo_junio) , sum(costo_julio) , sum(costo_agosto) , sum(costo_setiembre) , sum(costo_octubre) ,
		sum(costo_noviembre) , sum(costo_diciembre) , MAX(cliente)
	from @Tx
	group by nemo_alma, tipo_venta

END
GO
