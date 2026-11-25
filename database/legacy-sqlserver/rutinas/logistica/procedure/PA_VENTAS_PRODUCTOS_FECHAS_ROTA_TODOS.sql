CREATE PROCEDURE [dbo].[PA_VENTAS_PRODUCTOS_FECHAS_ROTA_TODOS]
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
--select @TIPO='0', @CODI_ALMA ='04' , @FEC1 ='01/01/2024', @FEC2 ='31/12/2024', @CODI_CLIE_PROV ='', @SUBFAMILIA ='', @CODI_PRES =0

set nocount on
set quoted_identifier off 

declare @SQLString nvarchar(4000), @SQLString_rot nvarchar(4000)
declare @Condi varchar(100) ,@Grup varchar(100)
declare @ParmString nvarchar(100)
declare @TI table (codi_prod char(8), ingresos numeric(12,4) null )
declare @TS table (codi_prod char(8), saldo numeric(12,4) null )

create table #Tx (idx int identity, nemo_alma varchar(50) null, codi_clie_prov char(5) null, laboratorio varchar(150) null, desc_sub_fami_prod varchar(150) null, desc_prod char(150) null,
		   desc_pres varchar(50) null, venta_cant_conta numeric(18,3) null, venta_valor_conta numeric(18,3) null, venta_costo_conta numeric(18,3) null,
                   venta_cant_cred numeric(18,3) null, venta_valor_cred numeric(18,3) null, venta_costo_Cred numeric(18,3) null, cod_cultivo int null,
                   codi_prod char(8) null, codi_tipo_pago int null,
                   cultivo varchar(50) null, tipo_pago varchar(50) null, sub_Fami_prod varchar(50) null, Linea varchar(50) null, 
                   prec_venta numeric(18,3) null, prec_costo numeric(18,3) null)

declare @Rot table (rot int null, codi_clie_prov char(5) null, cod_cultivo int null, codi_prod char(8) null, dias_rota int)
declare @Etapa table (rot_tipo int null, codi_prod char(8) null, codi_clie char(5) null)

create table #Xx (nemo_alma varchar(50) null, codi_clie_prov char(5) null, laboratorio varchar(150) null, desc_sub_fami_prod varchar(150) null, desc_prod char(150) null,
		   desc_pres varchar(50) null, venta_cant_conta numeric(18,3) null, venta_valor_conta numeric(18,3) null, venta_costo_conta numeric(18,3) null,
                   venta_cant_cred numeric(18,3) null, venta_valor_cred numeric(18,3) null, venta_costo_Cred numeric(18,3) null, cod_cultivo int null, 
		   codi_prod char(8) null, codi_tipo_pago int null, linea varchar(150) null, prec_venta numeric(18,3) null)

create table #Rota (rot int null, codi_clie_prov char(5) null, cod_cultivo int null, codi_prod char(8) null, dias_rota int)


create table #alma (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	set @Grup=""
	set @Condi="'00' as nemo, "
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
--select * from #alma
IF @TIPO='1' ---- SOLO POR LABORATORIO 

