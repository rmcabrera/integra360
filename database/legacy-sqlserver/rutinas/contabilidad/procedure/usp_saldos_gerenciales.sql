CREATE PROCEDURE [dbo].[usp_saldos_gerenciales]
	@Gere [int],
	@fech [datetime]
WITH EXECUTE AS CALLER
AS
--declare @Gere int , @fech datetime
--select @Gere =3 , @fech='12/06/2018'

set nocount on
declare @anio int
set @anio= year(@fech)

if @gere=3 
begin
	declare @rete_s numeric(12,2), @rete_d numeric(12,2)

	select @rete_s = sum(monto_s) , @rete_d = sum(monto_d) 
		from BANCOS_DISPONIBLE A (nolock)
			join BANCOS_DISPONIBLE_DETA B (nolock)
				on A.id_sec=B.id_sec
	where A.fecha=@fech

	if @rete_s is null set @rete_s=0
	if @rete_d is null set @rete_d=0


	select A.id_gere, A.id_tipo,desc_tipo_repo, 
			sum(importe*case when C.CODI_MONE='01' then 1 else 0 end* 
					case when Cargo_Abono='C' then 1 else -1 end) as SoloSoles,

			sum(importe*case when Cargo_Abono='C' then 1 else -1 end) as Importe,
			
			sum(importe_d*case when C.codi_mone='02' then 1 else 0 end *
						case when Cargo_Abono='C' then 1 else -1 end) as Importe_d,
			@rete_s as rete_s, @rete_d as rete_d
	from gerencial_repo_tipos A (nolock)
	join gerencial_repo_tipo_cuen B (nolock)
	on A.id_tipo=B.id_tipo and A.id_gere=B.id_gere
	join movi_contables C (nolock)
	on C.nro_cuen=B.nro_cuen
	where C.anio=@anio and cast(convert(char(10),C.fecha,103) as datetime)<=@fech
				and a.id_gere=@gere
	group by A.id_gere, A.id_tipo, desc_tipo_repo

end
else
begin
	select A.id_gere, A.id_tipo,desc_tipo_repo, 
			sum(importe*case when codi_mone='01' then 1 else 0 end* 
					case when Cargo_Abono='C' then 1 else -1 end) as SoloSoles,
			sum(importe*case when Cargo_Abono='C' then 1 else -1 end) as Importe,
			sum(importe_d*case when Cargo_Abono='C' then 1 else -1 end) as Importe_d, 0, 0 
	from gerencial_repo_tipos A (nolock)
	join gerencial_repo_tipo_cuen B (nolock)
	on A.id_tipo=B.id_tipo and A.id_gere=B.id_gere
	join movi_contables C (nolock)
	on C.nro_cuen=B.nro_cuen
	where C.anio=@anio and cast(convert(char(10),C.fecha,103) as datetime)<=@fech
				and a.id_gere=@gere
	group by A.id_gere, A.id_tipo, desc_tipo_repo
end
GO
