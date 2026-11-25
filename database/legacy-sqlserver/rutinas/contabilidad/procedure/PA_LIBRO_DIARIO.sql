CREATE PROCEDURE [dbo].[PA_LIBRO_DIARIO]
	@ANIO [char](4),
	@MES [char](2)
WITH EXECUTE AS CALLER
AS
--declare @ANIO CHAR(4) , @MES CHAR(2)
--select @ANIO ='2012' , @MES ='01'

SELECT
	COMPR, 
	FECHA,
	GLOSA,
	codi_libro,
	COMPR,
	isnull(serie,' ') + ' ' + nro_docu as NRO_COMPR,
	NRO_CUEN,
	(SELECT DESC_CUEN FROM CUENTAS_CONTABLE C WHERE C.NRO_CUEN = MOVI_CONTABLES.NRO_CUEN) AS DESC_CUEN,
	DEBE    =  case when cargo_abono ='C' THEN IMPORTE ELSE 0 END,
	HABER = case when cargo_abono = 'A' THEN IMPORTE ELSE 0 END ,
	DOLAR  = case when codi_mone='02' THEN IMPORTE_D ELSE 0 END 
FROM  MOVI_CONTABLES (nolock) INNER JOIN SUBDIARIO ON SUBDIARIO.NEMOTEC = MOVI_CONTABLES.SUBDIA 
WHERE ANIO=@ANIO AND MES = @MES and not( (subdia='V' and codi_tipo_docu='0003')  or 
		(subdia in ('A', 'S','X') and left(nro_cuen,1) in ('9','2','6') )
		or subdia='K'
		/*or (subdia='M' and left(nro_Cuen,2) in ('12','13') and codi_tipo_docu='0003')*/ )
union all
SELECT rtrim(min(compr)) as compr,
	fecha, 
	case subdia when 'V' then 'Consolidación desde ' +rtrim(min(nro_docu))+'-'+rtrim(max(nro_docu)) 
		when 'A' then 'Automático' when 'K' then 'Consumos del Mes' when 'S' then 'Saldos Iniciales' when 'X' then 'Asiento de Cierre' else '' end as glosa,
	codi_libro, min(compr) as compr,
	case when rtrim(serie)<>'' then rtrim(isnull(RTRIM(serie)+'-',' ')) else '' end  + rtrim(min(nro_docu)) as NRO_COMPR,
	NRO_CUEN,
	(SELECT DESC_CUEN FROM CUENTAS_CONTABLE C WHERE C.NRO_CUEN = MOVI_CONTABLES.NRO_CUEN) AS DESC_CUEN,
	DEBE    =  sum(case when cargo_abono ='C' THEN IMPORTE ELSE 0 END),
	HABER = sum(case when cargo_abono = 'A' THEN IMPORTE ELSE 0 END ),
	DOLAR  = sum(case when codi_mone='02' THEN IMPORTE_D ELSE 0 END )
FROM  MOVI_CONTABLES (nolock) INNER JOIN SUBDIARIO ON SUBDIARIO.NEMOTEC = MOVI_CONTABLES.SUBDIA 
WHERE ANIO=@ANIO AND MES = @MES and ( (subdia='V' and codi_tipo_docu='0003') or 
		(subdia in ('A', 'S','X') and left(nro_cuen,1) in ('9','2','6')))
group by anio, mes, fecha, serie, codi_libro, nro_Cuen, orden, SUBDIA
union all 
SELECT rtrim(min(compr)) as compr,
	cast(convert(char(10),fecha,103) as datetime) fecha, 
	case subdia when 'V' then 'Consolidación desde ' +rtrim(min(compr))+'-'+rtrim(max(compr)) 
		when 'A' then 'Automático' when 'K' then 'Consumos del Mes' when 'S' then 'Saldos Iniciales' when 'X' then 'Asiento de Cierre' else '' end as glosa,
	codi_libro, min(compr) as compr,
	'', --case when rtrim(serie)<>'' then rtrim(isnull(RTRIM(serie)+'-',' ')) else '' end  + rtrim(min(nro_docu)) as NRO_COMPR,
	NRO_CUEN,
	(SELECT DESC_CUEN FROM CUENTAS_CONTABLE C WHERE C.NRO_CUEN = MOVI_CONTABLES.NRO_CUEN) AS DESC_CUEN,
	DEBE    =  sum(case when cargo_abono ='C' THEN IMPORTE ELSE 0 END),
	HABER = sum(case when cargo_abono = 'A' THEN IMPORTE ELSE 0 END ),
	DOLAR  = sum(case when codi_mone='02' THEN IMPORTE_D ELSE 0 END )
FROM  MOVI_CONTABLES (nolock) INNER JOIN SUBDIARIO ON SUBDIARIO.NEMOTEC = MOVI_CONTABLES.SUBDIA 
WHERE ANIO=@ANIO AND MES = @MES and subdia='K'
group by anio, mes, cast(convert(char(10),fecha,103) as datetime), codi_libro,nro_Cuen, orden, SUBDIA
/*
--union all 
SELECT rtrim(min(compr)) as compr,
	cast(convert(char(10),fecha,103) as datetime) fecha, 
	case subdia when 'M' then 'Consolidación desde ' +rtrim(min(nro_docu))+'-'+rtrim(max(nro_docu)) 
		when 'A' then 'Automático' when 'K' then 'Consumos del Mes' when 'S' then 'Saldos Iniciales' 
		when 'X' then 'Asiento de Cierre' 
		else '' end as glosa,
	codi_libro, min(compr) as compr,
	case when rtrim(serie)<>'' then rtrim(isnull(RTRIM(serie)+'-',' ')) else '' end  + rtrim(min(nro_docu)) as NRO_COMPR,
	NRO_CUEN,
	(SELECT DESC_CUEN FROM CUENTAS_CONTABLE C WHERE C.NRO_CUEN = MOVI_CONTABLES.NRO_CUEN) AS DESC_CUEN,
	DEBE    =  sum(case when cargo_abono ='C' THEN IMPORTE ELSE 0 END),
	HABER = sum(case when cargo_abono = 'A' THEN IMPORTE ELSE 0 END ),
	DOLAR  = sum(case when codi_mone='02' THEN IMPORTE_D ELSE 0 END )
FROM  MOVI_CONTABLES (nolock) INNER JOIN SUBDIARIO ON SUBDIARIO.NEMOTEC = MOVI_CONTABLES.SUBDIA 
WHERE ANIO=@ANIO AND MES = @MES and (subdia='M' and left(nro_Cuen,2) in ('12','13') and codi_tipo_docu='0003')
group by anio, mes, cast(convert(char(10),fecha,103) as datetime), serie, codi_libro,nro_Cuen, orden, SUBDIA
order by 2*/


--ORDER BY SUBDIARIO.ORDEN ,  CAST(COMPR AS BIGINT), codi_contable
GO
