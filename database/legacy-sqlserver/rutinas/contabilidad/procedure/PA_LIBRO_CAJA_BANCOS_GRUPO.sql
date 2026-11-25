CREATE PROCEDURE [dbo].[PA_LIBRO_CAJA_BANCOS_GRUPO]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2) 
--select @anio ='2023', @mes ='09'

set nocount on 

-- si es E es un egreso con 104 abonada, entonces solo muestras las cuentas cargadas
-- si es I es un ingreso con 104 cargadas entonces solo muestras las abonadas , asi sea k una abonada sea una 102 o 103
create table #Tx (idd int null, compr varchar(10) null, fecha datetime null, glosa varchar(200) null, nro_cuen char(7) null,	
				desc_cuen varchar(100) null, deudor numeric(12,2) null, acreedor numeric(12,2) null, dolar numeric(12,2) null,
				tipo_camio numeric(12,4) null, subdia char(1) null, codi_docu char(4) null, codi_conta char(10) null,
				serie varchar(5) null, nro_docu varchar(10) null, banco char(7) null)

declare @cuenta char(7), @fechaf datetime

declare @fecha char(10), @ult int
declare  @l_a int , @l_m int
set @l_a=cast(@anio as int)
set @l_m=cast(@mes as int)
set @ult = dbo.f_ulti_dia( @l_a, @l_m)
 
set @fecha='01/' + @mes + '/'+ @anio
set @fechaf=cast(cast(@ult as varchar)+'/' + @mes + '/'+ @anio as datetime)


if @mes='01' 
	insert #Tx
	select 1 idd, max(compr),
		@fecha fecha, 'Saldo al ' + convert(char(10),dateadd(dd,-1,casT(@fecha as datetime)) ,103) glosa,  '' nro_cuen, 
		(select desc_cuen from cuentas_contable cc where cc.nro_cuen = M.nro_cuen) desc_cuen,
		case when sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)) > 0 then isnull(sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)),0) else 0 end DEUDOR,
		case when sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)) < 0 then isnull(ABS(sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end))),0) else 0 end ACREEDOR, 
		   0 DOLAR, 0 tipo_cambio, max(subdia), '' codi_tipo_docu, '' codi_contable, '' serie, '' nro_docu, nro_cuen
	from dbo.movi_contables M(nolock)
	where anio=@anio and mes = @mes and left(nro_cuen,3) in ('101','102') and subdia='S'
	 group by nro_cuen
else
	insert #Tx
	select 1 idd, '' compr,
		@fecha fecha, 'Saldo al ' + convert(char(10),dateadd(dd,-1,casT(@fecha as datetime)) ,103) glosa,  '' nro_cuen, 
		(select desc_cuen from cuentas_contable cc where cc.nro_cuen = M.nro_cuen) desc_cuen,
		case when sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)) > 0 then isnull(sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)),0) else 0 end DEUDOR,
		case when sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)) < 0 then isnull(ABS(sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end))),0) else 0 end ACREEDOR, 
		   0 DOLAR, 0 tipo_cambio, '' subdia, '' codi_tipo_docu, '' codi_contable, '' serie, '' nro_docu, nro_cuen
	from dbo.movi_contables M(nolock)
	where anio=@anio and mes < @mes and left(nro_cuen,3) in ('101','102')
		group by nro_cuen 

create table #TXR ( anio char(4) null, mes char(2) null, subdia char(1) null, compr varchar(10) null, codigo char(10) null, codi_vouc varchar(10) null, fec datetime null)

create table #Bx (banco char(7) )

insert #Bx
select nro_cuen from cuentas_contable (nolock)
where left(nro_cuen,3) in ('101','102')

declare c1 cursor for select distinct banco from #BX
open c1
fetch  c1 into @cuenta
while @@Fetch_status=0
begin
	insert #TxR			
	exec usp_cuen_caja @cuenta , @anio , @mes , @mes  , @fecha , @fechaf , 'M' , '' , '1' , '' , 'C' 
	
	insert #Tx
	select 	2, 
		B.compr,
		b.fecha,
		b.glosa,
		b.nro_cuen,
		(select desc_cuen from cuentas_contable cc where cc.nro_cuen = b.nro_cuen) as DESC_CUEN,
		DEUDOR 	 = case when cargo_abono ='A' THEN IMPORTE 	ELSE 0 END ,
		ACREEDOR = case when cargo_abono ='C' THEN IMPORTE 	ELSE 0 END ,
		DOLAR  	 = case when codi_mone	 ='02'  THEN IMPORTE_D 	ELSE 0 END ,
		tipo_cambio,
		b.subdia,
		codi_tipo_docu,
		b.codi_contable,
		b.serie,
		b.nro_docu, 
		@cuenta as banco
	from #txR A 
	join movi_contables B (nolock)
	on A.anio=B.anio and A.mes=B.mes and A.subdia=B.subdia and A.compr =B.compr
	and A.codi_vouc =B.codi_vouc and A.fec=B.fecha
	where B.codi_contable<>A.codigo 
	order by A.anio, A.mes, A.subdia, A.compr	
	
	delete #TxR
	fetch  c1 into @cuenta
end
close c1
deallocate c1

select compr , fecha , glosa , nro_cuen , desc_cuen , deudor , acreedor , dolar ,
  		tipo_camio , subdia , codi_docu , codi_conta , serie , nro_docu, idd, banco,
  		(select desc_cuen from cuentas_contable c (nolock) where c.nro_cuen=banco)	Desc_banco
from #TX
where left(nro_cuen,2)<>'12'
union all
select min(compr) , fecha , max(glosa) , nro_cuen , max(desc_cuen) , sum(deudor) , sum(acreedor) , 
		sum(dolar) ,
  		0.00 tipo_camio , subdia , codi_docu , '' codi_conta , serie , min(rtrim(nro_docu))+ ' - ' + max(rtrim(nro_docu)), 
		max(idd), banco,
  		(select desc_cuen from cuentas_contable c (nolock) where c.nro_cuen=banco)	Desc_banco
from #TX
where left(nro_cuen,2)='12'
group by fecha, nro_cuen, subdia, codi_docu,serie, banco


drop table #TX
drop table #TXR
drop table #Bx
GO
