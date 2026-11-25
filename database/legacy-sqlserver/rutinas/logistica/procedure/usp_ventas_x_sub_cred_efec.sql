CREATE PROCEDURE [dbo].[usp_ventas_x_sub_cred_efec]
	@alma [char](2),
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare  @alma char(2) , @f1 datetime , @f2 datetime
--select @alma ='00', @f1 ='01/08/2010', @f2 ='30/08/2010'

set nocount on 

if @alma='00' 
	select 	codi_prod, 
		 (select desc_pres from PRESENTACION PR (nolock) 
				where Pr.cod_pres in (select p.cod_pres from productos P (nolock) where P.codi_prod=SQL.codi_prod) ) desc_pres,   
		(select DESC_PROD from Productos P (nolock) where P.codi_prod =Sql.codi_prod) Desc_prod,   
		(select (select desc_sub_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =Sql.codi_prod) )) codi_sub_fami_prod ,
		sum(case when mes= 1 then cant_item_efec else 0 end) cant_ene_efe,
		sum(case when mes= 1 then cant_item_cred else 0 end) cant_ene_cred,
		sum(case when mes= 2 then cant_item_efec else 0 end) cant_feb_efe,
		sum(case when mes= 2 then cant_item_cred else 0 end) cant_feb_cred,
		sum(case when mes= 3 then cant_item_efec else 0 end) cant_mar_efe,
		sum(case when mes= 3 then cant_item_cred else 0 end) cant_mar_cred,
		sum(case when mes= 4 then cant_item_efec else 0 end) cant_abr_efe,
		sum(case when mes= 4 then cant_item_cred else 0 end) cant_abr_cred,
		sum(case when mes= 5 then cant_item_efec else 0 end) cant_may_efe,
		sum(case when mes= 5 then cant_item_cred else 0 end) cant_may_cred,
		sum(case when mes= 6 then cant_item_efec else 0 end) cant_jun_efe,
		sum(case when mes= 6 then cant_item_cred else 0 end) cant_jun_cred,
		sum(case when mes= 7 then cant_item_efec else 0 end) cant_jul_efe,
		sum(case when mes= 7 then cant_item_cred else 0 end) cant_jul_cred,
		sum(case when mes= 8 then cant_item_efec else 0 end) cant_ago_efe,
		sum(case when mes= 8 then cant_item_cred else 0 end) cant_ago_cred,
		sum(case when mes= 9 then cant_item_efec else 0 end) cant_set_efe,
		sum(case when mes= 9 then cant_item_cred else 0 end) cant_set_cred,
		sum(case when mes= 10 then cant_item_efec else 0 end) cant_oct_efe,
		sum(case when mes= 10 then cant_item_cred else 0 end) cant_oct_cred,
		sum(case when mes= 11 then cant_item_efec else 0 end) cant_nov_efe,
		sum(case when mes= 11 then cant_item_cred else 0 end) cant_nov_cred,
		sum(case when mes= 12 then cant_item_efec else 0 end) cant_dic_efe,
		sum(case when mes= 12 then cant_item_cred else 0 end) cant_dic_cred,
	
	
		sum(case when mes= 1 then PREC_ITEM_efec else 0 end) precio_ene_efe,
		sum(case when mes= 1 then PREC_ITEM_cred else 0 end) precio_ene_cred,
		sum(case when mes= 2 then PREC_ITEM_efec else 0 end) precio_feb_efe,
		sum(case when mes= 2 then PREC_ITEM_cred else 0 end) precio_feb_cred,
		sum(case when mes= 3 then PREC_ITEM_efec else 0 end) precio_mar_efe,
		sum(case when mes= 3 then PREC_ITEM_cred else 0 end) precio_mar_cred,
		sum(case when mes= 4 then PREC_ITEM_efec else 0 end) precio_abr_efe,
		sum(case when mes= 4 then PREC_ITEM_cred else 0 end) precio_abr_cred,
		sum(case when mes= 5 then PREC_ITEM_efec else 0 end) precio_may_efe,
		sum(case when mes= 5 then PREC_ITEM_cred else 0 end) precio_may_cred,
		sum(case when mes= 6 then PREC_ITEM_efec else 0 end) precio_jun_efe,
		sum(case when mes= 6 then PREC_ITEM_cred else 0 end) precio_jun_cred,
		sum(case when mes= 7 then PREC_ITEM_efec else 0 end) precio_jul_efe,
		sum(case when mes= 7 then PREC_ITEM_cred else 0 end) precio_jul_cred,
		sum(case when mes= 8 then PREC_ITEM_efec else 0 end) precio_ago_efe,
		sum(case when mes= 8 then PREC_ITEM_cred else 0 end) precio_ago_cred,
		sum(case when mes= 9 then PREC_ITEM_efec else 0 end) precio_set_efe,
		sum(case when mes= 9 then PREC_ITEM_cred else 0 end) precio_set_cred,
		sum(case when mes= 10 then PREC_ITEM_efec else 0 end) precio_oct_efe,
		sum(case when mes= 10 then PREC_ITEM_cred else 0 end) precio_oct_cred,
		sum(case when mes= 11 then PREC_ITEM_efec else 0 end) precio_nov_efe,
		sum(case when mes= 11 then PREC_ITEM_cred else 0 end) precio_nov_cred,
		sum(case when mes= 12 then PREC_ITEM_efec else 0 end) precio_dic_efe,
		sum(case when mes= 12 then PREC_ITEM_cred else 0 end) precio_dic_cred,
	
	
		sum(case when mes= 1 then prec_costo_efec else 0 end) costo_ene_efe,
		sum(case when mes= 1 then prec_costo_cred else 0 end) costo_ene_cred,
		sum(case when mes= 2 then prec_costo_efec else 0 end) costo_feb_efe,
		sum(case when mes= 2 then prec_costo_cred else 0 end) costo_feb_cred,
		sum(case when mes= 3 then prec_costo_efec else 0 end) costo_mar_efe,
		sum(case when mes= 3 then prec_costo_cred else 0 end) costo_mar_cred,
		sum(case when mes= 4 then prec_costo_efec else 0 end) costo_abr_efe,
		sum(case when mes= 4 then prec_costo_cred else 0 end) costo_abr_cred,
		sum(case when mes= 5 then prec_costo_efec else 0 end) costo_may_efe,
		sum(case when mes= 5 then prec_costo_cred else 0 end) costo_may_cred,
		sum(case when mes= 6 then prec_costo_efec else 0 end) costo_jun_efe,
		sum(case when mes= 6 then prec_costo_cred else 0 end) costo_jun_cred,
		sum(case when mes= 7 then prec_costo_efec else 0 end) costo_jul_efe,
		sum(case when mes= 7 then prec_costo_cred else 0 end) costo_jul_cred,
		sum(case when mes= 8 then prec_costo_efec else 0 end) costo_ago_efe,
		sum(case when mes= 8 then prec_costo_cred else 0 end) costo_ago_cred,
		sum(case when mes= 9 then prec_costo_efec else 0 end) costo_set_efe,
		sum(case when mes= 9 then prec_costo_cred else 0 end) costo_set_cred,
		sum(case when mes= 10 then prec_costo_efec else 0 end) costo_oct_efe,
		sum(case when mes= 10 then prec_costo_cred else 0 end) costo_oct_cred,
		sum(case when mes= 11 then prec_costo_efec else 0 end) costo_nov_efe,
		sum(case when mes= 11 then prec_costo_cred else 0 end) costo_nov_cred,
		sum(case when mes= 12 then prec_costo_efec else 0 end) costo_dic_efe,
		sum(case when mes= 12 then prec_costo_cred else 0 end) costo_dic_cred,

		(select (select (select cod_lin_pro from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =Sql.codi_prod) )))) IDD,

		(select (select (select (select des_lin_pro from LINEA_FAMILIA_PRO L (nolock) 
						where l.cod_lin_pro in (select F.cod_lin_pro from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =Sql.codi_prod) )))))) Linea,

		(select (select (select desc_fami_prod from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =Sql.codi_prod) )))) Familia 
	from
		(SELECT  FACTURA_DETALLE.CODI_PROD,   
		 	 month(fech_fact) mes,
			 ( case when CODI_TIPO_PAGO=1 then FACTURA_DETALLE.CANT_ITEM else 0 end ) cant_item_efec,   
			 ( case when CODI_TIPO_PAGO<>1 then FACTURA_DETALLE.CANT_ITEM else 0 end ) cant_item_cred,   
		
			 round((case when CODI_TIPO_PAGO=1 then  FACTURA_DETALLE.CANT_ITEM *(FACTURA_DETALLE.PREC_ITEM * (CASE WHEN factura.codi_mone='01' THEN 1 ELSE factura.tcambio END)) else 0 end ),2 )  PREC_ITEM_efec,
			 round((case when CODI_TIPO_PAGO<>1 then  FACTURA_DETALLE.CANT_ITEM *(FACTURA_DETALLE.PREC_ITEM * (CASE WHEN factura.codi_mone='01' THEN 1 ELSE factura.tcambio END)) else 0 end ),2) PREC_ITEM_CRED,
		
			 round((case when CODI_TIPO_PAGO=1 then FACTURA_DETALLE.CANT_ITEM *(FACTURA_DETALLE.PREC_COSTO * (case when codi_imp=3 then 1 else 1 + factura_detalle.igv/100 end)) else 0 end ) ,2 )prec_costo_efec,
			 round((case when CODI_TIPO_PAGO<>1 then FACTURA_DETALLE.CANT_ITEM *(FACTURA_DETALLE.PREC_COSTO * (case when codi_imp=3 then 1 else 1 + factura_detalle.igv/100 end)) else 0 end ),2) prec_costo_cred,
			
			 FACTURA.CODI_ALMA
		FROM  FACTURA (nolock)
			join FACTURA_DETALLE (nolock)
		on FACTURA.codi_fact = FACTURA_DETALLE.codi_fact
		where --YEAR(FACTURA.FECH_FACT) =@ANIO and 
			cast(convert(char(10), factura.fech_fact,103) as datetime) between @f1 and @f2 and
			( ISNULL(FACTURA.ESTADO,'')<>'A') ) SQL
	group by  codi_prod
	order by 4, 3, 2


