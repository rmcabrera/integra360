CREATE PROCEDURE [dbo].[PA_Planilla_AFP]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio as char (4), @mes as char (2)
--select @anio = '2015', @mes='08'

set nocount on

DECLARE @TX TABLE (CODI_PERS CHAR (5), AFP CHAR (2), VALOR NUMERIC(12,2))

-----------EMPLEADOS

INSERT @TX (CODI_PERS, AFP, VALOR)
SELECT CODI_PERS, CODI_SIST_PENS, SUM(VALOR) VALOR
FROM
	(SELECT CODI_PERS, CODI_SIST_PENS, SUM(VALOR) AS VALOR
		FROM dbo.PLANILLA_DE_EMPLEADOS PE (nolock),    
		     dbo.PLANILLA_EMPLEADO_CONCEPTOS PEC (nolock)
		WHERE   (PE.CODI_PLAN_EMPL = PEC.CODI_PLAN_EMPL) AND
		        (PE.ANIO = @ANIO ) AND
		        (PE.MES = @MES) AND (PEC.CODI_CONC = '199998')
			AND NOT ( (PE.CODI_TIPO_PLAN IN ('02','12') AND PE.ANIO BETWEEN '2009' AND '2014')
						or (PE.CODI_TIPO_PLAN IN ('02','12') and pe.anio+pe.mes>='201106')) 
			AND INDI_TIEM = 'M' and codi_sist_pens<>'01'
		GROUP BY CODI_PERS, CODI_SIST_PENS
	union all
	SELECT CODI_PERS, CODI_SIST_PENS, SUM(VALOR)
		FROM dbo.PLANILLA_DE_OBREROS PE (nolock),    
		     dbo.PLANILLA_OBRERO_CONCEPTOS PEC (nolock)
		WHERE   (PE.CODI_PLAN_OBRE = PEC.CODI_PLAN_OBRE) AND
		        (PE.ANIO = @ANIO ) AND
		        (PE.MES = @MES) AND (PEC.CODI_CONC = '199998')
			AND NOT ((PE.CODI_TIPO_PLAN IN ('02','12') AND PE.ANIO BETWEEN '2009' AND '2014')
											or (PE.CODI_TIPO_PLAN IN ('02','12') and pe.anio+pe.mes>='201106')) 
			AND INDI_TIEM = 'M' and codi_sist_pens<>'01'
		GROUP BY CODI_PERS, CODI_SIST_PENS ) SQL
GROUP BY CODI_PERS, CODI_SIST_PENS 

declare @RES table ( sec int identity,  cupss char(12) null, tipo_docu varchar(60) null, nrodocu char(10) null , apel_1 char(20) null,
			apel_2 char(20) null, nomb char(20) null, rela char(1) null, inicio char(1) null, cese char(1) null, 
			fecha char(10) null, remu numeric(10,2) null, ap1 numeric(10,2) null, ap2 numeric(10,2) null ,
			 ap3 numeric(10,2) null, riesgo char(1) null, afp char(2) null )

insert @RES(cupss, tipo_docu, nrodocu, apel_1, apel_2, nomb, rela, inicio, cese, fecha, remu, ap1, ap2, ap3, riesgo, afp)
SELECT        	left(P.NRO_CUPSS,12), (select codi_sunat from tipo_docu_iden td(nolock) where td.codi_tipo_docu_iden=P.codi_tipo_docu_iden) tipo_docu, 
	 	P.NRO_DOCU_IDEN,
		left(isnull(P.APEL_1,' '), 20) ,
		left(isnull(P.APEL_2,' '), 20) ,
		left(isnull(P.nomb_1,' ')+isnull(' '+P.nomb_2,' '), 20) , 
			
		case when fech_cese is null then 'S' else 
		case when cast(year(fech_cese) as varchar) + right('0'+ cast(month(fech_cese) as varchar),2) <= @anio + @mes then 'S' else 'N' end end rela, 
		case when month(fech_ingre)=@mes and year(fech_ingre)=@anio then 'S' else 'N' end inicio, 
		case when month(fech_cese)=@mes and year(fech_cese)=@anio then 'S' else 'N' end  cese,
		case when month(fech_ingre)=@mes and year(fech_ingre)=@anio then convert(char(10),fech_ingre ,103)
			when month(fech_cese)=@mes and year(fech_cese)=@anio then convert(char(10),fech_cese,103)  else ' ' end fec, 
			
		T.VALOR,
                0 as AV_CON_FIN,
		0 as AV_SIN_FIN,
	        0 as APORTE_EMPLEADOR,
		' ' as ries,
		(select AFPNET from sistema_pensiones S (NOLOCK)
			Where s.codi_sist_pens = T.afp) as AFP

FROM		dbo.PERSONAL P (nolock),
                @TX T 
WHERE           P.CODI_PERS = T.CODI_PERS	 

select /*right('0000'+cast(sec as varchar) ,5) sec,*/
	sec,  cupss as nro_cupss, case when tipo_docu=1 then '0'
	                  when tipo_docu=4 then '1' 
	                  when tipo_docu=7 then '4' end as tipo_docu, 
	nrodocu as nro_docu_iden, apel_1 ,apel_2, nomb, rela,
	inicio, cese, '' exc, fecha, remu, ap1, ap2, ap3, riesgo, null afp
from @RES
GO
