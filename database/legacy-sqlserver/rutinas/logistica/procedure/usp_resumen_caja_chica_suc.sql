CREATE PROCEDURE [dbo].[usp_resumen_caja_chica_suc]
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime , @fec2 datetime
--select @fec1 ='01/11/2009', @fec2 ='02/11/2009' 

set nocount on 

declare @Tx table ( tipo int null, fecha datetime, importe numeric(12,2) null, dolares numeric(12,2) null, suc varchar(50) null, CODI_ALMA CHAR(2))

insert @Tx
select 1 tipo , cast( convert(char(10),fech_fact,103) as datetime) fecha , 
	SUM(case when codi_mone='01' then TOTA_FACT else 0 end) importe,
	SUM(case when codi_mone='02' then TOTA_FACT else 0 end) importe_d,
	(SELECT NEMO_ALMA FROM dbo.ALMACEN A (nolock) WHERE A.CODI_ALMA=F.CODI_ALMA) suc ,
	CODI_ALMA
from dbo.factura F (nolock)
where  (fech_fact>=@fec1 and fech_fact<DateAdd(day,1,@fec2)) and isnull(estado,'')<>'A' and codi_tipo_pago=1 
group by codi_alma, cast( convert(char(10),fech_fact,103) as datetime)

union all

select cc.tipo_io tipo , cc.fecha fecha , 
	SUM(case when cc.codi_mone='01' then cc.importe else 0 end) importe,
	SUM(case when cc.codi_mone='02' then cc.importe else 0 end) importe_d,
	(SELECT NEMO_ALMA FROM dbo.ALMACEN A (nolock) WHERE A.CODI_ALMA=cc.CODI_ALMA) suc ,
	CODI_ALMA
from dbo.caja_chica cc (nolock)
where cc.fecha>=@fec1 and cc.fecha<=@fec2  AND isnull(dscto_adm,'0')<>'1'
group by  cc.CODI_ALMA , cc.tipo_io , cc.fecha

/*
insert @Tx (suc  , tipo , fecha , importe , dolares  )
select nemo_alma, 1, @fec1, 0 , 0
from almacen (nolock) where nemo_alma not in (select distinct suc from @Tx)

*/

select fecha, suc , 
	sum(case when tipo=1 then importe else 0 end) IngreSoles, 
	sum(case when tipo=0 then importe else 0 end) EgreSoles, 
	sum( importe * case when tipo=1 then 1 else -1 end ) SaldoSoles,
	sum(case when tipo=1 then dolares else 0 end) Ingredolar, 
	sum(case when tipo=0 then dolares else 0 end) Egredolar ,
	sum( dolares * case when tipo=1 then 1 else -1 end ) SaldoDolar,
	(select razon_social from empresa (nolock) ) Empresa,
	MAX(CODI_ALMA) CODI_ALMA
from @Tx
group by fecha, suc
order by fecha, suc
GO
