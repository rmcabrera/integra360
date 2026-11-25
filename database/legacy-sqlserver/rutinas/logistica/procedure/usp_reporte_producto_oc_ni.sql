CREATE PROCEDURE [dbo].[usp_reporte_producto_oc_ni]
	@F1 [datetime],
	@F2 [datetime],
	@prod [char](8)
WITH EXECUTE AS CALLER
AS
--declare @F1 datetime, @F2 datetime, @prod char(8)
--select @F1='01/01/2022', @F2='01/08/2022', @prod='00081595'

set nocount on

select nro_orde_comp, max(fecha) as fecha, max(codi_clie_prov) as codi_clie_prov,
	max(proveedor) as proveedor, max(ruc) as ruc, max(codi_prod) as codi_prod, 
	max(producto) as producto, max(precio) as precio, max(precio_igv) as precio_igv,
	max(razon_empr) as razon_empr, max(ruc_empr) as ruc_empr, nro_nota_ingr, fech_nota_ingr,
	max(precio_NI) as precio_NI, max(precio_igv_NI) as precio_igv_NI, sum(cantidad) cantidad,
	sum(cantidad_NI) cantidad_NI
from 
(
select nro_orde_comp, fecha, a.codi_clie_prov,
	(select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
	from cliente_proveedor c(nolock) where c.codi_clie_prov=a.codi_clie_prov) proveedor,
	(select ruc from cliente_proveedor c(nolock) where c.codi_clie_prov=a.codi_clie_prov) as ruc,
	b.codi_prod, (select desc_prod from productos p(nolock) where p.codi_prod=b.codi_prod) producto,
	
	case when upper(desc_cond_pago) like '%BONIFICA%' then 0 else
		case when afec_rete=1 then 
			(case when a.valo_vent=1 then round(precio,4) else round(precio,4) end) else	round(prec_orig,4) end end as precio,

	--round( precio / (1 + dbo.f_igv(fecha)/100.00),4) as precio,
	--round(precio,4) as precio_igv,
	
	case when upper(desc_cond_pago) like '%BONIFICA%' then 0 else
		case when afec_rete=1 then
			(case when a.valo_vent=1 then round(prec_orig,4) else round(precio * (1 + dbo.f_igv(fecha)/100.00),4) end) 
		else round(prec_orig,4) end end as precio_IGV,

	(select top 1 razon_social from Empresa (nolock) ) razon_empr,
	(select ruc from Empresa (nolock) ) ruc_empr,
	nro_nota_ingr, fech_nota_ingr,	
	/*round( prec_unit / (1 + dbo.f_igv(fech_nota_ingr)/100.00),4)*/ 0.00 as precio_NI,
    round(prec_unit,4) /*0.00*/ as precio_igv_NI, b.cantidad, x.cantidad as cantidad_NI

from orden_de_compra a (nolock)
join detalle_orden_compra b(nolock)
on a.codi_orde_comp = b.codi_orde_comp
left join detalle_nota_ingreso x(nolock)
on a.codi_orde_comp = left(x.codi_deta_orde_comp,10)
join nota_ingreso z(nolock)
on x.codi_nota_ingr = z.codi_nota_ingr and b.codi_prod=x.codi_prod
where cast(convert(char(10),fecha,103) as datetime) between @F1 and @F2
and (isnull(@prod,'')='' or x.codi_prod=@prod) 

/*union all

select null nro_orde_comp, fech_nota_ingr, codi_clie_prov, 
       (select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
	from cliente_proveedor c(nolock) where c.codi_clie_prov=a.codi_clie_prov) proveedor, null ruc, 
       null codi_prod, null producto,
       round( prec_unit / (1 + dbo.f_igv(fech_nota_ingr)/100.00),4) as precio,
       round(prec_unit,4) as precio_igv,
       (select top 1 razon_social from Empresa (nolock) ) razon_empr,
       (select ruc from Empresa (nolock) ) ruc_empr,
       nro_nota_ingr, fech_nota_ingr,	
       round( prec_unit / (1 + dbo.f_igv(fech_nota_ingr)/100.00),4) as precio_NI,
       round(prec_unit,4) as precio_igv_NI, cantidad

from nota_ingreso a(nolock)
join detalle_nota_ingreso b(nolock)
on a.codi_nota_ingr=b.codi_nota_ingr
where cast(convert(char(10),fech_nota_ingr,103) as datetime) between @F1 and @F2
and isnull(codi_deta_orde_comp,'')='' and (isnull(@prod,'')='' or b.codi_prod=@prod)*/) as SQL
group by nro_orde_comp, nro_nota_ingr, fech_nota_ingr
order by cast(SQL.nro_orde_comp as numeric)--, cast(SQL.nro_nota_ingr as numeric)
GO
