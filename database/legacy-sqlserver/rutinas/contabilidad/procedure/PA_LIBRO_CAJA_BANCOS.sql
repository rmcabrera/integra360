CREATE PROCEDURE [dbo].[PA_LIBRO_CAJA_BANCOS]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2) 
--select @anio ='2014', @mes ='07'

set nocount on 

-- si es E es un egreso con 104 abonada, entonces solo muestras las cuentas cargadas
-- si es I es un ingreso con 104 cargadas entonces solo muestras las abonadas , asi sea k una abonada sea una 102 o 103
create table #Tx (idd int null, compr varchar(10) null, fecha datetime null, glosa varchar(200) null, nro_cuen char(7) null,	
				desc_cuen varchar(100) null, deudor numeric(12,2) null, acreedor numeric(12,2) null, dolar numeric(12,2) null,
				tipo_camio numeric(12,4) null, subdia char(1) null, codi_docu char(4) null, codi_conta char(10) null,
				serie varchar(5) null, nro_docu varchar(25) null)

declare @fecha char(10)
set @fecha='01/' + @mes + '/'+ @anio

if @mes='01' 
	insert #Tx
	select 1 idd, max(compr),
		@fecha fecha, 'Saldo al ' + convert(char(10),dateadd(dd,-1,casT(@fecha as datetime)) ,103) glosa,  '' nro_cuen, 
		(select desc_cuen from cuentas_contable cc (nolock) where cc.nro_cuen = M.nro_cuen) desc_cuen,
		case when sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)) > 0 then isnull(sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)),0) else 0 end DEUDOR,
		case when sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)) < 0 then isnull(ABS(sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end))),0) else 0 end ACREEDOR, 
		   0 DOLAR, 0 tipo_cambio, max(subdia), '' codi_tipo_docu, '' codi_contable, '' serie, '' nro_docu
	from dbo.movi_contables M(nolock)
	where anio=@anio and mes = @mes and subdia='S' and left(nro_cuen,3) in ('101','102') 
	 group by nro_cuen
else
	insert #Tx
	select 1 idd, '' compr,
		@fecha fecha, 'Saldo al ' + convert(char(10),dateadd(dd,-1,casT(@fecha as datetime)) ,103) glosa,  '' nro_cuen, 
		(select desc_cuen from cuentas_contable cc (nolock) where cc.nro_cuen = M.nro_cuen) desc_cuen,
		case when sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)) > 0 then isnull(sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)),0) else 0 end DEUDOR,
		case when sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end)) < 0 then isnull(ABS(sum(isnull(importe,0) * (case when cargo_abono ='C' then 1 else -1 end))),0) else 0 end ACREEDOR, 
		   0 DOLAR, 0 tipo_cambio, '' subdia, '' codi_tipo_docu, '' codi_contable, '' serie, '' nro_docu
	from dbo.movi_contables M(nolock)
	where anio=@anio and mes < @mes and left(nro_cuen,3) in ('101','102')
		group by nro_cuen 

create table #Mx (compr char(4) null, subdia char(1) null, anio char(4) null, mes char(2) null, codi_vouc char(10) null)

insert #Mx
select  distinct compr, subdia, anio, mes, codi_vouc
	FROM 	movi_contables (nolock)
	WHERE	anio=@anio and mes = @mes and 
			( left(banco,3) in ('101','102')  
                 or (subdia in ('E','I','Q','M','D') and  left(nro_cuen,3) in ('101','102')))

insert #Tx
select 	2, A.compr,
	fecha,
	glosa,
	nro_cuen,
	(select desc_cuen from cuentas_contable cc where cc.nro_cuen = A.nro_cuen) as DESC_CUEN,
	DEUDOR 	 = case when cargo_abono ='A' THEN IMPORTE 	ELSE 0 END ,
	ACREEDOR = case when cargo_abono ='C' THEN IMPORTE 	ELSE 0 END ,
	DOLAR  	 = case when codi_mone	 ='02'  THEN IMPORTE_D 	ELSE 0 END ,
	tipo_cambio,
	A.subdia,
	codi_tipo_docu,
	codi_contable,
	serie,
	nro_docu
from movi_contables A (nolock)
join #Mx B
on A.anio=B.anio and A.mes=B.mes and A.subdia=B.subdia and A.compr=B.compr
		and A.codi_vouc= b.codi_vouc
		--and A.banco=B.banco

select compr , fecha , glosa , nro_cuen , desc_cuen , deudor , acreedor , dolar ,
  		tipo_camio , subdia , codi_docu , codi_conta , serie , nro_docu, idd
from #TX
where left(nro_cuen,3) not in ('101','102')


drop table #Tx
drop table #Mx
GO
