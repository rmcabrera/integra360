CREATE PROCEDURE [dbo].[usp_repo_nota_ingr_gene_letra]
	@registro [char](11)
WITH EXECUTE AS CALLER
AS
--declare @registro char(11)
--select @registro = '406C0580'

set nocount on 

create table #Nx (codi_nota_ingr char(10) )

declare @Ning table ( docu char(4) null, serie varchar(5) null, nro varchar(10) null, fecha datetime, codi_clie_prov char(5))
declare @Notax table ( codi_nota_ingr char(10), docu char(4) null, serie varchar(5) null, nro varchar(10) null, fecha datetime, codi_clie_prov char(5), ser_nota varchar(5))

insert @Ning
select A.codi_tipo_docu, A.serie, A.nro_docu, A.fecha, codi_clie_prov
		--right('00000000'+ rtrim(cast(codi_nota_ingr  as varchar)),10)
from movi_contables A (nolock) 
where subdia='C' and A.registro=@registro

insert @Notax
select codi_nota_ingr, a.docu, a.serie, a.nro, a.fecha ,a.codi_clie_prov, nro_Seri_docu_cont
from @Ning A
join Nota_ingreso B (nolock)
on A.codi_clie_prov=B.codi_clie_prov and A.docu=B.codi_tipo_docu_cont 
	 and A.nro=B.nro_docu_cont and A.fecha=B.FECH_REG_FACT

insert #Nx
select codi_nota_ingr from @notax
where serie=cast(ser_nota as int)

select detalle_nota_ingreso.nro_cuen, 
		detalle_nota_ingreso.codi_prod, desc_prod,cantidad, 
		isnull((select simb_unid_medi from unidad_medida U (nolock) where u.codi_unid_medi=productos.codi_unid_medi),'') Unidad, 
		prec_unit,round( round(  prec_unit , 4 ) * round( cantidad , 4 ) , 2 )  subtotal, 
		tipo_nota_ingr,
		(select nemo_tipo_is from tipo_ingr_sali T (nolock) where T.codi_tipo_is=tipo_nota_ingr) TipoIngreso,
		nro_nota_ingr, fech_nota_ingr,
	  	( select cast( cast( nro_orde_comp as numeric ) as varchar) from orden_de_compra (nolock) where codi_orde_comp = left( detalle_nota_ingreso.codi_deta_orde_comp , 10 ) ) as nro_orde_comp,
	  ( select desc_mone from monedas (nolock)where codi_mone = nota_ingreso.codi_mone) as mone_ni,
	  ( Select dbo.F_Cliente_Proveedor( nota_ingreso.codi_clie_prov ) From cliente_proveedor  (nolock)  where codi_clie_prov = nota_ingreso.codi_clie_prov ) as prov_rs,
		(select desc_tipo_docu from tipo_documento T (nolock) where t.codi_tipo_docu=codi_tipo_docu_cont) DocuFact, nro_seri_docu_cont, nro_docu_cont,
		(select razon_social from empresa (nolock)) Empresa,
		dbo.f_cliente_proveedor(nota_ingreso.codi_clie_prov) Razon_social
    from detalle_nota_ingreso,  productos, nota_ingreso, empresa em, TIPO_DOCUMENTO TD
   where  ( nota_ingreso.codi_nota_ingr = detalle_nota_ingreso.codi_nota_ingr ) and 
			productos.codi_prod = detalle_nota_ingreso.codi_prod  
			and td.codi_tipo_docu =* nota_ingreso.codi_tipo_docu
			and nota_ingreso.codi_nota_ingr in (SElect X.codi_nota_ingr from @Notax as X)
order by desc_prod

drop table #Nx
GO
