CREATE PROCEDURE [dbo].[usp_repo_vale_pendientes]
	@codi_alma [char](2),
	@tipo [char](1),
	@F1 [datetime],
	@F2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @codi_alma char(2), @tipo char(1), @F1 datetime, @F2 datetime
--select @codi_alma='19', @tipo='R', @F1='01/08/2015', @F2='30/09/2015'  

set nocount on

if @tipo='C'
begin
	select codi_prod, max(producto) producto,sum(cantidad) cantidad, 
		codi_clie_prov, max(proveedor) proveedor ,max(tipo_pago) tipo_pago, anio, prec_lista, 
		codi_vale, max(fecha) fecha, max(nro_vale) nro_vale, max(impo_item) impo_item, max(linea) linea
	from   
	(  
	select codi_prod,  year(fecha) as anio,
		(isnull((select desc_prod from productos where codi_prod=d.codi_prod),desc_item)) producto ,  
		(cantidad), c.codi_clie_prov, 
	(select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
	from cliente_proveedor cp(nolock) where cp.codi_clie_prov=c.codi_clie_prov) proveedor,
	(select desc_tipo_medio_pago from tipo_pago where tipo_pago.codi_tipo_medio_pago=c.codi_tipo_pago)tipo_pago, 
	prec_lista, c.codi_vale, fecha, nro_vale, id_sec, impo_item,
	(select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where L.cod_lin_pro in
		(select cod_lin_pro from FAMILIA_PRODUCTO FP(nolock) where FP.codi_fami_prod in 
			(select codi_fami_prod from SUB_FAMILIA_PRODUCTO SF(nolock) where SF.codi_sub_fami_prod in
				(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=D.codi_prod) )	) ) linea

	from registro_vale c  (nolock) left join registro_vale_detalle d (nolock) on d.codi_vale=c.codi_vale   
	where (cast(convert(char(10),fecha,103) as datetime) between @F1 and @F2) and c.codi_alma=@codi_alma 
	      and (codi_fact is null or codi_fact='') and isnull(c.estado,'')<>'N' ) SQL  
	group by codi_vale, id_sec, codi_clie_prov, codi_prod, tipo_pago , anio, prec_lista
end

if @tipo='T'
begin
	select codi_prod, max(producto) producto,sum(cantidad) cantidad, 
		codi_clie_prov, max(proveedor) proveedor ,max(tipo_pago) tipo_pago, anio, prec_lista, 
		codi_vale, max(fecha) fecha, max(nro_vale) nro_vale, max(impo_item) impo_item, max(linea) linea
	from   
	(  
	select codi_prod,  year(fecha) as anio,
		(isnull((select desc_prod from productos where codi_prod=d.codi_prod),desc_item)) producto ,  
		(cantidad), c.codi_clie_prov, 
	(select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
	from cliente_proveedor cp(nolock) where cp.codi_clie_prov=c.codi_clie_prov) proveedor,
	(select desc_tipo_medio_pago from tipo_pago where tipo_pago.codi_tipo_medio_pago=c.codi_tipo_pago)tipo_pago, 
	prec_lista, c.codi_vale, fecha, nro_vale, id_sec, impo_item,
	(select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where L.cod_lin_pro in
		(select cod_lin_pro from FAMILIA_PRODUCTO FP(nolock) where FP.codi_fami_prod in 
			(select codi_fami_prod from SUB_FAMILIA_PRODUCTO SF(nolock) where SF.codi_sub_fami_prod in
				(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=D.codi_prod) )	) ) linea

	from registro_vale c  (nolock) left join registro_vale_detalle d (nolock) on d.codi_vale=c.codi_vale   
	where (cast(convert(char(10),fecha,103) as datetime) between @F1 and @F2) and c.codi_alma=@codi_alma 
	      /*and (codi_fact is null or codi_fact='')*/ and isnull(c.estado,'')<>'N' ) SQL  
	group by codi_vale, id_sec, codi_clie_prov, codi_prod, tipo_pago , anio, prec_lista
