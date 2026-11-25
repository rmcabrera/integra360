CREATE PROCEDURE [dbo].[usp_libro_caja_deta_efect_ple]
	@l_an [char](4),
	@l_mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @l_an char(4), @l_mes char(2) 
--select @l_an ='2014', @l_mes ='02'

set nocount on

create table #RL (compr varchar(10) null, fecha datetime null, glosa varchar(250) null, 
				deudor numeric(12,2) null, acreedor numeric(12,2) null, 
				subdia char(1) null, codi_conta char(10) null, anio char(4) null, mes char(2) null,
				codi_mone char(2) null ,nro_cuen char(7),docu char(4) null, serie varchar(20) null, nro_docu varchar(20) null)

--insert #Rl
--exec PA_LIBRO_CAJA_BANCOS @anio =@l_an, @mes = @l_mes

insert #Rl
select compr, fecha, glosa, 
		case when cargo_abono='C' then importe else 0 end cargo, 
		case when cargo_abono='A' then importe else 0 end abono, 
		subdia, codi_contable, anio, mes , 
		codi_mone, --(select codi_mone from cuentas_contable C (nolock) where c.nro_cuen=m.nro_Cuen) as codi_mone,
		nro_cuen,
		codi_tipo_docu, 
		case when rtrim(ISNULL(serie,''))='' then 
				(select top 1 serie from Movi_Contables XX (nolock) 
						where XX.Registro=M.registro and not ISNULL(serie,'')='' /*and subdia in ('C','V','D')*/)
				else SERIE end 
		as serie, 
		nro_docu
from movi_Contables M (nolock) 
where anio=@l_an and mes=@l_mes and left(nro_Cuen,3) in ('101','102')

select 
/*1*/ anio+mes+'00'+'|'+
/*2*/ anio+mes + subdia+right('00000'+cast(compr as int),4) +'COD:'+codi_conta+'|' +        	  
/*3*/ case subdia when 'S' then 'A' when 'X' then 'C' else 'M' end + right('0000'+cast(cast(compr as int) as varchar),4)+'|' +    
/*4*/ nro_cuen +'|'+
/*5*/ 	'|'+
/*6*/	'|'+
/*7*/ case when codi_mone='01' then 'PEN' else 'USD' end +'|'+
/*8*/ isnull(cast((select codi_sunat from tipo_documento X (nolock) where X.CODI_TIPO_DOCU= R.docu ) as varchar),'00')+'|'+

/*9*/ case when isnumeric(rtrim(serie))=1 then right('0000'+rtrim(serie),4) else isnull(serie,'') end +'|'+
	
/*10*/case when isnull(cast((select CODI_sunat from tipo_documento X (nolock) where X.CODI_TIPO_DOCU= R.docu ) as varchar),'00')='00' then
		case when rtrim(isnull(nro_docu,''))='' then '00' else rtrim(isnull(nro_docu,'')) end 
	  else
			rtrim(isnull(nro_docu,'')) end +'|'+
/*11*/ convert(char(10),fecha,103)+'|'+
/*12*/ '|'+
/*13*/convert(char(10),fecha,103)+'|' +
/*14*/left(case when rtrim(glosa)='' then 'Glosa' 
		else  rtrim(dbo.uf_cambia_cnv(glosa))  end ,100) +'|'+
/*15*/ '|'+
/*16*/ cast(deudor as varchar)+'|'+
/*17*/ cast(acreedor as varchar) +'|'+
/*18*/ '|'+
/*19*/  '1' +'|'+
/*20*/ '|'
from #RL R
where compr<>''


drop table #RL
GO
