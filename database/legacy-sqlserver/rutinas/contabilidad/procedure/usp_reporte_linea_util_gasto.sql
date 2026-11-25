CREATE PROCEDURE [dbo].[usp_reporte_linea_util_gasto]
	@FI [datetime],
	@FF [datetime],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @FI datetime , @FF datetime
--select @FI='01/05/2015' , @FF ='18/05/2015' 

select (select X.codi_alma from almacen X (nolock) where X.codi_unid_oper=M.codi_unid_oper) codi_alma,
		(select X.nemo_alma from almacen X (nolock) where X.codi_unid_oper=M.codi_unid_oper) nemo,
		nro_cuen, compr, fecha, nro_docu, 
		(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu=M.codi_tipo_docu) TD,
		dbo.f_cliente_proveedor(codi_clie_prov)  razon, mes, subdia, 
		importe*case when cargo_abono='C' then 1 else -1 end as importe	,
		(select desc_cuen from cuentas_contable C (nolock) where C.nro_cuen=M.nro_cuen) as Cuenta
		from movi_contables M (nolock) 
where cast(convert(char(10),fecha,103) as datetime) between @FI and @FF
		and codi_unid_oper in (select A.codi_unid_oper from almacen A (nolock) where codi_alma=@codi_alma)
		and left(nro_Cuen,2) in (62, 63, 64, 65, 67 )
GO
