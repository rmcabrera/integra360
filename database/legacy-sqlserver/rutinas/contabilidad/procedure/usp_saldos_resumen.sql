CREATE PROCEDURE [dbo].[usp_saldos_resumen]
	@Gere [int],
	@fech [datetime]
WITH EXECUTE AS CALLER
AS
--declare @Gere int , @fech datetime
--select @Gere =2 , @fech='12/12/2018'

set nocount on
declare @anio int
set @anio= year(@fech)

declare @Ax table (id_gere int , id_tipo int, desc_tipo_repo varchar(100))
declare @Bx table (id_gere int , id_tipo int, nro_cuen varchar(7))

insert @Ax
select 2,	1,	'FACTURAS POR PAGAR' union all
select 2,	2,	'OBLIGACIONES FINANCIERAS'

insert @Bx
select 2,1,'4211101' union all
select 2,1,'4212101' union all
select 2,1,'4212103' union all
select 2,1,'4212104' union all
select 2,1,'4212201' union all
select 2,1,'4212203' union all
select 2,1,'4221101' union all
select 2,1,'4231101' union all
select 2,2,'4511101' union all
select 2,2,'4511201' union all
select 2,2,'4511202' union all
select 2,2,'4521101' union all
select 2,2,'4544101' union all
select 2,2,'4549101' 


select A.id_gere, A.id_tipo,desc_tipo_repo, 
		sum(importe*case when codi_mone='01' then 1 else 0 end* 
				case when Cargo_Abono='C' then 1 else -1 end) as SoloSoles,
		sum(importe*case when Cargo_Abono='C' then 1 else -1 end) as Importe,
		sum(importe_d*case when Cargo_Abono='C' then 1 else -1 end) as Importe_d, 0, 0 
from @Ax A 
join @Bx B 
on A.id_tipo=B.id_tipo and A.id_gere=B.id_gere
join movi_contables C (nolock)
on C.nro_cuen=B.nro_cuen
where C.anio=@anio and cast(convert(char(10),C.fecha,103) as datetime)<=@fech
			and a.id_gere=@gere
group by A.id_gere, A.id_tipo, desc_tipo_repo
GO
