CREATE PROCEDURE [dbo].[usp_reporte_detalle_kardex]
	@anio [int],
	@fecha1 [datetime],
	@fecha2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio int, @fecha1 datetime,  @fecha2 datetime,  @alma char(2)
--select @anio=2012, @fecha1='01/04/2012', @fecha2='30/04/2012',  @alma='00'

set nocount on
declare @almax table (codi_alma char(2) null)
declare @Tx table (codi_prod char(8) null, nro_cuen char(7) null, codi_alma char(2) null, almacen varchar(150) null, desc_prod varchar(150) null,
		   unidad char(5) null, anterior numeric(12,4) null, ingreso numeric(12,4) null, salida numeric(12,4) null, Saldo numeric(12,4) null,
		   anteValo numeric(12,4) null, ingresoValo numeric(12,4) null, salidaValo numeric(12,4) null, SaldoValo numeric(12,4) null,
		   empresa varchar(150) null )
if @alma = '00'
begin
	insert @almax
	Select codi_alma from dbo.almacen (nolock)
end 
else
begin	insert @almax
	Select codi_alma from dbo.almacen (nolock) where codi_alma = @alma
end


if @alma = '00'
begin 
	insert @Tx
	select 	A.codi_prod, nro_cuen,max(codi_alma) codi_alma,
		/*(select DESC_ALMA 
			from almacen X (nolock) where X.codi_alma=A.codi_alma)*/ '' almacen,
		max(lTRIM(desc_prod)) desc_prod,
		(select simb_unid_medi from unidad_medida U (nolock) 
			where u.codi_unid_medi= max(B.codi_unid_medi)) Unidad,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) < @fecha1 then cant_ingr - cant_sali else 0 end ) anterior,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) between @fecha1 and @fecha2 then cant_ingr else 0 end ) ingreso,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) between @fecha1 and @fecha2  then cant_sali else 0 end ) salida,
		sum(cant_ingr - cant_sali)  Saldo,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) < @fecha1 then valo_ingr - valo_sali else 0 end ) anteValo,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) between @fecha1 and @fecha2 then valo_ingr else 0 end ) ingresoValo,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) between @fecha1 and @fecha2  then valo_sali else 0 end ) salidaValo,
		sum( valo_ingr - valo_sali)  SaldoValo, (select razon_social from dbo.empresa (nolock)) empresa
	from kardex A (nolock)
	join productos B (nolock)
	on A.codi_prod=B.codi_prod 
	where periodo=@anio and 
		--isnull(codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @almax) and
		cast( convert(char(10), fech_tran,103) as datetime) <= @fecha2 
		--and A.codi_prod='41130003'
	group by a.codi_prod, B.nro_cuen
	order by desc_prod

end

if @alma <> '00'
begin 
	insert @Tx
	select 	A.codi_prod, nro_cuen,codi_alma,
		(select DESC_ALMA 
			from almacen X (nolock) where X.codi_alma=A.codi_alma) almacen,
		max(lTRIM(desc_prod)) desc_prod,
		(select simb_unid_medi from unidad_medida U (nolock) 
			where u.codi_unid_medi= max(B.codi_unid_medi)) Unidad,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) < @fecha1 then cant_ingr - cant_sali else 0 end ) anterior,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) between @fecha1 and @fecha2 then cant_ingr else 0 end ) ingreso,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) between @fecha1 and @fecha2  then cant_sali else 0 end ) salida,
		sum(cant_ingr - cant_sali)  Saldo,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) < @fecha1 then valo_ingr - valo_sali else 0 end ) anteValo,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) between @fecha1 and @fecha2 then valo_ingr else 0 end ) ingresoValo,
		sum(case when cast( convert(char(10), fech_tran,103) as datetime) between @fecha1 and @fecha2  then valo_sali else 0 end ) salidaValo,
		sum( valo_ingr - valo_sali)  SaldoValo, (select razon_social from dbo.empresa (nolock)) empresa
	from kardex A (nolock)
	join productos B (nolock)
	on A.codi_prod=B.codi_prod 
	where periodo=@anio and 
		isnull(codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @almax) and
		cast( convert(char(10), fech_tran,103) as datetime) <= @fecha2 
		--and A.codi_prod='41130003'
	group by codi_alma, a.codi_prod, B.nro_cuen
	order by desc_prod

end

select  codi_prod , nro_cuen , codi_alma , almacen , desc_prod ,
		   unidad , anterior , ingreso , salida , Saldo ,
		   anteValo, ingresoValo , salidaValo , SaldoValo , empresa 
from @Tx
where (anterior<>0 or ingreso<>0 or salida<>0 or Saldo<>0 or
   anteValo<>0 or ingresoValo<>0 or salidaValo<>0 or SaldoValo<>0)
order by desc_prod
GO
