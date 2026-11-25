CREATE PROCEDURE [dbo].[usp_libro_banco_deta_cta_ple]
	@l_an [char](4),
	@l_mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @l_an char(4), @l_mes char(2) 
--select @l_an ='2015', @l_mes ='07'

set nocount on

declare @l_cuen char(7)

create table #RL (compr varchar(10) null, fecha datetime null, glosa varchar(250) null, 
					clie varchar(200) null, 
					deudor numeric(12,2) null, acreedor numeric(12,2) null, 
					conta char(10) null,  
					banco varchar(100) null, 
					cta varchar(100) null, 
					cuenbanco char(7) null, 
					sunat char(2) null,
					subdia char(1) null, 
					medio char(3) null, tipo_docu_iden char(1) null, codi_clie_prov char(5) null,
					docu_iden varchar(15) null, nro_docu varchar(20) null, anio char(4) null, mes char(2) null)

insert #Rl
select compr, fecha, glosa, dbo.f_cliente_proveedor(codi_clie_prov),
		case when cargo_abono='C' then importe else 0 end cargo, 
		case when cargo_abono='A' then importe else 0 end abono, 
		codi_contable,  
		(select desc_banc from bancos b (nolock) 
				where B.codi_banc in (select codi_banc from cuentas_contable C (nolock) where C.nro_Cuen=M.nro_cuen)) as banco,
		(select nro_Cta_Cte_banc from cuentas_contable C (nolock) where C.nro_Cuen=M.nro_cuen) as  cuenta_cte,		
		nro_Cuen as ctabanco,
		(select codi_sunat from bancos b (nolock) 
				where B.codi_banc in (select codi_banc from cuentas_contable C (nolock) where C.nro_Cuen=M.nro_cuen)) as sunat,	
		subdia,
		(select T.codi_sunat from tipo_medio_pago t (nolock) where t.codi_Tipo_medio_pago=M.codi_Tipo_medio_pago) as codi_Tipo_medio_pago , 
		(select (select codi_sunat from tipo_docu_iden T (nolock) where T.codi_tipo_docu_iden =C.codi_tipo_docu_iden )
				from cliente_proveedor c (nolock) where c.codi_clie_prov=m.codi_clie_prov),
		codi_Clie_prov,
		(select ruc from cliente_proveedor c (nolock) where c.codi_clie_prov=m.codi_clie_prov) Docuiden,
		nro_docu, anio, mes
from movi_Contables M (nolock) 
where anio=@l_an and mes=@l_mes and left(nro_Cuen,3) in ('104')

select 
/*1*/ anio+mes+'00'+'|'+
/*2*/ anio+mes + subdia+right('0000'+cast(compr as int),4) +'COD:'+cast(cast(conta as numeric) as varchar)+'|' +
/*3*/ case subdia when 'S' then 'A' when 'X' then 'C' else 'M' end + right('0000'+cast(cast(compr as int) as varchar),4)+'|' +      
/*4*/ isnull(sunat,'99') +'|' +
/*5*/ isnull(cta,'') +'|'+
/*6*/ convert(char(10),fecha,103) +'|' +
/*7*/ right('000'+rtrim(isnull(medio,'999')),3) +'|'+
/*8*/left(case when rtrim(glosa)='' then 'Glosa' 
			else  rtrim(dbo.uf_cambia_cnv(glosa)) end ,60) +'|'+
/*9*/ isnull(tipo_docu_iden,'-') +'|'+
/*10*/isnull(docu_iden,'-') + '|' + 
/*11*/left(isnull(clie,'VARIOS'),60) +'|'+
/*12*/rtrim(case when rtrim(isnull(nro_docu,''))='' then compr else nro_docu end) +'|'+
/*13*/cast(deudor as varchar)+'|'+
/*14*/cast(acreedor as varchar)+'|'+
/*15*/ '1' +'|'+
/*16*/ '|'
from #RL
where not (deudor =0 and acreedor=0) --and compr in ('0107')

drop table #RL
GO
