CREATE PROCEDURE [dbo].[usp_balance_sunat]
	@mes [char](2),
	@anio [char](4),
	@dig [int],
	@acum [char](1)
WITH EXECUTE AS CALLER
AS
--declare @mes char(2) , @anio char(4), @dig int, @acum char(1)
--select @mes='01', @anio='2010', @dig =2, @acum='1'

set nocount on
set quoted_identifier off

declare @SQLString nvarchar(4000)
declare @cond varchar(100)
declare @ini_1 varchar(100), @ini_2 varchar(100), @fin_1 varchar(100), @fin_2 varchar(100), @simb varchar(2)
create table #Sx (nro_cuen char(7) null, importe_c numeric(12,2) null, importe_a numeric(12,2) null)

set @ini_1=''
set @ini_2=''
set @fin_1=''
set @fin_2=''
set @simb="="
if @acum='1'
begin
	set @simb= "<="
	set @ini_1="case when mesanio=01"+@anio+" then "
	set @ini_2=" else 0 end "
	set @fin_1="case when mesanio="+@mes+@anio+" then "
	set @fin_2=" else 0 end "
end

if @dig=2 set @cond="( select desc_clas_cuen from clases_Cuentas C (nolock) where c.codi_clas_cuen=left(SQL.nro_cuen,2) ) "
if @dig=3 set @cond="( select desc_subc from SUB_CLAS_CUEN C (nolock) where c.codi_subc=left(SQL.nro_cuen,3) ) "
if @dig=4 set @cond="( select desc_sub_4 from SUB_CLASE_CONT_4 C (nolock) where c.codi_subc_4=left(SQL.nro_cuen,4) ) "
if @dig=5 set @cond="( select desc_lcc from LINEA_CLASE_C C (nolock) where c.codi_lcc=left(SQL.nro_cuen,5) ) "
if @dig=7 set @cond="( select desc_cuen from cuentas_contable C (nolock) where c.nro_cuen=left(SQL.nro_cuen,7) ) "

if @mes='01' or @acum='1'
	insert #Sx
	select nro_cuen, sum(case when importe>0 then abs(importe) else 0 end) ,
		sum(case when importe<0 then abs(importe) else 0 end )
	from
	(select nro_cuen, sum(importe*case when cargo_Abono='C' then 1 else -1 end ) importe
		from movi_contables (nolock) where anio=@anio and mes='01' and subdia='S'
		group by nro_cuen) SQL
	group by nro_cuen	

