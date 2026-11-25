CREATE PROCEDURE [dbo].[usp_ventas_pdt_anio]
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime , @f2 datetime
--select @f1 ='01/08/2010', @f2 ='30/08/2010'

set nocount on 

declare @ctaexo char(7)

set @ctaexo = (select cuenta from cuentas_provision (nolock) where codigo=22)

SELECT  mes,
	codi_tipo_docu,
	(select desc_tipo_docu from tipo_documento T (nolock) where T.codi_tipo_docu=Mc.codi_tipo_docu) Documento,
	serie,
	(select Razon_Social from empresa (nolock) ) razon_social,
	(select Ruc from empresa (nolock) ) rucempre,
	sum(case when left(nro_cuen,1)='7' then Importe*(case when cargo_abono='A' then 1 else -1 end) else 0 end) venta,
	sum(case when left(nro_cuen,1)='7' and nro_cuen<>@ctaexo then Importe*(case when cargo_abono='A' then 1 else -1 end) else 0 end) venta_grav,
	sum(case when nro_cuen=@ctaexo then Importe*(case when cargo_abono='A' then 1 else -1 end)  else 0 end) exo
FROM Movi_Contables MC  (nolock)
WHERE subdia='V'
	and cast( convert(char(10), fecha ,103) as datetime ) between @f1 and @f2 
group by mes,codi_tipo_docu, serie
order by mes, codi_tipo_docu, serie
GO
