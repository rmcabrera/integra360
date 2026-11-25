CREATE PROCEDURE [dbo].[usp_genera_consumo]
	@mes [char](2),
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
--declare @mes char(2) , @anio char(4)
--select @mes ='05' , @anio ='2014'

set nocount on 
declare @errno  int,@errmsg	varchar(255), @error varchar(10)
declare @CTA69 char(7)
declare @CTA66 char(7)
declare @CTA94 char(7)
declare @CTA79 char(7)
declare @SUBCTA69 char(7)

select @CTA69 = cuenta from cuentas_provision  (nolock) where codigo='16'
select @CTA79 = cuenta from cuentas_provision  (nolock) where codigo='15'
--select @CTA94 = cuenta from cuentas_provision  (nolock) where codigo='25'
--select @CTA66 = cuenta from cuentas_provision  (nolock) where codigo='26'

select @SUBCTA69= nro_sub_cuen from cuentas_contable (nolock) where nro_cuen=@CTA69

declare @REP table ( fecha datetime null, nro_cuen char(7) null,  importe numeric(12,2) null,
		codi_unid_oper char(5) null, nro_sub_cuen char(7) null, glosa varchar(150) null,
		codi_sema varchar(10) null, nro_sali numeric(18,0) null, nro_seri_docu_sali char(5) null, nro_docu_sali char(10) null)

declare @MOV table (Codi_Contable int identity, Subdia char(1) null, Compr char(10) null,  Codi_Mone char(2) null, 
		Fecha datetime null , Nro_Cuen char(7) null, Nro_Sub_Cuen char(7) null , 
		Serie char(5) null, Nro_Docu char(10) null, Importe numeric(12,2) null ,igv numeric(12,2) null , 
		otros numeric(12,2) null , total numeric(12,2) null , importe_d numeric(12,2) null , igv_d numeric(12,2) null , 
		otros_d numeric(12,2) null , total_d numeric(12,2) null , 
		registro char(10) null, codi_unid_oper char(5) null, glosa varchar(200) null, 
		cargo_abono char(1) null, mes char(2) null, anio char(4)  null, 
		tipo_cambio numeric(18,4) null , codi_vouc char(10) null, codi_sema varchar(10) null, nro_fact char(10) null)

---------------------- VENTA Y ANTICIPADA (RETIRO)
insert @REP
Select  fech_emis, 
	pr.nro_cuen as cuen_prod,
	round(round(isnull(cantidad, 0 ), 4) * round(isnull(dds.prec_prom, 0 ), 4 ) ,2) importe,
	isnull(codi_unid_oper_rece,(select a.codi_unid_oper from almacen A (nolock) where a.codi_alma= ds.Codi_Alma)) as codi_unid_oper_rece,
	(Select isnull(nro_sub_cuen , '')  from cuentas_contable where nro_cuen = pr.nro_cuen )   as nsc_61,
	'Por VENTA de Producto ' + dds.codi_prod + '. Salida ' + ds.nro_sali as glosa, 
	('SM' + ds.nro_sali) as codi_sema, 
	ds.nro_sali, nro_seri_docu_sali, nro_docu_sali
	from docu_sali_mate ds (nolock),  Detalle_docu_sali dds (nolock) , productos pr (nolock)
	WHERE year( fech_emis)  = @anio  and month(fech_emis)  = @mes 
		and ds.codi_docu_sali = dds.codi_docu_sali and dds.codi_prod = pr.codi_prod 
		and tipo_sali in ('08','12'/*,'16'*/) --and nro_sali in (3247 , 3277,6630)
	order by nro_sali

insert @MOV (Subdia, Compr, Codi_Mone, Fecha, Nro_Cuen, Nro_Sub_Cuen, 
		Serie, Nro_Docu, Importe,igv, otros, total, importe_d, igv_d , otros_d, total_d, 
		registro, codi_unid_oper, glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_fact) 
select 'K' subdia, 1 compr, '01' mone, fecha, @CTA69, @SUBCTA69, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'C' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali
from @REP
union all
select 'K' subdia, 1 compr, '01' mone, fecha, nro_cuen, nro_sub_cuen, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'A' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali
from @REP
order by nro_sali, c_a desc

delete @REP

---------------------- FIN VENTA Y ANTICIPADA (RETIRO)

---------------------- CONSUMO MERCADERIA MISMA EMPRESA
insert @REP
Select  fech_emis, 
	pr.nro_cuen as cuen_prod,
	round(round(isnull(cantidad, 0 ), 4) * round(isnull(dds.prec_prom, 0 ), 4 ) ,2) importe,
	isnull(codi_unid_oper_rece,(select a.codi_unid_oper from almacen A (nolock) where a.codi_alma= ds.Codi_Alma) ),
	(Select isnull(nro_sub_cuen , '')  from cuentas_contable where nro_cuen = pr.nro_cuen )   as nsc_61,
	'Por CONSUMO de Producto ' + dds.codi_prod + '. Salida ' + ds.nro_sali as glosa, 
	('SM' + ds.nro_sali) as codi_sema, 
	ds.nro_sali, nro_seri_docu_sali, nro_docu_sali
	from docu_sali_mate ds (nolock),  Detalle_docu_sali dds (nolock) , productos pr (nolock)
	WHERE year( fech_emis)  = @anio  and month(fech_emis)  = @mes 
		and ds.codi_docu_sali = dds.codi_docu_sali and dds.codi_prod = pr.codi_prod 
		and tipo_sali in ('27') --and nro_sali in (8202 )
order by nro_sali

insert @MOV (Subdia, Compr, Codi_Mone, Fecha, Nro_Cuen, Nro_Sub_Cuen, 
		Serie, Nro_Docu, Importe,igv, otros, total, importe_d, igv_d , otros_d, total_d, 
		registro, codi_unid_oper, glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_fact) 
