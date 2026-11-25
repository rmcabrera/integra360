CREATE PROCEDURE [dbo].[PA_LIBRO_DIARIO_S]
	@ANIO [char](4),
	@MES [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2)
--select @anio ='2024', @mes ='05'

set nocount on

declare @Tx table(fecha datetime null, glosa varchar(255) null, nro_cuen char(7) null, tipo char(2) null,
                  importe numeric(18,2) null, compr char(20) null, orden numeric(18,0) null, cargo_abono char(1) null, subdia char(1),
				  car varchar(15) null)

insert @TX
select fecha, glosa,
	(select cuenta from libro_diario_s S(nolock) where S.cuenta=left(M.nro_cuen, len(S.cuenta))) nro_cuen,
	(select tipo from libro_diario_s S(nolock) where S.cuenta=left(M.nro_cuen, len(S.cuenta))) as tipo, 
	(importe * case when cargo_abono='C' then 1 else -1 end) as importe, compr,
	(select orden from subdiario (nolock) where NEMOTEC=M.subdia) as orden,
	cargo_abono, subdia,
	case subdia when 'S' then 'A' when 'X' then 'C' else 'M' end + right('0000'+cast(cast(compr as int) as varchar),4)

from movi_contables M(nolock)
where anio=@anio and mes=@mes  ---and subdia='A' ---and left(nro_Cuen,1)=8

/*
select left(nro_cuen,2), sum(importe*case when cargo_abono='C' then 1 else -1 end )
from movi_contables M(nolock)
where anio=@anio and mes=@mes  and subdia='A' 
group by left(nro_cuen,2)

select left(nro_cuen,2), sum(importe*case when cargo_abono='C' then 0 else 1 end )
from movi_contables M(nolock)
where anio=@anio and mes=@mes  and subdia='X' 
group by left(nro_cuen,2)
*/


SELECT fecha, glosa, nro_cuen, descr, tipo, importe, compr, car
FROM
(
select cast(convert(char(10),'01/'+ @mes+'/'+@anio,103) as datetime) as fecha, 'Saldo Inicial' as glosa,
	cuenta as nro_cuen,
	upper(dbo.uf_nom_cuen(cuenta)) as descr,
	(case when max(tipo)='A' then '1. ACTIVO'
		 when max(tipo)='P' then '2. PASIVO'
		 when max(tipo)='PT' then '3. PATRIMONIO'
		 when max(tipo)='G' then '4. GASTOS'
		 when max(tipo)='I' then '5. INGRESOS' 
		 when max(tipo)='S' then '6. SALDOS INTERMEDIARIOS DE GESTIÓN' 
		 when max(tipo)='CG' then '7. CUENTAS DE FUNCIÓN DEL GASTO' 
		 when max(tipo)='CO' then '8. CUENTAS DE ORDEN' end) as tipo,
	sum(importe * case when cargo_abono='C' then 1 else -1 end) as importe, '0000' as compr,
	(select orden from subdiario (nolock) where NEMOTEC=max(M.subdia) ) as orden, '' as car	
from movi_contables M(nolock)
join libro_diario_s S(nolock)
on S.cuenta=left(M.nro_cuen, len(S.cuenta))
where anio=@anio and mes<@mes 
group by cuenta

union all

select fecha, max(glosa) as glosa, nro_cuen, 
		upper(dbo.uf_nom_cuen(nro_cuen)) as decr, 
		(case when max(tipo)='A' then '1. ACTIVO'
			 when max(tipo)='P' then '2. PASIVO'
			 when max(tipo)='PT' then '3. PATRIMONIO'
			 when max(tipo)='G' then '4. GASTOS'
			 when max(tipo)='I' then '5. INGRESOS'
                         when max(tipo)='S' then '6. SALDOS INTERMEDIARIOS DE GESTIÓN' 
			 when max(tipo)='CG' then '7. CUENTAS DE FUNCIÓN DEL GASTO' 
			 when max(tipo)='CO' then '8. CUENTAS DE ORDEN' end) as tipo,
		 sum(importe) as importe, compr, max(orden), max(car) as car
from @Tx
where subdia<>'X'
group by fecha, compr, nro_cuen

union all

select fecha, max(glosa) + ' ' + cargo_abono as glosa , nro_cuen, 
		upper(dbo.uf_nom_cuen(nro_cuen)) as decr, 
		(case when max(tipo)='A' then '1. ACTIVO'
			 when max(tipo)='P' then '2. PASIVO'
			 when max(tipo)='PT' then '3. PATRIMONIO'
			 when max(tipo)='G' then '4. GASTOS'
			 when max(tipo)='I' then '5. INGRESOS'
                         when max(tipo)='S' then '6. SALDOS INTERMEDIARIOS DE GESTIÓN' 
			 when max(tipo)='CG' then '7. CUENTAS DE FUNCIÓN DEL GASTO' 
			 when max(tipo)='CO' then '8. CUENTAS DE ORDEN' end) as tipo,
		 sum(importe) as importe, compr, max(orden), max(car) as car
from @Tx
where subdia='X'
group by fecha, compr, nro_cuen, cargo_abono


) AS SQL	
ORDER BY SQL.nro_cuen, SQL.orden,  SQL.compr
GO
