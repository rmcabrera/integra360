CREATE PROCEDURE [dbo].[usp_reporte_vende_x_fact_resu_tipo_pago]
	@fec1 [datetime],
	@fec2 [datetime],
	@alma [char](2),
	@vende [char](5)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime , @fec2 datetime, @alma char(2), @vende char(5)
--select @fec1 ='01/01/2020' , @fec2='31/01/2020' , @alma ='06', @vende=''

set nocount on
set QUOTED_IDENTIFIER OFF

declare @SQLSTRING nvarchar(4000)
declare @Condi varchar(100)
declare @ParmString nvarchar(100)

declare @Tx table(documento varchar(50) null, ser_fact varchar(20) null, nro_fact varchar(20) null,
				  codi_tipo_docu char(5) null, cod_usua_vende char(5) null, codi_mone char(2) null, 
				  subtota_fact numeric(12,4) null, tota_exonerado numeric(12,4) null, igv_fact numeric(12,4) null,
				  tota_fact decimal(12,3) null,
				  hora_reg char(10) null, desc_tipo_medio_pago varchar(25) null, estado char(1) null)

set @ParmString = "@fec1 as datetime, @fec2 as datetime "
if @alma ='' or @alma is null set @Condi='' else set @Condi=" and F.codi_alma =" +@alma

set @SQLString ="select (select desc_tipo_docu from tipo_documento T (nolock) where T.codi_tipo_docu=f.codi_tipo_docu) Documento, 
		ser_fact ser_fact, nro_fact nro_fact, 
		F.codi_tipo_docu, 
		
		f.cod_usua_vende, F.codi_mone codi_mone,
		
		subtota_fact, tota_exonerado, igv_fact, tota_fact,
		
		convert(char(8),creacion,108) as hora_reg,
		(select desc_tipo_medio_pago from tipo_pago TP(nolock) where TP.codi_tipo_medio_pago=F.codi_tipo_pago) as desc_tipo_medio_pago, estado
		
	from factura F (nolock) 
	where cast(convert(char(10),fech_fact,103) as smalldatetime) between @fec1 and @fec2 and isnull(F.estado,'')<> 'A'  " +@Condi 
	

insert @Tx
execute sp_executesql @SQLString, @ParmString, @fec1=@fec1, @fec2=@fec2

declare @Rx table(turno_m int null, turno_t int null)

insert @Rx
select sum(turno_m) turno_m, sum(turno_t) turno_t
from(
select case when hora_reg>='06:00:00' and hora_reg<='14:00:00' then 1 else 0 end turno_m,
	   case when hora_reg>='14:01:00' and hora_reg<='19:00:00' then 1 else 0 end turno_t
from @Tx
where (cod_usua_vende=@vende or (@vende='' or @vende is null) )
) as T

