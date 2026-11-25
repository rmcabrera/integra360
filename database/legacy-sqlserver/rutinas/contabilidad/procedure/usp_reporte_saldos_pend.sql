CREATE PROCEDURE [dbo].[usp_reporte_saldos_pend]
	@cuenta [varchar](255),
	@fec [datetime],
	@anio [char](4),
	@codi_clie [char](5),
	@Tipo [char](1)
WITH EXECUTE AS CALLER
AS
--declare @cuenta varchar(255), @fec datetime , @anio char(4), @codi_clie char(5), @Tipo char(1)
--select @cuenta ='12', @fec ='31/12/2014' , @anio ='2014',  @codi_clie ='', @Tipo = 'S'

set nocount on 
set quoted_identifier off

create table #Tx (cuenta varchar(7) collate sql_latin1_general_cp1_ci_as   null)
create table #cli (codi char(5) collate sql_latin1_general_cp1_ci_as  null)
create table #Reporte ( codi_tipo_docu char(4) collate sql_latin1_general_cp1_ci_as null, cod varchar(10) null, codi_clie_prov char(5) collate sql_latin1_general_cp1_ci_as  null,
			imp numeric(12,2) null, impd numeric(12,2) null, Fs datetime null, fo datetime null,
			registro varchar(11) null, nro_cuen char(7) collate sql_latin1_general_cp1_ci_as  null, razon varchar(250) null, ruc varchar(15) null,
			razon_social varchar(250) null, desc_cuen varchar(250) null,  nro_docu varchar(20) null,
			compr varchar(10) collate sql_latin1_general_cp1_ci_as   null, subdia char(1) collate sql_latin1_general_cp1_ci_as   null, fv datetime null, anio char(4), mes char(2) collate sql_latin1_general_cp1_ci_as   null,
			codi_mone char(2) null, tipo_cambio numeric(12,4) null, glosa varchar(250) null, serie varchar(5) null,
			codi_unid_oper char(5) null, cargo_abono char(1) null, importe numeric(12,2) null, codi_vouc char(10) collate sql_latin1_general_cp1_ci_as  null ) 

create table #Mx (codi_clie_prov char(5) null, nrocuen char(7) null, registro char(11) null, fs datetime null, fo datetime null,
					imp numeric(12,2) null, impd numeric(12,2) null, fv datetime null)
create table #Cx (codi_contable char(10) null)

declare @ct int
declare @Ax varchar(255), @Inser varchar(7), @SQLString nvarchar(4000), @ParmString nvarchar(100)
declare @Condi varchar(200), @l_mes char(2)

set @l_mes = right('0'+cast(month(@Fec) as varchar),2)

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
	
	set @condi = " and   M.codi_clie_prov in (select codi from #cli) " 
end

set @ParmString  = " @fec datetime "

------------------ Muestra solo saldos --------------------------- 
if @Tipo='S' 	
begin
	set @SQLString="SELECT codi_clie_prov,nro_cuen,registro,
					max(fecha) as FS, min(fecha) as FO, 
					isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0) Imp,
					isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0) ImpD, 
					Max(fecha_venc) FV
			From movi_contables M (nolock)
			join #Tx T 
			on anio ='"+@anio +"' and left(M.nro_cuen,len(T.cuenta))= T.cuenta
			where  mes <= '"+@l_mes +"' " + @condi +" and 
					fecha <= @fec and  isnull(registro,'')<>''
			Group by codi_clie_prov,nro_cuen,registro 
			Having not (isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0)=0
					and isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0)=0)"
		
		Insert #Mx
		execute sp_executesql @Sqlstring, @ParmString, @fec=@fec

		insert #Cx
		SELECT MIN(codi_contable) FROM  movi_contables X (nolock)
			join #Mx T 
			on X.codi_clie_prov=T.codi_clie_prov and T.nrocuen= X.nro_cuen and X.registro=T.registro
		GROUP BY X.codi_clie_prov, X.registro, X.nro_cuen
				
		select codi_tipo_docu, M.codi_contable COD, M.codi_clie_prov, Imp, ImpD, FS, FO, 
			M.Registro , M.nro_cuen,
			(Select denominacion from cliente_proveedor Cx (nolock) where Cx.codi_clie_prov=M.codi_clie_prov) razon,
			(Select Ruc from cliente_proveedor Cx (nolock) where Cx.codi_clie_prov=M.codi_clie_prov) ruc,
			(Select top 1 razon_social from empresa (nolock)) Razon_social, 
			(Select desc_cuen from cuentas_contable CU (nolock) where cu.nro_cuen=M.nro_cuen) desc_cuen,
			 nro_docu, compr, subdia, FV, anio, mes, codi_mone, tipo_cambio, glosa, serie, codi_unid_oper, cargo_abono, importe		
		from movi_contables as M (nolock)
		join #Cx C
			on C.codi_contable=M.codi_contable
		join #Mx Mx
		on Mx.codi_clie_prov=M.codi_clie_prov and Mx.nrocuen=M.nro_cuen and Mx.registro=M.registro	
	
end 

