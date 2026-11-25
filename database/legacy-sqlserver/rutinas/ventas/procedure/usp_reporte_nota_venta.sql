CREATE PROCEDURE [dbo].[usp_reporte_nota_venta]
	@codi [int]
WITH EXECUTE AS CALLER
AS
--declare @codi int
--select @codi=1

set nocount on

select R.codi_nota_venta as codi_vale, nro_nota_venta as nro_vale, fecha,   
         dbo.f_cliente_proveedor(codi_clie_prov) cliente,   
	(select desc_tipo_medio_pago from tipo_pago T(nolock) where T.codi_tipo_medio_pago=R.codi_tipo_pago) tipo_pago, 
	(select simbolo from monedas M(nolock) where M.codi_mone = R.codi_mone) mone,   
	 tcambio, (case when tipo_credito=1 then 'Campaña' 
			else (case when tipo_credito=2 then 'Rotativo' 
			else (case when tipo_credito=3 then 'Moroso' else 'Especial' end) end) end) tipo_credito,
	(select desc_imp from tipo_impuestos I(nolock) where I.cod_imp=R.cod_imp) condicion,   
	(select isnull(apel_1,'') + ' ' + ISNULL(apel_2,'' )  + ' ' + ISNULL(nomb_1, '') + ' ' + ISNULL(nomb_2, '') 
	 from usuarios U (nolock) where U.codi_usua=R.codi_usua) usuario,
	(select isnull(apel_1,'')+ isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'')  + isnull(' ' + nomb_2,'') 
	 from usuarios X(nolock) where X.codi_usua=R.cod_usua_recetista and X.codi_carg='0501') usuario_ing,
	codi_prod, cantidad, desc_item, prec_lista, round(cantidad * prec_item,2) as 'total',
	(case when codi_imp =1 then 'A'else 'E' end) as 'C'
from NOTA_VENTA R(nolock)
join NOTA_VENTA_DETALLE D(nolock)
on R.codi_nota_venta = D.codi_nota_venta
where R.codi_nota_venta=@codi
GO
