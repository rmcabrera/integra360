CREATE PROCEDURE [dbo].[usp_reporte_registro_vale_efectivo_encol_agro]
	@fec1 [datetime],
	@fec2 [datetime],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime, @fec2 datetime ,@codi_alma char(2)
--select @fec1='06/07/2015', @fec2='06/07/2015',@codi_alma='17'

	select '1 - Efectivo' as  tipo ,max(fecha)as fecha,
		sum(importe)as importe,sum(importe_d)as importe_d  --
		--, sum(importe_cred)as importe_cred,sum(importe_d_cred)as importe_d_cred
	from (
	select 
	cast(convert(char(10),r.fecha,103)as datetime) as fecha, 
	case when codi_tipo_pago=1 then (case when r.codi_mone='01' then r.TOTA_FACT else 0 end) else 0 end importe,
	case when codi_tipo_pago=1 then (case when r.codi_mone='02' then r.TOTA_FACT else 0 end) else 0 end importe_d
	--case when codi_tipo_pago=4 then (case when r.codi_mone='01' then r.TOTA_FACT else 0 end) else 0 end importe_cred,
	--case when codi_tipo_pago=4 then (case when r.codi_mone='02' then r.TOTA_FACT else 0 end) else 0 end importe_d_cred
	
	from registro_vale r(nolock)
--  join caja_chica_depo c(nolock)on c.codi_docu = cast(r.codi_vale as varchar)
--	join depositos d(nolock)on d.codi_depo=c.codi_depo
	where (r.fecha>=@fec1 and r.fecha<DateAdd(day,1,@fec2)) and r.codi_alma=@codi_alma and r.codi_tipo_pago in (1) 
	and isnull(R.estado,'')='')sql		
	group by fecha 
	
	union all
	
	select '2 - Crédito' as tipo,
	cast(convert(char(10),d.fecha_depo,103)as datetime) as fecha, 
	--case when codi_tipo_pago=1 then (case when r.codi_mone='01' then c.importe else 0 end) else 0 end importe,
	--case when codi_tipo_pago=1 then (case when r.codi_mone='02' then c.importe else 0 end) else 0 end importe_d,
	case when codi_tipo_pago=4 then (case when r.codi_mone='01' then c.importe else 0 end) else 0 end importe_cred,
	case when codi_tipo_pago=4 then (case when r.codi_mone='02' then c.importe else 0 end) else 0 end importe_d_cred	
--	,r.estado
	from registro_vale r(nolock)
	join caja_chica_depo c(nolock)on c.codi_docu = cast(r.codi_vale as varchar)
	join depositos d(nolock)on d.codi_depo=c.codi_depo
	where (d.fecha_depo>=@fec1 and d.fecha_depo<DateAdd(day,1,@fec2)) and r.codi_alma=@codi_alma and r.codi_tipo_pago in (4) 
--		and isnull(R.estado,'')=''
GO
