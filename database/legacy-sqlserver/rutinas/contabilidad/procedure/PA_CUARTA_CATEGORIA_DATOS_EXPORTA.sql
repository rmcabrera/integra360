CREATE PROCEDURE [dbo].[PA_CUARTA_CATEGORIA_DATOS_EXPORTA]
	@ANIO [char](4),
	@MES [char](2)
WITH EXECUTE AS CALLER
AS
set nocount on 
create table #recibos_x_honorarios  (codi_clie_prov char(5) COLLATE SQL_Latin1_General_CP1_CI_AS )

declare @codi_vouc varchar(10)
declare @codi_clie_prov char(5)

insert into #recibos_x_honorarios (codi_clie_prov)
select distinct mov.codi_clie_prov 
from dbo.cliente_proveedor cp (nolock)
	join dbo.movi_contables mov (nolock)
 on cp.codi_clie_prov=mov.codi_clie_prov 
where mov.anio=@ANIO and mov.mes=@MES and mov.subdia='H' and nro_cuen in ('4210002') and isnull(ltrim(registro),'')<>''

select  distinct ( '6|' + isnull(cp.ruc,'') +  '|' + cast( isnull(cp.apel_1,'')  as varchar(40) )+ '|' +cast( isnull(cp.apel_2,'') as varchar(40)) + '|' 
+ cast(isnull(cp.nomb_1,'') as varchar(40))  + ' ' +  cast(isnull(cp.nomb_2,'') as varchar(40) )+ '|' +  isnull(convert(char(10), cp.fech_naci ,103),'')  +	
+ '|' +  isnull(cp.sexo,'1') + '|'+ cast(isnull(codi_nacion_sunat,'') as varchar(4) ) + '|||0|' + isnull(cp.domiciliado,0) + '|' +  '||||||||'   )
from  dbo.cliente_proveedor cp (nolock)	join 
	(select distinct codi_clie_prov from #recibos_x_honorarios) h on cp.codi_clie_prov=h.codi_clie_prov
left join dbo.nacion n (nolock) on n.codi_nacion=cp.codi_nacion

drop table #recibos_x_honorarios
GO