BEGIN

	set @Parmstring = "@fec1 datetime ,@fec2 datetime"	

	set @SQLString_rot = " select count(FD.codi_prod) rot, CP.codi_clie_prov, max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
	                       ( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
	FROM ALMACEN as SUC inner join FACTURA  as FAC  (nolock) on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov='"+@CODI_CLIE_PROV +"' AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov/*, cod_cultivo*/	"
	
	insert #Rota
	execute sp_executesql @SQLString_rot, @ParmString, @fec1 =@fec1 , @fec2 =@fec2
	
	set @SQLString = "
	select " +@Condi+" CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),     	  	
		max(cod_cultivo) cod_cultivo, FD.CODI_PROD, max(FAC.codi_tipo_pago) codi_tipo_pago,
		
		(select (select (select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where l.cod_lin_pro=F.cod_lin_pro) 
				 from familia_producto f (nolock)  
				where f.codi_fami_prod=s.codi_fami_prod) from sub_familia_producto S(nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from productos P(nolock) where P.codi_prod=FD.codi_prod)) as Linea,
		dbo.uf_ulti_prec_venta(FD.codi_prod, '" +@CODI_ALMA+ "') prec_venta				

	FROM ALMACEN as SUC inner join FACTURA  as FAC  (nolock) on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov='"+@CODI_CLIE_PROV +"' AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by   " +@Grup+" CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD
	order by desc_prod "

	insert #Xx
	execute sp_executesql @SQLString, @ParmString, @fec1 =@fec1 , @fec2 =@fec2

	if @codi_alma='00'
	begin
		insert @TI
		select codi_prod, sum(cantidad) ingreso from detalle_nota_ingreso A (nolock)
		where codi_nota_ingr in (select codi_nota_ingr from nota_ingreso B (nolock)
				where cast(convert(char(10),fech_nota_ingr,103) as datetime) between @Fec1 and @Fec2 and 
		codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
				and tipo_nota_ingr='01') 
		and codi_prod in (select distinct codi_prod from #Rota) 
		group by codi_prod
		
		insert @Etapa
		select (datediff(d, '01/01/' + cast(year(getdate()) as char(4)), cast(convert(char(10),getdate(),103) as datetime)) + 1 ) / count(distinct convert(char(10),fac.fech_fact,103)),
				FD.codi_prod, CP.codi_clie_prov
			from almacen as suc inner join factura as fac  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
			inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		where (cast(convert(varchar(10), FAC.fech_fact,103) as datetime) between @fec1 and @fec2)
			and (FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL) and (isnull(@CODI_ALMA,'00')='00' or FAC.codi_alma=@CODI_ALMA)
		group by FD.codi_prod, CP.codi_clie_prov
		
	end
	else

	begin
		insert @TI
		select codi_prod, sum(cantidad) ingreso from detalle_nota_ingreso A (nolock)
		where codi_nota_ingr in (select codi_nota_ingr from nota_ingreso B (nolock)
				where cast(convert(char(10),fech_nota_ingr,103) as datetime) between @Fec1 and @Fec2 and 
		codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
				and tipo_nota_ingr='23') 
		and codi_prod in (select distinct codi_prod from #Rota) 
		group by codi_prod
	end

	insert @TS
	select codi_prod, sum(cant_ingr - cant_sali) Saldo from kardex k (nolock)
		where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	and cast(convert(char(10),fech_tran,103)  as datetime )<= @Fec2 and periodo=year(@Fec2) and 
			codi_prod in  (select distinct codi_prod from #Rota) 
	group by codi_prod

	select nemo_alma, T.codi_clie_prov, laboratorio, desc_sub_fami_prod, desc_prod ,
	       desc_pres, venta_cant_conta, venta_valor_conta, venta_costo_conta ,
	       venta_cant_cred, venta_valor_cred, venta_costo_Cred, rot, 
	       (select desC_cultivo from cultivos C(nolock) where C.cod_cultivo=T.cod_cultivo) cultivo,
		(select desc_tipo_medio_pago from tipo_pago (nolock) where codi_tipo_medio_pago=T.codi_tipo_pago ) tipo_pago,
		isnull(ingresos,0) Ingreso, isnull(saldo, 0) Saldo, r.codi_prod,
		(select desc_sub_fami_prod from SUB_FAMILIA_PRODUCTO S(nolock) where S.codi_sub_Fami_prod in
			(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod = T.codi_prod)) sub_Fami_prod,
		
		(select (select (select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where l.cod_lin_pro=F.cod_lin_pro) 
				 from familia_producto f (nolock)  
				where f.codi_fami_prod=s.codi_fami_prod) from sub_familia_producto S(nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from productos P(nolock) where P.codi_prod=T.codi_prod)) as Linea,
			
		dbo.uf_ulti_prec_venta(T.codi_prod, @codi_alma) prec_venta,
		/*(select estado from #Rx X where x.codi_prod=T.codi_prod)*/'' as Estado1,
		/*(select estadostock from #Rx X where x.codi_prod=T.codi_prod)*/'' as Estado2,
		/*(select estadorota from #Rx X where x.codi_prod=T.codi_prod)*/'' as Estado3,
		isnull(r.dias_rota,0) as dias_rota,
		dbo.uf_ulti_prec_costo(T.codi_prod, @codi_alma) prec_costo,
		case when rot_tipo>= 0 and rot_tipo<=60 then 'A'
	         when rot_tipo>=61 and rot_tipo<=90 then 'M'
			 when rot_tipo>=91 or rot_tipo is null then 'B' end as rot_tipo	
		
	from #Xx T
	left join #Rota R
	on T.codi_clie_prov=R.codi_clie_prov /*and T.cod_cultivo = R.cod_cultivo*/ and T.codi_prod=R.codi_prod
	left join @Ti C
	on C.codi_prod=R.codi_prod
	left join @TS S
	on S.codi_prod=R.codi_prod
	
	left join @Etapa E
	on E.codi_prod=T.codi_prod and E.codi_clie=T.codi_clie_prov
		
end

else if @tipo='2' --- PROVEEDOR Y SUBFAMILIA

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
		( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA

	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	

	INSERT #Tx	
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) , 
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),     	  	
		max(cod_cultivo) cod_cultivo, FD.CODI_PROD, max(FAC.codi_tipo_pago) codi_tipo_pago,
		
		null, null, null, null, 0, 0
		
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD

end

else if @tipo='3' --- SUBFAMILIA

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
	( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	
	
	INSERT #Tx	
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),     	  	
		max(cod_cultivo) cod_cultivo, FD.CODI_PROD,	max(FAC.codi_tipo_pago) codi_tipo_pago,
		
		null, null, null, null, 0, 0

	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD

end

else if @tipo='4' --- PRESETANCION

BEGIN	

	insert @Rot
	select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
		( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 		as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	
	
	INSERT #Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),     	  	
		max(cod_cultivo) cod_cultivo, FD.CODI_PROD, max(FAC.codi_tipo_pago) codi_tipo_pago,
		
		null, null, null, null, 0, 0

	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 		as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD

end

else if @tipo='5' --- LABORATORIO Y PRESETANCION

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
		( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
	FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 		as FD on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV
		and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	
	
	INSERT #Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),     	  	
		max(cod_cultivo) cod_cultivo, FD.CODI_PROD,	max(FAC.codi_tipo_pago) codi_tipo_pago,
		
		null, null, null, null, 0, 0

	FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 		as FD on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV
		and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD

end

else if @tipo='6' --- SUB FAMILIA Y PRESENTACION

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
	( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 		as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA
		and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo

	INSERT #Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),     	  	
	        max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
		max(FAC.codi_tipo_pago) codi_tipo_pago,
		
		null, null, null, null, 0, 0

	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 		as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA
		and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD

end

else if @tipo='7' --- LABORATORIO , SUB FAMILIA ,  PRESENTACION

BEGIN

	insert @Rot
	select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
		( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 		as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA and CP.codi_clie_prov=@CODI_CLIE_PROV
		and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	
	
	INSERT #Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),     	  	
		max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
		max(FAC.codi_tipo_pago) codi_tipo_pago,
		
		null, null, null, null, 0, 0
		
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 		as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA and CP.codi_clie_prov=@CODI_CLIE_PROV
		and PRES.COD_PRES = @CODI_PRES AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD

end

else if @tipo='8' --- PROVEEDOR Y FAMILIA

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
		( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
	FROM ALMACEN as SUC inner join FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock) on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF (nolock) ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		and SF.CODI_FAMI_PROD = @SUBFAMILIA
	
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	
	
	INSERT #Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),     	  	
		max(cod_cultivo) cod_cultivo, FD.CODI_PROD, max(FAC.codi_tipo_pago) codi_tipo_pago,
		
		null, null, null, null, 0, 0

	FROM ALMACEN as SUC inner join FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock) on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF (nolock) ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		and SF.CODI_FAMI_PROD = @SUBFAMILIA
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, cod_cultivo*/, FD.CODI_PROD

end


else if @tipo='9' --- FAMILIA

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
		( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF  (nolock)ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_FAMI_PROD = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	
	
	INSERT #Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),     	  	
		max(cod_cultivo) cod_cultivo, FD.CODI_PROD, max(FAC.codi_tipo_pago) codi_tipo_pago,
		
		null, null, null, null, 0, 0

	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF  (nolock)ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_FAMI_PROD = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD

end
else if @tipo='10' --- PROVEEDOR Y linea

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
		( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
	FROM  ALMACEN as SUC inner join FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock) on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF (nolock) ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
		inner join LINEA_FAMILIA_PRO	L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	        and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		and L.cod_lin_pro = @SUBFAMILIA
	
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo		

	INSERT #Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),     	  	
		max(cod_cultivo) cod_cultivo, FD.CODI_PROD, max(FAC.codi_tipo_pago) codi_tipo_pago,
		
		null, null, null, null, 0, 0

	FROM ALMACEN as SUC inner join FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock) on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF (nolock) ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
		inner join LINEA_FAMILIA_PRO	L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	        and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		and L.cod_lin_pro = @SUBFAMILIA
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD

end


else if @tipo='11' --- linea

BEGIN

	insert @Rot
	select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
		( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
	FROM  ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF  (nolock)ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
		inner join LINEA_FAMILIA_PRO	L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and L.cod_lin_pro = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo		

	INSERT #Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
		venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

		venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
		venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
		venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),     	  	
		max(cod_cultivo) cod_cultivo, FD.CODI_PROD,	max(FAC.codi_tipo_pago) codi_tipo_pago,
		
		null, null, null, null, 0, 0

	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD  (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF  (nolock)ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
		inner join LINEA_FAMILIA_PRO	L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		and L.cod_lin_pro = @SUBFAMILIA AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	
	group by SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/ , FD.CODI_PROD

end

else 
 
  ---- TODOS LOS PRODUCTOS SIN TENER EN CUENTA EL LABORATORIO
BEGIN
--select 1 
	
	delete from #alma
	
	insert #alma 
	select distinct codi_alma from (
	Select codi_alma from si_dcvp.dbo.almacen (nolock)
	union all
	Select codi_alma from si_green.dbo.almacen (nolock)
	) as A
	where isnull(@codi_alma,'')='00' or codi_alma=@codi_alma
	
	IF @CODI_ALMA='01'
	BEGIN
		insert @Rot
		select count(FD.codi_prod) rot, CP.codi_clie_prov,  null cod_cultivo, FD.CODI_PROD,
				( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_tras,103))
		 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
		FROM SI_GREEN.dbo.ALMACEN as SUC inner join SI_GREEN.dbo.GUIA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_GREEN.dbo.GUIA_DETALLE 	as FD (nolock)on FAC.codi_GUIA = FD.codi_GUIA
			inner join SI_GREEN.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FAC.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_GREEN.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_GREEN.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_GREEN.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_GREEN.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			 and  (cast(convert(varchar(10), FAC.fech_tras, 103) as smalldatetime) between @fec1 and @fec2)	and codi_moti_tras='05' 
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
			--AND FD.CODI_PROD='00082226'
		group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	
		
		union all
		
		select count(FD.codi_prod) rot, CP.codi_clie_prov,  null cod_cultivo, FD.CODI_PROD,
				( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_tras,103))
		 
		FROM SI_dcvp.dbo.ALMACEN as SUC inner join SI_dcvp.dbo.GUIA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_dcvp.dbo.GUIA_DETALLE 	as FD (nolock)on FAC.codi_GUIA = FD.codi_GUIA
			inner join SI_dcvp.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FAC.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_dcvp.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_dcvp.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_dcvp.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_dcvp.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			 and  (cast(convert(varchar(10), FAC.fech_tras, 103) as smalldatetime) between @fec1 and @fec2)	and codi_moti_tras='05' 
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
			--AND FD.CODI_PROD='00082226'
		group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	
		
	END
	ELSE
	BEGIN
		insert @Rot
		select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
				( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
		 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
		FROM SI_GREEN.dbo.ALMACEN as SUC inner join SI_GREEN.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_GREEN.dbo.FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
			inner join SI_GREEN.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_GREEN.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_GREEN.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_GREEN.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_GREEN.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	
		
		union all
		
		select count(FD.codi_prod) rot, CP.codi_clie_prov,  max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
				( datediff(d,@fec1 ,@fec2 ) + 1 ) /  count(distinct convert(char(10),fac.fech_fact,103))
		 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
		FROM SI_dcvp.dbo.ALMACEN as SUC inner join SI_dcvp.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_dcvp.dbo.FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
			inner join SI_dcvp.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_dcvp.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_dcvp.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_dcvp.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_dcvp.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		where case when SUC.codi_alma='11' then '19' else SUC.codi_alma end collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	
		
		
		insert @Etapa
		select (datediff(d, '01/01/' + cast(year(getdate()) as char(4)), cast(convert(char(10),getdate(),103) as datetime)) + 1 ) / count(distinct convert(char(10),fac.fech_fact,103)),
				FD.codi_prod, CP.codi_clie_prov
			from SI_GREEN.dbo.almacen as suc inner join SI_GREEN.dbo.factura as fac  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_GREEN.dbo.FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
			inner join SI_GREEN.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_GREEN.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_GREEN.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_GREEN.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_GREEN.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		where (cast(convert(varchar(10), FAC.fech_fact,103) as datetime) between @fec1 and @fec2)
			and (FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL) and (isnull(@CODI_ALMA,'00')='00' or FAC.codi_alma=@CODI_ALMA)
		group by FD.codi_prod, CP.codi_clie_prov
		
		union all
		
		select (datediff(d, '01/01/' + cast(year(getdate()) as char(4)), cast(convert(char(10),getdate(),103) as datetime)) + 1 ) / count(distinct convert(char(10),fac.fech_fact,103)),
				FD.codi_prod, CP.codi_clie_prov
			from SI_dcvp.dbo.almacen as suc inner join SI_dcvp.dbo.factura as fac  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_dcvp.dbo.FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
			inner join SI_dcvp.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_dcvp.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_dcvp.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_dcvp.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_dcvp.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		where (cast(convert(varchar(10), FAC.fech_fact,103) as datetime) between @fec1 and @fec2)
			and (FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL) 
			and (isnull(@CODI_ALMA,'00')='00' or case when FAC.codi_alma='11' then '19' else FAC.codi_alma end=@CODI_ALMA)
		group by FD.codi_prod, CP.codi_clie_prov
				
	END
	
	if @CODI_ALMA='00'
	begin
		INSERT #Tx
		select 'TODOS' NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
			venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
			venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
			venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_GREEN.dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

			venta_cant_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
			venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
			venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_GREEN.dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),
			max(cod_cultivo) cod_cultivo, FD.CODI_PROD, max(FAC.codi_tipo_pago) codi_tipo_pago,
			
			(select desC_cultivo from SI_GREEN.dbo.cultivos C(nolock) where C.cod_cultivo=max(FAC.cod_cultivo)) cultivo,
			(select desc_tipo_medio_pago from SI_GREEN.dbo.tipo_pago (nolock) where codi_tipo_medio_pago=max(FAC.codi_tipo_pago)) tipo_pago,
			DESC_SUB_FAMI_PROD as sub_Fami_prod,
			
			(select (select (select des_lin_pro from SI_GREEN.dbo.LINEA_FAMILIA_PRO L(nolock) where l.cod_lin_pro=F.cod_lin_pro) 
			 from SI_GREEN.dbo.familia_producto f (nolock) where f.codi_fami_prod=s.codi_fami_prod) from SI_GREEN.dbo.sub_familia_producto S(nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from SI_GREEN.dbo.productos P(nolock) where P.codi_prod=FD.codi_prod)) as Linea,
			
			SI_GREEN.dbo.uf_ulti_prec_venta(FD.codi_prod, @codi_alma) prec_venta,
			SI_GREEN.dbo.uf_ulti_prec_costo(FD.codi_prod, @codi_alma) prec_costo
	  	  	
		FROM SI_GREEN.dbo.ALMACEN as SUC inner join SI_GREEN.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_GREEN.dbo.FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
			inner join SI_GREEN.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_GREEN.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_GREEN.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_GREEN.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_GREEN.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		
		where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
			--and FD.codi_prod='00012059'
		group by   -- SUC.NEMO_ALMA ,
				 CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD
				 
		union all
		
		select 'TODOS' NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
			venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
			venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
			venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_dcvp.dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

			venta_cant_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
			venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
			venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_dcvp.dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),
			max(cod_cultivo) cod_cultivo, FD.CODI_PROD, max(FAC.codi_tipo_pago) codi_tipo_pago,
			
			(select desC_cultivo from SI_dcvp.dbo.cultivos C(nolock) where C.cod_cultivo=max(FAC.cod_cultivo)) cultivo,
			(select desc_tipo_medio_pago from SI_dcvp.dbo.tipo_pago (nolock) where codi_tipo_medio_pago=max(FAC.codi_tipo_pago)) tipo_pago,
			DESC_SUB_FAMI_PROD as sub_Fami_prod,
			
			(select (select (select des_lin_pro from SI_dcvp.dbo.LINEA_FAMILIA_PRO L(nolock) where l.cod_lin_pro=F.cod_lin_pro) 
			 from SI_dcvp.dbo.familia_producto f (nolock) where f.codi_fami_prod=s.codi_fami_prod) from SI_dcvp.dbo.sub_familia_producto S(nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from SI_dcvp.dbo.productos P(nolock) where P.codi_prod=FD.codi_prod)) as Linea,
			
			SI_dcvp.dbo.uf_ulti_prec_venta(FD.codi_prod, @codi_alma) prec_venta,
			SI_dcvp.dbo.uf_ulti_prec_costo(FD.codi_prod, @codi_alma) prec_costo
	  	  	
		FROM SI_dcvp.dbo.ALMACEN as SUC inner join SI_dcvp.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_dcvp.dbo.FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
			inner join SI_dcvp.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_dcvp.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_dcvp.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_dcvp.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_dcvp.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		
		where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
			--and FD.codi_prod='00012059'
		group by   -- SUC.NEMO_ALMA ,
				 CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD
				 
	end
	if @CODI_ALMA='01'
	begin
		INSERT #Tx
		select NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
			venta_cant_conta    = sum( case 1 when 1 then FD.CANTIDAD else 0 end ) , 
			venta_valor_conta  = sum( case 1 when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 0 END ) * ( FD.CANTIDAD *  FD.PREC_VENTA)  else 0 end) ,   
			venta_costo_conta = sum( case 1 when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_GREEN.dbo.f_igv(fech_tras)/100 END ) * ( FD.CANTIDAD * FD.PREC_COMPRA) else 0 end)  ,   	  	

			venta_cant_cred     = sum( case 1 when 4 then FD.CANTIDAD else 0 end ) ,   
			venta_valor_cred   = sum( case 1 when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 0 END ) * ( FD.CANTIDAD *  FD.PREC_VENTA )  else 0 end) ,  
			venta_costo_cred  = sum( case 1 when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_GREEN.dbo.f_igv(fech_tras)/100 END ) * ( FD.CANTIDAD * FD.PREC_COMPRA) else 0 end),
			NULL cod_cultivo, FD.CODI_PROD, 1 codi_tipo_pago,
			
			null cultivo,
			(select desc_tipo_medio_pago from SI_GREEN.dbo.tipo_pago (nolock) where codi_tipo_medio_pago=1) tipo_pago,
			DESC_SUB_FAMI_PROD as sub_Fami_prod,
			
			(select (select (select des_lin_pro from SI_GREEN.dbo.LINEA_FAMILIA_PRO L(nolock) where l.cod_lin_pro=F.cod_lin_pro) 
			 from SI_GREEN.dbo.familia_producto f (nolock) where f.codi_fami_prod=s.codi_fami_prod) from SI_GREEN.dbo.sub_familia_producto S(nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from SI_GREEN.dbo.productos P(nolock) where P.codi_prod=FD.codi_prod)) as Linea,
			
			SI_GREEN.dbo.uf_ulti_prec_venta(FD.codi_prod, @codi_alma) prec_venta,
			SI_GREEN.dbo.uf_ulti_prec_costo(FD.codi_prod, @codi_alma) prec_costo	
	  	  	
		FROM SI_GREEN.dbo.ALMACEN as SUC inner join SI_GREEN.dbo.GUIA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_GREEN.dbo.GUIA_DETALLE 	as FD (nolock)on FAC.codi_guia = FD.codi_guia
			inner join SI_GREEN.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FAC.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_GREEN.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_GREEN.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_GREEN.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_GREEN.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		
		where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			 and  (cast(convert(varchar(10), FAC.fech_tras , 103) as smalldatetime) between @fec1 and @fec2) and codi_moti_tras='05'
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
			
		group by   SUC.NEMO_ALMA ,
				 CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD	
				 
		union all
		
		select NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
			venta_cant_conta    = sum( case 1 when 1 then FD.CANTIDAD else 0 end ) , 
			venta_valor_conta  = sum( case 1 when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 0 END ) * ( FD.CANTIDAD *  FD.PREC_VENTA) else 0 end) ,   
			venta_costo_conta = sum( case 1 when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_dcvp.dbo.f_igv(fech_tras)/100 END ) * ( FD.CANTIDAD * FD.PREC_COMPRA) else 0 end)  ,   	  	

			venta_cant_cred     = sum( case 1 when 4 then FD.CANTIDAD else 0 end ) ,   
			venta_valor_cred   = sum( case 1 when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE 0 END ) * ( FD.CANTIDAD *  FD.PREC_VENTA )  else 0 end) ,  
			venta_costo_cred  = sum( case 1 when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_dcvp.dbo.f_igv(fech_tras)/100 END ) * ( FD.CANTIDAD * FD.PREC_COMPRA) else 0 end),
			NULL cod_cultivo, FD.CODI_PROD, 1 codi_tipo_pago,
			
			null cultivo,
			(select desc_tipo_medio_pago from SI_dcvp.dbo.tipo_pago (nolock) where codi_tipo_medio_pago=1 /*max(FAC.codi_tipo_pago)*/ ) tipo_pago,
			DESC_SUB_FAMI_PROD as sub_Fami_prod,
			
			(select (select (select des_lin_pro from SI_dcvp.dbo.LINEA_FAMILIA_PRO L(nolock) where l.cod_lin_pro=F.cod_lin_pro) 
			 from SI_dcvp.dbo.familia_producto f (nolock) where f.codi_fami_prod=s.codi_fami_prod) from SI_dcvp.dbo.sub_familia_producto S(nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from SI_dcvp.dbo.productos P(nolock) where P.codi_prod=FD.codi_prod)) as Linea,
			
			SI_dcvp.dbo.uf_ulti_prec_venta(FD.codi_prod, @codi_alma) prec_venta,
			SI_dcvp.dbo.uf_ulti_prec_costo(FD.codi_prod, @codi_alma) prec_costo
	  	  	
		FROM SI_dcvp.dbo.ALMACEN as SUC inner join SI_dcvp.dbo.GUIA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_dcvp.dbo.GUIA_DETALLE 	as FD (nolock)on FAC.codi_guia = FD.codi_guia
			inner join SI_dcvp.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FAC.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_dcvp.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_dcvp.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_dcvp.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_dcvp.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		
		where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			 and  (cast(convert(varchar(10), FAC.fech_tras , 103) as smalldatetime) between @fec1 and @fec2) and codi_moti_tras='05'
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
			
		group by   SUC.NEMO_ALMA ,
				 CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD
				 
	end
	
	if @CODI_ALMA not in ('00','01')
	begin
		INSERT #Tx
		select NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
			venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
			venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
			venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_GREEN.dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

			venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
			venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
			venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_GREEN.dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),
			max(cod_cultivo) cod_cultivo, FD.CODI_PROD, max(FAC.codi_tipo_pago) codi_tipo_pago,
			
			(select desC_cultivo from SI_GREEN.dbo.cultivos C(nolock) where C.cod_cultivo=max(FAC.cod_cultivo)) cultivo,
			(select desc_tipo_medio_pago from SI_GREEN.dbo.tipo_pago (nolock) where codi_tipo_medio_pago=max(FAC.codi_tipo_pago)) tipo_pago,
			DESC_SUB_FAMI_PROD as sub_Fami_prod,
			
			(select (select (select des_lin_pro from SI_GREEN.dbo.LINEA_FAMILIA_PRO L(nolock) where l.cod_lin_pro=F.cod_lin_pro) 
			 from SI_GREEN.dbo.familia_producto f (nolock) where f.codi_fami_prod=s.codi_fami_prod) from SI_GREEN.dbo.sub_familia_producto S(nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from SI_GREEN.dbo.productos P(nolock) where P.codi_prod=FD.codi_prod)) as Linea,
			
			SI_GREEN.dbo.uf_ulti_prec_venta(FD.codi_prod, @codi_alma) prec_venta,
			SI_GREEN.dbo.uf_ulti_prec_costo(FD.codi_prod, @codi_alma) prec_costo
	  	  	
		FROM SI_GREEN.dbo.ALMACEN as SUC inner join SI_GREEN.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_GREEN.dbo.FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
			inner join SI_GREEN.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_GREEN.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_GREEN.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_GREEN.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_GREEN.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		
		where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
			--and FD.CODI_PROD='00012059'
			
		group by   SUC.NEMO_ALMA ,
				 CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD	
				 
		union all
		
		select NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
			venta_cant_conta    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
			venta_valor_conta  = sum( case FAC.CODI_TIPO_PAGO when 1 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,   
			venta_costo_conta = sum( case FAC.CODI_TIPO_PAGO when 1 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_dcvp.dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end)  ,   	  	

			venta_cant_cred     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end ) ,   
			venta_valor_cred   = sum( case FAC.CODI_TIPO_PAGO when 4 then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  else 0 end) ,  
			venta_costo_cred  = sum( case FAC.CODI_TIPO_PAGO when 4 then   (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+SI_dcvp.dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) else 0 end),
			max(cod_cultivo) cod_cultivo, FD.CODI_PROD, max(FAC.codi_tipo_pago) codi_tipo_pago,
			
			(select desC_cultivo from SI_dcvp.dbo.cultivos C(nolock) where C.cod_cultivo=max(FAC.cod_cultivo)) cultivo,
			(select desc_tipo_medio_pago from SI_dcvp.dbo.tipo_pago (nolock) where codi_tipo_medio_pago=max(FAC.codi_tipo_pago)) tipo_pago,
			DESC_SUB_FAMI_PROD as sub_Fami_prod,
			
			(select (select (select des_lin_pro from SI_dcvp.dbo.LINEA_FAMILIA_PRO L(nolock) where l.cod_lin_pro=F.cod_lin_pro) 
			 from SI_dcvp.dbo.familia_producto f (nolock) where f.codi_fami_prod=s.codi_fami_prod) from SI_dcvp.dbo.sub_familia_producto S(nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from SI_dcvp.dbo.productos P(nolock) where P.codi_prod=FD.codi_prod)) as Linea,
			
			SI_dcvp.dbo.uf_ulti_prec_venta(FD.codi_prod, @codi_alma) prec_venta,
			SI_dcvp.dbo.uf_ulti_prec_costo(FD.codi_prod, @codi_alma) prec_costo
	  	  	
		FROM SI_dcvp.dbo.ALMACEN as SUC inner join SI_dcvp.dbo.FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
			inner join SI_dcvp.dbo.FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
			inner join SI_dcvp.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
			inner join SI_dcvp.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
			INNER join SI_dcvp.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
			inner join SI_dcvp.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
			INNER JOIN SI_dcvp.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		
		where case when SUC.codi_alma='11' then '19' else SUC.codi_alma end collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
			AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
			--and FD.CODI_PROD='00012059'
			
		group by   SUC.NEMO_ALMA ,
				 CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES/*, COD_CULTIVO*/, FD.CODI_PROD	
				 
	end
