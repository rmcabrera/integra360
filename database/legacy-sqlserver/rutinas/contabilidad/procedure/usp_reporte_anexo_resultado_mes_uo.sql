CREATE PROCEDURE [dbo].[usp_reporte_anexo_resultado_mes_uo]
	@anio [char](4),
	@mes [char](2),
	@cuenta [char](7),
	@uo [char](5)
WITH EXECUTE AS CALLER
AS
--declare @mes char(2), @anio char(4), @cuenta  char(7), @uo char(5)
--select @mes='12', @anio='2011', @cuenta='6', @uo='30000'
set nocount on

SELECT      A.nro_cuen, 
            (select desc_cuen from cuentas_contable C (nolock) where c.nro_cuen=a.nro_cuen) desc_cuen,
            sum(case when mes='01' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SEne,
            sum(case when mes='02' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SFeb,
            sum(case when mes='03' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SMAr,
            sum(case when mes='04' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SAbr,
            sum(case when mes='05' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SMay,
            sum(case when mes='06' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SJun,
            sum(case when mes='07' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SJul,
            sum(case when mes='08' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SAgo,
            sum(case when mes='09' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SSeti,
            sum(case when mes='10' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SOct,
            sum(case when mes='11' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SNov,
            sum(case when mes='12' then importe*case when cargo_abono='C' then 1 else -1 end else 0 end) SDic
FROM MOVI_CONTABLES A (nolock)
WHERE ANIO = @ANIO and MES<=@MES and Left(NRO_CUEN,Len(@CUENTA)) =@CUENTA 
and CODI_UNID_OPER=@UO
group by nro_cuen
order by 1
GO
