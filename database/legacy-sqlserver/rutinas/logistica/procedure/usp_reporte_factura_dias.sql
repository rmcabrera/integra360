CREATE PROCEDURE [dbo].[usp_reporte_factura_dias]
	@fec1 [datetime],
	@fec2 [datetime],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime, @fec2 datetime, @codi_alma char(2)  
--select @fec1='23/10/2012', @fec2='23/10/2012', @codi_alma='00'  
  
set nocount on  
declare @alma table (codi_alma char(2) null)  
if @codi_alma = '00'  
begin  
 insert @alma  
 Select codi_alma from dbo.almacen (nolock)  
end   
else  
begin insert @alma  
 Select codi_alma from dbo.almacen (nolock) where codi_alma = @codi_alma  
  
end  
  
declare @Tx table (codi_fact char(10) null, codi_clie_prov char(5) null, doc varchar(20) null, fech_fact datetime, cliente varchar(250) null,  
     cultivo varchar(150) null, hectarea numeric(18,3) null, tota_fact numeric(18,3) null, empresa varchar(150) null,   
     ruc char(11) null, codi_alma char(2) null, nro_dias int, culti int, codi_tipo_pago int,zona varchar(200),cod_zona int )  
  
declare @Rx table (codi_clie_prov char(5) null, dias int null, culti int null, fech_fact_min datetime null, codi_tipo_pago int,cod_zona int null)  
  
insert @Tx  
select codi_fact, codi_clie_prov, (ltrim(rtrim(ser_fact)) + ' - ' + rtrim(ltrim(nro_fact))) doc,fech_fact,  
 (select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end  
 from dbo. cliente_proveedor c(nolock) where c.codi_clie_prov=f.codi_clie_prov) cliente,  
 (select desc_cultivo from dbo.cultivos B(nolock) where B.cod_cultivo=f.cod_cultivo) cultivo,  
  hectarea, tota_fact,  
 (select razon_social from dbo.empresa (nolock)) empresa,  
 (select ruc from dbo.empresa (nolock)) ruc, codi_alma, isnull(nro_dias,0) nro_dias, cod_cultivo, codi_tipo_pago,
  (SELECT DESC_ZONA FROM ZONAS (nolock) WHERE COD_ZONA=F.COD_ZONA) ZONA,
cod_zona  
from dbo.factura F(nolock)  
where cast(convert(varchar(10),fech_fact,103) as smalldatetime) between @fec1 and @fec2 --and codi_clie_prov='11311'  
and isnull(f.codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)   
  
insert @Rx  
select codi_clie_prov, datediff(dd,min(fech_fact),@fec2) dias, cod_cultivo, min(fech_fact) fech_fact_min, max(codi_tipo_pago) codi_tipo_pago ,
 cod_zona
from dbo.factura F(nolock)  
where cast(convert(varchar(10),fech_fact,103) as smalldatetime) between @fec1 and @fec2 --and codi_clie_prov='11311'  
and isnull(f.codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)   
group by codi_clie_prov, cod_cultivo,cod_zona  
  
select codi_fact, /*T.codi_clie_prov,*/ doc, fech_fact, cliente,  
    cultivo, hectarea, tota_fact, empresa, ruc, codi_alma,   
    nro_dias,(nro_dias + R.dias) dias, fech_fact_min, T.codi_clie_prov,   
 (case when T.codi_tipo_pago=1 then 'EFECTIVO' else 'CRÉDITO' end) tipo_pago,
zona  
from @Tx T  
left join @Rx R  
on T.codi_clie_prov = R.codi_clie_prov and T.culti = R.culti  and t.cod_zona=r.cod_zona
GO
