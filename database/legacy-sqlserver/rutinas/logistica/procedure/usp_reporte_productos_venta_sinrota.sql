CREATE PROCEDURE [dbo].[usp_reporte_productos_venta_sinrota]
	@F1 [datetime],
	@F2 [datetime],
	@alma [char](2),
	@tipo [char](1)
WITH EXECUTE AS CALLER
AS
--declare @alma char(2), @F1 datetime, @F2 datetime, @tipo char(1)
--select @alma ='00', @F1 ='01/01/2024', @F2 ='31/12/2024', @tipo='R'
--@tipo='0' no se usa, se agregó para mantener argumentos en w_repo_dias_sin_movi

set nocount on

select fecha, codi_prod, desc_prod, 
	(select (select desc_pres from presentacion X (nolock) where x.cod_pres=Pr.cod_pres)
				 from productos Pr (nolock) where Pr.codi_prod=PS.codi_prod) as presen,	
	codi_alma,
	(select nemo_alma from almacen A(nolock) where A.codi_alma=PS.codi_alma) as desc_alma,
	ultimaventa, plazo, diassinventa, observaciones,
	(select upper(login) from usuarios U(nolock) where U.codi_usua=PS.codi_usua) as hecho_por

from productos_sin_venta PS(nolock)
where cast(convert(char(10),fecha,103) as datetime) between @F1 and @F2
and (isnull(@alma,'00')='00' or codi_alma=@alma)
order by desc_prod, desc_alma
GO
