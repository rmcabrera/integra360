CREATE PROCEDURE [dbo].[usp_resumen_caja_deposito]
	@alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime,@fec2 datetime, @alma char(2)
--SELECT @fec1='01/11/2024', @FEC2='07/11/2024' , @alma ='00'

set nocount on 

declare @Tx table (idd int null, codi_depo varchar(10) null, nro_cuen char(7) null, codi_alma char(2) null,
			nro_oper varchar(20) null, fecha datetime null, codi_respo char(5) null, codi_usua_soli char(5) null, codi_mone char(2) null,
			importe numeric(12,2) null, importe_d numeric(12,2) null, glosa varchar(156) null, responsable varchar(150) null, suc varchar(50) null,
			solicitante varchar(150) null, banco varchar(200) null, fecha_depo datetime null, tipo_depo varchar(50) null,
			deposita numeric(12,2) null, deposita_d numeric(12,2) null)

insert @Tx			
SELECT 2 idd, DEPOSITOS.codi_depo,   
         DEPOSITOS.nro_cuen,   
         DEPOSITOS.codi_alma,   
         DEPOSITOS.nro_oper,   
         DEPOSITOS.fecha,   
         DEPOSITOS.codi_respo,   
         DEPOSITOS.codi_usua_soli,   
         DEPOSITOS.codi_mone,   
		case when codi_mone='01' then importe else 0.00 end importe,
		case when codi_mone='02' then importe else 0.00 end importe_d,
         DEPOSITOS.glosa  ,
		'  ' + (select denominacion from dbo.cliente_proveedor C (nolock) where C.codi_clie_prov=codi_respo) responsable,
		(SELECT NEMO_ALMA FROM dbo.ALMACEN A (nolock) WHERE A.CODI_ALMA=depositos.CODI_ALMA) suc,
		(select isnull(apel_1,'')+' '+isnull(nomb_1,'') from dbo.usuarios U (nolock) where U.codi_usua=codi_usua_soli) Solicitante,
		(Select desc_cuen FROM CUENTAS_CONTABLE C (nolock) WHERE c.NRO_CUEN= depositos.nro_cuen) banco,
		fecha_depo, case when DEPOSITOS.tipo='V' then 'V. Efect.' else 
								(case when DEPOSITOS.tipo='C' then 'C. Créd.' else 
										case when DEPOSITOS.tipo='S' then 'Admin.' else 'C. Docs' end end) end tipo_depo, null, null
    FROM DEPOSITOS (nolock)
	where (fecha>=@fec1 and fecha<DateAdd(day,1,@fec2)) and (isnull(@alma,'')='00' or codi_alma=@alma) and tipo<>'S'
	--and codi_depo not in ('HUD000002')
union all
select 1 idd, '', '', codi_alma, '', cast(convert(char(10), fecha , 103) as datetime ) fecha, '','', '', sum(importe), sum(importe_d), '', '',
		(SELECT NEMO_ALMA FROM dbo.ALMACEN A (nolock) WHERE A.CODI_ALMA=@ALMA) suc,'','SALDO DE CAJA', cast(convert(char(10), fecha , 103) as datetime ), '',
		null, null
from 
	(select 1 tipo , max(fech_fact) fecha , cast(count(nro_fact) as varchar(10)) +' Docs' nro_docu ,'VENTAS DEL PERIODO ' glosa,
	SUM(case when codi_mone='01' then TOTA_FACT else 0 end) importe,
	SUM(case when codi_mone='02' then TOTA_FACT else 0 end) importe_d,
	(SELECT NEMO_ALMA FROM dbo.ALMACEN (nolock) WHERE CODI_ALMA=F.CODI_ALMA) suc ,
	'CLIENTES VARIOS' deno , cast ( null as datetime) hora_real,'00000' codi_clie, 
	(select count(*) from caja_cierre where codi_alma=@alma and cast(convert(char(10),fecha ,103 ) as datetime ) =@fec1) est_cierre,'' nd,
		(select id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = '000') id_rubro,
		(select   (select desc_rubro from rubros_Caja X (nolock) 
				where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = '000') 
				and i_o=1)) desc_rubro,
		(select  (select i_o from rubros_Caja X (nolock) 
				where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = '000')
				and i_o=1)) i_o, F.codi_alma
	
	from dbo.factura F (nolock)
	where  (fech_fact>=@fec1 and fech_fact<DateAdd(day,1,@fec2)) and isnull(estado,'')<>'A' and codi_tipo_pago=1 and (isnull(@alma,'')='00' or codi_alma=@alma)
	group by codi_alma, fech_fact
	union all
	select cc.tipo_io tipo , cc.fecha fecha , cc.nro_recibo nro_docu, 
	(isnull(glosa,(select desc_reemb from dbo.tipo_reembolso (nolock) where tipo_reemb=tipo_contab))+' / '+
	(case when codi_usua_soli is null then (select top 1 lower(razon_social) from dbo.empresa (nolock) ) else
	(select isnull(apel_1,'')+' '+isnull(nomb_1,'') from dbo.usuarios (nolock) where codi_usua=codi_usua_soli) end)) glosa,
	SUM(case when cc.codi_mone='01' then cc.importe else 0 end)* case when tipo_io=0 then -1 else 1 end  importe,
	SUM(case when cc.codi_mone='02' then cc.importe else 0 end)* case when tipo_io=0 then -1 else 1 end importe_d,
	(SELECT NEMO_ALMA FROM dbo.ALMACEN (nolock) WHERE CODI_ALMA=cc.CODI_ALMA) suc ,
	(select denominacion from dbo.cliente_proveedor (nolock) where codi_clie_prov=cc.codi_clie_prov) deno , max(hora_real) hora_real, codi_clie_prov codi_clie,
	(select count(*) from caja_cierre where codi_alma=@alma and cast(convert(char(10),fecha ,103 ) as datetime ) =@fec1) est_cierre,isnull(max(nro_docu),'') nd,
		(select id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb = tipo_contab and r.i_o=tipo_io) id_rubro,
		(select (select desc_rubro from rubros_Caja X (nolock) 
				where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb =tipo_contab and r.i_o=tipo_io)
						and X.i_o=tipo_io)) desc_rubro,
		(select (select i_o from rubros_Caja X (nolock) 
				where X.id_rubro in (select R.id_rubro from rubros_caja_detalle R (nolock) where r.tipo_reemb =tipo_contab  and r.i_o=tipo_io)
					and X.i_o=tipo_io)) i_o, cc.codi_alma
	from dbo.caja_chica cc (nolock)
	where cc.fecha>=@fec1 and cc.fecha<=@fec2 and (isnull(@alma,'')='00' or cc.codi_alma=@alma) AND isnull(dscto_adm,'0')<>'1'
	group by  cc.CODI_ALMA , cc.codi_clie_prov , cc.tipo_io , cc.fecha, cc.nro_recibo, cc.glosa, tipo_contab, codi_usua_soli) SQL
