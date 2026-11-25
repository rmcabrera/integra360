CREATE PROCEDURE [dbo].[usp_libro_Mayor_sunat_acum]
	@anio [char](4),
	@mes [char](2),
	@cuen [varchar](7),
	@tipo [char](1)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes  char(2), @cuen varchar(7) , @tipo char(1)
--select @anio ='2014', @mes  ='09' , @cuen ='21' , @Tipo ='D' 

set nocount on 
set quoted_identifier off

declare @SQLString nvarchar(2000)
declare @Condi varchar(10), @MESX varchar(6)

if @mes='01' 
	set @MESX ='00'+@anio 
else
begin
	set @MESX = right('00'+cast(cast(@mes as int ) -1 as varchar), 2 ) +@anio 
end

create table #Tx ( nro_cuen char(7) null, clase varchar(100) null, sub_clase varchar(100) null, linea_clase varchar(100) null,
			cuenta varchar(100) null, fecha datetime null, glosa varchar(200) null, debe numeric(12,2) null,
			haber numeric(12,2) null, registro varchar(10) null, serie varchar(10) null, nro_docu varchar(20) null,
			compr varchar(10) null, subdia char(1) null, codi_contable char(10) null, codi_tipo_docu char(4) null, 
				anio char(4) null, mes char(2) null) 


if @cuen = '0000000' or rtrim(@cuen)=''
   begin
	set @SQLString = "SELECT  nro_cuen, 
				(select desc_clas_cuen 	from clases_cuentas 	clc where clc.codi_clas_cuen 	= left(movi_contables.nro_cuen,2) ) 	as Clase,
				(select desc_subc 		from sub_clas_cuen 	sc  where sc.codi_subc 		= left(movi_contables.nro_cuen,3) ) 	as Sub_Clase,
				(select desc_LCC  		from Linea_clase_c 	Lc  where Lc.codi_LCC 		= left(movi_contables.nro_cuen,5) ) 	as Linea_Clase,
				(select desc_cuen 		from cuentas_contable 	cc  where cc.nro_cuen 		= movi_contables.nro_cuen ) 		as Cuenta,
				cast(convert(char(10),fecha,103) as datetime) as fecha,
				glosa, 
				DEBE  = case when cargo_abono='C' THEN IMPORTE ELSE 0 END ,
				HABER = case when cargo_abono='A' THEN IMPORTE ELSE 0 END ,
				registro, serie , nro_docu, compr, subdia, codi_contable, codi_tipo_docu, anio,mes 
			FROM MOVI_CONTABLES (nolock)
			WHERE anio = " + @ANIO + " and mes ="+@MES +"  
			union all
			select nro_cuen, 
				(select desc_clas_cuen 	from clases_cuentas clc where clc.codi_clas_cuen 	= left(s.nro_cuen,2) ) 	as Clase,
				(select desc_subc from sub_clas_cuen 	sc  where sc.codi_subc 		= left(s.nro_cuen,3) ) 	as Sub_Clase,
				(select desc_LCC  from Linea_clase_c 	Lc  where Lc.codi_LCC 		= left(s.nro_cuen,5) ) 	as Linea_Clase,
				(select desc_cuen from cuentas_contable cc  where cc.nro_cuen 		= s.nro_cuen ) 		as Cuenta,
				null fecha, 'Saldo Anterior', 
				cargoacum, abonoacum , '', '','','','', 1 , '',"+@anio+","+ @mes +" 
				from saldos_cuentas S (nolock) 
				WHERE mesanio = " + @MESX+ " 
			order by nro_cuen, fecha, codi_contable"
	insert #Tx
	execute sp_executesql @SQLString

   end
