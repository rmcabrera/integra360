CREATE PROCEDURE [dbo].[PA_DATOS_SUSPENSION_CUARTA_CATEGORIA_EXPORTA]
	@ANIO [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
set nocount on 
create table #personal_datos_suspension_cta 
(codi_clie_prov CHAR(5), codi_tipo_doc_sunat varchar(2) , nro_doc_iden varchar(15) , nro_operacion VARCHAR(15) , fech_inicio VARCHAR(10) , anio CHAR(4) , medio_presentacion CHAR(1))

-------RECUPERAMOS LOS DATOS DE SUSPENSION DE CUARTA CATEGORIA----------------
insert into #personal_datos_suspension_cta( codi_clie_prov , codi_tipo_doc_sunat , nro_doc_iden , nro_operacion , fech_inicio , anio , medio_presentacion)
SELECT  CP1.codi_clie_prov, '6', cp1.ruc  , cast(CPS.nro_operacion as varchar(15)) , isnull(convert(char(10), CPS.fech_inicio,103),'') ,
	    cast(CPS.anio as char(4)), cast(CPS.medio_presentacion as char(1))
FROM dbo.CLIENTE_PROVEEDOR CP1 (nolock) 
JOIN  dbo.CLIE_PROV_SUSPEN_CTA_CATEG CPS (nolock)
ON CP1.CODI_CLIE_PROV=CPS.CODI_CLIE_PROV AND 
	CP1.codi_clie_prov in (select distinct mov.codi_clie_prov 
			from dbo.movi_contables mov (nolock) 
				where mov.anio=@ANIO and mov.mes=@MES and mov.subdia='H' and 
					nro_cuen in ('4210002') and isnull(ltrim(registro),'')<>'')
	
--- TODOS TIENE COMO DOCUMENTO EL RUC - CODIGO SUNAT = 6

select isnull(codi_tipo_doc_sunat,'') + '|' + cast(nro_doc_iden as varchar(15))+ '|' + isnull(cast( nro_operacion as varchar(15)),'')+ '|' + 
		isnull(convert(char(10), fech_inicio ,103),'') + '|' + isnull(anio,'') + '|' + isnull(medio_presentacion,'') + '|' 
from   #personal_datos_suspension_cta

drop table #personal_datos_suspension_cta
GO
