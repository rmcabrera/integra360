CREATE PROCEDURE [dbo].[usp_repo_comi_2014]
	@FI [datetime],
	@FF [datetime],
	@codi_alma [char](2),
	@linea [char](2)
WITH EXECUTE AS CALLER
AS
--declare @FI datetime , @FF datetime , @codi_alma char(2), @linea char(2)
--select @FI='01/03/2017', @FF='31/03/2017', @codi_alma ='02', @linea='01'

set nocount on

declare @Alma table (codi_alma char(2))
declare @LineaT table (codi char(2))

declare @Tx table (nemo_alma varchar(50) null, codi_prod char(8) null, desc_prod varchar(200) null, prec_prov numeric(12,2) null,
					descto_porcenta numeric(12,2) null, codi_fami_prod char(2) null, desc_pres varchar(100) null,
					cliente varchar(200) null, fech_fact datetime null, codi_tipo_docu char(4) null, ser_fact char(5) null, nro_fact int null,
					codi_mone char(2) null, codi_tipo_pago int null, cant_item numeric(12,4) null, prec_item numeric(12,4) null, prec_costo numeric(12,4) null,
					codi_alma char(2) null, codi_Clie_prov char(5) null, cod_impuesto int null, igvdeta numeric(12,3) null, alta int null, linea char(2) null,
					tipocomi varchar(100) null)
if @codi_alma='00'
	insert @alma
	select codi_alma from almacen (nolock)
else
	insert @alma
	select @codi_alma	

if @linea='00' 
	insert @LineaT 
	select cod_lin_pro from linea_familia_pro (nolock) where cod_lin_pro in ('01','02','03','05')
else
	insert @LineaT 
	select @linea
	
insert @tx					
SELECT ALMACEN.NEMO_ALMA,   
         FACTURA_DETALLE.CODI_PROD,   
         PRODUCTOS.DESC_PROD,   
         PRODUCTOS.prec_prov,   
         PRODUCTOS.descto_porcenta,   
		(select (select (select codi_fami_prod from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =PRODUCTOS.codi_prod) ))))codi_fami_prod,

         PRESENTACION.desc_pres,   
         (Select isnull(denominacion,'NO DEFINIDO') from cliente_proveedor (nolock) 
			where codi_clie_prov=FACTURA.CODI_CLIE_PROV) CLIENTE,   
         FACTURA.FECH_FACT,   
         FACTURA.CODI_TIPO_DOCU,   
         FACTURA.SER_FACT,   
         FACTURA.NRO_FACT,
         FACTURA.CODI_MONE,   
         FACTURA.CODI_TIPO_PAGO,   
         FACTURA_DETALLE.CANT_ITEM,   
		(FACTURA_DETALLE.PREC_ITEM * (CASE WHEN factura.codi_mone='01' THEN 1 ELSE factura.tcambio END)) PREC_ITEM,
		FACTURA_DETALLE.PREC_COSTO ,
		FACTURA.CODI_ALMA,
		factura.codi_clie_prov,  codi_imp  as cod_impuesto,  factura_detalle.igv as igvdeta,
		isnull((select top 1 codi_rota from PRODUCTOS_MATRIZ X(nolock) 
			where X.codi_prod= productos.codi_prod /*and codi_rota is not null*/),0) altaomi,
				
		(select (select (select (select top 1 cod_lin_pro from LINEA_FAMILIA_PRO L (nolock) 
						where l.cod_lin_pro in (select F.cod_lin_pro from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =PRODUCTOS.codi_prod) )))))) Linea,
					
		isnull((select W.descripcion from PRODUCTOS_BAJA_ROTACION W (nolock) 
				where W.codi_rota in (select top 1 codi_rota from PRODUCTOS_MATRIZ X(nolock) 
					where X.codi_prod= productos.codi_prod )),'GENERAL') Tipoc
	
    FROM ALMACEN (nolock),    
         FACTURA(nolock),   
         FACTURA_DETALLE(nolock),   
         PRODUCTOS(nolock) ,   
         PRESENTACION  (nolock)
   WHERE ( ALMACEN.CODI_ALMA = FACTURA.CODI_ALMA ) and  
         ( FACTURA_DETALLE.CODI_FACT = FACTURA.CODI_FACT ) and  
         ( PRODUCTOS.CODI_PROD = FACTURA_DETALLE.CODI_PROD ) and  
         ( PRODUCTOS.cod_pres = PRESENTACION.cod_pres ) and
		( FACTURA.FECH_FACT >= @FI) and
		( FACTURA.FECH_FACT < DATEADD(DAY,1,@FF)) and
		( ISNULL(FACTURA.ESTADO,'')<>'A')  and 
		(select (select (select (select cod_lin_pro from LINEA_FAMILIA_PRO L (nolock) 
						where l.cod_lin_pro in (select F.cod_lin_pro from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =PRODUCTOS.codi_prod) ))))))  in (select codi from @LineaT)

