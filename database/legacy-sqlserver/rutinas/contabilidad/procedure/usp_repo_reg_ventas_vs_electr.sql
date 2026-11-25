CREATE PROCEDURE [dbo].[usp_repo_reg_ventas_vs_electr]
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime, @f2 datetime
--select @f1 ='01/05/2019' , @f2='31/05/2019'

set nocount on 

declare @Rx table (grupo int, tipocompro varchar(100), codi_tipo_docu char(4), documento  varchar(50) null,
						codi_mone char(2) null, gravada numeric(12,2) null, exonerado numeric(12,2) null,
						igv numeric(12,2) null, total numeric(12,2) null)


insert @Rx
select 1 as Grupo, 
		'Comprobantes Electrónicos' as TipoCompr,
		codi_tipo_docu, 
		(select desc_tipo_docu from tipo_documento t (nolock) where t.codi_tipo_docu=M.codi_tipo_docu ) as Documento,
		codi_mone,
		sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							 and left(nro_cuen,2)<>'40'  and  not  (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4') then importe else 0 end ) as Gravada,
		sum(case when  (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							 and left(nro_cuen,2)<>'40' and (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4') then importe else 0 end ) as Exonerada,		
		sum(case when left(nro_cuen,2)='40' then importe else 0 end ) as igv, 	
		sum(case when left(nro_cuen,2) in ('12','16') then importe else 0 end ) as Total
from movi_contables M (nolock)
where cast(convert(char(10),m.fecha,103) as datetime) between @f1 and @f2
		and M.subdia='V'
		and codi_tipo_docu in ('0001','0003') and isnumeric(serie)=0
group by codi_tipo_docu, codi_mone


insert @Rx
select 1 as Grupo, 
		'Comprobantes Electrónicos' as TipoCompr,
		codi_tipo_docu, 
		(select desc_tipo_docu from tipo_documento t (nolock) where t.codi_tipo_docu=M.codi_tipo_docu ) +
				' ' + case when left(serie,1)='B' then 'Boletas' else 'Facturas' end as Documento,
		codi_mone,
		sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							 and left(nro_cuen,2)<>'40' and not  (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4') then importe else 0 end ) as Gravada,
		sum(case when  (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							 and left(nro_cuen,2)<>'40' and (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4') then importe else 0 end ) as Exonerada,		
		sum(case when left(nro_cuen,2)='40' then importe else 0 end ) as igv, 	
		sum(case when left(nro_cuen,2) in ('12','16') then importe else 0 end ) as Total
from movi_contables M (nolock)
where cast(convert(char(10),m.fecha,103) as datetime) between @f1 and @f2
		and M.subdia='V'
		and codi_tipo_docu in ('0007') and isnumeric(serie)=0
group by codi_tipo_docu, serie, codi_mone

insert @Rx
select 1 as Grupo, 
		'Comprobantes Manuales' as TipoCompr,
		codi_tipo_docu, 
		(select desc_tipo_docu from tipo_documento t (nolock) where t.codi_tipo_docu=M.codi_tipo_docu ) as Documento,
		codi_mone,
		sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							 and left(nro_cuen,2)<>'40' and not  (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4') then importe else 0 end ) as Gravada,
		sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							 and left(nro_cuen,2)<>'40'and  (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4') then importe else 0 end ) as Exonerada,		
		sum(case when left(nro_cuen,2)='40' then importe else 0 end ) as igv, 	
		sum(case when left(nro_cuen,2) in ('12','16') then importe else 0 end ) as Total
from movi_contables M (nolock)
where cast(convert(char(10),m.fecha,103) as datetime) between @f1 and @f2
		and M.subdia='V'
		and codi_tipo_docu in ('0001','0003') and isnumeric(serie)=1
--				and compr=1 and serie='032'
group by codi_tipo_docu, codi_mone


insert @Rx
select 1 as Grupo, 
		'Comprobantes Manuales' as TipoCompr,
		codi_tipo_docu, 
		(select desc_tipo_docu from tipo_documento t (nolock) where t.codi_tipo_docu=M.codi_tipo_docu ) +
				' ' + case when left(serie,1)='B' then 'Boletas' else 'Facturas' end as Documento,
		codi_mone,
		sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							 and left(nro_cuen,2)<>'40' and not  (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4') then importe else 0 end ) as Gravada,
		sum(case when  (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							 and left(nro_cuen,2)<>'40' and (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4') then importe else 0 end ) as Exonerada,		
		sum(case when left(nro_cuen,2)='40' then importe else 0 end ) as igv, 	
		sum(case when left(nro_cuen,2) in ('12','16') then importe else 0 end ) as Total
from movi_contables M (nolock)
where cast(convert(char(10),m.fecha,103) as datetime) between @f1 and @f2
		and M.subdia='V'
		and codi_tipo_docu in ('0007') and isnumeric(serie)=1
group by codi_tipo_docu, serie, codi_mone


select grupo, tipocompro,
		codi_tipo_docu, documento, codi_mone, gravada,
		exonerado, igv, total
from @Rx
GO
