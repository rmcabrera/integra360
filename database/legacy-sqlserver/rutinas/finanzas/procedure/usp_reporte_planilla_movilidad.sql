CREATE PROCEDURE [dbo].[usp_reporte_planilla_movilidad]
	@Anio [int],
	@mes [int],
	@tipo [char](1),
	@F1 [datetime],
	@F2 [datetime],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @Anio int, @mes int, @tipo char(1), @F1 datetime, @F2 datetime, @codi_alma char(2)
--select @anio=2015, @mes=1, @tipo='F', @F1='01/01/2015', @F2='30/01/2015', @codi_alma=''

set nocount on

if @tipo='M' 
begin
	select fecha, C.codi_clie_prov, 
			(select case when left(tipo_pers,1)='N' then apel_1+ isnull(' ' +apel_2,'')+ 
					isnull( ' ' +nomb_1,'') + isnull( ' ' +nomb_2, '') else
				isnull(razo_Soci, denominacion) end from cliente_proveedor X (nolock) where x.codi_Clie_prov=C.codi_clie_prov) Nombres,
			(select ruc from cliente_proveedor X (nolock) where x.codi_Clie_prov=C.codi_clie_prov) dni ,
		 ruta_de, ruta_a, glosa, importe, '' firma,
			(select razon_Social from empresa (nolock)) Empresa,
			(select ruc from empresa (nolock)) ruc ,
			(select direccion from empresa (nolock)) direccion
	from caja_chica C (nolock)
	join cliente_proveedor CP(nolock)
	on C.codi_clie_prov = CP.codi_clie_prov
	where (year(fecha)=@anio and month(fecha)=@mes ) and left(tipo_pers,1)='N' --and codi_tipo_docu='0000'
	and (isnull(@codi_alma,'')='' or codi_alma=@codi_alma) and tipo_contab in (126,156)
	order by fecha 
end
else
begin
	select fecha, C.codi_clie_prov, 
			(select case when left(tipo_pers,1)='N' then apel_1+ isnull(' ' +apel_2,'')+ 
					isnull( ' ' +nomb_1,'') + isnull( ' ' +nomb_2, '') else
				isnull(razo_Soci, denominacion) end from cliente_proveedor X (nolock) where x.codi_Clie_prov=C.codi_clie_prov) Nombres,
			(select ruc from cliente_proveedor X (nolock) where x.codi_Clie_prov=C.codi_clie_prov) dni ,
		 ruta_de, ruta_a, glosa, importe, '' firma,
			(select razon_Social from empresa (nolock)) Empresa,
			(select ruc from empresa (nolock)) ruc ,
			(select direccion from empresa (nolock)) direccion
	from caja_chica C (nolock)
	join cliente_proveedor CP(nolock)
	on C.codi_clie_prov = CP.codi_clie_prov
	where (cast(convert(char(10),fecha,103) as datetime) between @F1 and @F2 ) and left(tipo_pers,1)='N' --and codi_tipo_docu='0000'
	and (isnull(@codi_alma,'')='' or codi_alma=@codi_alma) and tipo_contab in (126,156)
	order by fecha 
end
GO
