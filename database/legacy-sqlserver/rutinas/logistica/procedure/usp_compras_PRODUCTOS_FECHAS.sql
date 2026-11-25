CREATE PROCEDURE [dbo].[usp_compras_PRODUCTOS_FECHAS]
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
--select @TIPO ='0', @CODI_ALMA ='00' , @FEC1 ='31/08/2012', @FEC2 ='31/08/2012', @CODI_CLIE_PROV ='12566', @SUBFAMILIA ='', @CODI_PRES =0

set nocount on
set quoted_identifier off 

declare @TS table (codi_prod char(8), saldo numeric(12,4) null )
declare @KA table (codi_prod_k char(8), saldo_k numeric(12,4) null )
declare @Tx table (nemo_alma varchar(50) null, codi_clie_prov char(5) null, laboratorio varchar(150) null, desc_sub_fami_prod varchar(150) null, 
		   desc_prod char(150) null, desc_pres varchar(50) null, venta_cant_conta numeric(18,3) null, venta_valor_conta numeric(18,3) null, 
		   venta_cant_exo numeric(18,3) null, venta_valor_exo numeric(18,3) null, codi_prod char(8) null, desc_pago varchar(150) null )

declare @Rot table (rot int null, codi_clie_prov char(5) null, codi_prod char(8) null, venta_cant_conta_rota numeric(12,3) null, venta_cant_cred_rota numeric(12,3) null)

create table #Xx (nemo_alma varchar(50) null, codi_clie_prov char(5) null, laboratorio varchar(150) null, desc_sub_fami_prod varchar(150) null, desc_prod char(150) null,
		   desc_pres varchar(50) null, venta_cant_conta numeric(18,3) null, venta_valor_conta numeric(18,3) null, venta_cant_exo numeric(18,3) null,
                   venta_valor_exo numeric(18,3) null, codi_prod char(8) null, desc_pago varchar(150) null)

create table #Rota (rot int null, codi_clie_prov char(5) null, cod_cultivo int null, codi_prod char(8) null,
		    venta_cant_conta_rota numeric(12,3) null, venta_cant_cred_rota numeric(12,3) null)

declare @anio char(4)
declare @SQLString nvarchar(4000), @SQLString_rot nvarchar(4000)   
declare @Condi varchar(100) ,@Grup varchar(100)
declare @ParmString nvarchar(100)

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
	Select codi_alma from almacen (nolock) where codi_alma = @codi_alma
END

SET @anio=year(dateadd(yyyy,-1,@FEC1))

set nocount on
--- TODO ESTA POR SUCURSAL Y ENTRE FECHAS --------------

IF @TIPO='1' ---- SOLO POR LABORATORIO 

