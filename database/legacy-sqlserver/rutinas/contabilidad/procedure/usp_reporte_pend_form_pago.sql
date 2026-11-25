CREATE PROCEDURE [dbo].[usp_reporte_pend_form_pago]
	@cuenta [varchar](255),
	@fec [datetime],
	@anio [char](4),
	@codi_clie [char](5),
	@fecha2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @cuenta varchar(255), @fec datetime , @anio char(4), @codi_clie char(5), @fecha2 datetime
--select @cuenta ='42', @fec ='01/01/2010' , @anio ='2010',  @codi_clie ='04638',  @fecha2='30/08/2010'

set nocount on 
set quoted_identifier off

create table #Tx (cuenta varchar(7) collate sql_latin1_general_cp1_ci_as   null)
create table #cli (codi char(5) collate sql_latin1_general_cp1_ci_as  null)
create table #Reporte ( codi_tipo_docu char(4) collate sql_latin1_general_cp1_ci_as null, cod varchar(10) null, codi_clie_prov char(5) collate sql_latin1_general_cp1_ci_as  null,
			imp numeric(12,2) null, impd numeric(12,2) null, Fs datetime null, fo datetime null,
			registro varchar(11) collate sql_latin1_general_cp1_ci_as null, nro_cuen char(7) collate sql_latin1_general_cp1_ci_as  null, razon varchar(250) null, ruc varchar(15) null,
			razon_social varchar(250) null, desc_cuen varchar(250) null,  nro_docu varchar(20) null,
			compr varchar(10) null, subdia char(1) null, fv datetime null, anio int, mes char(2) null,
			codi_mone char(2) null, tipo_cambio numeric(12,4) null, glosa varchar(250) null, serie varchar(5) null,
			codi_unid_oper char(5) null, cargo_abono char(1) null, importe numeric(12,2) null ) 

create table #Pendi ( codi_tipo_docu char(4) collate sql_latin1_general_cp1_ci_as null, cod varchar(10) null, codi_clie_prov char(5) collate sql_latin1_general_cp1_ci_as  null,
			imp numeric(12,2) null, impd numeric(12,2) null, Fs datetime null, fo datetime null,
			registro varchar(11) collate sql_latin1_general_cp1_ci_as null, nro_cuen char(7) collate sql_latin1_general_cp1_ci_as  null, razon varchar(250) null, ruc varchar(15) null,
			razon_social varchar(250) null, desc_cuen varchar(250) null,  nro_docu varchar(20) null,
			compr varchar(10) null, subdia char(1) null, fv datetime null, anio int, mes char(2) null,
			codi_mone char(2) null, tipo_cambio numeric(12,4) null, glosa varchar(250) null, serie varchar(5) null,
			codi_unid_oper char(5) null, cargo_abono char(1) null, importe numeric(12,2) null ) 

declare @ct int
declare @Ax varchar(255), @Inser varchar(7), @SQLString nvarchar(4000), @ParmString nvarchar(100) , @ParmString2 nvarchar(100)
declare @Condi varchar(200)

set  @ct=0
set @Ax=@cuenta
while len(@AX)>0 and @Ct<=100
begin
	set  @ct=@ct +1
	if patindex('%,%',@ax)>0 
	begin
		set @Inser = substring(@Ax,1, patindex('%,%',@ax)- 1)
		set @Ax = substring(@Ax,patindex('%,%',@ax)+ 1, len(@AX) - len(@Inser))
	end
	else
	begin
		set @Inser = @Ax
		set @Ax=''
	end
	if rtrim(@Inser)<>''
		insert #Tx 
		select @Inser
end

set @condi=''

if not (rtrim(@codi_clie)='' or @codi_clie is null) 
begin
	insert #Cli
	select @codi_clie
	
	set @condi = " and   movi_contables.codi_clie_prov in (select codi from #cli) " 
end

set @ParmString  = " @fec datetime  "
set @ParmString2  = " @fec datetime , @fec2 datetime "


