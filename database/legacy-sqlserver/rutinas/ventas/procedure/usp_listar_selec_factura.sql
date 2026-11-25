CREATE PROCEDURE [dbo].[usp_listar_selec_factura]
	@fecha [datetime],
	@almacen [char](2),
	@cliente [char](5)
WITH EXECUTE AS CALLER
AS
--declare @fecha datetime , @almacen char(2) , @cliente char(5)
--select @fecha ='18/04/2018', @almacen='05' , @cliente ='06457'

set nocount on 

declare @Tempo table(tipo char(1), codigo char(10) , codi_alma char(2), denominacion varchar(200) null, fecha datetime null,
		codi_docu char(4) collate SQL_Latin1_General_CP1_CI_AS null, serie varchar(5) null , numero varchar(8) null, 
		moneda char(2) collate SQL_Latin1_General_CP1_CI_AS null, monto numeric(12,2) null )

insert @Tempo
select 	'F' tipo, F.codi_fact, codi_alma, 
	(select denominacion from dbo.cliente_proveedor C (nolock) where C.codi_clie_prov=F.codi_clie_prov) Denominacion, 
	fech_fact, 
	codi_tipo_docu,
	(case when isnumeric(ser_fact)=1 then cast(cast(ser_fact as numeric(18)) as varchar(50)) else ser_fact end) serie, 
	cast(nro_fact as int) nro, codi_mone, 
	tota_fact - 
	isnull((select sum(c.prec_vent)
	from dbo.nota_credito C(nolock) 
	where C.codi_fact=F.codi_fact and codi_tipo_pago='4' and isnull(F.estado,'')<>'A' 
	and fech_nota_cred<DATEADD(day, 1,@fecha) and C.codi_alma=F.codi_alma and C.codi_clie_prov=F.codi_clie_prov),0)
	
from dbo.factura f (nolock)
where 	f.codi_alma=@almacen and
	f.codi_clie_prov = @cliente and
	f.fech_fact<DATEADD(day, 1, @fecha) and 
	f.codi_tipo_pago='4' and 
	isnull(f.estado,'')<>'A' --and NRO_FACT='12677'
union all
select 'R', nro_recibo, codi_alma, 
	(select denominacion from dbo.cliente_proveedor C (nolock) where C.codi_clie_prov=CJ.codi_clie_prov) Denominacion, 
	fecha, codi_tipo_docu,
	(case when isnumeric(serie)=1 then cast(cast(serie as numeric(18)) as varchar(50)) else serie end), 
	cast(nro_docu as int), codi_mone, 
	(-1 * importe ) imp
from dbo.caja_chica CJ (nolock)
where CJ.codi_alma=@almacen and 
      tipo_io=1 and 
      Cj.codi_tipo_docu is not null and 
      Cj.fecha<DATEADD(day, 1, @fecha) and 
      Cj.codi_clie_prov = @cliente --and isnumeric(serie)=1

select  B.codigo, @Cliente Codi_clie_prov, B.denominacion, B.codi_alma, B.fecha, 
	A.codi_docu, A.serie, A.numero, A.moneda, A.Monto,
	(select simbolo from dbo.monedas M (nolock)  where M.codi_mone = A.moneda ) Simbolo,
	(select desc_tipo_docu from dbo.tipo_documento (nolock) where codi_tipo_docu = A.codi_docu) Tipo_documento,
	'0' estado, 0.00 Asignar	
from 
(select  codi_docu, serie,numero,moneda, sum(monto) Monto
	from @Tempo T
	group by codi_docu, serie,numero,moneda
	having sum(monto)<>0 ) A 
join (select codigo, codi_alma, denominacion, fecha, codi_docu, serie,numero, moneda
	 from @Tempo A where A.tipo='F') B
on A.codi_docu =B.codi_docu and A.serie = B.serie and a.numero=B.numero and A.moneda=B.moneda
GO