end
--select * from #Tx
--return
IF @TIPO<>'1'
BEGIN
	
	if @CODI_ALMA in ('00','01')
	begin
			insert @TI
			select codi_prod, sum(cantidad) ingreso 
			from SI_GREEN.dbo.detalle_nota_ingreso A (nolock)
			where A.codi_nota_ingr in (select B.codi_nota_ingr from SI_GREEN.dbo.nota_ingreso B (nolock)
							where cast(convert(char(10),fech_nota_ingr,103) as datetime) between @Fec1 and @Fec2 
			and B.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			and tipo_nota_ingr='01') and codi_prod in (select distinct codi_prod from @Rot) 
			--and A.codi_prod='00012059'
			group by codi_prod
			
			union all
			
			select codi_prod, sum(cantidad) ingreso 
			from SI_dcvp.dbo.detalle_nota_ingreso A (nolock)
			where A.codi_nota_ingr in (select B.codi_nota_ingr from SI_dcvp.dbo.nota_ingreso B (nolock)
							where cast(convert(char(10),fech_nota_ingr,103) as datetime) between @Fec1 and @Fec2 
			and B.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			and tipo_nota_ingr='01') and codi_prod in (select distinct codi_prod from @Rot) 
			--and A.codi_prod='00012059'
			group by codi_prod
	end
	/*if @CODI_ALMA='01'
	begin
			insert @TI
			select codi_prod, sum(cantidad) ingreso 
			from guia_detalle A (nolock)
			where A.codi_guia in (select B.codi_guia from guia B (nolock)
							where cast(convert(char(10),fech_tras,103) as datetime) between @Fec1 and @Fec2 
			and B.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			and codi_moti_tras='05') ---and codi_prod in (select distinct codi_prod from @Rot) 
			group by codi_prod
	end*/
	if @CODI_ALMA not in ('00','01')
	begin
			insert @TI
			select codi_prod, sum(cantidad) ingreso 
			from SI_GREEN.dbo.detalle_nota_ingreso A (nolock)
			where A.codi_nota_ingr in (select B.codi_nota_ingr from SI_GREEN.dbo.nota_ingreso B (nolock)
							where cast(convert(char(10),fech_nota_ingr,103) as datetime) between @Fec1 and @Fec2 
			and B.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			and tipo_nota_ingr='23') ---and codi_prod in (select distinct codi_prod from @Rot) 
			group by codi_prod
			
			union all
			
			select codi_prod, sum(cantidad) ingreso 
			from SI_dcvp.dbo.detalle_nota_ingreso A (nolock)
			where A.codi_nota_ingr in (select B.codi_nota_ingr from SI_dcvp.dbo.nota_ingreso B (nolock)
							where cast(convert(char(10),fech_nota_ingr,103) as datetime) between @Fec1 and @Fec2 
			and case when B.codi_alma='11' then '19' else B.codi_alma end collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
			and tipo_nota_ingr='23') ---and codi_prod in (select distinct codi_prod from @Rot) 
			group by codi_prod

	end

	insert @TS
	select codi_prod, sum(cant_ingr - cant_sali) Saldo from SI_GREEN.dbo.kardex k (nolock)
			where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	and cast(convert(char(10),fech_tran,103)  as datetime )<= @Fec2 and periodo=year(@Fec2) and 
				codi_prod in  (select distinct codi_prod from @Rot) 
	group by codi_prod
	
	union all
	
	select codi_prod, sum(cant_ingr - cant_sali) Saldo from SI_dcvp.dbo.kardex k (nolock)
			where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	and cast(convert(char(10),fech_tran,103)  as datetime )<= @Fec2 and periodo=year(@Fec2) and 
				codi_prod in  (select distinct codi_prod from @Rot) 
	group by codi_prod
	
	
	if @CODI_ALMA='00'
	begin
		insert #Tx
		select  'TODOS' as nemo_alma, P.codi_clie_prov, SI_GREEN.dbo.f_cliente_proveedor(P.codi_clie_prov) as Laboratorio,
				desc_sub_fami_prod, desc_prod , 
				(select desc_pres from SI_GREEN.dbo.PRESENTACION AS PRES (nolock) where P.COD_PRES=PRES.COD_PRES) desc_pres,
				0,0,0,0,0,0,null,
				K.codi_prod, 
				null, 
				null, null, null, null, 0, 0
				
		from SI_GREEN.dbo.kardex k (nolock)
		join SI_GREEN.dbo.almacen A (nolock)
		on k.codi_alma=a.codi_alma
		join SI_GREEN.dbo.productos P (nolock)
		on k.codi_prod=P.codi_prod
		join SI_GREEN.dbo.sub_familia_producto S
		on S.codi_sub_Fami_prod=P.codi_sub_Fami_prod
		left join @Ti C
		on C.codi_prod=K.codi_prod
		
			where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
					and cast(convert(char(10),fech_tran,103)  as datetime )<= @Fec2 and periodo=year(@Fec2) and 
				k.codi_prod not in  (select distinct R.codi_prod from @Rot R ) 
				--and K.codi_prod='00012059'
		group by --nemo_alma, 
					P.codi_clie_prov, desc_sub_fami_prod, desc_prod ,COD_PRES, k.codi_prod
					
		union all
		
		select  'TODOS' as nemo_alma, P.codi_clie_prov, SI_dcvp.dbo.f_cliente_proveedor(P.codi_clie_prov) as Laboratorio,
				desc_sub_fami_prod, desc_prod , 
				(select desc_pres from SI_dcvp.dbo.PRESENTACION AS PRES (nolock) where P.COD_PRES=PRES.COD_PRES) desc_pres,
				0,0,0,0,0,0,null,
				K.codi_prod, 
				null,
				null, null, null, null, 0, 0
							
		from SI_dcvp.dbo.kardex k (nolock)
		join SI_dcvp.dbo.almacen A (nolock)
		on k.codi_alma=a.codi_alma
		join SI_dcvp.dbo.productos P (nolock)
		on k.codi_prod=P.codi_prod
		join SI_dcvp.dbo.sub_familia_producto S
		on S.codi_sub_Fami_prod=P.codi_sub_Fami_prod
		left join @Ti C
		on C.codi_prod=K.codi_prod
		
			where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
					and cast(convert(char(10),fech_tran,103)  as datetime )<= @Fec2 and periodo=year(@Fec2) and 
				k.codi_prod not in  (select distinct R.codi_prod from @Rot R ) 
				--and K.codi_prod='00012059'
		group by --nemo_alma, 
					P.codi_clie_prov, desc_sub_fami_prod, desc_prod ,COD_PRES, k.codi_prod		
					
	end
	else
	begin
		insert #Tx
		select  nemo_alma, P.codi_clie_prov, SI_GREEN.dbo.f_cliente_proveedor(P.codi_clie_prov) as Laboratorio,
				desc_sub_fami_prod, desc_prod , 
				(select desc_pres from SI_GREEN.dbo.PRESENTACION AS PRES (nolock) where P.COD_PRES=PRES.COD_PRES) desc_pres,
				0,0,0,0,0,0,null,
				K.codi_prod, 
				null,
				null, null, null, null, 0, 0
							
		from SI_GREEN.dbo.kardex k (nolock)
		join SI_GREEN.dbo.almacen A (nolock)
		on k.codi_alma=a.codi_alma
		join SI_GREEN.dbo.productos P (nolock)
		on k.codi_prod=P.codi_prod
		join SI_GREEN.dbo.sub_familia_producto S
		on S.codi_sub_Fami_prod=P.codi_sub_Fami_prod
		left join @Ti C
		on C.codi_prod=K.codi_prod
		
			where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
					and cast(convert(char(10),fech_tran,103)  as datetime )<= @Fec2 and periodo=year(@Fec2) and 
				k.codi_prod not in  (select distinct R.codi_prod from @Rot R ) 
				--and K.codi_prod='00012059'
		group by nemo_alma, P.codi_clie_prov, desc_sub_fami_prod, desc_prod ,COD_PRES, k.codi_prod
		
		union all
		
		select  nemo_alma, P.codi_clie_prov, SI_dcvp.dbo.f_cliente_proveedor(P.codi_clie_prov) as Laboratorio,
				desc_sub_fami_prod, desc_prod , 
				(select desc_pres from SI_dcvp.dbo.PRESENTACION AS PRES (nolock) where P.COD_PRES=PRES.COD_PRES) desc_pres,
				0,0,0,0,0,0,null,
				K.codi_prod, 
				null,
				null, null, null, null, 0, 0
							
		from SI_dcvp.dbo.kardex k (nolock)
		join SI_dcvp.dbo.almacen A (nolock)
		on k.codi_alma=a.codi_alma
		join SI_dcvp.dbo.productos P (nolock)
		on k.codi_prod=P.codi_prod
		join SI_dcvp.dbo.sub_familia_producto S
		on S.codi_sub_Fami_prod=P.codi_sub_Fami_prod
		left join @Ti C
		on C.codi_prod=K.codi_prod
		
			where case when K.codi_alma='11' then '19' else K.codi_alma end collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
					and cast(convert(char(10),fech_tran,103)  as datetime )<= @Fec2 and periodo=year(@Fec2) and 
				k.codi_prod not in  (select distinct R.codi_prod from @Rot R ) 
				--and K.codi_prod='00012059'
		group by nemo_alma, P.codi_clie_prov, desc_sub_fami_prod, desc_prod ,COD_PRES, k.codi_prod
		
	end	

