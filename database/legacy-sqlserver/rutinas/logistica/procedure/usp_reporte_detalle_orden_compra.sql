CREATE PROCEDURE [dbo].[usp_reporte_detalle_orden_compra]
	@tipo [char](1),
	@F1 [datetime],
	@F2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @tipo char(1), @F1 datetime, @F2 datetime
--select @tipo='F', @F1='01/05/2018', @F2='30/09/2019'

set nocount on

select fecha, nro_orde_comp, ltrim(dbo.f_cliente_proveedor(codi_clie_prov)) as cliente, cantidad, 
	   (select simb_unid_medi from unidad_medida U(nolock) where U.codi_unid_medi in 
			(select codi_unid_medi from productos P(nolock) where P.codi_prod=B.codi_prod)) unid_medi,
	   (select case when cod_impuesto=1 then 'AFECTO'
				    when cod_impuesto=2 then 'ARANCEL' else 'EXONERADO' end
	   from productos P(nolock) where P.codi_prod=B.codi_prod) impuesto,
	   codi_prod, ltrim(dbo.f_producto(codi_prod)) as producto,
	   precio, round(round(precio,4) * round(cantidad,4),4) total,
	   
	   (select des_lin_pro from linea_familia_pro L(nolock) where L.cod_lin_pro in
			(select cod_lin_pro from familia_producto F(nolock) where F.codi_fami_prod in		
				(select S.codi_fami_prod from sub_familia_producto S(nolock) where S.codi_sub_fami_prod in	
					(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=B.codi_prod)))) linea
	   
from orden_de_compra A(nolock)
join detalle_orden_compra B(nolock)
on A.codi_orde_comp=B.codi_orde_comp
where convert(char(10),fecha,103) between @F1 and @F2
--and nro_orde_comp='6806'
order by codi_deta_orde_comp
GO