BEGIN
	set @Parmstring = "@fec1 datetime ,@fec2 datetime"
	
	set @SQLString_rot = " select count(FD.codi_prod) rot, CP.codi_clie_prov, max(cod_cultivo) cod_cultivo, FD.CODI_PROD,
			venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
			venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
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
	select " +@Condi+" CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
		venta_cant_conta    = sum(case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else fd.cantidad  end end) , --sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   ), 

		venta_cant_exo    = sum(case when afecto=0 then fd.cantidad else case when cod_impuesto=3 then fd.cantidad else 0  end end)    ,
		venta_valor_exo  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 0  end end), max(FD.codi_prod) ,
  (select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
	(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	

	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov='"+@CODI_CLIE_PROV +"'  AND tipo_nota_ingr='01'
	group by   " +@Grup+" CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES
	order by desc_prod "
	
	insert #Xx
	execute sp_executesql @SQLString, @ParmString, @fec1 =@fec1 , @fec2 =@fec2

	insert @KA
	select K.codi_prod, sum(cant_ingr - cant_sali) Saldo 
	from kardex k (nolock)
	where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	and periodo=@anio and year(fech_tran)=@anio and K.codi_prod in (select distinct T.codi_prod from #Xx T) 
	group by K.codi_prod
	
	insert @TS
	select K.codi_prod, sum(cant_ingr - cant_sali) Saldo from kardex k (nolock)
			where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	and cast(convert(char(10),fech_tran,103)  as datetime )<= @Fec2 and periodo=year(@Fec2) and 
				K.codi_prod in (select distinct T.codi_prod from #Xx T) 
	group by K.codi_prod
	
	select nemo_alma, T.codi_clie_prov, laboratorio, desc_sub_fami_prod, desc_prod,
	       desc_pres, venta_cant_conta, venta_valor_conta, venta_cant_exo, venta_valor_exo,
		isnull(saldo, 0) stock, isnull(saldo_k, 0) saldo, rot, R.venta_cant_conta_rota, R.venta_cant_cred_rota,
		T.desc_pago             
	from #Xx T
	left join #Rota R
        on /*T.codi_clie_prov=R.codi_clie_prov and T.cod_cultivo = R.cod_cultivo and*/ T.codi_prod=R.codi_prod
	left join @TS S
	on S.codi_prod=R.codi_prod
	left join @KA X
	on T.codi_prod = X.codi_prod_k
end

else if @tipo='2' --- PROVEEDOR Y SUBFAMILIA

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,
		venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
	 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo

	INSERT @Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end),
		0.00 venta_cant_exo, 0.00 venta_valor_exo, max(FD.codi_prod),
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
		(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	

	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV AND tipo_nota_ingr='01'
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES

end

else if @tipo='3' --- SUBFAMILIA

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,
		venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
	 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo

	INSERT @Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end),
		0.00 venta_cant_exo, 0.00 venta_valor_exo, max(FD.codi_prod),
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
		(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	
	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES

end

else if @tipo='4' --- PRESETANCION

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,
		venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
	 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo	

	INSERT @Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end),
		0.00 venta_cant_exo, 0.00 venta_valor_exo, max(FD.codi_prod),
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
		(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	

	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and PRES.COD_PRES = @CODI_PRES AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES

end

else if @tipo='5' --- LABORATORIO Y PRESETANCION

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,
		venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
	 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo		

	INSERT @Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end),
		0.00 venta_cant_exo, 0.00 venta_valor_exo, max(FD.codi_prod),
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
		(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	

	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV
		and PRES.COD_PRES = @CODI_PRES AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES

end

else if @tipo='6' --- SUB FAMILIA Y PRESENTACION

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,
		venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
	 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo			

	INSERT @Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end),
		0.00 venta_cant_exo, 0.00 venta_valor_exo, max(FD.codi_prod),
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
		(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	

	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA
		and PRES.COD_PRES = @CODI_PRES AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES

end

else if @tipo='7' --- LABORATORIO , SUB FAMILIA ,  PRESENTACION

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,
		venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
	 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo			

	INSERT @Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end),
		0.00 venta_cant_exo, 0.00 venta_valor_exo, max(FD.codi_prod),
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
		(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	
	
	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS			as PROD  (nolock)on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 		AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA and CP.codi_clie_prov=@CODI_CLIE_PROV
		and PRES.COD_PRES = @CODI_PRES AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES

end

else if @tipo='8' --- PROVEEDOR Y FAMILIA

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,
		venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
	 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo			

	INSERT @Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end),
		0.00 venta_cant_exo, 0.00 venta_valor_exo, max(FD.codi_prod),
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
		(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	
	
	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF (nolock) ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV AND tipo_nota_ingr='01'
		and SF.CODI_FAMI_PROD = @SUBFAMILIA
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES

end


else if @tipo='9' --- FAMILIA

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,
		venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
	 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo		

	INSERT @Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end),
		0.00 venta_cant_exo, 0.00 venta_valor_exo, max(FD.codi_prod),
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
		(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	
	
	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF  (nolock)ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_FAMI_PROD = @SUBFAMILIA AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES

end
else if @tipo='10' --- PROVEEDOR Y linea

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,
		venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
	 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo		

	INSERT @Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end),
		0.00 venta_cant_exo, 0.00 venta_valor_exo, max(FD.codi_prod),
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
		(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	

	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF (nolock) ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
		inner join LINEA_FAMILIA_PRO	L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	        and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.codi_clie_prov=@CODI_CLIE_PROV 
		and L.cod_lin_pro = @SUBFAMILIA and tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , PROD.DESC_PROD , PRES.DESC_PRES

end


else if @tipo='11' --- linea

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,
		venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
	 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo		

	INSERT @Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   ),
		0.00 venta_cant_exo, 0.00 venta_valor_exo, max(FD.codi_prod),
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
		(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	

	
	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN FAMILIA_PRODUCTO AS SF  (nolock)ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
		inner join LINEA_FAMILIA_PRO	L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and L.cod_lin_pro = @SUBFAMILIA AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , PROD.DESC_PROD , PRES.DESC_PRES

end

else 
 
---- TODOS LOS PRODUCTOS SIN TENER EN CUENTA EL LABORATORIO

BEGIN
	insert @Rot
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,
		venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) , 
		venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )   
	 --FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo

	INSERT @Tx
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' ,
                PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else fd.cantidad  end end) , --sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   ), 

		venta_cant_exo = sum(case when afecto=0 then fd.cantidad else case when cod_impuesto=3 then fd.cantidad else 0  end end)    ,
		venta_valor_exo  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 0  end end   ), max(FD.codi_prod),
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in
		(select distinct left(codi_deta_orde_comp,10) from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago	
	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		AND tipo_nota_ingr='01'
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES

end

IF @TIPO<>'1'
BEGIN

	insert @KA
	select K.codi_prod, sum(cant_ingr - cant_sali) Saldo 
	from kardex k (nolock)
	where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	and periodo=@anio and year(fech_tran)=@anio and K.codi_prod in (select distinct T.codi_prod from @Tx T) 
	group by K.codi_prod
	
	insert @TS
	select K.codi_prod, sum(cant_ingr - cant_sali) Saldo from kardex k (nolock)
			where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	and cast(convert(char(10),fech_tran,103)  as datetime )<= @Fec2 and periodo=year(@Fec2) and 
				K.codi_prod in (select distinct T.codi_prod from @Tx T) 
	group by K.codi_prod

	select nemo_alma, T.codi_clie_prov, laboratorio, desc_sub_fami_prod, desc_prod,
	       desc_pres, venta_cant_conta, venta_valor_conta, venta_cant_exo, venta_valor_exo,
		isnull(saldo, 0) stock, isnull(saldo_k, 0) saldo, rot,
		R.venta_cant_conta_rota, R.venta_cant_cred_rota, T.desc_pago
	from @Tx T
	left join @Rot R
	on /*T.codi_clie_prov=R.codi_clie_prov and T.cod_cultivo = R.cod_cultivo and*/ T.codi_prod=R.codi_prod   
	left join @TS S
	on T.codi_prod=S.codi_prod
	left join @KA X
	on S.codi_prod = X.codi_prod_k
	
END



drop table #alma 
drop table #Xx
drop table #Rota
set quoted_identifier on
GO
