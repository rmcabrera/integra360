CREATE PROCEDURE [dbo].[usp_genera_consumo_nc]
	@mes [char](2),
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
--declare @mes char(2) , @anio char(4)
--select @mes ='02' , @anio ='2022'

set nocount on 
declare @errno  int,@errmsg	varchar(255), @error varchar(10)
declare @CTA69 char(7)
declare @CTA66 char(7)
declare @CTA94 char(7)
declare @CTA79 char(7)
declare @SUBCTA69 char(7), @sub char(1), @vouc varchar(10), @comp varchar(10), @sema char(8)

select @CTA69 = cuenta from cuentas_provision  (nolock) where codigo='16'
select @CTA79 = cuenta from cuentas_provision  (nolock) where codigo='15'

select @SUBCTA69= nro_sub_cuen from cuentas_contable (nolock) where nro_cuen=@CTA69

declare @REP table ( fecha datetime null, nro_cuen char(7) null,  importe numeric(12,2) null,
		codi_unid_oper char(5) null, nro_sub_cuen char(7) null, glosa varchar(150) null,
		codi_sema char(8) null, nro_sali numeric(18,0) null, nro_seri_docu_sali char(5) null, 
		nro_docu_sali char(10) null, codi_clie char(5) null)

declare @MOV table (Codi_Contable int identity, Subdia char(1) null, Compr char(10) null,  Codi_Mone char(2) null, 
		Fecha datetime null , Nro_Cuen char(7) null, Nro_Sub_Cuen char(7) null , 
		Serie char(5) null, Nro_Docu char(10) null, Importe numeric(12,2) null ,igv numeric(12,2) null , 
		otros numeric(12,2) null , total numeric(12,2) null , importe_d numeric(12,2) null , igv_d numeric(12,2) null , 
		otros_d numeric(12,2) null , total_d numeric(12,2) null , 
		registro char(10) null, codi_unid_oper char(5) null, glosa varchar(200) null, 
		cargo_abono char(1) null, mes char(2) null, anio char(4)  null, 
		tipo_cambio numeric(18,4) null , codi_vouc char(10) null, codi_sema char(8) null, nro_fact char(10) null, codi_clie char(5) null)

---------------------- VENTA Y ANTICIPADA (RETIRO)
insert @REP
select max(fech_emis) fech_emis, max(cuen_prod) cuen_prod, max(importe) importe, max(codi_unid_oper_rece) codi_unid_oper_rece, 
	   max(nsc_61) nsc_61, max(glosa) glosa, max(codi_sema) codi_sema, nro_sali, nro_seri_docu_sali, nro_docu_sali, max(codi_clie_prov) codi_clie_prov

from(
Select fech_nota_cred as fech_emis, 
	pr.nro_cuen as cuen_prod,
	round(round(isnull(cant_item, 0 ), 4) * round(isnull(dds.prec_prom, 0 ), 4 ) ,2) importe,
	isnull(codi_unid_oper_rece,(select a.codi_unid_oper from almacen A (nolock) where a.codi_alma= ds.Codi_Alma)) as codi_unid_oper_rece,
	(Select isnull(nro_sub_cuen , '')  from cuentas_contable where nro_cuen = pr.nro_cuen )   as nsc_61,
	'Por VENTA de Producto ' + dds.codi_prod + '. Salida ' + ds.nro_sali as glosa, 
	('SM' + ds.nro_sali) as codi_sema, 
	ds.nro_sali, nro_seri_docu_sali, nro_docu_sali,
	(select F.codi_clie_prov from factura F(nolock) where F.codi_fact=DS.codi_fact) codi_clie_prov, dds.codi_prod
	
	from docu_sali_mate ds (nolock) join Detalle_docu_sali dds (nolock) on ds.codi_docu_sali = dds.codi_docu_sali 
	join nota_credito N(nolock) on ds.codi_fact = N.codi_fact
	join nota_credito_deta D(nolock) on N.codi_nota_cred=D.codi_nota_cred and dds.codi_prod = D.codi_item	
	join productos pr (nolock) on dds.codi_prod = pr.codi_prod 
	
	WHERE year(fech_nota_cred)=@anio and month(fech_nota_cred)=@mes
		and tipo_sali in ('08','12'/*,'16'*/) 
		--and N.codi_nota_cred='0000000581'
		) as SQL
	
	group by nro_sali, nro_seri_docu_sali, nro_docu_sali, codi_prod
	order by nro_sali

insert @MOV (Subdia, Compr, Codi_Mone, Fecha, Nro_Cuen, Nro_Sub_Cuen, 
		Serie, Nro_Docu, Importe,igv, otros, total, importe_d, igv_d , otros_d, total_d, 
		registro, codi_unid_oper, glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_fact, codi_clie) 
select 'K' subdia, 1 compr, '01' mone, fecha, nro_cuen, nro_sub_cuen, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'C' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali, codi_clie
from @REP
union all
select 'K' subdia, 1 compr, '01' mone, fecha, @CTA69, @SUBCTA69, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'A' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali, codi_clie
from @REP
order by nro_sali, c_a desc

--delete @REP

---------------------- FIN VENTA Y ANTICIPADA (RETIRO)


--set @sema = ( select max(codi_sema) from @REP )

set @sub='M'

set @vouc=dbo.uf_agrupar(@sub)

delete from movi_contables where anio=@anio and mes=@mes and subdia=@sub and codi_sema is not null

if @@error <> 0 
begin
	select @errno = 30002, @errmsg = 'No se puede eliminar asientos de consumo NC'
	goto error
end 

set @comp = cast(isnull( ( select max(cast(compr as numeric)) 
			from movi_contables (nolock) where anio=@anio and mes=@mes and subdia=@sub ), 0 )   + 1  as varchar)

--select @vouc, @sema

begin transaction
	
	declare @MX numeric(18)
	select @MX = max(codi_contable) from movi_contables (nolock)
/*
	delete from movi_contables where anio=@anio and mes=@mes and subdia=@sub --and codi_sema=@sema
	and codi_sema is not null

	if @@error <> 0 
	begin
		select @errno = 30002, @errmsg = 'No se puede eliminar asientos de consumo NC'
		goto error
	end 
*/
	insert movi_contables(codi_contable, Codi_Clie_Prov, Subdia, Compr, Codi_Mone, Fecha, Nro_Cuen, Nro_Sub_Cuen, 
		Serie, Nro_Docu, Importe,igv, otros, total, importe_d, igv_d , otros_d, total_d, 
		registro, codi_unid_oper, glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_fact)
	select right('0000000000'+cast(@MX + codi_contable as varchar(10)),10) codi, 
		codi_clie, @sub as subdia, @comp as compr, Codi_Mone, Fecha, Nro_Cuen, Nro_Sub_Cuen, 
		Serie, Nro_Docu, Importe,igv, otros, total, importe_d, igv_d , otros_d, total_d, 
		registro, codi_unid_oper, glosa, cargo_abono, mes, anio, tipo_cambio, @vouc as codi_vouc, codi_sema, nro_fact
	from @MOV
	
	if @@error <> 0 
	begin
		select @errno = 30002, @errmsg = 'No se puede generar asientos de consumo NC'
		goto error
	end 
	
	commit transaction 
	
	select @comp
		
return
error:
	rollback transaction	
	raiserror @errno @errmsg
GO