select sum(efec_s_valor_m) efec_s_valor_m, sum(efec_s_exo_m) efec_s_exo_m, sum(efec_s_igv_m) efec_s_igv_m, sum(efec_s_total_m) efec_s_total_m,
	   sum(efec_d_valor_m) efec_d_valor_m, sum(efec_d_exo_m) efec_d_exo_m, sum(efec_d_igv_m) efec_d_igv_m, sum(efec_d_total_m) efec_d_total_m,
	   sum(cred_s_valor_m) cred_s_valor_m, sum(cred_s_exo_m) cred_s_exo_m, sum(cred_s_igv_m) cred_s_igv_m, sum(cred_s_total_m) cred_s_total_m,
	   sum(cred_d_valor_m) cred_d_valor_m, sum(cred_d_exo_m) cred_d_exo_m, sum(cred_d_igv_m) cred_d_igv_m, sum(cred_d_total_m) cred_d_total_m,
	   sum(total_s_valor_m) total_s_valor_m, sum(total_s_exo_m) total_s_exo_m, sum(total_s_igv_m) total_s_igv_m, sum(total_s_total_m) total_s_total_m,
	   sum(total_d_valor_m) total_d_valor_m, sum(total_d_exo_m) total_d_exo_m, sum(total_d_igv_m) total_d_igv_m, sum(total_d_total_m) total_d_total_m,
	   
	   sum(efec_s_valor_t) efec_s_valor_t, sum(efec_s_exo_t) efec_s_exo_t, sum(efec_s_igv_t) efec_s_igv_t, sum(efec_s_total_t) efec_s_totafact_t,
	   sum(efec_d_valor_t) efec_d_valor_t, sum(efec_d_exo_t) efec_d_exo_t, sum(efec_d_igv_t) efec_d_igv_t, sum(efec_d_total_t) efec_d_totafact_t,
	   sum(cred_s_valor_t) cred_s_valor_t, sum(cred_s_exo_t) cred_s_exo_t, sum(cred_s_igv_t) cred_s_igv_t, sum(cred_s_total_t) cred_s_totafact_t,
	   sum(cred_d_valor_t) cred_d_valor_t, sum(cred_d_exo_t) cred_d_exo_t, sum(cred_d_igv_t) cred_d_igv_t, sum(cred_d_total_t) cred_d_totafact_t,
	   sum(total_s_valor_t) total_s_valor_t, sum(total_s_exo_t) total_s_exo_t, sum(total_s_igv_t) total_s_igv_t, sum(total_s_total_t) total_s_total_t,
	   sum(total_d_valor_t) total_d_valor_t, sum(total_d_exo_t) total_d_exo_t, sum(total_d_igv_t) total_d_igv_t, sum(total_d_total_t) total_d_total_t,
	   
	   sum(efec_s_valor) efec_s_valor, sum(efec_s_exo) efec_s_exo, sum(efec_s_igv) efec_s_igv, sum(efec_s_total) efec_s_total,
	   sum(efec_d_valor) efec_d_valor, sum(efec_d_exo) efec_d_exo, sum(efec_d_igv) efec_d_igv, sum(efec_d_total) efec_d_total,
	   sum(cred_s_valor) cred_s_valor, sum(cred_s_exo) cred_s_exo, sum(cred_s_igv) cred_s_igv, sum(cred_s_total) cred_s_total,
	   sum(cred_d_valor) cred_d_valor, sum(cred_d_exo) cred_d_exo, sum(cred_d_igv) cred_d_igv, sum(cred_d_total) cred_d_total,
	   sum(total_s_valor) total_s_valor, sum(total_s_exo) total_s_exo, sum(total_s_igv) total_s_igv, sum(total_s_total) total_s_total,
	   sum(total_d_valor) total_d_valor, sum(total_d_exo) total_d_exo, sum(total_d_igv) total_d_igv, sum(total_d_total) total_d_total,
	   
	   (select turno_m from @Rx) as turno_m, (select turno_t from @Rx) as turno_t
