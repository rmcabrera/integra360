CREATE PROCEDURE [dbo].[usp_listar_facturas_vs_provision]
	@anio [int],
	@ms [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio int , @ms char(2)
--select @anio =2008 , @ms ='08'
set nocount on

Declare @TempoF table (codi_clie_prov char(5), codi_doc char(4) null, 
	serie char(5) null,numero char(10) null, cliente varchar(250) null, fecha datetime, codi_alma varchar(25) null ) 
Declare @TempoP table (codi_clie_prov char(5), codi_doc char(4) null, serie char(5) null,
	numero char(10) null, cliente varchar(250) null, fecha datetime, codi_alma varchar(25) null ) 

insert @TempoF
select distinct codi_clie_prov, codi_tipo_docu, cast(ser_fact as numeric), nro_fact ,
	(select isnull(razo_soci,denominacion) from dbo.cliente_proveedor C (nolock) where C.codi_clie_prov=Factura.codi_clie_prov),
	fech_fact, (select nemo_alma from dbo.almacen A (nolock) where A.codi_alma=Factura.codi_alma)
from dbo.factura (nolock) where year(fech_fact)=@anio and month(fech_fact)=@ms

insert @TempoP
select distinct codi_clie_prov, codi_tipo_docu, cast(serie as numeric), nro_docu ,
	(select isnull(razo_soci,denominacion) from dbo.cliente_proveedor C (nolock) where C.codi_clie_prov=movi_contables.codi_clie_prov),
	fecha, (select nemo_alma from dbo.almacen A (nolock) where A.codi_alma=movi_contables.codi_alma)
from dbo.movi_contables (nolock) where anio=@anio and mes=@ms and subdia='V' 


select 1 IDD ,codi_clie_prov,  codi_doc, serie, numero , cliente, fecha,codi_alma
from @TempoF A
where not exists (select * from @TempoP B 
		where B.codi_clie_prov=A.codi_clie_prov and 
		      B.codi_doc=A.codi_doc and B.serie=A.serie and 
		      B.numero=A.numero)
union all
select 2 IDD,codi_clie_prov, codi_doc, serie, numero, cliente, fecha,codi_alma
from @TempoP A
where not exists (select * from @TempoF B 
		where B.codi_clie_prov=A.codi_clie_prov and 
		      B.codi_doc=A.codi_doc and B.serie=A.serie and 
		      B.numero=A.numero)
GO
