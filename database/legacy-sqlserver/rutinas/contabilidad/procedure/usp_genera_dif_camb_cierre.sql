CREATE PROCEDURE [dbo].[usp_genera_dif_camb_cierre]
	@fec [datetime],
	@anio [char](4),
	@hecho [char](5)
WITH EXECUTE AS CALLER
AS
--declare @fec datetime , @anio char(4), @hecho char(5)
--select @fec ='31/07/2021' , @anio ='2021' , @hecho='00000' 

set nocount on 
set quoted_identifier off

declare @errno  int,@errmsg	varchar(255), @error varchar(10)

create table #Tx (cuenta varchar(7) null)
create table #Reporte ( codi_tipo_docu char(4) null, cod varchar(10) null, codi_clie_prov char(5) null,
			imp numeric(12,2) null, impd numeric(12,2) null, Fs datetime null, fo datetime null,
			registro varchar(11) null, nro_cuen char(7) null, razon varchar(250) null, ruc varchar(15) null,
			razon_social varchar(250) null, desc_cuen varchar(250) null,  nro_docu varchar(20) null,
			compr varchar(10) null, subdia char(1) null, fv datetime null, anio int, mes char(2) null,
			codi_mone char(2) null, tipo_cambio numeric(12,4) null, glosa varchar(250) null, serie varchar(5) null,
			codi_unid_oper char(5) null, cargo_abono char(1) null, importe numeric(12,2) null/*, TPCConver numeric(12,6) null ,
			IMPORTEORI numeric(12,2) null, soles numeric(12,2) null , dolares numeric(12,2) null, dias int null*/) 

create table #Mx (codi_clie_prov char(5) null, nrocuen char(7) null, registro char(11) null, fs datetime null, fo datetime null,
					imp numeric(12,2) null, impd numeric(12,2) null, fv datetime null)
					
create table #Cx (codi_contable char(10) null)
					
declare @ct int
declare @Ax varchar(255), @Inser varchar(7), @SQLString nvarchar(4000), @ParmString nvarchar(100)
declare @Condi varchar(200), @ms char(2), @glos varchar(250)
declare @cu6 char(7), @ls_unid char(5), @cu7 char(7), @scu6 char(7), @scu7 char(7)
declare @Var char(5)

set @ms= right('0'+cast(month(@fec) as varchar),2)

select @Var= codi_clie_prov from cliente_proveedor (nolock) where razo_soci='VARIOS'
if @Var is null or rtrim(@Var)='' set @Var='00000'


set @glos='Ajuste por diferencia de Cambio de '+ dbo.uf_nom_mes(cast(@ms as int))+ ' del '+@anio

set @ls_unid= null
Select @cu6 = Cuenta /*, @ls_unid= codi_unid_oper */  From Cuentas_Provision (nolock) Where Codigo = '17'
Select @cu7 = Cuenta From Cuentas_Provision  (nolock) Where Codigo = '18'

select @scu6 = nro_sub_cuen   from cuentas_contable  (nolock) where nro_cuen=@cu6
select @scu7 = nro_sub_cuen from cuentas_contable  (nolock) where nro_cuen=@cu7

set  @ct=0

set @condi=''

set @ParmString  = " @fec datetime "


