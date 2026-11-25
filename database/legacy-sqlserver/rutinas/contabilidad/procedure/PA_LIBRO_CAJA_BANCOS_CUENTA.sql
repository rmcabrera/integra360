CREATE PROCEDURE [dbo].[PA_LIBRO_CAJA_BANCOS_CUENTA]
	@anio [char](4),
	@mes [char](2),
	@nro_cuen [char](7)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2) , @nro_cuen char(7) 
--select @anio ='2014' , @mes ='03' , @nro_cuen 	='1041221'

set nocount on 

declare @ls_codi_mone_cuen char(2)
declare @desc_mone varchar(20)

declare @fec datetime, @saldo numeric(12,2)

Select @ls_codi_mone_cuen  = isnull(codi_mone , '01' ) From Cuentas_contable (nolock) where nro_cuen = @nro_cuen
select @desc_mone  = desc_mone from monedas (nolock) where codi_mone =@ls_codi_mone_cuen

--if @ls_codi_mone_cuen = '01' 
--if @mes<>'01' 
	Select @saldo= isnull(dbo.F_sald_cuen_mes_inve( @nro_cuen, @mes, @anio, null, 'M', 1,'','') ,0)
	from cuentas_contable (nolock) where nro_cuen = @nro_cuen
--else
	--Select @saldo= isnull(dbo.F_sald_cuen_mes_inve( @nro_cuen, @mes, @anio, null, 'M', 0,'','') ,0)
	--from cuentas_contable (nolock) where nro_cuen = @nro_cuen


/*else
	Select @saldo = isnull(dbo.F_sald_cuen_mes_dola_cart( @nro_cuen, @mes, @anio, null, 'M',  1) ,0)
	from cuentas_contable (nolock) where nro_cuen = @nro_cuen
*/

set @fec=dateadd(dd, -1 , cast('01/'+@mes+'/'+@anio as datetime))

create table #TX(compr varchar(10) null, fecha datetime null, codi int null, glosa varchar(200) null,
		  clie varchar(123) null, serie char(5) null, nro varchar(10) null, cuen char(7) null,
		    descr varchar(100) null, deudo numeric(12,2) null, acree numeric(12,2) null, dolar numeric(12,2) null,
			docu char(4) null, conta char(10) null, banco varchar(50) null, cta varchar(40) null)

create table #rX (compr varchar(10) null, fecha datetime null, codi int null, glosa varchar(200) null,
		  clie varchar(123) null, serie char(5) null, nro varchar(10) null, cuen char(7) null,
		    descr varchar(100) null, deudo numeric(12,2) null, acree numeric(12,2) null, dolar numeric(12,2) null,
			docu char(4) null, conta char(10) null, banco varchar(50) null, cta varchar(40) null, subdia char(1) )

if @mes<>'01' 
	insert #Tx
	select null, @fec, null, 'Saldo Inicial', null, '','', @nro_cuen, 
			(select desc_cuen from cuentas_contable cc (nolock) where cc.nro_cuen = @nro_cuen) as DESC_CUEN,
			case when @saldo<0 then 0 else abs(@saldo) end, 
			case when @saldo<0 then abs(@saldo) else 0 end, 
			0, null, null,
           		(select  DESC_BANC  from    Bancos B (nolock) , cuentas_contable cc (nolock)
			 where   cc.nro_cuen = @nro_cuen and cc.codi_banc = b.codi_banc ) , 	
			(select NRO_CTA_CTE_BANC 
				from cuentas_contable cc (nolock) where cc.nro_cuen = @nro_cuen)-- + ' - ' + @desc_mone 
else
	insert #Tx
	select  null, max(fecha) , null, 'Saldo Inicial' , null, '', '', nro_cuen, 
			(select desc_cuen from cuentas_contable cc (nolock) where cc.nro_cuen = @nro_cuen) as DESC_CUEN,
			case when sum(importe*case when cargo_Abono='C' then 1 else -1 end ) <0 then 0 else abs(sum(importe*case when cargo_Abono='C' then 1 else -1 end ))  end ,
			case when sum(importe*case when cargo_Abono='C' then 1 else -1 end ) <0 then abs(sum(importe*case when cargo_Abono='C' then 1 else -1 end )) else 0 end ,
			0, null, null,
			(select  DESC_BANC  from    Bancos B (nolock) , cuentas_contable cc (nolock)
			 where   cc.nro_cuen = @nro_cuen and cc.codi_banc = b.codi_banc ) , 	
			(select NRO_CTA_CTE_BANC 
				from cuentas_contable cc (nolock) where cc.nro_cuen = @nro_cuen)
	FROM 	movi_contables (nolock)
	WHERE	anio=@anio and mes = @mes and subdia='S' and nro_cuen=@nro_cuen
	group by nro_cuen

create table #Mx (compr char(4) null, subdia char(1) null, anio char(4) null, mes char(2) null, banco char(7) null, codi_vouc char(10) null)

insert #Mx
select  distinct compr, subdia, anio, mes, banco,codi_vouc
	FROM 	movi_contables (nolock)
	WHERE	anio=@anio and mes = @mes and 
			(banco=@nro_cuen or nro_cuen=@nro_cuen) and subdia<>'S' 

insert #Rx
SELECT 	A.compr			,
	fecha			,
	Codi_Tipo_Medio_Pago	,
	glosa			,
	(select case 
		when upper(tipo_pers)='NATURAL' then apel_1+' '+apel_2+ isnull(' '+nomb_1,'')+isnull(' '+nomb_2,'') 
		else razo_soci end 
	from cliente_proveedor C (nolock)
	where c.codi_clie_prov = a.codi_clie_prov ) clie_Prov,
	serie			,
	nro_docu		,
	nro_cuen		,
	(select desc_cuen from cuentas_contable cc (nolock) where cc.nro_cuen = A.nro_cuen) as DESC_CUEN,
	DEUDOR 	 = case when cargo_abono ='A'  THEN IMPORTE ELSE 0 END ,
	ACREEDOR = case when cargo_abono ='C'  THEN IMPORTE ELSE 0 END ,
	DOLAR  	 = case when codi_mone	 ='02' THEN IMPORTE_D 	ELSE 0 END ,
	codi_tipo_docu		,
	codi_contable	,
	(select  DESC_BANC  from    Bancos B (nolock) , cuentas_contable cc (nolock)
	 where   cc.nro_cuen=@nro_cuen and cc.codi_banc = b.codi_banc ) as ENTI_FINAN,
		(select NRO_CTA_CTE_BANC from cuentas_contable cc (nolock) where cc.nro_cuen = @nro_cuen)  as NRO_CTA_CTE,
	a.subdia
FROM 	movi_contables	A (nolock)
join #MX B
on A.anio=B.anio and A.mes=B.mes and A.subdia=B.subdia and A.compr=B.compr
	and A.codi_vouc= b.codi_vouc
		--and A.banco=B.banco


select compr , fecha , codi , glosa ,  clie , serie , nro , cuen ,  descr , deudo , acree , dolar ,docu , conta , banco , cta , @nro_cuen grupo
from #Tx
union all
select compr , fecha , codi , glosa ,  clie , serie , nro , cuen ,  descr , deudo , acree , dolar ,docu , conta , banco , cta , @nro_cuen grupo
from #Rx
where cuen<>@nro_cuen
order by fecha


drop table #Tx
drop table #Rx
GO
