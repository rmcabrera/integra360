CREATE PROCEDURE [dbo].[usp_detalle_oc_vs_ni]
	@alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @alma char(2) , @fec1 datetime , @fec2 datetime , @prod char(8)
--select @alma ='01' , @fec1='01/01/2009' , @fec2='31/05/2010', @prod='00011103'

set nocount on

declare @Tx table (codi char(10), nro numeric(12), cliente char(5) null, fecha datetime null, codi_mone char(2) null,	
			total numeric(12,2) null, codi_deta char(12) null, codi_prod char(8) null,
			cantidad numeric(12,4) null, precio numeric(12,4) null, atendido numeric(12,4) null,
			prec_ing numeric(12,4) null , docu varchar(20) null, nrodocu varchar(20) null, fechafact datetime null,
			nro_ingr numeric(12) null, fech_ingr datetime null)

insert @Tx
select O.codi_orde_comp, nro_orde_comp, codi_clie_prov, fecha, O.codi_mone, total, 
	D.codi_Deta_orde_comp, D.codi_prod, D.cantidad, D.precio,
	X.cantidad Atendido,
	x.prec_unit,
	(select desc_tipo_docu from tipo_documento T (nolock)
		where codi_tipo_docu in (select codi_tipo_docu_cont from nota_ingreso N (nolock) where N.codi_nota_ingr COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS=x.codi_nota_ingr)) Docu,
	(select rtrim(nro_Seri_docu_cont) +' - ' + rtrim(nro_docu_cont) from nota_ingreso N (nolock) where N.codi_nota_ingr COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS=x.codi_nota_ingr) Fact,
	(select fech_reg_fact from nota_ingreso N (nolock) where N.codi_nota_ingr COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS =x.codi_nota_ingr) FechaFact,
	(select nro_nota_ingr from nota_ingreso N (nolock) where N.codi_nota_ingr COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS=x.codi_nota_ingr) nro_ingr,
	(select fech_nota_ingr from nota_ingreso N (nolock) where N.codi_nota_ingr COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS=x.codi_nota_ingr) fech_ingr
from orden_de_compra  O (nolock)
join DETALLE_ORDEN_COMPRA D (nolock)
on O.codi_orde_comp=d.codi_orde_comp
left join detalle_nota_ingreso x (nolock)
on X.codi_deta_orde_comp=D.codi_deta_orde_comp
where PEDI_TRAB='P' and O.codi_alma=@alma and --codi_prod=@prod and 
	cast(convert(char(10), fecha,103) as datetime) between @fec1 and @fec2
	--and D.codi_deta_orde_comp='000000012104'


select codi , nro,cliente , fecha , codi_mone , total , codi_deta , codi_prod , cantidad , precio , atendido ,
	(select razon_social from empresa (nolock)) Empresa,
	(select denominacion from cliente_proveedor c (nolock) where c.codi_clie_prov COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS =t.cliente) Razclie,
	(SELECT desc_prod from productos P (nolock) where P.codi_prod COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS=T.codi_prod) Producto,
	cantidad - atendido as saldo,
	(select nemo_alma from almacen A (nolock) where A.codi_alma COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS=@alma) almacen, prec_ing,
	docu , nrodocu , fechafact, nro_ingr, fech_ingr,
	(select p.codi_clie_prov from productos P (nolock) where p.codi_prod COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS=T.codi_prod) codi_labo, 
	(select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end
		from cliente_proveedor c ( nolock) where C.codi_clie_prov in (
		select p.codi_clie_prov from productos P (nolock) where p.codi_prod COLLATE SQL_LATIN1_GENERAL_CP1_CI_AS=T.codi_prod)) Labora
from @tx T
order by producto, codi_deta,fecha
GO