------------------ para el cierre por diferencia de cambios
set @SQLString="SELECT codi_clie_prov,M.nro_cuen,registro,
					max(fecha) as FS, min(fecha) as FO, 
					isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0) Imp,
					isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0) ImpD, 
					Max(fecha_venc) FV
			From movi_contables M (nolock)
			join cuentas_contable C (nolock) on M.nro_cuen=C.nro_cuen
			where anio ='"+@anio +"' and mes <= month(@fec) and fecha <= @fec and genera_dif='1' and not (registro is null or ltrim(registro)='') 
			Group by codi_clie_prov,M.nro_cuen,registro 
			Having not (isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0)=0
					and isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0)=0)"
		
		Insert #Mx
		execute sp_executesql @Sqlstring, @ParmString, @fec=@fec

		insert #Cx
		SELECT MIN(codi_contable) FROM  movi_contables X (nolock)
			WHERE X.nro_cuen in (select C.nro_cuen from cuentas_contable C (nolock) where genera_dif='1') and 
			NOT (registro IS NULL OR registro = '') and fecha <= @fec 
		GROUP BY X.codi_clie_prov, X.registro, X.nro_cuen	
		
		insert #Reporte (codi_tipo_docu, cod, codi_clie_prov, imp, impd, Fs, fo, registro, nro_cuen, razon, ruc, razon_social, desc_cuen,  nro_docu,
		compr, subdia, fv, anio, mes, codi_mone, tipo_cambio, glosa, serie, codi_unid_oper, cargo_abono, importe)  
		
		select codi_tipo_docu, M.codi_contable COD, M.codi_clie_prov, Imp, ImpD, FS, FO, 
			M.Registro , M.nro_cuen,
			(Select denominacion from cliente_proveedor Cx (nolock) where Cx.codi_clie_prov=M.codi_clie_prov) razon,
			(Select Ruc from cliente_proveedor Cx (nolock) where Cx.codi_clie_prov=M.codi_clie_prov) ruc,
			(Select top 1 razon_social from empresa (nolock)) Razon_social, 
			/*(Select desc_cuen from cuentas_contable CU (nolock) where cu.nro_cuen=M.nro_cuen)*/ '' desc_cuen,
			 nro_docu, compr, subdia, FV, anio, mes, codi_mone, tipo_cambio, glosa, serie, codi_unid_oper, cargo_abono, importe		
		from movi_contables as M (nolock)
		join #Cx C
			on C.codi_contable=M.codi_contable
		join #Mx Mx
		on Mx.codi_clie_prov=M.codi_clie_prov and Mx.nrocuen=M.nro_cuen and Mx.registro=M.registro		
/*
set @SQLString="SELECT codi_tipo_docu, codi_contable COD, S1.codi_clie_prov, Imp, ImpD, FS, FO, 
		S1.Registro , S1.nro_cuen,
		(Select denominacion from cliente_proveedor C (nolock) where C.codi_clie_prov=s1.codi_clie_prov) razon,
		(Select Ruc from cliente_proveedor C (nolock) where C.codi_clie_prov=s1.codi_clie_prov) ruc,
		(Select top 1 razon_social from empresa (nolock)) Razon_social, 
		(Select desc_cuen from cuentas_contable CU (nolock) where cu.nro_cuen=S1.nro_cuen) desc_cuen,
		nro_docu, compr, subdia, FV, anio, mes, codi_mone, tipo_cambio, glosa, serie, codi_unid_oper, cargo_abono, importe
	FROM 
	(select max(fecha) as FS, min(fecha) as FO, codi_clie_prov, 
			isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0) Imp,
			isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0) ImpD, 
			registro, nro_cuen, Max(fecha_venc) FV
		From movi_contables  (nolock)
		where  movi_contables.nro_cuen in (select C.nro_cuen from cuentas_contable C (nolock) where genera_dif='1')  " + @condi +" and 
			fecha <= @fec and mes <= month(@fec) and anio ='"+@anio +"' and not (registro is null or ltrim(registro)='') 
		Group by codi_clie_prov,nro_cuen,registro 
		Having not (isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0)=0
				and isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0)=0)) S1
	JOIN
	(select  tipo_cambio as tipo_cambio,codi_tipo_docu,codi_contable,codi_clie_prov, nro_cuen, registro,compr, 
	     		nro_docu, serie, glosa, subdia, fecha_venc, anio, mes, codi_mone, codi_unid_oper, cargo_abono, importe 
		from movi_contables as Ct (nolock)
		WHERE      Ct.codi_contable IN
			 (SELECT MIN(codi_contable) FROM  movi_contables (nolock)
				WHERE movi_contables.nro_cuen in (select C.nro_cuen from cuentas_contable C (nolock) where genera_dif='1') " + @condi +"  and 
				NOT (registro IS NULL OR registro = '') and fecha <= @fec 
				GROUP BY codi_clie_prov, registro, nro_cuen)) S2 
	ON S1.codi_clie_prov = S2.codi_clie_prov AND S1.registro = S2.registro AND S1.nro_cuen = S2.nro_cuen
	/*where (abs(imp)>0.1 and codi_mone='01') or (abs(impd)>0.1 and codi_mone='02')*/"
