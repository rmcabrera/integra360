CREATE PROCEDURE [dbo].[usp_lista_factura_cancelacion]
	@almacen [char](2),
	@tipo_pago [char](1),
	@fecha_ini [datetime],
	@fecha_fin [datetime],
	@codi_mone [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fecha_ini datetime, @fecha_fin datetime , @almacen char(2), @tipo_pago char(1), @codi_mone char(2)
--select @fecha_ini ='01/07/2021', @fecha_fin ='31/07/2021' , @almacen = '09', @tipo_pago ='C'  , @codi_mone='01'
  
set nocount on   
declare @TempoFact  table (tipo_docu char(4) collate SQL_Latin1_General_CP1_CI_AS,  
  serie char(5) null, numero varchar(10) null,   
 total numeric(12,3) null, moneda char(2) collate SQL_Latin1_General_CP1_CI_AS null,   
 estado char(1) , fecha datetime null, cliente char(5) collate SQL_Latin1_General_CP1_CI_AS null,  
 registro varchar(20) collate SQL_Latin1_General_CP1_CI_AS null, codigo varchar(10))  
  
declare @Facturas table (registro varchar(10) collate SQL_Latin1_General_CP1_CI_AS null , importe numeric(12,2) null)  
  
if @tipo_pago ='E'  
begin  
 insert @TempoFact  
 select codi_tipo_docu, ser_Fact, nro_fact,  tota_fact, codi_mone, '0' estado , fech_fact,  
  codi_clie_prov, right(codi_tipo_docu,1) + right(rtrim(ser_fact),2) + rtrim(nro_fact) Registro ,  
  codi_Fact  
 from dbo.factura  (nolock)  
 where  cast( convert(char(10),fech_fact,103) as smalldatetime)  between @fecha_ini and @fecha_fin and   
  codi_tipo_pago = '1' and   
  codi_alma =@almacen and  
  isnull(prov_canc,'0') ='0' and  
  isnull(estado,'')<>'A'  
  and codi_mone=@codi_mone
 --group by codi_tipo_docu, ser_Fact, nro_fact, codi_mone, fech_fact, codi_clie_prov  
end   
  
if @tipo_pago ='C'  
begin  
 insert @TempoFact  
 select codi_tipo_docu, serie, case when isnull(nro_docu,'')='' then nro_recibo else nro_docu end nro_docu, 
	importe , codi_mone, '0' estado, fecha, codi_clie_prov,  
   right(codi_tipo_docu,1) + right(rtrim(serie),2) + rtrim(nro_docu) Registro, nro_recibo  
 from dbo.caja_chica (nolock)  
 where  codi_alma =@almacen and  
  tipo_io = 1 and   
  cast( convert(char(10),fecha,103) as smalldatetime)  between @fecha_ini and @fecha_fin  and  
  isnull(prov_canc,'0') ='0'   
  and codi_tipo_docu in ('0001','0003')  
  and codi_mone=@codi_mone
 --group by codi_tipo_docu, serie, nro_docu, codi_mone,fecha, codi_clie_prov  
end  
  
/*  
--insert @Facturas  
select --registro,sum(case when cargo_abono ='C' then 1 else -1 end * importe ) Saldos   
 registro, fecha, codi_tipo_docu, nro_docu, serie  
from dbo.movi_contables (nolock)   
where registro in (select registro from @tempofact)  
 and cargo_abono='A'   
--group by registro   
--having sum(case when cargo_abono ='C' then 1 else -1 end * importe )<>0  
*/  
  
select tipo_docu , serie , numero ,  total , moneda , estado , cast( convert(char(10),fecha,103) as smalldatetime) fecha ,  
 (select desc_tipo_docu from dbo.tipo_documento (nolock) where tipo_docu= codi_tipo_docu) Documento,  
 (select simbolo from dbo.monedas (nolock) where codi_mone = moneda ) Simbolo,  
 cliente,  
 (select denominacion from dbo.cliente_proveedor (nolock) where codi_clie_prov = cliente) Razon,  
 codigo  
from @TempoFact  
---where registro in (select registro from @Facturas)
GO
