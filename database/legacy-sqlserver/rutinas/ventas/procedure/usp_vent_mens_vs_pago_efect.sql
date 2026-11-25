CREATE PROCEDURE [dbo].[usp_vent_mens_vs_pago_efect]
	@anio [int],
	@tc [numeric](12, 2),
	@m1 [char](2),
	@m2 [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio int, @tc numeric(12,2), @m1 char(2), @m2 char(2) 
--select @anio=2016, @Tc = 3.4, @m1='01', @m2='02'

set nocount on
create table #TV (tipo int, codi_Clie_prov char(5) , mes int, monto numeric(12,2))
create table #TL (tipo int, codi_Clie_prov char(5) , mes int, monto numeric(12,2))
create table #Tg (tipo int, codi_Clie_prov char(5) , mes int, monto numeric(12,2))

declare @Lista table (idtipo int, codi_clie_prov char(5) )


insert #Tv
select 1, c.codi_clie_prov , month(FECH_FACT) as mes , 
		sum(case when a.CODI_MONE='01' then 1 else a.TCAMBIO end * b.IMPO_ITEM) as Venta
from factura A (nolock)
	join factura_Detalle b (nolock)
on A.codi_Fact=B.codi_Fact
	join productos C (nolock)
on B.codi_prod=C.codi_prod
	where year(fech_fact)=@anio and month(fech_fact) between @m1 and @m2
	and isnull(a.ESTADO,'')<>'A'
	--and C.codi_clie_prov='05753' 
group by c.codi_clie_prov, month(FECH_FACT)

insert @Lista
select distinct 1,codi_clie_prov from #tv union all
select distinct 2,codi_clie_prov from #tv union all
select distinct 3,codi_clie_prov from #tv union all
select distinct 4,codi_clie_prov from #tv union all
select distinct 5,codi_clie_prov from #tv 

insert #Tl
SELECT   2, codi_clie_prov, mes ,sum(case when codi_mone='01' then importe else importe_d*@tc end) as letras
 fROM         Movi_Contables MC (nolock)
WHERE      anio=@anio and month(fecha) between @m1 and @m2 and
			--fecha>=:fi and fecha<DATEADD(day, 1, :ff) AND 
			codi_Clie_prov in (select t.codi_clie_prov from #Tv as t) and 
			(Subdia in ('E','Q')) AND (Cargo_Abono = 'C') 
					AND (NOT (isnull(Nro_Cuen,'')=isnull(Banco,'') ) ) 
						AND NOT ((Glosa LIKE '%dif%') AND (Glosa LIKE '%camb%')) AND Importe>0
			and nro_cuen in ('4231101') 
group by codi_clie_prov, mes

insert #Tg
SELECT   3, codi_clie_prov, mes ,sum(case when codi_mone='01' then importe else importe_d*@tc end)  as letras
 fROM         Movi_Contables MC (nolock)
WHERE      anio=@anio and month(fecha) between @m1 and @m2 and 
			--fecha>=:fi and fecha<DATEADD(day, 1, :ff) AND 
			codi_Clie_prov in (select t.codi_clie_prov from #Tv as t) and 
			(Subdia in ('E','Q')) AND (Cargo_Abono = 'C') 
					AND (NOT (isnull(Nro_Cuen,'')=isnull(Banco,'') ) ) 
						AND NOT ((Glosa LIKE '%dif%') AND (Glosa LIKE '%camb%')) AND Importe>0
			and nro_cuen in ('6736101') 
group by codi_clie_prov, mes


create table #Repo (tipo int , codi_clie_prov char(5) , ene numeric(12,2) null, feb numeric(12,2) null, mar numeric(12,2) null, 
			abr numeric(12,2) null, may numeric(12,2) null, jun numeric(12,2) null, jul numeric(12,2) null, ago numeric(12,2) null, 
			seti numeric(12,2) null, oct numeric(12,2) null, nov numeric(12,2) null, dic numeric(12,2) null,total numeric(12,2) null )

insert #repo
select tipo, codi_clie_prov, 
		sum(case when mes=1 then monto else 0 end) as Ene ,
		sum(case when mes=2 then monto else 0 end) as Feb  ,
		sum(case when mes=3 then monto else 0 end) as Mar  ,
		sum(case when mes=4 then monto else 0 end) as Abr,
		sum(case when mes=5 then monto else 0 end) as May,
		sum(case when mes=6 then monto else 0 end) as Jun,
		sum(case when mes=7 then monto else 0 end) as Jul,
		sum(case when mes=8 then monto else 0 end) as Ago,
		sum(case when mes=9 then monto else 0 end) as Seti,
		sum(case when mes=10 then monto else 0 end) as Oct,
		sum(case when mes=11 then monto else 0 end) as Nov,
		sum(case when mes=12 then monto else 0 end) as Dic,
		sum(monto)
from #tv
group by tipo, codi_Clie_prov

union all

select tipo, codi_clie_prov, 
		sum(case when mes=1 then monto else 0 end) as Ene ,
		sum(case when mes=2 then monto else 0 end) as Feb  ,
		sum(case when mes=3 then monto else 0 end) as Mar  ,
		sum(case when mes=4 then monto else 0 end) as Abr,
		sum(case when mes=5 then monto else 0 end) as May,
		sum(case when mes=6 then monto else 0 end) as Jun,
		sum(case when mes=7 then monto else 0 end) as Jul,
		sum(case when mes=8 then monto else 0 end) as Ago,
		sum(case when mes=9 then monto else 0 end) as Seti,
		sum(case when mes=10 then monto else 0 end) as Oct,
		sum(case when mes=11 then monto else 0 end) as Nov,
		sum(case when mes=12 then monto else 0 end) as Dic,
		sum(monto)
from #tl
group by tipo, codi_Clie_prov

union all

select tipo, codi_clie_prov, 
		sum(case when mes=1 then monto else 0 end) as Ene ,
		sum(case when mes=2 then monto else 0 end) as Feb  ,
		sum(case when mes=3 then monto else 0 end) as Mar  ,
		sum(case when mes=4 then monto else 0 end) as Abr,
		sum(case when mes=5 then monto else 0 end) as May,
		sum(case when mes=6 then monto else 0 end) as Jun,
		sum(case when mes=7 then monto else 0 end) as Jul,
		sum(case when mes=8 then monto else 0 end) as Ago,
		sum(case when mes=9 then monto else 0 end) as Seti,
		sum(case when mes=10 then monto else 0 end) as Oct,
		sum(case when mes=11 then monto else 0 end) as Nov,
		sum(case when mes=12 then monto else 0 end) as Dic ,
		sum(monto)
from #tg
group by tipo, codi_Clie_prov


create table #Resu (tipo int , codi_clie_prov char(5) , ene numeric(12,2) null, feb numeric(12,2) null, mar numeric(12,2) null, 
			abr numeric(12,2) null, may numeric(12,2) null, jun numeric(12,2) null, jul numeric(12,2) null, ago numeric(12,2) null, 
			seti numeric(12,2) null, oct numeric(12,2) null, nov numeric(12,2) null, dic numeric(12,2) null,total numeric(12,2) null )

insert #Resu
select tipo, codi_clie_prov, ene, feb, mar, abr, may, jun, jul, ago, seti, oct, nov, dic, total
from  #repo
union all
select 4 as tipo, codi_clie_prov, sum(ene), sum(feb), sum(mar), sum(abr), sum(may), sum(jun), sum(jul), sum(ago), sum(seti), sum(oct), sum(nov), sum(dic), sum(total)
from  #repo where tipo in (2,3)
group by codi_clie_prov 
union all
select 5 as tipo, codi_clie_prov, sum(ene*case when tipo=1 then 1 else -1 end), sum(feb*case when tipo=1 then 1 else -1 end), sum(mar*case when tipo=1 then 1 else -1 end), 
			sum(abr*case when tipo=1 then 1 else -1 end), sum(may*case when tipo=1 then 1 else -1 end), sum(jun*case when tipo=1 then 1 else -1 end), 
			sum(jul*case when tipo=1 then 1 else -1 end), sum(ago*case when tipo=1 then 1 else -1 end), sum(seti*case when tipo=1 then 1 else -1 end), 
			sum(oct*case when tipo=1 then 1 else -1 end), sum(nov*case when tipo=1 then 1 else -1 end), sum(dic*case when tipo=1 then 1 else -1 end), 
			sum(total*case when tipo=1 then 1 else -1 end)
from  #repo where tipo in (1,2,3)
group by codi_clie_prov 



select isnull(tipo, idtipo) as tipo, 
		case when isnull(tipo, idtipo)=1 then 'TOT.VENTA GENERAL'
			when isnull(tipo, idtipo)=2 then 'PAGOS LETRAS Y FACTURAS'
			when isnull(tipo, idtipo)=3 then 'GASTOS FINANCIAMIENTO'
			when isnull(tipo, idtipo)=4 then 'TOTAL PAGOS EFECTUADOS'
			when isnull(tipo, idtipo)=5 then 'DIFERENCIA' end as Ventas,
		isnull(A.codi_clie_prov, b.codi_clie_prov) codi_clie_prov, 
		dbo.f_cliente_proveedor(isnull(A.codi_clie_prov, b.codi_clie_prov)) as Laboratorio,
		isnull(ene,0) as ene, 
		isnull(feb, 0) as feb,
		isnull(mar, 0) as mar,
		isnull(abr, 0) as abr,
		isnull(may, 0) as may,
		isnull(jun, 0) as jun,
		isnull(jul, 0) as jul,
		isnull(ago, 0) as ago,
		isnull(seti, 0) as seti,
		isnull(oct, 0) as oct,
		isnull(nov, 0) as nov,
		isnull(dic, 0) as dic,
		isnull(total,0) as total
from #resu A
right join @Lista B
on A.codi_clie_prov=B.codi_clie_prov and 
	A.tipo =B.idtipo
order by 4, tipo



drop table #tv
drop table #tg
drop table #tl
drop table #repo
drop table #resu
GO