--select * from #Tx
--return

	declare @sum numeric(18,6), @cont int
	declare @sumstoc numeric(18,6), @sumrot numeric(18,6)
	
	create table #Rx ( idx int identity, codi_prod char(8) , valor numeric(12,2) null, estado char(1) null,
						valorstock numeric(12,2) null, estadostock char(1) null  , valorrota numeric(12,2) null, estadorota char(1) null )
	
	create table #Ox ( idx int identity, codi_prod char(8) , valor numeric(12,2) null , stock numeric(12,2) null , rotacion int null)

	insert #OX
	select codi_prod, sum(venta_cant_conta + venta_cant_cred), 
			(select top 1 saldo from @Ts x where x.codi_prod=T.codi_prod ),
			(select top 1 rot from @Rot r where r.codi_prod=T.codi_prod )
	from #Tx T 
	group by codi_prod
	order by sum(venta_cant_conta + venta_cant_cred) desc
	
	set @sum= (select sum((valor ) ) from #Ox ) * 80/100.00
	set @sumstoc= (select sum((stock ) ) from #Ox ) * 80/100.00
	set @sumrot = (select sum((rotacion ) ) from #Ox ) * 80/100.00

	insert #Rx
	select codi_prod, (select sum(valor) from #OX A where A.idx<=T.idx) Acum, '0',
				(select sum(stock) from #OX A where A.idx<=T.idx) Acum1, '0' , 
				(select sum(rotacion) from #OX A where A.idx<=T.idx) Acum2, '0'
	from #OX T
	order by idx	
	
	update #Rx set estado='1'
	where valor<=@sum

	update #Rx set estadostock='1'
	where valorstock<=@sumstoc

	update #Rx set estadorota='1'
	where valorrota<=@sumrot

	set @cont = round((select max(idx) from #Rx ) * 20/100.00,0)

	-- select @cont, @sum
	update #Rx set estado='2', estadostock='2' , estadorota='2'
	where idx<=@cont
	
--	select * from #rx
	
	select nemo_alma, T.codi_clie_prov, laboratorio, desc_sub_fami_prod, desc_prod ,
	       desc_pres, venta_cant_conta, venta_valor_conta, venta_costo_conta ,
	       venta_cant_cred, venta_valor_cred, venta_costo_Cred, rot, 
	       /*(select desC_cultivo from cultivos C(nolock) where C.cod_cultivo=T.cod_cultivo)*/ cultivo,
			/*(select desc_tipo_medio_pago from tipo_pago (nolock) where codi_tipo_medio_pago=T.codi_tipo_pago )*/ tipo_pago,
			isnull(ingresos,0) Ingreso, isnull(saldo, 0) Saldo, T.codi_prod,
		/*(select desc_sub_fami_prod from SUB_FAMILIA_PRODUCTO S(nolock) where S.codi_sub_Fami_prod in
			(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod = T.codi_prod))*/ isnull(sub_Fami_prod,'') sub_Fami_prod,
			
		/*(select (select (select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where l.cod_lin_pro=F.cod_lin_pro) 
			 from familia_producto f (nolock) where f.codi_fami_prod=s.codi_fami_prod) from sub_familia_producto S(nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from productos P(nolock) where P.codi_prod=T.codi_prod)) as*/ isnull(Linea,'') Linea,
		/*dbo.uf_ulti_prec_venta(T.codi_prod, @codi_alma) */ prec_venta,
		(select estado from #Rx X where x.codi_prod=T.codi_prod) as Estado1,
		(select estadostock from #Rx X where x.codi_prod=T.codi_prod) as Estado2,
		(select estadorota from #Rx X where x.codi_prod=T.codi_prod) as Estado3,
		isnull(r.dias_rota,0) as dias_rota,
		/*dbo.uf_ulti_prec_costo(T.codi_prod, @codi_alma)*/ prec_costo,
		case when rot_tipo>= 0 and rot_tipo<=60 then 'A'
	         when rot_tipo>=61 and rot_tipo<=90 then 'M'
			 when rot_tipo>=91 or rot_tipo is null then 'B' end as rot_tipo, venta_cant_conta + venta_cant_cred as canti_venta
		
	from #Tx T
	left join @Rot R
	on T.codi_clie_prov=R.codi_clie_prov /*and T.cod_cultivo = R.cod_cultivo*/ and T.codi_prod=R.codi_prod
	left join @Ti C
	on C.codi_prod=R.codi_prod
	left join @TS S
	on S.codi_prod=R.codi_prod
	
	left join @Etapa E
	on E.codi_prod=T.codi_prod and E.codi_clie=T.codi_clie_prov

	--where T.codi_prod='00080569'
	
	drop table #Rx
	drop table #Ox
	
END

drop table #alma 
drop table #Tx
drop table #Xx
drop table #Rota
GO