declare @Rx table (nemo_alma varchar(50) null, codi_prod char(8) null, desc_prod varchar(250) null, desc_pres varchar(50) null,
					costo_cont_cant numeric(12,2) null, costo_Afec_cont numeric(12,2) null, costo_exo_cont numeric(12,2) null, total_costo_cont numeric(12,2) null,
					afec_cont_vent numeric(12,2) null, exo_cont_vent numeric(12,2) null, total_cont_vent numeric(12,2) null, 
					costo_cred_cant numeric(12,2) null, costo_Afec_cred numeric(12,2) null, costo_exo_cred numeric(12,2) null, total_costo_cred numeric(12,2) null,
					afec_cred_vent numeric(12,2) null, exo_cred_vent numeric(12,2) null, total_cred_vent numeric(12,2) null, cantidad numeric(12,2) null,
					costo_total numeric(12,2) null, total_Venta numeric(12,2) null, linea char(2) null, Alta int null, tipocomi varchar(100) null)

insert @Rx					
select max(case when @codi_alma='00' then 'TODOS' else nemo_alma end ) nemo_alma, codi_prod, desc_prod,
		desc_pres, 
		sum(case when codi_tipo_pago=1 then cant_item else 0 end ) Costo_Cont_cant, 
		
		sum(case when codi_tipo_pago=1 then 
			 case when cod_impuesto=1 then prec_costo*cant_item else 0 end 
			 else 0 end) Costo_afect_Cont,
			 
		sum(case when codi_tipo_pago=1 then 
			 case when cod_impuesto=3 then prec_costo*cant_item else 0 end 
			 else 0 end) Costo_Exo_Cont,
			 
		sum(case when codi_tipo_pago=1 then 
			 prec_costo*cant_item 
			 else 0 end) Total_Costo_Cont,
		round ( sum(case when codi_tipo_pago=1 and cod_impuesto=1 then
				(prec_item/(1+igvdeta/100)* cant_item) else 0 end) , 2 ) Afec_Cont_venta,
				
		round ( sum(case when codi_tipo_pago=1 and cod_impuesto=3 then
				(prec_item* cant_item) else 0 end) , 2 ) Exo_Cont_venta,
				
		round ( sum(case when codi_tipo_pago=1 and cod_impuesto=1 then
				(prec_item/(1+igvdeta/100)* cant_item) else 0 end) , 2 ) + 
			round ( sum(case when codi_tipo_pago=1 and cod_impuesto=3 then
				(prec_item * cant_item) else 0 end) , 2 ) Total_Cont_venta,

		sum(case when codi_tipo_pago<>1 then cant_item else 0 end ) Costo_Cred_Cant, 
		
		sum(case when codi_tipo_pago<>1 then 
			 case when cod_impuesto=1 then prec_costo*cant_item else 0 end else 0 end) Costo_Afec_Cred,
			 
		sum(case when codi_tipo_pago<>1 then 
			 case when cod_impuesto=3 then prec_costo*cant_item else 0 end  else 0 end) Costo_Exo_Cred,
			 
		sum(case when codi_tipo_pago<>1 then  prec_costo*cant_item 	 else 0 end) Total_Costo_Cred,
		
		round ( sum(case when codi_tipo_pago<>1 and cod_impuesto=1 then
				(prec_item/(1+igvdeta/100)* cant_item) else 0 end) , 2 ) Afec_Cred_venta,
				
		round ( sum(case when codi_tipo_pago<>1 and cod_impuesto=3 then
				(prec_item* cant_item) else 0 end) , 2 ) Exo_Cred_venta,
				
		round ( sum(case when codi_tipo_pago<>1 and cod_impuesto=1 then
				(prec_item/(1+igvdeta/100)* cant_item) else 0 end) , 2 ) + 
			round ( sum(case when codi_tipo_pago<>1 and cod_impuesto=3 then
				(prec_item * cant_item) else 0 end) , 2 ) Total_Cred_venta,
				
		sum(cant_item) Cantidad,
		sum(prec_costo*cant_item) Costo_total,
		
		round ( sum(case when cod_impuesto=1 then
				(prec_item/(1+igvdeta/100)* cant_item) else 0 end) , 2 ) + 
			round ( sum(case when cod_impuesto=3 then
				(prec_item * cant_item) else 0 end) , 2 ) Total_Venta,
		linea, max(alta), max(tipocomi)
from @Tx
where codi_alma in (select codi_alma from @alma)-- and linea='01'
	-- and codi_prod=80973
group by linea,codi_prod, desc_prod,desc_pres

select nemo_alma , codi_prod , desc_prod , desc_pres , costo_cont_cant , costo_Afec_cont , costo_exo_cont , total_costo_cont ,
		afec_cont_vent , exo_cont_vent , total_cont_vent , 	costo_cred_cant , costo_Afec_cred , costo_exo_cred , total_costo_cred ,
		afec_cred_vent , exo_cred_vent , total_cred_vent , cantidad ,costo_total , total_Venta ,
		linea, alta, tipocomi, (select des_lin_pro from LINEA_FAMILIA_PRO L (nolock) where cod_lin_pro=linea) LineaProd,
		(select (select desc_sub_fami_prod from SUB_FAMILIA_PRODUCTO S (nolock) where S.CODI_SUB_FAMI_PROD=P.codi_sub_fami_prod)
				 from productos P (nolock) where p.codi_prod=R.codi_prod) SubFami
from @Rx R
--where tipocomi='GENERAL'
GO
