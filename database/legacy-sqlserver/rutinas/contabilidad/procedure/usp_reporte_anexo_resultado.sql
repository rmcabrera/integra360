CREATE PROCEDURE [dbo].[usp_reporte_anexo_resultado]
	@anio [char](4),
	@mes [char](2),
	@cuenta [char](7)
WITH EXECUTE AS CALLER
AS
--declare @mes char(2), @anio char(4), @cuenta  char(7)
--select @mes='12', @anio='2011', @cuenta=''

set nocount on
SELECT  codi_unid_oper,
        (select  desc_unid_oper from unid_oper U (nolock) where U.codi_unid_oper=A.codi_unid_oper) Desc_unid_oper,
         A.nro_cuen, (select desc_cuen from cuentas_contable C (nolock) where c.nro_cuen=a.nro_cuen) desc_cuen,
         sum(case when mes='01' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SEne,
	 sum(case when mes='02' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SFeb,
    	 sum(case when mes='03' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SMAr,
	 sum(case when mes='04' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SAbr,
         sum(case when mes='05' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SMay,
         sum(case when mes='06' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SJun,
         sum(case when mes='07' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SJul,
         sum(case when mes='08' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SAgo,
         sum(case when mes='09' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SSet,
         sum(case when mes='10' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SOct,
         sum(case when mes='11' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SNov,
         sum(case when mes='12' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SDic, 
	 Left(NRO_CUEN,2) cta2,	Left(NRO_CUEN,3) cta3, Left(NRO_CUEN,5) cta5, Left(NRO_CUEN,7) cta7
FROM MOVI_CONTABLES A (nolock)
WHERE ANIO = @anio and mes<=@mes and Left(NRO_CUEN,Len(@cuenta)) =@cuenta  
group by nro_cuen, codi_unid_oper
order by 2
GO