from(
select 
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then subtota_fact else 0 end efec_s_valor_m,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_exonerado else 0 end efec_s_exo_m,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then igv_fact else 0 end efec_s_igv_m,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_fact else 0 end efec_s_total_m,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then subtota_fact else 0 end efec_d_valor_m,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_exonerado else 0 end efec_d_exo_m,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then igv_fact else 0 end efec_d_igv_m,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_fact else 0 end efec_d_total_m,
	   
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then subtota_fact else 0 end cred_s_valor_m,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_exonerado else 0 end cred_s_exo_m,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then igv_fact else 0 end cred_s_igv_m,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_fact else 0 end cred_s_total_m,						
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then subtota_fact else 0 end cred_d_valor_m,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_exonerado else 0 end cred_d_exo_m,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then igv_fact else 0 end cred_d_igv_m,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_fact else 0 end cred_d_total_m,	
		
case when codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then subtota_fact else 0 end total_s_valor_m,
case when codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_exonerado else 0 end total_s_exo_m,
case when codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then igv_fact else 0 end total_s_igv_m,
case when codi_mone='01' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_fact else 0 end total_s_total_m,		
case when codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then subtota_fact else 0 end total_d_valor_m,
case when codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_exonerado else 0 end total_d_exo_m,
case when codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then igv_fact else 0 end total_d_igv_m,
case when codi_mone='02' and (hora_reg>='06:00:00' and hora_reg<='15:00:00') then tota_fact else 0 end total_d_total_m,
					
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then subtota_fact else 0 end efec_s_valor_t,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_exonerado else 0 end efec_s_exo_t,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then igv_fact else 0 end efec_s_igv_t,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_fact else 0 end efec_s_total_t,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then subtota_fact else 0 end efec_d_valor_t,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_exonerado else 0 end efec_d_exo_t,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then igv_fact else 0 end efec_d_igv_t,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_fact else 0 end efec_d_total_t,

case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then subtota_fact else 0 end cred_s_valor_t,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_exonerado else 0 end cred_s_exo_t,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then igv_fact else 0 end cred_s_igv_t,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_fact else 0 end cred_s_total_t,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then subtota_fact else 0 end cred_d_valor_t,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_exonerado else 0 end cred_d_exo_t,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then igv_fact else 0 end cred_d_igv_t,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_fact else 0 end cred_d_total_t,

case when codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then subtota_fact else 0 end total_s_valor_t,
case when codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_exonerado else 0 end total_s_exo_t,
case when codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then igv_fact else 0 end total_s_igv_t,
case when codi_mone='01' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_fact else 0 end total_s_total_t,		
case when codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then subtota_fact else 0 end total_d_valor_t,
case when codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_exonerado else 0 end total_d_exo_t,
case when codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then igv_fact else 0 end total_d_igv_t,
case when codi_mone='02' and (hora_reg>'15:00:00' and hora_reg<='21:00:00') then tota_fact else 0 end total_d_total_t,

case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' then subtota_fact else 0 end efec_s_valor,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' then tota_exonerado else 0 end efec_s_exo,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' then igv_fact else 0 end efec_s_igv,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='01' then tota_fact else 0 end efec_s_total,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' then subtota_fact else 0 end efec_d_valor,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' then tota_exonerado else 0 end efec_d_exo,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' then igv_fact else 0 end efec_d_igv,
case when upper(desc_tipo_medio_pago)='EFECTIVO' and codi_mone='02' then tota_fact else 0 end efec_d_total,
	   
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' then subtota_fact else 0 end cred_s_valor,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' then tota_exonerado else 0 end cred_s_exo,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' then igv_fact else 0 end cred_s_igv,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='01' then tota_fact else 0 end cred_s_total,						
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' then subtota_fact else 0 end cred_d_valor,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' then tota_exonerado else 0 end cred_d_exo,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' then igv_fact else 0 end cred_d_igv,
case when upper(desc_tipo_medio_pago)='CREDITO' and codi_mone='02' then tota_fact else 0 end cred_d_total,
		
case when codi_mone='01' then subtota_fact else 0 end total_s_valor,
case when codi_mone='01' then tota_exonerado else 0 end total_s_exo,
case when codi_mone='01' then igv_fact else 0 end total_s_igv,
case when codi_mone='01' then tota_fact else 0 end total_s_total,		
case when codi_mone='02' then subtota_fact else 0 end total_d_valor,
case when codi_mone='02' then tota_exonerado else 0 end total_d_exo,
case when codi_mone='02' then igv_fact else 0 end total_d_igv,
case when codi_mone='02' then tota_fact else 0 end total_d_total

--, upper(desc_tipo_medio_pago) desc_tipo_medio_pago, codi_mone
				   
from @Tx
where (cod_usua_vende=@vende or (@vende='' or @vende is null) )
) as SQL

--group by desc_tipo_medio_pago, codi_mone
GO
