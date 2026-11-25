CREATE PROCEDURE [dbo].[PA_Lista_Notas_Credito_Debito]
	@f1 [smalldatetime],
	@f2 [smalldatetime],
	@tipo [char](1)
WITH EXECUTE AS CALLER
AS
if @tipo = 'P'
   begin
	select codi_nota_cred 			as Codi, 
	       ser_nota_cred 			as serie,
	       cast(nro_nota_cred  as numeric)	as nro,
	       (select denominacion from cliente_proveedor cp where cp.codi_clie_prov = nc.codi_clie_prov) as deno,
	       (select ruc	    from cliente_proveedor cp where cp.codi_clie_prov = nc.codi_clie_prov) as ruc,
	       cast(convert(char(10),fech_nota_cred,103) as smalldatetime) as fecha,
		prec_vent,
		'CRED' as docu
	From nota_credito  nc
	where  (cast(convert(char(10),fech_nota_cred,103) as smalldatetime) between @f1 and @f2  )   and NOT contabilizado= '1'
	
	union
		
	select codi_nota_debi 			as Codi, 
	       ser_nota_debi 			as serie,
	       cast(nro_nota_debi  as numeric)	as nro,
	       (select denominacion from cliente_proveedor cp where cp.codi_clie_prov = nc.codi_clie_prov) as deno,
	       (select ruc	    from cliente_proveedor cp where cp.codi_clie_prov = nc.codi_clie_prov) as ruc,
	       cast(convert(char(10),fech_nota_debi,103) as smalldatetime) as fecha,
		prec_vent,
		'DEBI' as docu
	From nota_debito  nc
	where  (cast(convert(char(10),fech_nota_debi,103) as smalldatetime) between @f1 and @f2  )    and NOT contabilizado = '1'
   end

else

   begin
	select codi_nota_cred 			as Codi, 
	       ser_nota_cred 			as serie,
	       cast(nro_nota_cred  as numeric)	as nro,
	       (select denominacion from cliente_proveedor cp where cp.codi_clie_prov = nc.codi_clie_prov) as deno,
	       (select ruc	    from cliente_proveedor cp where cp.codi_clie_prov = nc.codi_clie_prov) as ruc,
	       cast(convert(char(10),fech_nota_cred,103) as smalldatetime) as fecha,
		prec_vent,
		'CRED' as docu
	From nota_credito  nc
	where  cast(convert(char(10),fech_nota_cred,103) as smalldatetime) between @f1 and @f2 
	
	union
		
	select codi_nota_debi 			as Codi, 
	       ser_nota_debi 			as serie,
	       cast(nro_nota_debi  as numeric)	as nro,
	       (select denominacion from cliente_proveedor cp where cp.codi_clie_prov = nc.codi_clie_prov) as deno,
	       (select ruc	    from cliente_proveedor cp where cp.codi_clie_prov = nc.codi_clie_prov) as ruc,
	       cast(convert(char(10),fech_nota_debi,103) as smalldatetime) as fecha,
		prec_vent,
		'DEBI' as docu
	From nota_debito  nc
	where  cast(convert(char(10),fech_nota_debi,103) as smalldatetime) between @f1 and @f2 
   end
GO
