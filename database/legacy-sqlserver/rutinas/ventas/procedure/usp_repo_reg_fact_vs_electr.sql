CREATE PROCEDURE [dbo].[usp_repo_reg_fact_vs_electr]
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime , @f2 datetime
--select @f1 ='01/01/2018', @f2 ='31/05/2018'

set nocount on

declare @Rx table (grupo int, tipocompro varchar(100), codi_tipo_docu char(4), documento  varchar(50) null,
						codi_mone char(2) null, gravada numeric(12,2) null, exonerado numeric(12,2) null,
						igv numeric(12,2) null, total numeric(12,2) null)

------------------ boletas y facturas electronicas
insert @Rx
select 1 as Grupo, 
		'Comprobantes Electrónicos' as TipoCompr,
		codi_tipo_docu, 
		(select desc_tipo_docu from tipo_documento t (nolock) where t.codi_tipo_docu=F.codi_tipo_docu ) as Documento,
		codi_mone,
		sum(subtota_fact) as Gravada,
		sum(tota_exonerado)  as Exonerado,
		sum(igv_fact) as IGV,
		sum(tota_Fact) as Total
from factura F (nolock)
where cast(convert(char(10),fech_Fact,103) as datetime) between @f1 and @f2
		and isnumeric(ser_fact)=0 and isnull(estado,'')<>'A'
group by codi_tipo_docu, codi_mone
order by codi_tipo_docu desc

---------------notas de credito electronicas

insert @Rx		
select 1 as grupo, 
		'Comprobantes Electrónicos' as TipoCompr,
		'0007' as Docu,	
		(select desc_tipo_docu from tipo_documento t (nolock) where t.codi_tipo_docu='0007') +' ' + 
				case when left(ser_nota_Cred,1)='B' then 'Boletas' else 'Facturas' end  as Documento,
		 codi_mone,
		 sum(case when igv=0 then 0 else valo_vent end) as Gravada, 
		 sum(case when igv=0 then valo_vent else 0 end) as Exonerada, 
		 sum(igv) as IGV, 
		 sum(prec_vent) as total
from nota_credito f (nolock)
where cast(convert(char(10),fech_nota_cred,103) as datetime) between @f1 and @f2
		and isnumeric(ser_nota_cred)=0 and isnull(estado,'')<>'A'
group by ser_nota_Cred, codi_mone
order by ser_nota_Cred

--------------- boletas y facturas manuales
insert @Rx
select 2 as Grupo, 
		'Comprobantes Manuales' as TipoCompr,
		codi_tipo_docu, 
		(select desc_tipo_docu from tipo_documento t (nolock) where t.codi_tipo_docu=F.codi_tipo_docu ) as Documento,
		codi_mone,
		sum(subtota_fact) as Gravada,
		sum(tota_exonerado)  as Exonerado,
		sum(igv_fact) as IGV,
		sum(tota_Fact) as Total
from factura F (nolock)
where cast(convert(char(10),fech_Fact,103) as datetime) between @f1 and @f2
		and isnumeric(ser_fact)=1 and isnull(estado,'')<>'A'
group by codi_tipo_docu, codi_mone
order by codi_tipo_docu desc

-------------- nota de creditos manuales 
insert @Rx		
select 2 as grupo,
		'Comprobantes Manuales' as TipoCompr,
		 '0007' as Docu,
		(select desc_tipo_docu from tipo_documento t (nolock) where t.codi_tipo_docu='0007') +' ' + 
				case when left(ser_nota_Cred,1)='B' then 'Boletas' else 'Facturas' end  as Documento,
		 codi_mone,
		 sum(case when igv=0 then 0 else valo_vent end) as Gravada, 
		 sum(case when igv=0 then valo_vent else 0 end) as Exonerada, 
		 sum(igv) as IGV, 
		 sum(prec_vent) as total
from nota_credito f (nolock)
where cast(convert(char(10),fech_nota_cred,103) as datetime) between @f1 and @f2
		and isnumeric(ser_nota_cred)=1 and isnull(estado,'')<>'A'
group by ser_nota_Cred, codi_mone
order by ser_nota_Cred


select grupo, tipocompro,
		codi_tipo_docu, documento, codi_mone, gravada,
		exonerado, igv, total
from @Rx
GO
