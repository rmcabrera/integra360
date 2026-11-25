CREATE PROCEDURE [dbo].[PA_PRODUCTOS_LISTA_PRECIOS]
	@tipo [char](1),
	@CODI_ALMA [char](2),
	@codi_prov [char](5)
WITH EXECUTE AS CALLER
AS
begin

if @tipo='1'  -- Mostramos los productos por almacen

begin	
	select prod.codi_prod , prod.desc_prod , prod.codi_mone , prod.esta_prod , pre.desc_pres , prod.prec_prov ,
		prod.descto_compra , prod.descto_porcenta , prod.cod_impuesto , prod.tcambio , ap.codi_alma , ap.prec_costo ,
		ap.prec_porc_uti_men , ap.prec_porc_uti_may , ap.prec_porc_uti_esp , 
		(select valor from valores_unitarios_anuales where codi_valo_unit=2 and esta_acti=1) igv , prod.nro_decim_precio ,
		a.nemo_alma suc  ,  cp.denominacion prov
	
	from productos prod left join presentacion pre on prod.cod_pres = pre.cod_pres
		left join almacen_producto ap on ap.codi_prod=prod.codi_prod 
		inner join almacen a on ap.codi_alma=a.codi_alma 
		left join cliente_proveedor cp on prod.codi_clie_prov=cp.codi_clie_prov

	where a.codi_alma=@codi_alma
end

else 
	-- Mostramos los productos por almacen y proveedor
begin	
	select prod.codi_prod , prod.desc_prod , prod.codi_mone , prod.esta_prod , pre.desc_pres , prod.prec_prov ,
		prod.descto_compra , prod.descto_porcenta , prod.cod_impuesto , prod.tcambio , ap.codi_alma , ap.prec_costo ,
		ap.prec_porc_uti_men , ap.prec_porc_uti_may , ap.prec_porc_uti_esp , 
		(select valor from valores_unitarios_anuales where codi_valo_unit=2 and esta_acti=1) igv , prod.nro_decim_precio ,
		a.nemo_alma suc ,  cp.denominacion prov
	
	from productos prod left join presentacion pre on prod.cod_pres = pre.cod_pres
		left join almacen_producto ap on ap.codi_prod=prod.codi_prod 
		inner join almacen a on ap.codi_alma=a.codi_alma 
		left join cliente_proveedor cp on prod.codi_clie_prov=cp.codi_clie_prov

	where a.codi_alma=@codi_alma and prod.codi_clie_prov=@codi_prov
end

end
GO