select 'K' subdia, 1 compr, '01' mone, fecha, nro_sub_cuen, null, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'C' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali
from @REP
union all
select 'K' subdia, 1 compr, '01' mone, fecha, nro_cuen, nro_sub_cuen, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'A' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali
from @REP
union all
select 'K' subdia, 1 compr, '01' mone, fecha, @CTA94, null, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'C' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali
from @REP
union all
select 'K' subdia, 1 compr, '01' mone, fecha, @CTA79, nro_sub_cuen, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'A' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali
from @REP

delete @REP
---------------------- FIN CONSUMO MERCADERIA MISMA EMPRESA


---------------------- ROBO MERCADERIA 
insert @REP
Select  fech_emis, 
	pr.nro_cuen as cuen_prod,
	round(round(isnull(cantidad, 0 ), 4) * round(isnull(dds.prec_prom, 0 ), 4 ) ,2) importe,
	codi_unid_oper_rece,
	(Select isnull(nro_sub_cuen , '')  from cuentas_contable where nro_cuen = pr.nro_cuen )   as nsc_61,
	'Por ROBO de Producto ' + dds.codi_prod + '. Salida ' + ds.nro_sali as glosa, 
	('SM' + ds.nro_sali) as codi_sema, 
	ds.nro_sali, nro_seri_docu_sali, nro_docu_sali
	from docu_sali_mate ds (nolock),  Detalle_docu_sali dds (nolock) , productos pr (nolock)
	WHERE year( fech_emis)  = @anio  and month(fech_emis)  = @mes 
		and ds.codi_docu_sali = dds.codi_docu_sali and dds.codi_prod = pr.codi_prod 
		and tipo_sali in ('26') --and nro_sali in (7401 )
order by nro_sali

insert @MOV (Subdia, Compr, Codi_Mone, Fecha, Nro_Cuen, Nro_Sub_Cuen, 
		Serie, Nro_Docu, Importe,igv, otros, total, importe_d, igv_d , otros_d, total_d, 
		registro, codi_unid_oper, glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_fact) 
select 'K' subdia, 1 compr, '01' mone, fecha, @CTA66, null, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'C' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali
from @REP
union all
select 'K' subdia, 1 compr, '01' mone, fecha, nro_cuen, nro_sub_cuen, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'A' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali
from @REP

delete @REP
---------------------- FIN ROBO MERCADERIA 

---------------------- DEVOLUCION DE PRODUCTOS
--insert @REP
/*Select  fech_emis, 
	pr.nro_cuen as cuen_prod,
	round(round(isnull(cantidad, 0 ), 4) * round(isnull(dds.prec_prom, 0 ), 4 ) ,2) importe,
	codi_unid_oper_rece,
	(Select isnull(nro_sub_cuen , '')  from cuentas_contable where nro_cuen = pr.nro_cuen )   as nsc_61,
	'Por Devolución de Producto ' + dds.codi_prod + '. Salida ' + ds.nro_sali as glosa, 
	('SM' + ds.nro_sali) as codi_sema, 
	ds.nro_sali
	from docu_sali_mate ds (nolock),  Detalle_docu_sali dds (nolock) , productos pr (nolock)
	WHERE year( fech_emis)  = @anio  and month(fech_emis)  = @mes 
		and ds.codi_docu_sali = dds.codi_docu_sali and dds.codi_prod = pr.codi_prod 
		and tipo_sali in ('07') --and nro_sali in (8202 )
order by nro_sali*/

insert @MOV (Subdia, Compr, Codi_Mone, Fecha, Nro_Cuen, Nro_Sub_Cuen, 
		Serie, Nro_Docu, Importe,igv, otros, total, importe_d, igv_d , otros_d, total_d, 
		registro, codi_unid_oper, glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_fact) 
select 'K' subdia, 1 compr, '01' mone, fecha, nro_sub_cuen, null, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'C' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali
from @REP
union all
select 'K' subdia, 1 compr, '01' mone, fecha, nro_cuen, nro_sub_cuen, nro_seri_docu_sali, nro_sali, importe,0 igv, 
	0 otros, 0 total , 0 imp_d , 0 igv_d, 0 otro_d, 0 total_d,
	'' registro , codi_unid_oper, glosa, 'A' c_a, @mes mes , @anio anio , 0 tpc , '' codvou, codi_sema, nro_docu_sali
from @REP

---------------------- FIN DEVOLUCION DE PRODUCTOS


begin transaction
	
	declare @MX numeric(18)
	select @MX = max(codi_contable) from movi_contables (nolock)

	delete from movi_contables where anio=@anio and mes= @mes and  subdia= 'K'

	if @@error <> 0 
	begin
		select @errno = 30002, @errmsg = 'No se puede eliminar asientos de consumo'
		goto error
	end 

	insert movi_contables(codi_contable, Subdia, Compr, Codi_Mone, Fecha, Nro_Cuen, Nro_Sub_Cuen, 
		Serie, Nro_Docu, Importe,igv, otros, total, importe_d, igv_d , otros_d, total_d, 
		registro, codi_unid_oper, glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_fact)
	select right('0000000000'+cast(@MX + codi_contable as varchar(10)),10) codi, 
		Subdia, Compr, Codi_Mone, Fecha, Nro_Cuen, Nro_Sub_Cuen, 
		Serie, Nro_Docu, Importe,igv, otros, total, importe_d, igv_d , otros_d, total_d, 
		registro, codi_unid_oper, glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_fact
	from @MOV
	
	if @@error <> 0 
	begin
		select @errno = 30002, @errmsg = 'No se puede generar asientos de consumo'
		goto error
	end 
	
	commit transaction 	
return
error:
	rollback transaction	
	raiserror @errno @errmsg
GO
