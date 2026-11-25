CREATE PROCEDURE [dbo].[PA_Reporte_Facturas]
	@f1 [smalldatetime],
	@f2 [smalldatetime],
	@codi_tipo_docu [char](4),
	@codi_clie_prov [char](5) = null
WITH EXECUTE AS CALLER
AS
if @codi_clie_prov is not null
   begin
	Select 	F.serie_fact, F.nro_fact, F.fecha_fact, (Case when upper(CP.tipo_pers) = 'NATURAL'then CP.denominacion else CP.razo_soci end ) as  cliente,
		M.simbolo,F.valorventa,F.igv,F.total,F.nro_oc_clie, f.codi_tipo_docu, cp.ruc, (select ruc from empresa) as ruc_e, F.estado
	from facturas F	inner join Cliente_Proveedor 	CP on F.codi_clie 	= CP.codi_clie_prov
			inner join Monedas		M  on F.codi_mone	= M.codi_mone		
	Where   f.fecha_fact between @f1 and @f2  and f.estado <> 'E' and f.codi_tipo_docu = @codi_tipo_docu and f.codi_clie = @codi_clie_prov
	Order by f.codi_tipo_docu, f.serie_fact, f.nro_fact
   end
else
   begin
	Select 	F.serie_fact, F.nro_fact, F.fecha_fact, (Case when upper(CP.tipo_pers) = 'NATURAL'then CP.denominacion else CP.razo_soci end ) as  cliente,
		M.simbolo,F.valorventa,F.igv,F.total,F.nro_oc_clie, f.codi_tipo_docu, cp.ruc, (select ruc from empresa) as ruc_e, F.estado
	from facturas F	inner join Cliente_Proveedor 	CP on F.codi_clie 	= CP.codi_clie_prov
			inner join Monedas		M  on F.codi_mone	= M.codi_mone		
	Where f.fecha_fact between @f1 and @f2 and f.estado <> 'E' and f.codi_tipo_docu = @codi_tipo_docu
	Order by f.codi_tipo_docu, f.serie_fact, f.nro_fact
   end
GO
