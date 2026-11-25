CREATE PROCEDURE [dbo].[usp_reporte_recomenda_agri]
	@F1 [datetime],
	@F2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @F1 datetime , @F2 datetime, @alma char(2)
--select @F1 = '12/03/2017', @F2 = '12/12/2017', @alma=''

set nocount on

declare @Tx table(codi_rec numeric(18,0) null, nro_rec numeric(18,0) null, fecha datetime null, codi_usua char(5) null, 
		responsable varchar(200) null, codi_prod char(8) null, producto varchar(200) null, prec_espe numeric(18,2) null, 
                dosis_cant numeric(18,2) null, dosis varchar(50) null, codi_clie char(5) null, sub_fami char(5) null,
				unidad  numeric(12,3) null, total numeric(12,2) null )

insert @TX
select r.codi_rec, r.nro_rec, fecha, c.codi_usua, 
       (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') 
       from usuarios u(nolock) where u.codi_usua = c.codi_usua) as responsable,
       codi_prod, dbo.f_producto(codi_prod) producto, prec_espe, dosis_cant, dosis,	
       (select codi_clie_prov from productos p(nolock) where p.codi_prod = d.codi_prod) as codi_clie,
       (select codi_sub_fami_prod from productos p(nolock) where p.codi_prod = d.codi_prod) as sub_fami,
	   cant_unidad, total_val
from captacion_visita c(nolock)
join recomendacion r(nolock)
on c.codi_rec = r.nro_rec
join recomendacion_deta d(nolock)
on r.codi_rec = d.codi_rec
where (fecha between @F1 and @F2) and (isnull(@alma,'')='' or codi_alma=@alma)
--where c.codi_capta=18310

select max(codi_rec) codi_rec, max(nro_rec) nro_rec, max(fecha) fecha, codi_usua, max(upper(responsable)) as responsable, 
	codi_prod, max(producto) producto, sum(prec_espe) prec_espe, sum(dosis_cant) dosis_cant, max(dosis) dosis, 
	(select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
	 from cliente_proveedor c(nolock) where c.codi_clie_prov = max(codi_clie)) as laboratorio, 
	(select desc_sub_fami_prod from sub_familia_producto (nolock) where codi_sub_fami_prod = max(sub_fami)) as sub_familia,
	sum(unidad) as unidad , sum(total) as total
from @Tx
group by codi_usua, codi_prod
order by responsable, fecha
GO
