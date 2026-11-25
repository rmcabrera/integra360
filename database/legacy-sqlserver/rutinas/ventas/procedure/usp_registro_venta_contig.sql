CREATE PROCEDURE [dbo].[usp_registro_venta_contig]
	@anio [char](4),
	@mes [char](2),
	@fecha [datetime]
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2), @fecha datetime
--select  @anio ='2018', @mes ='03', @fecha='02/03/2018'
        
set nocount on         

select 
	/*1*/	'5'	+'|'+	--cast(isnull(f.moti_cont,7)  as varchar) + '|'+
	/*2*/	isnull(codi_oper,'01')	+	'|'+
	/*3*/	convert(char(10),fech_fact,103)	+	'|'+
	/*4*/	isnull((select t.CODI_SUNAT from TIPO_DOCUMENTO T (nolock) where t.CODI_TIPO_DOCU=F.CODI_TIPO_DOCU),'00') + '|' +
	/*5*/	right('0000'+rtrim(SER_FACT),4)	+ '|' +
	/*6*/	right('00000000'+ rtrim(NRO_FACT),8)+ '|' +
	/*7*/	''	+'|'	+
	/*8*/	isnull(cast((select (select codi_sunat from TIPO_DOCU_IDEN x (nolock)
				where x.Codi_Tipo_Docu_Iden= c.Codi_Tipo_Docu_Iden) from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=F.CODI_CLIE_PROV) as varchar) ,'1')+ '|' +
	/*9*/	(select c.ruc from cliente_proveedor c (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) + '|' +
	/*10*/	isnull(rtrim(left(dbo.F_Cliente_Proveedor(f.CODI_CLIE_PROV),60)),'') + '|'+
	/*11*/	case when codi_mone='01' then 'PEN' else 'USD' end +	'|'+
	/*12*/	case when isnull(codi_oper,'01')='02' then '0.00' else cast(cast(f.VALO_FACT as numeric(12,2))as varchar) end +'|'+
	/*13*/	cast(0.00 as varchar)+'|' +
	/*14*/	'0.00'	+	'|'+
	/*15*/	case when isnull(codi_oper,'01')='02' then cast(cast(f.VALO_FACT as numeric(12,2)) as varchar) else '0.00' end + '|'+
	/*16*/	'0.00'	+	'|'+	
	/*17*/	cast(cast(isnull(F.IGV_FACT,0) as numeric(12,2)) as varchar) + '|' +
	/*18*/	'0.00'	+	'|'+	
	/*19*/	cast(cast(f.tota_fact as numeric(12,2)) as varchar) + '|'+
	/*20*/	''	+	'|'	+
	/*21*/	''	+	'|'	+
	/*22*/	''	+	'|'	+
	/*23*/	''	+	'|'	+
	/*24*/	'0.00'	+	'|'	+
	/*25*/	'0.00'	+	'|'	+
	/*26*/	'0.00'	+	'|'	
from factura F (nolock)
where year(fech_fact)=@anio and month(fech_fact)=@mes 
and cast(convert(char(10),fech_fact,103) as datetime)=@fecha and isnumeric(ser_fact)=1 and isnull(estado,'')<>'A'

union all

select 
	/*1*/	'1|' + --cast(isnull(f.moti_cont,7)  as varchar) + '|'+
	/*2*/	isnull(null,'01')	+	'|'+
	/*3*/	convert(char(10),FECH_NOTA_CRED,103)	+	'|'+
	/*4*/	isnull((select t.CODI_SUNAT from TIPO_DOCUMENTO T (nolock) where t.CODI_TIPO_DOCU='0007'),'00') + '|' +
	/*5*/	right('00000'+rtrim(SER_NOTA_CRED),4)	+	'|' +
	/*6*/	right('00000000'+ rtrim(NRO_NOTA_CRED),8)	+	'|' +
	/*7*/	''	+'|'	+
	/*8*/	isnull(cast((select (select codi_sunat from TIPO_DOCU_IDEN x (nolock)
				where x.Codi_Tipo_Docu_Iden= c.Codi_Tipo_Docu_Iden) from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=F.CODI_CLIE_PROV) as varchar) ,'1')+ '|' +
	/*9*/	(select c.ruc from cliente_proveedor c (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) + '|' +
	/*10*/	isnull(left(dbo.F_Cliente_Proveedor(f.CODI_CLIE_PROV),60),'') + '|'+
	/*11*/	case when codi_mone='01' then 'PEN' else 'USD' end +	'|'+
	/*12*/	case when isnull(null,'01')='02' then '0.00' else cast(cast(f.VALO_VENT as numeric(12,2)) as varchar) end +'|'+
	/*13*/	'0.00'	+'|' +
	/*14*/	'0.00'	+	'|'+
	/*15*/	case when isnull(null,'01')='02' then cast(cast(f.VALO_VENT as numeric(12,2))  as varchar) else '0.00' end + '|'+
	/*16*/	'0.00'	+	'|'+	
	/*17*/	cast(cast(isnull(F.IGV,0) as numeric(12,2))  as varchar) + '|' +
	/*18*/	'0.00'	+	'|'+	
	/*19*/	cast(cast(f.PREC_VENT  as numeric(12,2)) as varchar) + '|'+
	/*20*/	isnull((select (select t.CODI_SUNAT from TIPO_DOCUMENTO T (nolock) where t.CODI_TIPO_DOCU=x.codi_tipo_docu)
				 from factura x (nolock) where x.CODI_FACT=F.codi_fact),'')	+	'|'	+
	/*21*/	isnull((select rtrim(x.SER_FACT)
				 from factura x (nolock) where x.CODI_FACT=F.codi_fact),'')		+	'|'	+
	/*22*/	isnull((select rtrim(x.NRO_FACT)
				 from factura x (nolock) where x.CODI_FACT=F.codi_fact),'')		+	'|'	+
	/*23*/	''	+	'|'	+
	/*24*/	'0.00'	+	'|'	+
	/*25*/	'0.00'	+	'|'	+
	/*26*/	'0.00'	+	'|'	
from nota_Credito F (nolock)
where year(FECH_NOTA_CRED)=@anio and month(FECH_NOTA_CRED)=@mes 
and cast(convert(char(10),fech_nota_cred,103) as datetime)=@fecha and isnumeric(SER_NOTA_CRED)=1 and isnull(estado,'')<>'A'

union all

select 
	/*1*/	'1|' + --cast(isnull(f.moti_cont,7)  as varchar) + '|'+
	/*2*/	isnull(null,'01')	+	'|'+
	/*3*/	convert(char(10),FECH_NOTA_DEBI,103)	+	'|'+
	/*4*/	isnull((select t.CODI_SUNAT from TIPO_DOCUMENTO T (nolock) where t.CODI_TIPO_DOCU='0008'),'00') + '|' +
	/*5*/	right('00000'+rtrim(SER_NOTA_DEBI),4)	+	'|' +
	/*6*/	right('00000000'+ rtrim(NRO_NOTA_DEBI),8)	+	'|' +
	/*7*/	''	+'|'	+
	/*8*/	isnull(cast((select (select codi_sunat from TIPO_DOCU_IDEN x (nolock)
				where x.Codi_Tipo_Docu_Iden= c.Codi_Tipo_Docu_Iden) from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=F.CODI_CLIE_PROV) as varchar) ,'1')+ '|' +
	/*9*/	(select c.ruc from cliente_proveedor c (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) + '|' +
	/*10*/	isnull(left(dbo.F_Cliente_Proveedor(f.CODI_CLIE_PROV),60),'') + '|'+
	/*11*/	case when codi_mone='01' then 'PEN' else 'USD' end +	'|'+
	/*12*/	case when isnull(null,'01')='02' then '0.00' else cast(cast(f.VALO_VENT  as numeric(12,2))  as varchar) end +'|'+
	/*13*/	'0.00'	+'|' +
	/*14*/	'0.00'	+	'|'+
	/*15*/	case when isnull(null,'01')='02' then cast(cast(f.VALO_VENT as numeric(12,2))  as varchar) else '0.00' end + '|'+
	/*16*/	'0.00'	+	'|'+	
	/*17*/	cast(cast(isnull(F.IGV,0) as numeric(12,2))  as varchar) + '|' +
	/*18*/	'0.00'	+	'|'+	
	/*19*/	cast(cast(f.PREC_VENT as numeric(12,2))  as varchar) + '|'+
	/*20*/	isnull((select (select t.CODI_SUNAT from TIPO_DOCUMENTO T (nolock) where t.CODI_TIPO_DOCU=x.codi_tipo_docu)
				 from factura x (nolock) where x.CODI_FACT=F.codi_fact),'')	+	'|'	+
	/*21*/	isnull((select rtrim(x.SER_FACT)
				 from factura x (nolock) where x.CODI_FACT=F.codi_fact),'')		+	'|'	+
	/*22*/	isnull((select rtrim(x.NRO_FACT)
				 from factura x (nolock) where x.CODI_FACT=F.codi_fact),'')		+	'|'	+
	/*23*/	''	+	'|'	+
	/*24*/	'0.00'	+	'|'	+
	/*25*/	'0.00'	+	'|'	+
	/*26*/	'0.00'	+	'|'	
from NOTA_DEBITO F (nolock)
where year(FECH_NOTA_DEBI)=@anio and month(FECH_NOTA_DEBI)=@mes 
and cast(convert(char(10),fech_nota_debi,103) as datetime)=@fecha and isnumeric(SER_NOTA_DEBI)=1 and isnull(estado,'')<>'A'
GO
