CREATE PROCEDURE [dbo].[usp_reporte_productos_precio_variacion]
	@alma [char](2),
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @alma char(2), @f1 datetime, @f2 datetime
--select @alma ='', @f1 ='01/01/2024', @f2 ='31/12/2024'

set nocount on


select fecha,
		codi_alma, 
		(select nemo_alma from almacen A(nolock) where A.codi_alma=E.codi_alma) as sucursal,
		E.codi_prod,
		(select desc_prod from productos P(nolock) where P.codi_prod=E.codi_prod) as desc_prod,
		evento,
		(select simbolo from monedas M(nolock) where M.codi_mone in
			(select P.codi_mone from productos P(nolock) where P.codi_prod=E.codi_prod)) moneda,
		SUBSTRING( SUBSTRING(evento, 37, len(evento)) , 13 + len(dbo.f_producto(E.codi_prod)), len(SUBSTRING(evento, 37, len(evento))) ) variacion,
		(select upper(login) from usuarios U(nolock) where U.codi_usua=E.hecho_por) as hecho_por,
		(select desc_sub_fami_prod from sub_familia_producto S(nolock) where S.codi_sub_fami_prod=P.codi_sub_fami_prod) as sub_familia
		
from productos_eventos E(nolock)
join productos P(nolock)
on E.codi_prod=P.codi_prod
where cast(convert(char(10),fecha,103) as datetime) between @f1 and @f2
and (isnull(@alma,'')='' or codi_alma=@alma)
and tipo='M'
GO
