CREATE PROCEDURE [dbo].[usp_compras_PRODUCTOS_FECHAS_Conso]
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
--select @TIPO ='1', @CODI_ALMA ='00' , @FEC1 ='01/01/2010', @FEC2 ='31/12/2010', @CODI_CLIE_PROV ='16168', @SUBFAMILIA ='', @CODI_PRES =0

set nocount on
set quoted_identifier off 

declare @SQLString nvarchar(4000)
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

set nocount on
--- TODO ESTA POR SUCURSAL Y ENTRE FECHAS --------------

declare @Ruc varchar(15)

IF @TIPO='1' ---- SOLO POR LABORATORIO 

BEGIN
	set @ruc= (select ruc from dbo.cliente_proveedor (nolock) where codi_clie_prov=@CODI_CLIE_PROV)

	create table #TX ( alma varchar(30) null, codi_clie_prov char(5) null, laboratorio varchar(200) null,
				desc_sub_fami varchar(150) null, desc_prod varchar(200) null, codi_prod char(8) null,
		desc_pres  varchar(20) null, ruc varchar(15) null, 
		vent_cant_cont numeric(12,4) null,vent_valor_cont numeric(12,4) null,
		vent_cant_cred numeric(12,4) null,vent_valor_cred numeric(12,4) null) 

	set @Parmstring = "@fec1 datetime ,@fec2 datetime"

	set @SQLString = "
	select " +@Condi+" CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
		isnull(codi_aux,prod.codi_prod)  codi_PROD , 
		(select ruc from siep_agrog.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,
		venta_cant_conta    = sum(case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else fd.cantidad  end end) , --sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else 1+siep_agrog.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   ), 

		venta_cant_exo    = sum(case when afecto=0 then fd.cantidad else case when cod_impuesto=3 then fd.cantidad else 0  end end)    ,
		venta_valor_exo  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 0  end end   )

	FROM siep_agrog.dbo.ALMACEN as SUC (nolock) inner join siep_agrog.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrog.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrog.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrog.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrog.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrog.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.ruc="+@ruc +"  AND tipo_nota_ingr='01'
	group by   " +@Grup+" CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , isnull(codi_aux,prod.codi_prod)  , PROD.DESC_PROD , PRES.DESC_PRES
	order by desc_prod "

	insert #TX
	execute sp_executesql @SQLString, @ParmString, @fec1 =@fec1 , @fec2 =@fec2

	set @SQLString = "
	select " +@Condi+" CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
		prod.codi_prod codi_PROD , 
		(select ruc from siep_agrom.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,
		venta_cant_conta    = sum(case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else fd.cantidad  end end) , --sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else 1+siep_agrom.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   ), 

		venta_cant_exo    = sum(case when afecto=0 then fd.cantidad else case when cod_impuesto=3 then fd.cantidad else 0  end end)    ,
		venta_valor_exo  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 0  end end   )

	FROM siep_agrom.dbo.ALMACEN as SUC (nolock) inner join siep_agrom.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrom.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrom.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrom.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrom.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrom.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.ruc="+@ruc +"  AND tipo_nota_ingr='01'
	group by   " +@Grup+" CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , prod.codi_prod  , PROD.DESC_PROD , PRES.DESC_PRES
	order by desc_prod "

	insert #TX
	execute sp_executesql @SQLString, @ParmString, @fec1 =@fec1 , @fec2 =@fec2

	
	select alma ,  ruc, max(laboratorio) , desc_sub_fami , desc_prod , 
		desc_pres  , 
		 sum(vent_cant_cont) vent_cant_cont ,
		sum(vent_valor_cont) vent_valor_cont , 
		sum(vent_cant_cred) vent_cant_cred , 
		sum(vent_valor_cred) vent_valor_cred 
	 from #Tx
	group by alma, ruc, desc_sub_fami , DESC_PROD , DESC_PRES

	drop table #Tx

end

else if @tipo='2' --- PROVEEDOR Y SUBFAMILIA

