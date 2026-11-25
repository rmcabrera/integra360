CREATE PROCEDURE [dbo].[usp_repo_venta_x_anios_unidades]
	@TIPO [varchar](2),
	@CODI_ALMA [char](2),
	@FEC1 [datetime],
	@FEC2 [datetime],
	@CODI_CLIE_PROV [char](5),
	@SUBFAMILIA [char](4),
	@CODI_PRES [int]
WITH EXECUTE AS CALLER
AS
--declare @TIPO varCHAR(2) , @CODI_ALMA CHAR(2) , @FEC1 DATETIME , @FEC2 DATETIME  , @CODI_CLIE_PROV CHAR(5)  , @SUBFAMILIA char(4) , @CODI_PRES INT 
--select @TIPO ='1', @CODI_ALMA ='00' , @FEC1 ='01/01/2017', @FEC2 ='31/01/2019', @CODI_CLIE_PROV ='04554', @SUBFAMILIA ='', @CODI_PRES =0

set nocount on
set quoted_identifier off 

declare @SQLString nvarchar(4000)
declare @Condi varchar(100) ,@Grup varchar(100)
declare @ParmString nvarchar(100)

create table #alma (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	set @Grup=""
	set @Condi="'TODOS' as nemo, "
	insert #alma 
	Select codi_alma from almacen (nolock)
END
ELSE
BEGIN
	set @Condi=" SUC.NEMO_ALMA , "
	set @Grup=" SUC.NEMO_ALMA , "
	insert #alma 
	Select codi_alma from almacen  (nolock) where codi_alma = @codi_alma
END

set nocount on
--- TODO ESTA POR SUCURSAL Y ENTRE FECHAS --------------

	set @Parmstring = "@fec1 datetime ,@fec2 datetime"

	set @SQLString = "
	select " +@Condi+" CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,
		year(fac.fech_Fact) as anio,
		cantidad = sum( FD.CANT_ITEM )  
	
	FROM ALMACEN as SUC inner join FACTURA  as FAC  (nolock) on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as datetime) between @fec1 and @fec2)	
		and CP.CODI_CLIE_PROV ='"+@CODI_CLIE_PROV+"' AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by   " +@Grup+"  year(fac.fech_Fact), CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES
	order by desc_prod "
	
	execute sp_executesql @SQLString, @ParmString, @fec1 =@fec1 , @fec2 =@fec2


drop table #alma 

set quoted_identifier on
GO