end

if @tipo='P'
begin

	select codi_prod,producto,sum(cantidad) cantidad, max(codi_clie_prov) codi_clie_prov, max(proveedor) proveedor, 
		max(tipo_pago)tipo_pago , anio, 
	       prec_lista, codi_vale, max(fecha) fecha, max(nro_vale) nro_vale, max(impo_item) impo_item,
	       max(linea) linea
	from   
	(  
	select codi_prod,  year(fecha) as anio, c.codi_clie_prov,
		(isnull((select desc_prod from productos where codi_prod=d.codi_prod), desc_item)) producto ,  
		(cantidad), (select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
		from cliente_proveedor cp(nolock) where cp.codi_clie_prov=c.codi_clie_prov) proveedor,
		(select desc_tipo_medio_pago from tipo_pago where tipo_pago.codi_tipo_medio_pago=c.codi_tipo_pago)tipo_pago, 
	prec_lista, c.codi_vale, fecha, nro_vale, id_sec, impo_item,
	(select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where L.cod_lin_pro in
		(select cod_lin_pro from FAMILIA_PRODUCTO FP(nolock) where FP.codi_fami_prod in 
			(select codi_fami_prod from SUB_FAMILIA_PRODUCTO SF(nolock) where SF.codi_sub_fami_prod in
				(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=D.codi_prod) )	) ) linea

	from registro_vale c  (nolock) join registro_vale_detalle d (nolock) on d.codi_vale=c.codi_vale   
	where (cast(convert(char(10),fecha,103) as datetime) between @F1 and @F2) and c.codi_alma=@codi_alma 
	      and (codi_fact is null or codi_fact='') and isnull(c.estado,'')<>'N' ) SQL  
	group by codi_vale, id_Sec, codi_prod, producto, anio, prec_lista
end

if @tipo='R'
begin

	select codi_prod, producto,sum(cantidad) cantidad, 
		'' codi_clie_prov, '' proveedor, 
		max(tipo_pago) tipo_pago , anio, 
	       prec_lista, null codi_vale, 
	       cast(convert(char(10),fecha,103) as datetime) as fecha, null nro_vale, max(impo_item) impo_item,
	       max(linea) linea
	from   
	(  
	select codi_prod,  year(fecha) as anio, c.codi_clie_prov,
		(isnull((select desc_prod from productos where codi_prod=d.codi_prod), desc_item)) producto ,  
		(cantidad), (select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
		from cliente_proveedor cp(nolock) where cp.codi_clie_prov=c.codi_clie_prov) proveedor,
		(select desc_tipo_medio_pago from tipo_pago where tipo_pago.codi_tipo_medio_pago=c.codi_tipo_pago)tipo_pago, 
	prec_lista, c.codi_vale,
	cast( convert(char(10),fecha,103) as datetime) as fecha, 
	nro_vale, id_sec, impo_item,
	(select des_lin_pro from LINEA_FAMILIA_PRO L(nolock) where L.cod_lin_pro in
		(select cod_lin_pro from FAMILIA_PRODUCTO FP(nolock) where FP.codi_fami_prod in 
			(select codi_fami_prod from SUB_FAMILIA_PRODUCTO SF(nolock) where SF.codi_sub_fami_prod in
				(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=D.codi_prod) )	) ) linea

	from registro_vale c  (nolock) join registro_vale_detalle d (nolock) on d.codi_vale=c.codi_vale   
	where (cast(convert(char(10),fecha,103) as datetime) between @F1 and @F2) and c.codi_alma=@codi_alma 
	      and (codi_fact is null or codi_fact='') and isnull(c.estado,'')<>'N' ) SQL  
	group by cast(convert(char(10),fecha,103) as datetime), codi_prod, producto, anio, prec_lista
	order by 1
end
GO