------------------ Muestra solo saldos --------------------------- 
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
		where  exists (select * from #Tx T where left(nro_cuen,len(T.cuenta))= t.cuenta)  " + @condi +" and 
			fecha <= @fec and mes <= month(@fec) and anio ="+@anio +"and not (registro is null or ltrim(registro)='') 
		Group by codi_clie_prov,nro_cuen,registro 
		Having not (isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0)=0
				and isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0)=0)) S1
	JOIN
	(select  tipo_cambio as tipo_cambio,codi_tipo_docu,codi_contable,codi_clie_prov, nro_cuen, registro,compr, 
	     		nro_docu, serie, glosa, subdia, fecha_venc, anio, mes, codi_mone, codi_unid_oper, cargo_abono, importe 
		from movi_contables as Ct (nolock)
		WHERE      Ct.codi_contable IN
			 (SELECT MIN(codi_contable)
				FROM  movi_contables (nolock)
				WHERE exists (select * from #Tx T where left(nro_cuen,len(T.cuenta))= t.cuenta)  " + @condi +"  and 
				NOT (registro IS NULL OR registro = '') and fecha <= @fec 
				GROUP BY codi_clie_prov, registro, nro_cuen)) S2 
	ON S1.codi_clie_prov = S2.codi_clie_prov AND S1.registro = S2.registro AND S1.nro_cuen = S2.nro_cuen
	/*where (abs(imp)>0.1 and codi_mone='01') or (abs(impd)>0.1 and codi_mone='02')*/"
	

insert #Reporte ( codi_tipo_docu , cod , codi_clie_prov ,imp , impd , Fs , fo , registro , nro_cuen , razon , ruc ,razon_social , desc_cuen ,  nro_docu ,
		compr , subdia , fv , anio , mes ,codi_mone , tipo_cambio , glosa , serie , codi_unid_oper , cargo_abono , importe )  
execute sp_executesql @Sqlstring, @ParmString, @fec=@fec
/*
select --codi_tipo_docu , cod , codi_clie_prov ,imp , impd , Fs , fo , registro , nro_cuen , razon , ruc ,razon_social , desc_cuen ,  nro_docu ,
	--	compr , subdia , fv , anio , mes ,codi_mone , tipo_cambio , glosa , serie , codi_unid_oper , cargo_abono , importe 
from #Reporte */


------------------ Muestra detalle cancelados y pendientes --------------------------- 

set @SQLString="select codi_tipo_docu, codi_contable, 
		codi_clie_prov, isnull(importe,0)  as IMP, isnull(importe_d,0) as iMPD, fecha as FS, null, registro,
		nro_cuen, (Select denominacion from cliente_proveedor C (nolock) where C.codi_clie_prov=movi_contables.codi_clie_prov) razon,
		(Select Ruc from cliente_proveedor C (nolock) where C.codi_clie_prov=movi_contables.codi_clie_prov) ruc,
		(Select top 1 razon_social from empresa (nolock)) Razon_social, 
		(Select desc_cuen from cuentas_contable CU (nolock) where cu.nro_cuen=movi_contables.nro_cuen) desc_cuen,
		nro_docu,compr, subdia, fecha_venc ,anio, mes, codi_mone, tipo_cambio, glosa, serie,
		codi_unid_oper , cargo_Abono, importe
	from movi_contables (nolock) 
	where  anio ="+@anio +"and exists (select * from #Tx T where left(nro_cuen,len(T.cuenta))= t.cuenta)  " + @condi +" 
			and codi_clie_prov is not null and 
			fecha>@fec2 and (fecha <= @fec and mes <= month(@fec) ) 
			and not (registro is null or ltrim(registro)='') 
		and registro in (select distinct r.registro from #reporte R ) "

insert #Pendi
execute sp_executesql @Sqlstring, @ParmString2 , @fec=@fecha2, @fec2 = @fec


select codi_tipo_docu , cod , codi_clie_prov ,abs(imp) , abs(impd) , Fs , fo , registro , nro_cuen , razon , ruc ,razon_social , desc_cuen ,  nro_docu ,
		compr , subdia , fv , anio , mes ,codi_mone , tipo_cambio , glosa , serie , codi_unid_oper , cargo_abono , importe 
from #Reporte
union all
select codi_tipo_docu , cod , codi_clie_prov ,imp , impd , Fs , fo , registro , nro_cuen , razon , ruc ,razon_social , desc_cuen ,  nro_docu ,
		compr , subdia , fv , anio , mes ,codi_mone , tipo_cambio , glosa , serie , codi_unid_oper , cargo_abono , importe 
from #Pendi
--where cargo_Abono='A'
order by codi_clie_prov, registro, anio, mes, fs


drop table #Reporte
drop table #Pendi
drop table #Tx 
drop table  #Cli
set quoted_identifier on
GO
