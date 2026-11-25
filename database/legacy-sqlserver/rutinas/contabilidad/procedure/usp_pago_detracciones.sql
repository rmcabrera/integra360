CREATE PROCEDURE [dbo].[usp_pago_detracciones]
	@fecha [datetime],
	@sub [char](1)
WITH EXECUTE AS CALLER
AS
--declare @Fecha datetime , @sub char(1)
--select @fecha='16/12/2014', @sub='C'

set nocount on

declare @anio char(4), @Cta char(1) ,@Tca char(1)

set @anio = year(@fecha)

declare @Tx table (nro_cuen char(7) null, codi_clie_prov char(5) null, registro varchar(11) null, importe numeric(12,2) null, dolares numeric(12,2) null, codi_mone char(2) null)

declare @Rx table (nro_cuen char(7) null, codi_clie_prov char(5) null, registro varchar(11) null, anio int null, mes char(2) null, compr varchar(10) null,
			subdia char(1) null, codi_bien_serv char(5) null, codi_oper char(2) null, pdetr numeric(12,2) null,
			codi_tipo_docu char(4) null,  serie char(5) null, nro_docu varchar(20) null, importe numeric(12,2) null, codi_mone char(2) null,
			tpc numeric(12,6) null, regcompr varchar(11) null, fecha datetime null)
if @sub='C'
begin
	set @Cta='4' 
	set @Tca='A'
end
else 
begin
	set @Cta='1'
	set @Tca='C'
end

insert @TX
select nro_cuen, codi_clie_prov, registro  , 
	sum(importe*case when cargo_abono=@Tca then 1 else -1 end),
	sum(importe_d*case when cargo_abono=@Tca then 1 else -1 end) , '01' codi_mone
from movi_contables (nolock)
where anio=@anio and cast(convert(char(10),fecha,103) as datetime)<=@fecha and PATINDEX ( '%D%' , registro )>0 
	and left(nro_Cuen,1)=@Cta
	and registro not in (select isnull(D.registro,'') from detalle_detraccion D (nolock))
group by /*codi_mone,*/ nro_cuen, codi_clie_prov, registro 
having sum(importe* case when cargo_abono='C' then 1 else -1 end)<>0


insert @Rx
select x.nro_cuen, X.codi_clie_prov, X.reg,  X.anio, X.mes, X.compr, X.subdia, codi_bien_serv, codi_oper, pdetr,
	c.codi_tipo_docu, c.serie, c.nro_docu, case when codi_mone='01' then c.importe else importe_D end importe,c.codi_mone, c.tipo_cambio,
	x.registro, c.fecha
from movi_contables c( nolock)
join 
 (select A.registro, B.compr, B.anio, b.mes, A.subdia , A.codi_clie_prov, b.nro_cuen, b.registro reg
	from movi_contables  A (nolock)
	join (select anio, mes, compr, registro, codi_clie_prov, nro_docu, nro_cuen
		from movi_contables (nolock)  
			where registro in (select R.registro from @TX R) and subdia='D') B
	on A.anio=b.anio and a.mes=B.mes and A.compr=B.compr
	where  A.subdia='D' and  ( PATINDEX ( '%C%' , A.registro )>0 or left(B.nro_Cuen,1)='1') ) X
on C.registro=X.registro
where C.subdia=@Sub and C.detraccion=1


select A.nro_cuen, A.codi_clie_prov, A.registro, 	
	case when B.codi_mone='01' then a.importe else
		round(/*B.importe * pdetr **/ dolares * (SELECT venta from tipo_cambio_a_dolar (nolock) 
			where codi_mone_camb='02' and fech_camb=cast(convert(char(10), fecha, 103) as datetime)),0) end importe,

	anio, mes, compr, subdia , codi_bien_serv, codi_oper, pdetr,
	(select ruc from empresa (nolock)) rucadqui,
	(select ruc from cliente_proveedor C (nolock) where C.codi_clie_prov=a.codi_clie_prov) Rucprovee,
	(select case when left(tipo_pers,1)='N' then apel_1+isnull(' ' + apel_2,'')  + isnull(' '  + nomb_1,'')  + isnull(' ' +nomb_2,'')
			else isnull(razo_soci, denominacion) end from cliente_proveedor C(nolock) where c.codi_clie_prov=A.codi_clie_prov) Proveedor,
	(select razon_social from empresa (nolock))  Empresa,
	B.importe Original, A.codi_mone, b.tpc, 0 depoprov, 1 depoadqu, 0 estado,
	(select desc_tipo_docu from tipo_documento T (nolock) where T.codi_tipo_docu=B.codi_tipo_docu) Docu, serie, nro_docu, 
	isnull(dolares,0) dolares,
	cast(convert(char(10),getdate(),103) as datetime) fechapago, 
	(SELECT venta from tipo_cambio_a_dolar (nolock) where codi_mone_camb='02' and fech_camb=cast(convert(char(10),getdate(),103) as datetime) ) tipocambio,
	isnull((Select top 1 nro_cta_cte 
		from cta_cte_prov C (nolock)
		where C.codi_clie_prov = a.codi_clie_prov and C.detraccion = 1),'') nro_cta_cte, RegCompr, B.codi_tipo_docu
from @TX A 
join @RX B
on A.registro=B.registro and A.codi_clie_prov=B.codi_clie_prov
--where B.registro='412D0013'
order by anio, mes, compr
GO
