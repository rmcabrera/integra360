CREATE PROCEDURE [dbo].[usp_lista_ni_prov]
	@Prov [char](1),
	@F1 [datetime],
	@F2 [datetime],
	@idd [int]
WITH EXECUTE AS CALLER
AS
--declare @Prov char(1), @F1 datetime, @F2 datetime, @idd int
--select @Prov='0', @F1='08/03/2016', @F2='08/03/2016', @idd=2

set nocount on 
set quoted_identifier off

declare @SQLString nvarchar(4000)
declare  @Cond varchar(10)

declare @ParmDefinition nvarchar(100)  
set @ParmDefinition="@F1 datetime, @F2 datetime"  

if @prov='0' set @cond=" not " else set @cond=""

declare @Tx table(idd int, codi_nota_ingr char(10) null, fech_nota_ingr datetime null, codi_clie_prov char(5) null, importe numeric(18,2) null,
				  nro_docu varchar(10) null, codi_tipo_docu char(4) null, nro_seri varchar(5) null, codi_unid_oper_dest char(5) null,
				  codi_mone char(2) null, nro_seri_docu_cont char(5) null, nro_docu_cont char(10) null, fech_reg_fact datetime null,
				  observaciones varchar(200) null, codi_tipo_docu_cont char(4) null, nro_nota_ingr char(10) null, fech_guia_remi datetime null,
				  tipo_nota_ingr char(2) null, otro_no_afec numeric(18,2) null, otro_afec numeric(18,2) null, denominacion varchar(150) null,
				  fech_venc_fact datetime null)


set @SQlstring="SELECT 1 as idd, NOTA_INGRESO.CODI_NOTA_INGR,   
	         NOTA_INGRESO.FECH_NOTA_INGR,   
	         NOTA_INGRESO.CODI_CLIE_PROV,   
	         NOTA_INGRESO.IMPORTE,   
	         NOTA_INGRESO.NRO_DOCU,   
	         NOTA_INGRESO.CODI_TIPO_DOCU,   
	         NOTA_INGRESO.NRO_SERI,   
	         NOTA_INGRESO.CODI_UNID_OPER_DEST,   
	         NOTA_INGRESO.CODI_MONE,   
	         NOTA_INGRESO.NRO_SERI_DOCU_CONT,   
	         NOTA_INGRESO.NRO_DOCU_CONT,   
	         NOTA_INGRESO.FECH_REG_FACT,   
	         NOTA_INGRESO.OBSERVACIONES,   
	         NOTA_INGRESO.CODI_TIPO_DOCU_CONT,   
	         NOTA_INGRESO.NRO_NOTA_INGR,   
	         NOTA_INGRESO.FECH_GUIA_REMI,   
	         NOTA_INGRESO.TIPO_NOTA_INGR,   
	         NOTA_INGRESO.OTRO_NO_AFEC,   
	         NOTA_INGRESO.OTRO_AFEC , 
		(select denominacion from cliente_proveedor (nolock) where codi_clie_prov=NOTA_INGRESO.CODI_CLIE_PROV) as denominacion, fech_venc_fact
	FROM NOTA_INGRESO  (nolock) 
	where cast(convert(char(10),fech_nota_ingr,103) as datetime) between @F1 and @F2 and NOTA_INGRESO.tipo_nota_ingr in ('01','02','26') and 
		codi_nota_ingr "+@cond+ " in (
			select codi_nota_ingr 
			from
			(select  CODI_NOTA_INGR,   
			         CODI_CLIE_PROV,   
				case when isnumeric(isnull(ltrim(nro_seri_docu_cont),''))=1 then 
					cast(cast ( nro_seri_docu_cont as numeric) as varchar(10)) else isnull(nro_seri_docu_cont,'') end NRO_SERI_DOCU_CONT,
				case when isnumeric(isnull(ltrim(nro_docu_cont),''))=1 then
					cast(cast ( nro_docu_cont as numeric) as varchar(20)) else isnull(nro_docu_cont,'') end NRO_DOCU_CONT, 
			         CODI_TIPO_DOCU_CONt
			FROM NOTA_INGRESO  N (nolock) 
			where N.tipo_nota_ingr in ('01','02','26') and isnull(contab,'0')='1' ) A 
			join (select codi_clie_prov, codi_tipo_docu, 
				case when isnumeric(serie)=1 then cast(cast(serie as numeric) as varchar(5)) else serie end serie,
				case when isnumeric(nro_docu)=1 then cast(cast(nro_docu as numeric) as varchar(10)) else nro_docu end nro_docu
			from movi_contables (nolock) 
			where subdia='C' and not (registro is null or rtrim(registro) ='')) B
			on A.codi_clie_prov=B.codi_clie_prov  and A.codi_tipo_docu_cont=B.codi_tipo_docu 
				and A.nro_seri_docu_cont =B.serie and a.nro_docu_cont=b.nro_docu ) 
				
				union all
				
			select 2 as idd, codi_docu_sali, fech_emis, codi_clie_prov, importe, nro_docu_sali, codi_tipo_docu_sali, nro_seri_docu_sali, codi_unid_oper_rece, 
			'01' as codi_mone, nro_seri_docu_cont, nro_docu_cont, fech_reg_fact, motivo, codi_tipo_docu_cont, nro_sali, fech_emis, tipo_sali,
			0 as otro_no_afec, 0 as otro_afec, (select denominacion from cliente_proveedor where codi_clie_prov=docu_sali_mate.CODI_CLIE_PROV) as denominacion,
			null
			from docu_sali_mate (nolock) where cast(convert(char(10),fech_emis,103) as datetime) between @F1 and @F2 and tipo_sali='07' "

insert @Tx
execute sp_executesql @SQLString, @ParmDefinition,  @F1 = @F1 ,@F2=@F2

set quoted_identifier on


select  idd, codi_nota_ingr, fech_nota_ingr, codi_clie_prov, importe,
		nro_docu, codi_tipo_docu, nro_seri, codi_unid_oper_dest,
		codi_mone, nro_seri_docu_cont, nro_docu_cont, fech_reg_fact,
		observaciones, codi_tipo_docu_cont, nro_nota_ingr, fech_guia_remi,
		tipo_nota_ingr, otro_no_afec, otro_afec, denominacion,
		fech_venc_fact
from @Tx
where idd=@idd
GO
