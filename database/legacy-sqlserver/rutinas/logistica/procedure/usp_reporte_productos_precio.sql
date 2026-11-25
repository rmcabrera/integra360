CREATE PROCEDURE [dbo].[usp_reporte_productos_precio]
	@F1 [datetime],
	@F2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @F1 datetime, @F2 datetime, @alma char(2)
--select @F1='01/01/2010', @F2='30/04/2015', @alma='01'

set nocount on

select distinct A.codi_nota_ingr, B.codi_prod, C.desc_prod,
		(select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
		from cliente_proveedor cp(nolock) where cp.codi_clie_prov in 
			(select codi_clie_prov from productos P(nolock) where P.codi_prod = B.codi_prod)) laboratorio,	
		(select desc_sub_fami_prod from sub_familia_producto sf(nolock) where sf.codi_sub_fami_prod in
			(select s.codi_sub_fami_prod from sub_familia_producto s(nolock) where s.codi_sub_fami_prod = C.codi_sub_fami_prod)) subfamilia,
		convert(char(10),fech_nota_ingr,103) fech_nota_ingr, prec_unit, A.codi_alma, 
		(select nemo_alma from almacen M(nolock) where M.codi_alma = A.codi_alma) almacen
		/*, cantidad, 
		A.nro_nota_ingr, prec_compra,
		isnull((case when isnull(peso,0)<>0 then ((select top 1 precio from orden_de_compra g(nolock)
			join detalle_orden_compra gd(nolock)on g.codi_orde_comp = gd.codi_orde_comp
				where cast(convert(char(10),fecha,103) as datetime) <= cast(convert(char(10),fech_nota_ingr ,103) as datetime)
				and GD.codi_prod=B.codi_prod order by fecha desc)/ peso ) * 1000.00 else 0 end),0) precio_TN
				*/
from nota_ingreso A(nolock)
join detalle_nota_ingreso B(nolock) 
on A.codi_nota_ingr = B.codi_nota_ingr
join productos C(nolock)
on B.codi_prod = C.codi_prod
where (cast(convert(char(10),fech_nota_ingr,103) as datetime) between @F1 and @F2) 
and A.codi_alma=@alma and A.tipo_nota_ingr='01' --and B.codi_prod='00080660' 
order by A.codi_nota_ingr desc, C.desc_prod, laboratorio, subfamilia, fech_nota_ingr
GO
