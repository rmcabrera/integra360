CREATE PROCEDURE [dbo].[PA_VENTAS_CONSOLIDADO_PRODUCTOS]
	@TIPO [char](1),
	@codi_clie_prov [char](5),
	@cod_prod [char](8),
	@codi_alma [char](2),
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare  @TIPO CHAR(1) , @codi_clie_prov CHAR(5) , @cod_prod CHAR(8) , @codi_alma char(2) , @f1 datetime , @f2 datetime
--select  @TIPO ='1' , @codi_clie_prov ='04554' , @cod_prod ='00011586' , @codi_alma ='00', @f1 ='01/08/2010' , @f2 ='30/08/2010'

SET NOCOUNT ON

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


BEGIN

IF @TIPO='1'
BEGIN 

	create table #Mes (nro_mes int , codi_clie_prov char(5) , laboratorio varchar(100) , cod_prod char(8) , desc_prod varchar(150) , desc_pres varchar(50))
	
	declare @prod varchar(150)
	declare @lab varchar(100)
	declare @codi_pres int
	declare @nro_meses int
	declare @presenta varchar(50)
	
	select @lab  = denominacion from cliente_proveedor  (nolock)where codi_clie_prov=@codi_clie_prov ;
	select @prod = desc_prod , @codi_pres= cod_pres from productos  (nolock)where codi_prod = @cod_prod ;
	select @presenta = desc_pres from presentacion  (nolock)where cod_pres = @codi_pres;
	
	set @nro_meses=1
	while @nro_meses<13
	begin 
	  insert into 	#Mes (nro_mes , codi_clie_prov , laboratorio , cod_prod , desc_prod , desc_pres )
		 values      (@nro_meses , @codi_clie_prov , @lab , @cod_prod , @prod , @presenta)
	  set @nro_meses = @nro_meses + 1 
	end
	
	select 
		( case M.nro_mes when 1 then 'ENERO'  when 2 then 'FEBRERO'  when 3 then 'MARZO'  when 4 then 'ABRIL' 
				 when 5 then 'MAYO'  when 6 then 'JUNIO' when 7 then 'JULIO'  when 8 then 'AGOSTO' 
				 when 9 then 'SETIEMBRE'  when 10 then 'OCTUBRE'  when 11 then 'NOVIEMBRE'  when 12 then 'DICIEMBRE' END ) MES  ,
	
	       M.codi_clie_prov, M.laboratorio, M.cod_prod, M.desc_prod , M.desc_pres ,
	      sum( isnull(F.venta_cant_conta,0)  )  V_Cantid_Contado , sum( isnull(F.venta_valor_conta,0) ) V_Valor_Contado , sum( isnull(F.venta_costo_conta,0)) V_Costo_Contado , 
	      sum( isnull(F.venta_cant_cred,0)) V_Cantid_Cred,sum(  isnull(F.venta_valor_cred,0))  V_Valor_Cred,  sum( isnull(F.venta_costo_cred,0)) V_Costo_Cred
	
	from #Mes M left join 
	
		( select month(fac.fech_fact) as 'Mes', CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, PROD.codi_prod , PRES.DESC_PRES ,
			
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
			INNER join PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
			inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			
		where 	--year(FAC.FECH_FACT)= @ANIO and 
			cast(convert(char(10), fac.fech_fact,103) as datetime) between @f1 and @f2 and  
			CP.codi_clie_prov = @codi_clie_prov and FD.codi_prod=@cod_prod
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
			AND SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
				
		group by CP.CODI_CLIE_PROV, CP.DENOMINACION  , PROD.codi_PROD , PRES.DESC_PRES , month(fac.fech_fact) ) as F
	
	on M.nro_mes=F.mes
	
	group by  M.nro_mes ,  M.codi_clie_prov, M.laboratorio, M.cod_prod, M.desc_prod , M.desc_pres  
	
	drop table #Mes

END

ELSE
	BEGIN
	
	select  cast('' as varchar(12)) MES,  cast('' as char(5)) codi_clie_prov , cast('' as varchar(100)) laboratorio ,
		cast( '' as char(8)) cod_prod ,cast( '' as varchar(150))  desc_prod , cast( '' as varchar(50)) desc_pres ,
		0.000 V_Cantid_Contado , 0.000 V_Valor_Contado , 0.000 V_Costo_Contado ,  0.000 V_Cantid_Cred, 0.000 V_Valor_Cred , 0.000 V_Costo_Cred
	END
END
GO