else
   begin
	set @SQLString = "SELECT  nro_cuen, 
		(select desc_clas_cuen 	from clases_cuentas 	clc where clc.codi_clas_cuen 	= left(movi_contables.nro_cuen,2) ) 	as Clase,
		(select desc_subc 		from sub_clas_cuen 	sc  where sc.codi_subc 		= left(movi_contables.nro_cuen,3) ) 	as Sub_Clase,
		(select desc_LCC  		from Linea_clase_c 	Lc  where Lc.codi_LCC 		= left(movi_contables.nro_cuen,5) ) 	as Linea_Clase,
		(select desc_cuen 		from cuentas_contable 	cc  where cc.nro_cuen 		= movi_contables.nro_cuen ) 		as Cuenta,
		cast(convert(char(10),fecha,103) as datetime) as fecha,
		glosa,
		DEBE  = case when cargo_abono='C' THEN IMPORTE ELSE 0 END ,
		HABER = case when cargo_abono='A' THEN IMPORTE ELSE 0 END ,
		registro, serie , nro_docu, compr, subdia, codi_contable, codi_tipo_docu, anio,mes 
		FROM MOVI_CONTABLES (nolock)
		WHERE anio = " + @ANIO + " and mes ="+@MES +" and left(nro_cuen,len("+@cuen+")) = " + @cuen + "
		union all
		select nro_cuen, 
			(select desc_clas_cuen 	from clases_cuentas clc where clc.codi_clas_cuen 	= left(s.nro_cuen,2) ) 	as Clase,
			(select desc_subc from sub_clas_cuen 	sc  where sc.codi_subc 		= left(s.nro_cuen,3) ) 	as Sub_Clase,
			(select desc_LCC  from Linea_clase_c 	Lc  where Lc.codi_LCC 		= left(s.nro_cuen,5) ) 	as Linea_Clase,
			(select desc_cuen from cuentas_contable cc  where cc.nro_cuen 		= s.nro_cuen ) 		as Cuenta,
			null fecha, 'Saldo Anterior', 
			cargoacum, abonoacum , '', '','','','', 1, '',"+@anio+","+ @mes +" 
			from saldos_cuentas S (nolock) 
			WHERE mesanio = " + @MESX+ "  and left(nro_cuen,len("+@cuen+")) = " + @cuen + "
		order by nro_cuen, fecha, codi_contable"

	insert #Tx
	execute sp_executesql @SQLString		
   end

select  nro_cuen, clase , sub_clase , linea_clase ,	cuenta , fecha , glosa , debe , haber , registro , serie , nro_docu ,compr , subdia, codi_contable
from #Tx
WHERE not( (subdia='V' and codi_tipo_docu='0003') or subdia='K' or 
		(subdia in ('A', 'S','X') and left(nro_cuen,1) in ('9','2','6'))
		/*or (subdia='M' and left(nro_Cuen,2) in ('12','13') and codi_tipo_docu='0003')*/  )
union all
select  nro_cuen, clase , sub_clase , linea_clase ,	cuenta , fecha , 
	case subdia when 'V' then 'Consolidación desde ' +rtrim(min(nro_docu))+'-'+rtrim(max(nro_docu)) 
		when 'A' then 'Automático' when 'K' then 'Consumos del Mes' when 'S' then 'Saldos Iniciales' when 'X' then 'Asiento de Cierre' else '' end as glosa,
	sum(debe) , sum(haber ), null registro , serie , min(nro_docu) , min(compr) , subdia, min(codi_contable)
from #Tx
WHERE ( (subdia='V' and codi_tipo_docu='0003') or 
		(subdia in ('A', 'S','X') and left(nro_cuen,1) in ('9','2','6')))
group by anio, mes, fecha, serie,  nro_Cuen, SUBDIA,clase , sub_clase , linea_clase ,	cuenta
union all
select  nro_cuen, clase , sub_clase , linea_clase ,cuenta , cast(convert(char(10),fecha,103) as datetime) , 
	case subdia when 'V' then 'Consolidación desde ' +rtrim(min(nro_docu))+'-'+rtrim(max(nro_docu)) 
		when 'A' then 'Automático' when 'K' then 'Consumos del Mes' when 'S' then 'Saldos Iniciales' when 'X' then 'Asiento de Cierre' else '' end as glosa,
	sum(debe) , sum(haber ), null registro , serie , min(nro_docu) , min(compr) , subdia, min(codi_contable)
from #Tx
WHERE subdia='K'
group by anio, mes, cast(convert(char(10),fecha,103) as datetime), serie, nro_Cuen,  SUBDIA,clase , sub_clase , linea_clase ,	cuenta
/*union all
select  nro_cuen, clase , sub_clase , linea_clase ,	cuenta , cast(convert(char(10),fecha,103) as datetime) , 
	case subdia when 'M' then 'Consolidación desde ' +rtrim(min(nro_docu))+'-'+rtrim(max(nro_docu)) 
		when 'A' then 'Automático' when 'K' then 'Consumos del Mes' when 'S' then 'Saldos Iniciales' 
		when 'X' then 'Asiento de Cierre' 
		else '' end as glosa,
	sum(debe) , sum(haber ), null registro , serie , min(nro_docu) , min(compr) , subdia, min(codi_contable)
from #Tx
WHERE ANIO=@ANIO AND MES = @MES and subdia='M' and left(nro_Cuen,2) in ('12','13') and codi_tipo_docu='0003'
group by anio, mes, cast(convert(char(10),fecha,103) as datetime), serie, nro_Cuen,  SUBDIA,clase , sub_clase , linea_clase ,	cuenta
*/
drop table #Tx 
set quoted_identifier on
GO