*/	

/*insert #Reporte ( codi_tipo_docu , cod , codi_clie_prov ,imp , impd , Fs , fo , registro , nro_cuen , razon , ruc ,razon_social , desc_cuen ,  nro_docu ,
		compr , subdia , fv , anio , mes ,codi_mone , tipo_cambio , glosa , serie , codi_unid_oper , cargo_abono , importe )  
execute sp_executesql @Sqlstring, @ParmString, @fec=@fec*/

declare @Res table (idd int identity, codi_tipo_docu char(4) null, codi_clie_prov char(5) null, imp numeric(12,2) null,
		impd numeric(12,2) null, registro varchar(10) null, nro_cuen char(7) null, nro_docu varchar(20) null,
		codi_mone char(2) null, glosa varchar(250) null, serie varchar(5) null, codi_uni_oper char(5) null, tpc numeric(12,4) null,
		nro_sub_cuen char(7) null, tipo char(1) null)


insert @Res
select codi_tipo_docu , codi_clie_prov ,imp , impd , registro , nro_cuen , nro_docu ,
		codi_mone , glosa , serie , codi_unid_oper , 
	(select case when (select tipo_cuen from cuentas_contable C (nolock) where c.nro_cuen=R.nro_cuen)  in ('3','4')
		then venta 
		else compra end from tipo_cambio_a_dolar T (nolock) 
			where convert(char(10),fech_camb,103)=convert(char(10),@fec ,103) and codi_mone_camb='02' and codi_mone_orig='01')	TpCierre,
	(select nro_sub_cuen from cuentas_contable  C (nolock) where C.nro_cuen=R.nro_cuen)  nro_sub_cuen,
	(select tipo_cuen from cuentas_contable  C (nolock) where C.nro_cuen=R.nro_cuen)  tipo_cuen
from #Reporte R where codi_mone='02'

declare @fecha datetime, @sub char(1) , @vouc varchar(10), @comp varchar(10)

set @fecha = cast(convert(char(10),@fec,103) as datetime)

set @sub='M'

if @ls_unid is null or rtrim(@ls_unid)='' set @ls_unid = null

declare @movi table ( idd numeric(12) identity, codi_clie_prov char(5) null,codi_mone char(2) null,subdia char(1) null,
		 compr varchar(10) null, registro varchar(10) null, glosa varchar(200) null, 
		mes char(2) null, anio char(4) null, fecha datetime null ,nro_cuen char(7) null, nro_sub_cuen char(7) null,
		codi_tipo_docu char(4) null ,importe numeric(12,2) null, importe_d numeric(12,2) null, cargo_abono char(1) null,
		tipo_cambio numeric(12,6) null, tipo_cambio_2 numeric(12,6) null, codi_vouc varchar(10) null, 
		codi_unid_oper char(5) null, hecho_por char(5)  null, serie char(5) null, glosa_g varchar(255) null, nro_docu varchar(10) null)

insert @movi (codi_clie_prov,codi_mone,subdia, compr, registro, glosa, mes,anio,fecha,nro_cuen,nro_sub_cuen,
	codi_tipo_docu,importe,importe_d, cargo_abono,tipo_cambio, tipo_cambio_2,codi_vouc,codi_unid_oper,hecho_por, 
	serie, glosa_g, nro_docu)
