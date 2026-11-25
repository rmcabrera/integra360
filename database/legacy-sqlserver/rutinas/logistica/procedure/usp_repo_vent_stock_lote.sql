CREATE PROCEDURE [dbo].[usp_repo_vent_stock_lote]
	@CODI_ALMA [char](2),
	@FEC1 [datetime],
	@FEC2 [datetime],
	@CODI_CLIE_PROV [char](5),
	@SUBFAMILIA [char](4)
WITH EXECUTE AS CALLER
AS
--declare @CODI_ALMA CHAR(2) , @FEC1 DATETIME , @FEC2 DATETIME  , @CODI_CLIE_PROV CHAR(5)  , @SUBFAMILIA char(4) 
--select  @CODI_ALMA ='02' , @FEC1 ='01/07/2018', @FEC2 ='09/08/2118', @CODI_CLIE_PROV ='', @SUBFAMILIA =''

set nocount on 
---columnas (FECHA VENCIMIENTO, CONDICION, PRIMER ARREGLO, SEGUNDO ARREGLO) 
	select NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, 
		upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' , PROD.DESC_PROD , PRES.DESC_PRES ,
		venta_cant    = sum(  FD.CANT_ITEM  ) , 
		venta_valor  = sum(  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  ) ,   
		venta_costo	= sum(  (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) )  ,   	  	
		FD.CODI_PROD  	  	,
		E.codi_prod_alma_lote,
		max(F.fec_vence) as fec_vence, max(F.p_arreglo) as p_arreglo , max(F.s_arreglo) as s_arreglo,
		max(case f.condicion when 1 then 'Bueno' when 0 then 'Malo' when 2 then 'Regular' when 3 then 'Regular Modificado' end ) as condicion,
		(select (select (select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where l.cod_lin_pro=F.cod_lin_pro) 
			 from familia_producto f (nolock) where f.codi_fami_prod=s.codi_fami_prod) from sub_familia_producto S(nolock)
				where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from productos P(nolock) where P.codi_prod=FD.codi_prod)) as Linea
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE 	as FD (nolock)on FAC.codi_fact = FD.codi_fact
		inner join ALMACEN_PRODUCTO 	as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)
		inner join PRODUCTOS		as PROD (nolock) on AP.codi_prod = PROD.codi_prod
		INNER join PRESENTACION 	AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES
		inner join CLIENTE_PROVEEDOR 	as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD
		join docu_sali_mate C 
		on FAC.codi_Fact=C.codi_Fact
		join detalle_docu_sali D
		on C.codi_docu_sali=D.codi_docu_sali and FD.codi_prod=D.codi_prod
		join PRODUCTOS_LOTES_INGRE_SALI E
		on D.codi_Deta_docu_sali=E.codi_Deta_ingre_sali
		join producto_almacen_lote F
		on E.codi_prod_alma_lote=F.codi_prod_alma_lote

	where (cast(convert(varchar(10), FAC.fech_fact , 103) as datetime) between @fec1 and @fec2)	
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		--and fd.codi_prod='00081042'
		and (fd.codi_alma=@CODI_ALMA or @CODI_ALMA='')
		and E.io=2
	group by SUC.NEMO_ALMA ,
			 CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES, FD.CODI_PROD,
			 E.codi_prod_alma_lote
GO