BEGIN
	set @ruc= (select ruc from dbo.cliente_proveedor (nolock) where codi_clie_prov=@CODI_CLIE_PROV)

	select NEMO_ALMA, ruc , max(laboratorio) laboratorio, 
		DESC_SUB_FAMI_PROD, 	
		desc_prod, desc_pres, 
		sum(venta_cant_conta) venta_cant_conta,
		sum(venta_valor_conta) venta_valor_conta
	from
	(	
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
		isnull(codi_aux,prod.codi_prod)  codi_PROD , 
		(select ruc from siep_agrog.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+siep_agrog.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrog.dbo.ALMACEN as SUC (nolock) inner join siep_agrog.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrog.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrog.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrog.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrog.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrog.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.ruc=@ruc AND tipo_nota_ingr='01'
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , isnull(codi_aux,prod.codi_prod), PROD.DESC_PROD , PRES.DESC_PRES
	union all
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
		prod.codi_prod  codi_PROD , 
		(select ruc from siep_agrom.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+siep_agrom.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrom.dbo.ALMACEN as SUC (nolock) inner join siep_agrom.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrom.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrom.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrom.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrom.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrom.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.ruc=@ruc AND tipo_nota_ingr='01'
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , prod.codi_prod, PROD.DESC_PROD , PRES.DESC_PRES) SQL

	group by NEMO_ALMA , ruc, laboratorio , DESC_SUB_FAMI_PROD , DESC_PROD , DESC_PRES 



end

else if @tipo='3' --- SUBFAMILIA

BEGIN
	select  NEMO_ALMA, ruc , max(laboratorio) laboratorio, 
		DESC_SUB_FAMI_PROD, 	
		desc_prod, desc_pres, 
		sum(venta_cant_conta) venta_cant_conta,
		sum(venta_valor_conta) venta_valor_conta
	from
	(	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
			isnull(codi_aux,prod.codi_prod)  codi_PROD , 
		(select ruc from siep_agrog.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,	

		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+siep_agrog.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrog.dbo.ALMACEN as SUC (nolock) inner join siep_agrog.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrog.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrog.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrog.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrog.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrog.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , isnull(codi_aux,prod.codi_prod)  , PROD.DESC_PROD , PRES.DESC_PRES

	union all

	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
		prod.codi_prod  codi_PROD , 
		(select ruc from siep_agrom.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,	

		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+siep_agrom.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrom.dbo.ALMACEN as SUC (nolock) inner join siep_agrom.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrom.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrom.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrom.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrom.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrom.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_SUB_FAMI_PROD = @SUBFAMILIA AND tipo_nota_ingr='01'
	
		group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , prod.codi_prod  , PROD.DESC_PROD , PRES.DESC_PRES) SQL
	group by nemo_alma, ruc, laboratorio, DESC_SUB_FAMI_PROD, DESC_PROD , DESC_PRES




end

else if @tipo='4' --- PRESETANCION

BEGIN
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )

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
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
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
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
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
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
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
	set @ruc= (select ruc from dbo.cliente_proveedor (nolock) where codi_clie_prov=@CODI_CLIE_PROV)

	select NEMO_ALMA, ruc , max(laboratorio) laboratorio, 
	DESC_SUB_FAMI_PROD, 	
	desc_prod, desc_pres, 
	sum(venta_cant_conta) venta_cant_conta,
	sum(venta_valor_conta) venta_valor_conta
	from
	(select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
		isnull(codi_aux,prod.codi_prod)  codi_PROD , 
		(select ruc from siep_agrog.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,	

		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+siep_agrog.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrog.dbo.ALMACEN as SUC (nolock) inner join siep_agrog.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrog.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrog.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrog.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrog.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrog.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN siep_agrog.dbo.FAMILIA_PRODUCTO AS SF (nolock) ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.ruc= @ruc AND tipo_nota_ingr='01'
		and SF.CODI_FAMI_PROD = @SUBFAMILIA
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , isnull(codi_aux,prod.codi_prod) , PROD.DESC_PROD , PRES.DESC_PRES

	union all

	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
		prod.codi_prod codi_PROD , 
		(select ruc from siep_agrom.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,	

		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+siep_agrom.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrom.dbo.ALMACEN as SUC (nolock) inner join siep_agrom.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrom.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrom.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrom.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrom.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrom.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN siep_agrom.dbo.FAMILIA_PRODUCTO AS SF (nolock) ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.ruc=@ruc AND tipo_nota_ingr='01'
		and SF.CODI_FAMI_PROD = @SUBFAMILIA
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , prod.codi_prod , PROD.DESC_PROD , PRES.DESC_PRES) SQL

	group by nemo_alma, ruc, laboratorio , DESC_SUB_FAMI_PROD , DESC_PROD , DESC_PRES

end


else if @tipo='9' --- FAMILIA

BEGIN
	select NEMO_ALMA, ruc , max(laboratorio) laboratorio, 
		DESC_SUB_FAMI_PROD, 	
		desc_prod, desc_pres, 
		sum(venta_cant_conta) venta_cant_conta,
		sum(venta_valor_conta) venta_valor_conta
	from
	(	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
		isnull(codi_aux,prod.codi_prod)  codi_PROD , 
		(select ruc from siep_agrog.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+siep_agrog.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrog.dbo.ALMACEN as SUC (nolock) inner join siep_agrog.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrog.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrog.dbo.ALMACEN_PRODUCTO 	as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrog.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrog.dbo.PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrog.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN siep_agrog.dbo.FAMILIA_PRODUCTO AS SF  (nolock)ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_FAMI_PROD = @SUBFAMILIA AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , isnull(codi_aux,prod.codi_prod)  , PROD.DESC_PROD , PRES.DESC_PRES
	
	UNION ALL

	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(SF.DESC_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
		prod.codi_prod codi_PROD , 
		(select ruc from siep_agrom.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+siep_agrom.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrom.dbo.ALMACEN as SUC (nolock) inner join siep_agrom.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrom.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrom.dbo.ALMACEN_PRODUCTO 	as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrom.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrom.dbo.PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrom.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN siep_agrom.dbo.FAMILIA_PRODUCTO AS SF  (nolock)ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and SF.CODI_FAMI_PROD = @SUBFAMILIA AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_FAMI_PROD , prod.codi_prod  , PROD.DESC_PROD , PRES.DESC_PRES) SQL

	group by nemo_alma , ruc, laboratorio, DESC_SUB_FAMI_PROD ,  DESC_PROD , DESC_PRES


end
else if @tipo='10' --- PROVEEDOR Y linea

BEGIN
	set @ruc= (select ruc from dbo.cliente_proveedor (nolock) where codi_clie_prov=@CODI_CLIE_PROV)

	select NEMO_ALMA, ruc , max(laboratorio) laboratorio, 
		DESC_SUB_FAMI_PROD, 	
		desc_prod, desc_pres, 
		sum(venta_cant_conta) venta_cant_conta,
		sum(venta_valor_conta) venta_valor_conta
	from
	(select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
		isnull(codi_aux,prod.codi_prod)  codi_PROD , 
		(select ruc from siep_agrog.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,	
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+siep_agrog.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrog.dbo.ALMACEN as SUC (nolock) inner join siep_agrog.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrog.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrog.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrog.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrog.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrog.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN siep_agrog.dbo.FAMILIA_PRODUCTO AS SF (nolock) ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
		inner join siep_agrog.dbo.LINEA_FAMILIA_PRO	L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	        and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.ruc=@ruc
		and L.cod_lin_pro = @SUBFAMILIA and tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , isnull(codi_aux,prod.codi_prod)  , PROD.DESC_PROD , PRES.DESC_PRES
	
	union all

	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD'  , PROD.DESC_PROD , PRES.DESC_PRES ,
		prod.codi_prod codi_PROD , 
		(select ruc from siep_agrom.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,	
	
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+siep_agrom.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrom.dbo.ALMACEN as SUC (nolock) inner join siep_agrom.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrom.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrom.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrom.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrom.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrom.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SUF (nolock) ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN siep_agrom.dbo.FAMILIA_PRODUCTO AS SF (nolock) ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
		inner join siep_agrom.dbo.LINEA_FAMILIA_PRO	L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
	        and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and CP.ruc=@ruc
		and L.cod_lin_pro = @SUBFAMILIA and tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , prod.codi_prod  , PROD.DESC_PROD , PRES.DESC_PRES) SQL

	group by nemo_alma , ruc, laboratorio, DESC_SUB_FAMI_PROD ,  DESC_PROD , DESC_PRES


end


else if @tipo='11' --- linea

BEGIN
	select NEMO_ALMA, ruc , max(laboratorio) laboratorio, 
		DESC_SUB_FAMI_PROD, 	
		desc_prod, desc_pres, 
		sum(venta_cant_conta) venta_cant_conta,
		sum(venta_valor_conta) venta_valor_conta
	from
	(select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
		isnull(codi_aux,prod.codi_prod)  codi_PROD , 
		(select ruc from siep_agrog.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,		
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+ siep_agrog.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrog.dbo.ALMACEN as SUC (nolock) inner join siep_agrog.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrog.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrog.dbo.ALMACEN_PRODUCTO 	as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrog.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrog.dbo.PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrog.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN siep_agrog.dbo.FAMILIA_PRODUCTO AS SF  (nolock)ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
		inner join siep_agrog.dbo.LINEA_FAMILIA_PRO	L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and L.cod_lin_pro = @SUBFAMILIA AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , isnull(codi_aux,prod.codi_prod)  , PROD.DESC_PROD , PRES.DESC_PRES
	
	union all
	
	select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio,  upper(L.des_lin_pro) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
		prod.codi_prod codi_PROD , 
		(select ruc from siep_agrom.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,		
		venta_cant_conta    = sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+ siep_agrom.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   )
	
	FROM siep_agrom.dbo.ALMACEN as SUC (nolock) inner join siep_agrom.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrom.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrom.dbo.ALMACEN_PRODUCTO 	as AP (nolock) on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrom.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrom.dbo.PRESENTACION 	AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrom.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SUF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SUF.CODI_SUB_FAMI_PROD
		INNER JOIN siep_agrom.dbo.FAMILIA_PRODUCTO AS SF  (nolock)ON 	SUF.CODI_FAMI_PROD=SF.CODI_FAMI_PROD
		inner join siep_agrom.dbo.LINEA_FAMILIA_PRO	L (nolock) ON    sf.cod_lin_pro = l.cod_lin_pro

	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		and L.cod_lin_pro = @SUBFAMILIA AND tipo_nota_ingr='01'
	
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , L.des_lin_pro , prod.codi_prod , PROD.DESC_PROD , PRES.DESC_PRES) SQL

	group by nemo_alma , ruc, laboratorio, DESC_SUB_FAMI_PROD ,  DESC_PROD , DESC_PRES

end

else 
 
---- TODOS LOS PRODUCTOS SIN TENER EN CUENTA EL LABORATORIO

BEGIN
	select 'TODOS' NEMO_ALMA, ruc , max(laboratorio) laboratorio, 
		DESC_SUB_FAMI_PROD, 	
		desc_prod, desc_pres, 
		sum(venta_cant_conta) venta_cant_conta,
		sum(venta_valor_conta) venta_valor_conta, 
		sum(venta_cant_exo) venta_cant_cred, 
		sum(venta_valor_exo) venta_valor_cred
	from
	(select  'TODOS'  NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' ,
                PROD.DESC_PROD , PRES.DESC_PRES ,
		(select ruc from siep_agrog.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,
		isnull(codi_aux,prod.codi_prod) codi_prod, 
		venta_cant_conta    = sum(case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else fd.cantidad  end end) , --sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else 1+siep_agrog.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   ), 

		venta_cant_exo    = sum(case when afecto=0 then fd.cantidad else case when cod_impuesto=3 then fd.cantidad else 0  end end)    ,
		venta_valor_exo  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 0  end end   )

	FROM siep_agrog.dbo.ALMACEN as SUC (nolock) inner join siep_agrog.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrog.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrog.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrog.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrog.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrog.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrog.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		AND tipo_nota_ingr='01'
	group by   --SUC.NEMO_ALMA , 
		CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , isnull(codi_aux,prod.codi_prod) , PROD.DESC_PROD , PRES.DESC_PRES
	
	union all
	select  'TODOS'  NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' ,
                PROD.DESC_PROD , PRES.DESC_PRES ,
		(select ruc from siep_agrom.dbo.cliente_proveedor C (nolock) where c.codi_clie_prov=cp.codi_clie_prov) ruc,
		isnull(codi_aux,prod.codi_prod) codi_prod, 
		venta_cant_conta    = sum(case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else fd.cantidad  end end) , --sum(fd.cantidad ),
		venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else 1+siep_agrom.dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   ), 

		venta_cant_exo    = sum(case when afecto=0 then fd.cantidad else case when cod_impuesto=3 then fd.cantidad else 0  end end)    ,
		venta_valor_exo  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* 
				case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 0  end end   )

	FROM siep_agrom.dbo.ALMACEN as SUC (nolock) inner join siep_agrom.dbo.nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join siep_agrom.dbo.detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr
		inner join siep_agrom.dbo.ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join siep_agrom.dbo.PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join siep_agrom.dbo.PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join siep_agrom.dbo.CLIENTE_PROVEEDOR 	as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN siep_agrom.dbo.SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )
		 and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)	
		AND tipo_nota_ingr='01'
	group by   --SUC.NEMO_ALMA , 
		CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , isnull(codi_aux,prod.codi_prod) , PROD.DESC_PROD , PRES.DESC_PRES) SQL

	group by ruc, DESC_SUB_FAMI_PROD , codi_prod, DESC_PROD , DESC_PRES

end

drop table #alma 

set quoted_identifier on
GO
