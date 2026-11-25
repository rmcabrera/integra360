CREATE PROCEDURE [dbo].[usp_stock_cancelado]
	@prod [char](8),
	@ani [int]
WITH EXECUTE AS CALLER
AS
--declare @prod char(8) , @ani int
--select @prod='00081285', @ani = 2016

set nocount on

declare @StockProd table (codi_prod char(8), stock int ,valorizado numeric(12,2))
declare @NotaIngr table (idd int identity,codi_clie_prov char(5),codi_tipo_docu char(4), serie varchar(10) null, nro_docu varchar(20) null, fecha datetime,
							prec_tota numeric(12,2) , codi_mone char(2) , tpc numeric(12,6), cantidad int, prec_unit numeric(12,4))							
declare @DocuFact table (idd int identity,codi_clie_prov char(5),codi_tipo_docu char(4), serie varchar(10) null, nro_docu varchar(20) null, fecha datetime)
declare @RegCompra table ( registro varchar(11), idd int)
declare @RegCompraCance table ( registro varchar(11))
declare @RegLetras table ( registro varchar(11), RegCompra varchar(11))
declare @RegLetrasPend table ( registro varchar(11), saldo numeric(12,2))
declare @SaldoLetra table (idd int, saldo numeric(12,2))
declare @SaldoNotaIngr table (codi_clie_prov char(5),codi_tipo_docu char(4), serie varchar(10) null, nro_docu varchar(20) null, fecha datetime, saldo numeric(12,2))
declare @Rx table ( codi_prod char(8), pendiente numeric(12,2), facturado numeric(12,2), cantidad int, subtotal numeric(12,2) , stock int, valorizado numeric(12,2))

------------------- Stock Actual---------------------------
insert @StockProd 
select codi_prod, sum(cant_ingr - cant_sali) , sum(valo_ingr - valo_sali) 
from kardex (nolock)
where periodo=@ani and codi_prod=@prod
group by codi_prod

------------------------- Documentos Asociados a la Compra------------------------
insert @NotaIngr
select distinct codi_clie_prov,codi_tipo_docu_cont, 
		case when isnumeric(nro_seri_docu_cont)=1 then 
			cast(cast(nro_seri_docu_cont  as numeric) as varchar)
		else
			nro_seri_docu_cont end as serie , 
		case when isnumeric(nro_docu_cont)=1 then 
			cast(cast(nro_docu_cont as numeric) as varchar)
		else
			nro_docu_cont end as docu, 
		fech_reg_fact, prec_tota, A.codi_mone, tipo_camb, cantidad , prec_unit
from nota_ingreso A (nolock)
join detalle_nota_ingreso B (nolock)
on A.codi_nota_ingr=B.codi_nota_ingr
where B.codi_prod=@prod and tipo_nota_ingr='01'

insert @DocuFact
select distinct codi_clie_prov, codi_tipo_docu, serie, nro_docu, fecha
from @NotaIngr
---------------------------- Registros Contables --------------------------
insert @regCompra
select registro ,idd
from movi_contables A (nolock)
join @DocuFact B 
on A.codi_clie_prov=B.codi_clie_prov and A.codi_tipo_docu=B.codi_Tipo_docu and A.serie=B.serie and A.nro_docu=B.nro_docu
where left(nro_Cuen,2)	='42' and subdia='C'


------------------------- Registros Contables Cancelados ------------------------------
insert @regCompraCance
select registro  --, sum(importe *case when cargo_abono='C' then 1 else -1 end ) 
from movi_contables A (nolock)
where registro in (select registro from @RegCompra)and subdia<>'S'
group by registro
having sum(importe *case when cargo_abono='C' then 1 else -1 end ) =0

--------------------------Registros Cancelados Verificando Letras ------------------------
insert @RegLetras
select distinct registro, RegCompra
from movi_contables B (nolock)
join (select anio, mes, subdia, compr, x.registro as RegCompra
			from movi_contables A (nolock)
			join @RegCompraCance X
			on A.registro =X.registro 
			where subdia='L') C
on B.anio=C.anio and B.mes=C.mes and B.subdia=C.subdia and B.compr=C.compr	
where registro not in (select registro from @RegCompra)		

-------------------Registro de Letras Con Saldos-----------------
insert @RegLetrasPend 
select registro  , sum(importe *case when cargo_abono='C' then 1 else -1 end ) 
from movi_contables A (nolock)
where registro in (select registro from @RegLetras)and subdia<>'S'
group by registro
having not (sum(importe *case when cargo_abono='C' then 1 else -1 end ) =0)

insert @SaldoLetra
select Idd, sum(saldo) as Saldos
from @RegLetrasPend A
join @RegLetras B
on A.registro=B.registro
join @regCompra C
on B.regcompra=C.registro
group by Idd

insert @SaldoNotaIngr 
select codi_clie_prov, codi_tipo_docu, serie, nro_docu, fecha, saldo
from @DocuFact A 
join @SaldoLetra S
on A.idd =S.idd 

insert @Rx
select (select codi_prod from @StockProd) codi_prod,
		sum(saldo ), 
		sum(round(prec_tota * case when codi_mone='01' then 1 else tpc end,2))  as Total,
		sum(cantidad) as cantidad, 
		--prec_unit * case when codi_mone='01' then 1 else tpc end  as prec_unit,
		sum(cantidad* prec_unit * case when codi_mone='01' then 1 else tpc end)  as Subtotal,
		(select stock from @StockProd) Stock,
		(select valorizado from @StockProd) Valorizado
from @SaldoNotaIngr A
join @NotaIngr B
on A.codi_clie_prov=B.codi_clie_prov and A.codi_tipo_docu=B.codi_Tipo_docu and A.serie=B.serie and A.nro_docu=B.nro_docu
/*
select * 
from @SaldoNotaIngr A
join @NotaIngr B
on A.codi_clie_prov=B.codi_clie_prov and A.codi_tipo_docu=B.codi_Tipo_docu and A.serie=B.serie and A.nro_docu=B.nro_docu
*/

select codi_prod, 
		(select Desc_prod from Productos P (nolock) where P.codi_prod=R.codi_prod) as Desc_prod,
		Stock,
		facturado,
		pendiente,
		abs(round(pendiente/ facturado,2)) *100 as Porc, 
		cantidad as CantCompro, 
		Stock - Cantidad as Disponible,
		round(cantidad * (1 - abs(round(pendiente/ facturado,2))),0) as Pagadas, 
		Stock - cantidad + round(cantidad * (1 - abs(round(pendiente/ facturado,2))),0) StockPagado, 
		Cantidad  - round(cantidad * (1 - abs(round(pendiente/ facturado,2))),0) StockPendiente,
		subtotal, 
		valorizado,
		(select razon_Social from empresa ) Empresa,
		(select ruc from empresa ) Ruc
from @Rx R
GO
