CREATE PROCEDURE [dbo].[usp_repo_resum_vent_sucur]
	@fi [datetime],
	@ff [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @tipo int, @fi datetime, @ff datetime,  @alma char(2)
--select @tipo=1, @fi='01/01/2017', @ff='30/01/2017', @alma='04'

select 
	codi_alma, 
	(Select nemo_alma from almacen A (nolock) where a.codi_alma=sql.codi_alma) Nemo,
	'00' linea, 
	--sum(case when linea='01' then cantidad else 0 end) cantidad, 
	sum(case when codi_tipo_pago=1 and linea='01' then prec_costo else 0 end ) costo01,
	sum(case when codi_tipo_pago=1 and linea='01' then venta else 0 end) venta01,
	sum(case when codi_tipo_pago=4 and linea='01' then prec_costo else 0 end ) costo01C,
	sum(case when codi_tipo_pago=4 and linea='01' then venta else 0 end) credito01,

	sum(case when codi_tipo_pago=1 and linea='02' then prec_costo else 0 end ) costo02,
	sum(case when codi_tipo_pago=1 and linea='02' then venta else 0 end) venta02,
	sum(case when codi_tipo_pago=4 and linea='02' then prec_costo else 0 end ) costo02C,
	sum(case when codi_tipo_pago=4 and linea='02' then venta else 0 end) credito02,
	
	sum(case when codi_tipo_pago=1 and linea='03' then prec_costo else 0 end ) costo03,
	sum(case when codi_tipo_pago=1 and linea='03' then venta else 0 end) venta03,
	sum(case when codi_tipo_pago=4 and linea='03' then prec_costo else 0 end ) costo03C,
	sum(case when codi_tipo_pago=4 and linea='03' then venta else 0 end) credito03,

	sum(case when codi_tipo_pago=1 and linea='04' then prec_costo else 0 end ) costo04,
	sum(case when codi_tipo_pago=1 and linea='04' then venta else 0 end) venta04,
	sum(case when codi_tipo_pago=4 and linea='04' then prec_costo else 0 end ) costo04C,
	sum(case when codi_tipo_pago=4 and linea='04' then venta else 0 end) credito04,

	sum(case when codi_tipo_pago=1 and linea='05' then prec_costo else 0 end ) costo05,
	sum(case when codi_tipo_pago=1 and linea='05' then venta else 0 end) venta05,
	sum(case when codi_tipo_pago=4 and linea='05' then prec_costo else 0 end ) costo01C,
	sum(case when codi_tipo_pago=4 and linea='05' then venta else 0 end) credito05,

	sum(case when codi_tipo_pago=1 and linea='06' then prec_costo else 0 end ) costo06,
	sum(case when codi_tipo_pago=1 and linea='06' then venta else 0 end) venta06,
	sum(case when codi_tipo_pago=4 and linea='06' then prec_costo else 0 end ) costo06C,
	sum(case when codi_tipo_pago=4 and linea='05' then venta else 0 end) credito05,

	sum(case when codi_tipo_pago=1 and linea='07' then prec_costo else 0 end ) costo07,
	sum(case when codi_tipo_pago=1 and linea='07' then venta else 0 end) venta07,
	sum(case when codi_tipo_pago=4 and linea='07' then prec_costo else 0 end ) costo07C,
	sum(case when codi_tipo_pago=4 and linea='07' then venta else 0 end) credito07,

	sum(case when codi_tipo_pago=1 and linea='08' then prec_costo else 0 end ) costo08,
	sum(case when codi_tipo_pago=1 and linea='08' then venta else 0 end) venta08,
	sum(case when codi_tipo_pago=4 and linea='08' then prec_costo else 0 end ) costo08C,
	sum(case when codi_tipo_pago=4 and linea='08' then venta else 0 end) credito08,

	sum(case when codi_tipo_pago=1 then prec_costo else 0 end ) costo,
	sum(case when codi_tipo_pago=1 then venta else 0 end) venta,
	sum(case when codi_tipo_pago=4 then prec_costo else 0 end ) costoC,
	sum(case when codi_tipo_pago=4 then venta else 0 end) credito,

	null as setnull 

from
(  SELECT FACTURA.CODI_ALMA, codi_tipo_pago, 
	/*(select (select (select (select des_lin_pro from LINEA_FAMILIA_PRO L (nolock) 
						where l.cod_lin_pro in (select F.cod_lin_pro from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =D.codi_prod) )))))) Linea,
	*/
	(select (select (select (select F.cod_lin_pro from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =D.codi_prod) ))))) Linea,
	
					
	sum(D.CANT_ITEM)  cantidad,
	SUM(D.CANT_ITEM *(D.PREC_ITEM * (CASE WHEN factura.codi_mone='01' THEN 1 ELSE factura.tcambio END))) venta,
	SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end))) prec_costo
    FROM FACTURA (nolock),   
         FACTURA_DETALLE D(nolock), 
	 productos (nolock)
   WHERE  D.CODI_FACT = FACTURA.CODI_FACT  and  
	  D.codi_prod=productos.codi_prod and 
	( FACTURA.FECH_FACT >= @FI) and
	( FACTURA.FECH_FACT < DATEADD(DAY,1,@FF)) and 
	( ISNULL(FACTURA.ESTADO,'')<>'A') --and codi_tipo_pago=@tipo
		and (isnull(@alma,'')='' or Factura.codi_alma=@alma)

	group by  factura.codi_alma, factura.codi_tipo_pago, D.codi_prod) SQL
group by codi_alma--, linea
order by codi_alma
GO
