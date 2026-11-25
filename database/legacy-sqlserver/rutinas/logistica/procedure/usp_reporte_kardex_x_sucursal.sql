CREATE PROCEDURE [dbo].[usp_reporte_kardex_x_sucursal]
	@anio [char](4),
	@F1 [datetime],
	@F2 [datetime],
	@lab [char](5),
	@subfam [char](5),
	@fam [char](2),
	@linea [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @F1 datetime, @F2 datetime, @lab char(5), @subfam char(5), @fam char(2), @linea char(2)
--select @anio='2016', @F1='01/04/2016', @F2='22/04/2016', @lab='05690', @subfam=null, @fam=null, @linea=null

set nocount on

declare @Tx table(codi_alma char(2) null, almacen varchar(50) null, codi_prod char(8) null, descripcion varchar(150) null,
                  stock numeric(18,2) null, lab char(5) null, subfam char(4) null, fam char(2) null, linea char(2) null)

insert @Tx
select k.codi_alma, (select nemo_alma from almacen a(nolock) where a.codi_alma=k.codi_alma) almacen, 
       k.codi_prod, max(rtrim(ltrim(desc_prod))) descripcion,
       isnull(sum(cant_ingr - cant_sali ),0) /*- 
       isnull((select sum(cantidad) 
			from registro_vale_detalle d (nolock) join registro_vale c (nolock)  on c.codi_vale=d.codi_vale
			where D.codi_alma=K.codi_alma and D.CODI_PROD=K.codi_prod and (codi_fact is null or codi_fact='') and isnull(c.estado,'')<>'N'),0)*/ as stock,
       max(p.codi_clie_prov) codi_clie_lab, 
       max(p.codi_sub_fami_prod) codi_sub_fami_prod,
       (select codi_fami_prod from sub_familia_producto s(nolock) where s.codi_sub_fami_prod=max(p.codi_sub_fami_prod)) codi_fami_prod,	
	(select cod_lin_pro from familia_producto f(nolock) where f.codi_fami_prod in	
		(select codi_fami_prod from sub_familia_producto s(nolock) where s.codi_sub_fami_prod=max(p.codi_sub_fami_prod))) codi_lin_prod
from kardex k (nolock)
join productos p(nolock)
on k.codi_prod = p.codi_prod
where year(fech_tran)=@anio and cast(convert(char(10),fech_tran,103) as datetime) /*between @F1 and*/<= @F2 --and p.codi_prod='00010003'
		--and k.codi_prod=00081148
group by k.codi_alma, k.codi_prod
order by 1, 2

/*
select D.codi_alma,codi_prod, sum(cantidad) cantidad_descontar
	from registro_vale_detalle d (nolock) join registro_vale c (nolock)  on c.codi_vale=d.codi_vale
	where (codi_fact is null or codi_fact='') and isnull(c.estado,'')<>'N' and codi_prod=81148
	group by D.codi_alma, codi_prod
*/	
select codi_alma +' - '+ almacen sucursal, codi_prod, descripcion, stock, 
	lab, dbo.f_cliente_proveedor(lab) laboratorio,
	subfam, (select desc_sub_fami_prod from sub_familia_producto s(nolock) where s.codi_sub_fami_prod=subfam) sub_familia,
	fam, (select desc_fami_prod from familia_producto f(nolock) where f.codi_fami_prod=fam) familia,
	linea, (select des_lin_pro from linea_familia_pro L(nolock) where L.cod_lin_pro=linea) linea
from @Tx
where (lab=@lab or @lab is null) and (subfam=@subfam or @subfam is null) 
and (fam=@fam or @fam is null) and (linea=@linea or @linea is null)
GO