select codi_clie_prov, codi_mone, @sub, @comp, registro,  glosa, @ms, @anio, @fecha, 
	nro_cuen, 
	nro_sub_cuen, 
	codi_tipo_docu,
	abs(round(impd*tpc,2) - imp) , 0 as importe_d, 
	case when tipo in ('1','2') 
		then case when (round(impd*tpc,2) - imp) >=0 then 'C' else 'A' end
		else case when (round(impd*tpc,2) - imp) <=0 then 'A' else 'C' end
		end  cargo_abono, 
	tpc, 0 as tipo_cambio_2,@vouc, @ls_unid, @hecho , serie, @glos, nro_docu
from @Res R where abs(round(impd*tpc,2) - imp)<>0
union all
select codi_clie_prov, codi_mone, @sub sub, @comp comp, null registro,  @glos glosa, @ms mes , @anio anio, @fecha fecha, 
		nro_cuen, max(nro_sub_cuen) , null codi_tipo_docu, 
		abs(sum(importe* case when cargo_Abono='C' then 1 else -1 end )) , 
		abs(sum(importe_d* case when cargo_Abono='C' then 1 else -1 end )), 
		case when sum(importe* case when cargo_Abono='C' then 1 else -1 end )>=0 then 'C' else 'A' end cargo_abono,  
		max(tpc), max(tipo_cambio_2),@vouc vouc, @ls_unid unid, @hecho hecho, '' serie, @glos glos, '' nro_docu
from
(select @Var as codi_clie_prov, codi_mone, @sub sub, @comp comp, null registro,  glosa, @ms mes , @anio anio, @fecha fecha, 

	case when tipo in ('1','2') 
		then case when (round(impd*tpc,2) - imp) >=0 then @cu7 else @cu6 end
		else case when (round(impd*tpc,2) - imp) <=0 then @cu6 else @cu7 end
		end  nro_cuen, 

	case when tipo in ('1','2') 
		then case when (round(impd*tpc,2) - imp) >=0 then @scu7 else @scu6 end
		else case when (round(impd*tpc,2) - imp) <=0 then @scu6 else @scu7 end
		end  nro_sub_cuen, 
	codi_tipo_docu,

	abs(round(impd*tpc,2) - imp) importe , 0 as importe_d, 

	case when tipo in ('1','2') 
		then case when (round(impd*tpc,2) - imp) >=0 then 'A' else 'C' end
		else case when (round(impd*tpc,2) - imp) <=0 then 'C' else 'A' end
		end  cargo_abono, 
	tpc, 0 as tipo_cambio_2, @vouc vouc, @ls_unid unid, @hecho hecho, serie, @glos glos, nro_docu
from @Res R where abs(round(impd*tpc,2) - imp)<>0) SQL
group by codi_clie_prov, codi_mone, nro_cuen


set @vouc=dbo.uf_agrupar(@sub)
set @comp = cast(isnull( ( select max(cast(compr as numeric)) 
			from movi_contables  (nolock) where anio=@anio and mes=@ms and subdia=@sub ), 0 )   + 1  as varchar)


begin transaction
	
	declare @MX numeric(18)
	select @MX = max(codi_contable) from movi_contables (nolock)

	insert into movi_contables(codi_contable,codi_clie_prov,codi_mone,subdia, compr, registro, glosa, mes,anio,fecha,nro_cuen,nro_sub_cuen,
		codi_tipo_docu,importe,importe_d, cargo_abono,tipo_cambio, tipo_cambio_2,codi_vouc,codi_unid_oper,hecho_por, serie, nro_docu)
	select right('0000000000'+ cast(@MX+ idd as varchar),10) ,codi_clie_prov,codi_mone,subdia, @comp, registro, glosa, mes,anio,fecha,nro_cuen,nro_sub_cuen,
		codi_tipo_docu,importe,importe_d, cargo_abono,tipo_cambio, tipo_cambio_2,@vouc,codi_unid_oper,hecho_por, serie, nro_docu
	from @movi

	if @@error <> 0 
	begin
		select @errno = 30002, @errmsg = 'No se puede generar asientos de consumo'
		goto error
	end 
	
	commit transaction 	

	drop table #tx
	drop table #reporte
	drop table #Mx
	drop table #Cx

	select @comp

return

error:
	rollback transaction	
	--raiserror @errno @errmsg
GO