------------------ Muestra detalle cancelados y pendientes --------------------------- 
if @tipo='D'
begin

	set @SQLString="select codi_tipo_docu, codi_contable, 
			M.codi_clie_prov, isnull(importe,0)  as IMP, isnull(importe_d,0) as iMPD, fecha as FS, null, registro,
			nro_cuen, 
			C.denominacion as razon,
			Ruc ,
			(Select top 1 razon_social from empresa (nolock)) Razon_social, 
			(Select desc_cuen from cuentas_contable CU (nolock) where cu.nro_cuen=M.nro_cuen) desc_cuen,
			nro_docu,compr, subdia, fecha_venc ,anio, mes, codi_mone, tipo_cambio, glosa, serie,
			codi_unid_oper , cargo_Abono, importe, 
			--codi_vouc
			case when subdia ='E' and left(nro_cuen,2)='10' and cargo_abono='A' then 
				(select isnull(rtrim((select nemo from tipo_documento T (nolock) where T.codi_tipo_docu = M.codi_tipo_docu)),'') + ' - '+ isnull(nro_docu,''))
		 		 else '' end DocCance 
		from movi_contables M (nolock) 
		join #Tx T 
		on M.anio ='"+@anio +"' and M.mes <= '"+@l_mes +"' and left(M.nro_cuen,len(T.cuenta))= T.cuenta
		join cliente_proveedor C (nolock)
		on M.codi_clie_prov=C.codi_clie_prov
		where M.codi_clie_prov is not null " + @condi +" and 		
					fecha <= @fec and  isnull(registro,'')<>''"

--	insert #Reporte
	execute sp_executesql @Sqlstring, @ParmString, @fec=@fec

/*	select  codi_tipo_docu , cod , codi_clie_prov ,imp , impd , Fs , fo , registro , nro_cuen , razon , ruc ,razon_social , desc_cuen ,  nro_docu ,
			compr , subdia , fv , anio , mes ,codi_mone , tipo_cambio , glosa , serie , codi_unid_oper , cargo_abono , importe ,
		case when subdia ='E' then 
		(select isnull(rtrim((select nemo from tipo_documento T (nolock) where T.codi_tipo_docu = max(M.codi_tipo_docu))),'') + ' - '+ max(isnull(nro_docu,''))
			 from movi_contables M (nolock) where M.anio= R.anio and M.mes=R.mes and M.subdia=R.subdia 
			and M.compr=R.compr and m.CODI_VOUC=R.codi_vouc and left(nro_cuen,2)='10' and cargo_abono='A') 
				 else '' end DocCance 
	from #Reporte R
	order by codi_clie_prov, registro, anio, mes, fs
*/
end

------------------ Muestra documentos pendientes al detalle --------------------------- 

if @tipo='P'
begin

	set @SQLString="SELECT codi_clie_prov,nro_cuen,registro,
					max(fecha) as FS, min(fecha) as FO, 
					isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0) Imp,
					isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0) ImpD, 
					Max(fecha_venc) FV
			From movi_contables M (nolock)
			join #Tx T 
			on anio ='"+@anio +"' and left(M.nro_cuen,len(T.cuenta))= T.cuenta
			where  mes <= '"+@l_mes +"' " + @condi +" and 
					fecha <= @fec and  isnull(registro,'')<>''
			Group by codi_clie_prov,nro_cuen,registro 
			Having not (isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0)=0
					and isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0)=0)"		
	Insert #Mx
	execute sp_executesql @Sqlstring, @ParmString, @fec=@fec

	set @SQLString="select codi_tipo_docu, codi_contable, 
			m.codi_clie_prov, isnull(importe,0)  as IMP, isnull(importe_d,0)  as iMPD, fecha as FS, null, M.registro,
			M.nro_cuen, 
			denominacion as razon,
			ruc,
			(Select top 1 razon_social from empresa (nolock)) Razon_social, 
			(Select desc_cuen from cuentas_contable CU (nolock) where cu.nro_cuen=m.nro_cuen) desc_cuen,
			nro_docu,compr, subdia, fecha_venc ,anio, mes, codi_mone, tipo_cambio, glosa, serie,
			codi_unid_oper , cargo_Abono, importe
		from movi_contables M (nolock) 
		join #Mx T 
		on M.anio ='"+@anio +"' and M.mes <= '"+@l_mes +"' and 
			M.codi_clie_prov=T.codi_clie_prov and M.nro_cuen=T.nrocuen and M.registro=T.registro
		join cliente_proveedor C (nolock)
		on M.codi_clie_prov=C.codi_clie_prov
		where M.codi_clie_prov is not null " + @condi +" and 		
					fecha <= @fec and  isnull(M.registro,'')<>''
		order by M.codi_clie_prov, M.registro, anio, mes, fs"

	--insert #Reporte
	execute sp_executesql @Sqlstring, @ParmString, @fec=@fec

	/*select codi_tipo_docu , cod , codi_clie_prov ,imp , impd , Fs , fo , R.registro , nro_cuen , razon , ruc ,razon_social , desc_cuen ,  nro_docu ,
			compr , subdia , fv , anio , mes ,codi_mone , tipo_cambio , glosa , serie , codi_unid_oper , cargo_abono , importe 
	from #Reporte R 
	join (	select x.registro, sum(isnull(x.imp,0)*case when x.cargo_abono='C' then 1 else -1 end) as impx, 
			sum(isnull(x.impd,0)*case when x.cargo_abono='C' then 1 else -1 end) as impdx
		from #reporte X
		group by X.registro
		Having not (isnull(sum( case when x.cargo_abono='C' then isnull(x.imp,0) else -1*isnull(x.imp,0) end ),0)=0
			and isnull(sum(case when x.cargo_abono ='C' then isnull(x.impd,0) else -1*isnull(x.impd,0) end ),0)=0) ) B
	on R.registro=B.registro
	order by codi_clie_prov, R.registro, anio, mes, fs
*/

end


drop table  #Reporte
drop table  #Tx 
drop table  #Cli
drop table  #Mx
drop table  #Cx

set quoted_identifier on
GO