else
	select 	codi_prod, 
		 (select desc_pres from PRESENTACION PR (nolock) 
				where Pr.cod_pres in (select p.cod_pres from productos P (nolock) where P.codi_prod=SQL.codi_prod) ) desc_pres,   
		(select DESC_PROD from Productos P (nolock) where P.codi_prod =Sql.codi_prod) Desc_prod,   
		(select (select desc_sub_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =Sql.codi_prod) )) codi_sub_fami_prod ,
		sum(case when mes= 1 then cant_item_efec else 0 end) cant_ene_efe,
		sum(case when mes= 1 then cant_item_cred else 0 end) cant_ene_cred,
		sum(case when mes= 2 then cant_item_efec else 0 end) cant_feb_efe,
		sum(case when mes= 2 then cant_item_cred else 0 end) cant_feb_cred,
		sum(case when mes= 3 then cant_item_efec else 0 end) cant_mar_efe,
		sum(case when mes= 3 then cant_item_cred else 0 end) cant_mar_cred,
		sum(case when mes= 4 then cant_item_efec else 0 end) cant_abr_efe,
		sum(case when mes= 4 then cant_item_cred else 0 end) cant_abr_cred,
		sum(case when mes= 5 then cant_item_efec else 0 end) cant_may_efe,
		sum(case when mes= 5 then cant_item_cred else 0 end) cant_may_cred,
		sum(case when mes= 6 then cant_item_efec else 0 end) cant_jun_efe,
		sum(case when mes= 6 then cant_item_cred else 0 end) cant_jun_cred,
		sum(case when mes= 7 then cant_item_efec else 0 end) cant_jul_efe,
		sum(case when mes= 7 then cant_item_cred else 0 end) cant_jul_cred,
		sum(case when mes= 8 then cant_item_efec else 0 end) cant_ago_efe,
		sum(case when mes= 8 then cant_item_cred else 0 end) cant_ago_cred,
		sum(case when mes= 9 then cant_item_efec else 0 end) cant_set_efe,
		sum(case when mes= 9 then cant_item_cred else 0 end) cant_set_cred,
		sum(case when mes= 10 then cant_item_efec else 0 end) cant_oct_efe,
		sum(case when mes= 10 then cant_item_cred else 0 end) cant_oct_cred,
		sum(case when mes= 11 then cant_item_efec else 0 end) cant_nov_efe,
		sum(case when mes= 11 then cant_item_cred else 0 end) cant_nov_cred,
		sum(case when mes= 12 then cant_item_efec else 0 end) cant_dic_efe,
		sum(case when mes= 12 then cant_item_cred else 0 end) cant_dic_cred,
	
	
		sum(case when mes= 1 then PREC_ITEM_efec else 0 end) precio_ene_efe,
		sum(case when mes= 1 then PREC_ITEM_cred else 0 end) precio_ene_cred,
		sum(case when mes= 2 then PREC_ITEM_efec else 0 end) precio_feb_efe,
		sum(case when mes= 2 then PREC_ITEM_cred else 0 end) precio_feb_cred,
		sum(case when mes= 3 then PREC_ITEM_efec else 0 end) precio_mar_efe,
		sum(case when mes= 3 then PREC_ITEM_cred else 0 end) precio_mar_cred,
		sum(case when mes= 4 then PREC_ITEM_efec else 0 end) precio_abr_efe,
		sum(case when mes= 4 then PREC_ITEM_cred else 0 end) precio_abr_cred,
		sum(case when mes= 5 then PREC_ITEM_efec else 0 end) precio_may_efe,
		sum(case when mes= 5 then PREC_ITEM_cred else 0 end) precio_may_cred,
		sum(case when mes= 6 then PREC_ITEM_efec else 0 end) precio_jun_efe,
		sum(case when mes= 6 then PREC_ITEM_cred else 0 end) precio_jun_cred,
		sum(case when mes= 7 then PREC_ITEM_efec else 0 end) precio_jul_efe,
		sum(case when mes= 7 then PREC_ITEM_cred else 0 end) precio_jul_cred,
		sum(case when mes= 8 then PREC_ITEM_efec else 0 end) precio_ago_efe,
		sum(case when mes= 8 then PREC_ITEM_cred else 0 end) precio_ago_cred,
		sum(case when mes= 9 then PREC_ITEM_efec else 0 end) precio_set_efe,
		sum(case when mes= 9 then PREC_ITEM_cred else 0 end) precio_set_cred,
		sum(case when mes= 10 then PREC_ITEM_efec else 0 end) precio_oct_efe,
		sum(case when mes= 10 then PREC_ITEM_cred else 0 end) precio_oct_cred,
		sum(case when mes= 11 then PREC_ITEM_efec else 0 end) precio_nov_efe,
		sum(case when mes= 11 then PREC_ITEM_cred else 0 end) precio_nov_cred,
		sum(case when mes= 12 then PREC_ITEM_efec else 0 end) precio_dic_efe,
		sum(case when mes= 12 then PREC_ITEM_cred else 0 end) precio_dic_cred,
	
	
		sum(case when mes= 1 then prec_costo_efec else 0 end) costo_ene_efe,
		sum(case when mes= 1 then prec_costo_cred else 0 end) costo_ene_cred,
		sum(case when mes= 2 then prec_costo_efec else 0 end) costo_feb_efe,
		sum(case when mes= 2 then prec_costo_cred else 0 end) costo_feb_cred,
		sum(case when mes= 3 then prec_costo_efec else 0 end) costo_mar_efe,
		sum(case when mes= 3 then prec_costo_cred else 0 end) costo_mar_cred,
		sum(case when mes= 4 then prec_costo_efec else 0 end) costo_abr_efe,
		sum(case when mes= 4 then prec_costo_cred else 0 end) costo_abr_cred,
		sum(case when mes= 5 then prec_costo_efec else 0 end) costo_may_efe,
		sum(case when mes= 5 then prec_costo_cred else 0 end) costo_may_cred,
		sum(case when mes= 6 then prec_costo_efec else 0 end) costo_jun_efe,
		sum(case when mes= 6 then prec_costo_cred else 0 end) costo_jun_cred,
		sum(case when mes= 7 then prec_costo_efec else 0 end) costo_jul_efe,
		sum(case when mes= 7 then prec_costo_cred else 0 end) costo_jul_cred,
		sum(case when mes= 8 then prec_costo_efec else 0 end) costo_ago_efe,
		sum(case when mes= 8 then prec_costo_cred else 0 end) costo_ago_cred,
		sum(case when mes= 9 then prec_costo_efec else 0 end) costo_set_efe,
		sum(case when mes= 9 then prec_costo_cred else 0 end) costo_set_cred,
		sum(case when mes= 10 then prec_costo_efec else 0 end) costo_oct_efe,
		sum(case when mes= 10 then prec_costo_cred else 0 end) costo_oct_cred,
		sum(case when mes= 11 then prec_costo_efec else 0 end) costo_nov_efe,
		sum(case when mes= 11 then prec_costo_cred else 0 end) costo_nov_cred,
		sum(case when mes= 12 then prec_costo_efec else 0 end) costo_dic_efe,
		sum(case when mes= 12 then prec_costo_cred else 0 end) costo_dic_cred,

		(select (select (select cod_lin_pro from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =Sql.codi_prod) )))) IDD,

		(select (select (select (select des_lin_pro from LINEA_FAMILIA_PRO L (nolock) 
						where l.cod_lin_pro in (select F.cod_lin_pro from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =Sql.codi_prod) )))))) Linea,

		(select (select (select desc_fami_prod from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =Sql.codi_prod) )))) Familia 

	from
		(SELECT  FACTURA_DETALLE.CODI_PROD,   
		 	 month(fech_fact) mes,
			 ( case when CODI_TIPO_PAGO=1 then FACTURA_DETALLE.CANT_ITEM else 0 end ) cant_item_efec,   
			 ( case when CODI_TIPO_PAGO<>1 then FACTURA_DETALLE.CANT_ITEM else 0 end ) cant_item_cred,   
		
			 round((case when CODI_TIPO_PAGO=1 then  FACTURA_DETALLE.CANT_ITEM *(FACTURA_DETALLE.PREC_ITEM * (CASE WHEN factura.codi_mone='01' THEN 1 ELSE factura.tcambio END)) else 0 end ),2 )  PREC_ITEM_efec,
			 round((case when CODI_TIPO_PAGO<>1 then  FACTURA_DETALLE.CANT_ITEM *(FACTURA_DETALLE.PREC_ITEM * (CASE WHEN factura.codi_mone='01' THEN 1 ELSE factura.tcambio END)) else 0 end ),2) PREC_ITEM_CRED,
		
			 round((case when CODI_TIPO_PAGO=1 then FACTURA_DETALLE.CANT_ITEM *(FACTURA_DETALLE.PREC_COSTO * (case when codi_imp=3 then 1 else 1 + factura_detalle.igv/100 end)) else 0 end ) ,2 )prec_costo_efec,
			 round((case when CODI_TIPO_PAGO<>1 then FACTURA_DETALLE.CANT_ITEM *(FACTURA_DETALLE.PREC_COSTO * (case when codi_imp=3 then 1 else 1 + factura_detalle.igv/100 end)) else 0 end ),2) prec_costo_cred,
			
			 FACTURA.CODI_ALMA
		FROM  FACTURA (nolock)
			join FACTURA_DETALLE (nolock)
		on FACTURA.codi_fact = FACTURA_DETALLE.codi_fact 
		where factura.codi_alma=@alma and 
			--YEAR(FACTURA.FECH_FACT) =@ANIO and 
			cast(convert(char(10), factura.fech_fact,103) as datetime) between @f1 and @f2 and
			( ISNULL(FACTURA.ESTADO,'')<>'A') ) SQL
	group by  codi_prod
	order by 4, 3, 2
GO