set @SQLstring ="
	select  left(nro_cuen,"+cast(@dig as varchar)+") cuenta,"+@cond+" descr, 

		abs(case when sum(deudorini) - sum(acreeini)+ isnull((select sum(importe_c)-SUM(importe_a) from #Sx S 
				where left(S.nro_cuen,"+cast(@dig as varchar)+")=left(SQL.nro_cuen,"+cast(@dig as varchar)+") 
				group by  left(S.nro_cuen,"+cast(@dig as varchar)+") ),0)  <=0 
			then  0 else sum(deudorini) - sum(acreeini) + isnull((select sum(importe_c)- sum(importe_a) from #Sx S 
				where left(S.nro_cuen,"+cast(@dig as varchar)+")=left(SQL.nro_cuen,"+cast(@dig as varchar)+") 
				group by  left(S.nro_cuen,"+cast(@dig as varchar)+") ),0) end )  deudorini ,

		abs(case when sum(deudorini) - sum(acreeini) + isnull((select sum(importe_c)-SUM(importe_a) from #Sx S 
				where left(S.nro_cuen,"+cast(@dig as varchar)+")=left(SQL.nro_cuen,"+cast(@dig as varchar)+") 
				group by  left(S.nro_cuen,"+cast(@dig as varchar)+") ),0) <=0 
			then sum(deudorini) - sum(acreeini) + isnull((select sum(importe_c)-SUM(importe_a) from #Sx S 
				where left(S.nro_cuen,"+cast(@dig as varchar)+")=left(SQL.nro_cuen,"+cast(@dig as varchar)+") 
				group by  left(S.nro_cuen,"+cast(@dig as varchar)+") ),0) else 0 end ) acreeini,

		sum(cargo) - 
			isnull((select sum(importe_c) from #Sx S 
				where left(S.nro_cuen,"+cast(@dig as varchar)+")=left(SQL.nro_cuen,"+cast(@dig as varchar)+") 
				group by  left(S.nro_cuen,"+cast(@dig as varchar)+") ),0) cargo, 

		sum(abono) - isnull((select sum(importe_a) from #Sx S 
				where left(S.nro_cuen,"+cast(@dig as varchar)+")=left(SQL.nro_cuen,"+cast(@dig as varchar)+") 
				group by  left(S.nro_cuen,"+cast(@dig as varchar)+") ),0)  abono, 

		abs(case when sum(deudorfin) - sum(acreefin) <=0 then  0 else sum(deudorfin) - sum(acreefin) end ) deudorfin,

		abs(case when sum(deudorfin) - sum(acreefin) <=0 then  sum(deudorfin) - sum(acreefin) else 0 end )  acreefin, 

		abs(case when sum(activo) - sum(pasivo) <=0 then  0 else sum(activo) - sum(pasivo)  end ) activo,

		abs(case when sum(activo) - sum(pasivo)  <=0 then  sum(activo) - sum(pasivo)  else 0 end )  pasivo, 

		abs(case when sum(perdidafunc)  - sum(gananfunc) <=0 then  0 else sum(perdidafunc)  - sum(gananfunc) end ) perdidafunc, 

		abs(case when sum(perdidafunc)  - sum(gananfunc) <=0 then  sum(perdidafunc)  - sum(gananfunc) else 0 end ) gananfunc

	from (select  nro_cuen, "+@ini_1+" 
			abs(case when saldoant <=0 then  0 else saldoant end ) "+@ini_2+" deudorini, 
			" + @ini_1 +" abs(case when saldoant <=0 then  saldoant else 0 end ) " +@ini_2 + " acreeini, 
			cargo ,
			abono , " + @fin_1+" 
			abs(case when saldonue <=0 then  0 else saldonue  end ) "+@fin_2+" deudorfin, 
			" + @fin_1+" abs(case when saldonue <=0 then  saldonue  else 0 end ) "+@fin_2+" acreefin,

			"+@fin_1 +" case when left( nro_cuen ,1) in ( '1','2','3','4','5')  then 
				abs(case when saldonue <=0 then 0 else saldonue end ) else 0 end " +@fin_2 +" activo,
		
			" + @fin_1+" case when left( nro_cuen ,1) in ( '1','2','3','4','5')  then 
				abs(case when saldonue >=0 then 0 else saldonue end ) else 0 end " + @fin_2+" pasivo, 

			"+@fin_1 +" case when left(nro_cuen,2) in ('66','69') 
				or left(nro_cuen,1) in ('9','8') 
				or (left(nro_cuen,1)='7'  and left(nro_cuen,2) not in ('72','79')) then   
				abs( case when saldonue <=0 then  0 else saldonue end ) else 0 end "+@fin_2+" perdidafunc,

			"+@fin_1+" case when left(nro_cuen,2) in ('66','69') 
				or left(nro_cuen,1) in ('9','8') 
				or (left(nro_cuen,1)='7'  and left(nro_cuen,2) not in ('72','79')) then   
				abs( case when saldonue <=0 then saldonue else 0 end ) else 0 end "+@fin_2+" gananfunc

		from saldos_cuentas S(nolock)
		where mesanio"+@simb+@mes+@anio+" and right(mesanio,4)='"+@anio+"' ) SQL 
		group by left(nro_cuen,"+cast(@dig as varchar)+")
		order by left(nro_cuen,"+cast(@dig as varchar)+") "


execute sp_executesql @SQLString

set quoted_identifier on

drop table #Sx
GO