group by cast(convert(char(10), fecha , 103) as datetime), codi_alma  
order by fecha, idd, nro_cuen

declare @Px table (fecha datetime, saldo numeric(12,2), saldo_d numeric(12,2))


insert @PX
select fecha, sum(importe* case when idd=1 then 1 else -1  end ) as Saldo,
		sum(importe_d* case when idd=1 then 1 else -1  end ) as SaldoD
from @tx  as  SQ
group by fecha
having sum(importe* case when idd=1 then 1 else -1  end )<>0
		or sum(importe_d* case when idd=1 then 1 else -1  end )<>0

/*
declare @fx datetime, @impox numeric(12,2), @impox_d numeric(12,2)
declare @suma_impox numeric(12,2), @suma_impox_d numeric(12,2), @gr int, @indi int

declare @Rx table(fecha datetime null, importe numeric(12,2) null, importe_d numeric(12,2) null, 
                  deposita numeric(12,2) null, deposita_d numeric(12,2) null, grupo int)

set @suma_impox = 0
set @suma_impox_d = 0
set @gr = 0

declare depos cursor for
select fecha, 
	   sum(importe * case when idd=1 then 1 else -1 end) importe, 
	   sum(importe_d * case when idd=1 then 1 else -1 end) importe_d,
	   case when idd=2 then 1 else 0 end indi
	   
from @Tx
--where fecha<>'23/12/2020'
group by fecha, idd
order by fecha

open depos
fetch next from depos

into @fx, @impox, @impox_d, @indi

while @@fetch_status = 0
begin
	
	set @suma_impox = @suma_impox + @impox
	set @suma_impox_d = @suma_impox_d + @impox_d
	set @gr = @gr + 1
	
	if @indi=1
	begin
		insert @Rx
		select @fx, @impox, @impox_d, @suma_impox, @suma_impox_d, null
		
		set @suma_impox = 0
		set @suma_impox_d = 0
	end
	/*else
	begin
		insert @Rx
		select @fx, @impox, @impox_d, null, null, null
		
		update @Rx set grupo = @gr where fecha<=@fx and grupo is null
		
		update @Rx set deposita = @suma_impox, deposita_d = @suma_impox_d where fecha=@fx
		
		set @suma_impox = 0
		set @suma_impox_d = 0
	end*/
		
	fetch next from depos
	into @fx, @impox, @impox_d, @indi

end

close depos;
deallocate depos;

--select * from @Rx
--return

declare @RxT table(fec datetime , codi varchar(10) null, deposita numeric(12,2) null, deposita_d numeric(12,2) null)

insert @RxT
select T.fecha, max(codi_depo) as codi_depo, max(R.deposita) deposita, max(R.deposita_d) deposita_d
from @Tx as T
join @Rx as R
on T.fecha = R.fecha
--where R.deposita is not null
group by T.fecha
order by codi_depo desc

update @Tx set deposita = RT.deposita, deposita_d = RT.deposita_d
from @Tx T
join @RxT RT on fecha=fec and codi_depo=codi
*/

if @alma<>'00'
begin
	select idd , codi_depo , nro_cuen , codi_alma ,
			nro_oper , fecha , codi_respo , codi_usua_soli , codi_mone ,
			importe , importe_d , 
			glosa , responsable , suc ,
			solicitante , banco , fecha_depo , tipo_depo,
			case when isnull((select count(*) from @Px X where x.fecha=T.fecha),0) = 0 then 'Depositado' else 'Pendiente' end as EstadoP,
			/*isnull((select deposita from @RxT R where fec=T.fecha and codi=codi_depo),0)*/ null as deposita,
			/*isnull((select deposita_d from @RxT R where fec=T.fecha and codi=codi_depo),0)*/ null as deposita_d
				
	from @Tx as T
end
else
begin
	select codi_alma ,
			(select nemo_alma from almacen A(nolock) where A.codi_alma=T.codi_alma) as sucursal,
		   sum(importe * case when idd=1 then 1 else -1 end) as importe,
		   sum(importe_d * case when idd=1 then 1 else -1 end) as importe_d
				
	from @Tx as T
	group by codi_alma
	order by codi_alma
end
GO
