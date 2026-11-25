CREATE PROCEDURE [dbo].[usp_saldos_gerenciales_clieprov]
	@Gere [int],
	@tipo [int],
	@fech [datetime]
WITH EXECUTE AS CALLER
AS
--declare @Gere int , @tipo int ,@fech datetime
--select @Gere =1 , @tipo =1, @fech='17/09/2018'

set nocount on
declare @anio int
set @anio= year(@fech)

select A.id_gere, A.id_tipo,desc_tipo_repo, 
		C.codi_clie_prov,
		sum(importe*case when codi_mone='01' then 1 else 0 end* 
				case when Cargo_Abono='C' then 1 else -1 end) as SoloSoles,
		sum(importe*case when Cargo_Abono='C' then 1 else -1 end) as Importe,
		sum(importe_d*case when Cargo_Abono='C' then 1 else -1 end) as Importe_d,
		(Select top 1 razon_social from empresa) razon_social,
		(select desc_cuen from cuentas_contable where nro_cuen=c.nro_cuen) ccdes_cuen,
		dbo.F_Cliente_Proveedor(c.Codi_Clie_Prov) ClieProv,
		C.nro_cuen, (select ruc from cliente_proveedor cp(nolock) where cp.codi_clie_prov=C.codi_clie_prov) ruc
from gerencial_repo_tipos A (nolock)
join gerencial_repo_tipo_cuen B (nolock)
on A.id_tipo=B.id_tipo and A.id_gere=B.id_gere
join movi_contables C (nolock)
on C.nro_cuen=B.nro_cuen
where C.anio=@anio and cast(convert(char(10),C.fecha,103) as datetime)<=@fech
			and a.id_gere=@gere and a.id_tipo=@tipo
group by A.id_gere, A.id_tipo, desc_tipo_repo, Codi_Clie_Prov, c.nro_cuen
having not ( sum(importe*case when Cargo_Abono='C' then 1 else -1 end) =0 and sum(importe_d*case when Cargo_Abono='C' then 1 else -1 end)=0 )
order by ClieProv
GO
