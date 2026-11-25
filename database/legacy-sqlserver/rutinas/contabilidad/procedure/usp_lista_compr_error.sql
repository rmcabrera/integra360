CREATE PROCEDURE [dbo].[usp_lista_compr_error]
	@anio [char](4),
	@ms [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @ms char(2)
--select @anio='2018', @ms='01'

set nocount on

select subdia, compr, banco, cargo_abono, importe, glosa, nro_cuen, nro_sub_cuen
from(
select mes, subdia, compr, banco, cargo_abono, importe, glosa, nro_cuen, nro_sub_cuen from movi_contables (nolock)
where anio=@anio and mes=@ms and left(nro_cuen,1)='9' and subdia not in ('A','K')

union all

select mes, subdia, compr, banco, cargo_abono, importe, glosa, nro_cuen, nro_sub_cuen from movi_contables (nolock)
where anio=@anio and mes=@ms and subdia not in ('A','K') and left(nro_cuen,1)='6' 
and left(isnull(nro_sub_cuen,''),1) not in  ('2', '9')) as SQL

order by SQL.mes, SQL.subdia, cast(SQL.compr as numeric)
GO
