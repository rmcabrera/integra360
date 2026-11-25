CREATE PROCEDURE [dbo].[usp_ratios_oblig_vs_invent]
	@anio [char](4),
	@fec [datetime]
WITH EXECUTE AS CALLER
AS
--declare @anio char(4) , @fec datetime
--select @anio='2016', @fec='31/01/2016'

set nocount on


create table #Cli (codi_clie_prov char(5)) 

insert #Cli
select distinct N.codi_clie_prov from nota_ingreso N (nolock) where tipo_nota_ingr='01'

create table #inven (codi_clie_prov char(5) , total numeric(18,2) null)

insert #inven
select  labor, sum(round(stock * precio_s,2)) total
from(
select 
	  sum(cant_ingr - cant_sali) as stock,  
	  dbo.uf_ulti_prec_compr(codi_prod) precio_s,
	  (select codi_clie_prov from productos X (nolock) where X.codi_prod=kf.codi_prod) as Labor
from kardex as KF (nolock)
where periodo=@anio and fech_tran<=@fec and
			left((select cuentas_contable.nro_cuen from cuentas_contable , productos where 
				cuentas_contable.nro_cuen= productos.nro_cuen and codi_prod=kf.codi_prod),2)<>'33'		
			--and codi_prod in (select p.codi_prod from productos p (nolock) where p.codi_clie_prov in (select C.codi_clie_prov from #Cli C))
		--and codi_prod='00081554'
	 group by codi_prod) as SQL
group by labor


create table #Tempo ( codi_clie_prov char(5), importe numeric(12,2) null, dolares numeric(12,2) null,
				razon varchar(150) null, ruc varchar(15) null, total numeric(12,2) null)
				
insert #Tempo				
select 	C.codi_clie_prov,
--		sum(importe*case when codi_mone='01' then 1 else 0 end* 
--				case when Cargo_Abono='C' then 1 else -1 end) as SoloSoles,
		sum(importe*case when Cargo_Abono='C' then 1 else -1 end) as Importe,
		sum(importe_d*case when Cargo_Abono='C' then 1 else -1 end) as Importe_d,
		--(select desc_cuen from cuentas_contable where nro_cuen=c.nro_cuen) ccdes_cuen,
		dbo.F_Cliente_Proveedor(c.Codi_Clie_Prov) ClieProv,
		---C.nro_cuen, 
		(select ruc from cliente_proveedor cp(nolock) where cp.codi_clie_prov=C.codi_clie_prov) ruc,
		isnull((select i.total from #inven I where i.codi_clie_prov=c.codi_clie_prov) ,0) as Inven
from gerencial_repo_tipos A (nolock)
join gerencial_repo_tipo_cuen B (nolock)
on A.id_tipo=B.id_tipo and A.id_gere=B.id_gere
join movi_contables C (nolock)
on C.nro_cuen=B.nro_cuen
where C.anio=@anio and cast(convert(char(10),C.fecha,103) as datetime)<=@fec
			and a.id_gere=2 and a.id_tipo=1
			and codi_clie_prov in (select C.codi_clie_prov from #Cli C)
group by Codi_Clie_Prov
having not ( sum(importe*case when Cargo_Abono='C' then 1 else -1 end) =0 and sum(importe_d*case when Cargo_Abono='C' then 1 else -1 end)=0 )
order by ClieProv

		 
select razon, ruc, abs(sum(importe)) as Pagar, sum(total) as Total,
		abs(sum(importe)) / case when sum(total) =0 then 1 else sum(total) end *
			case when abs(sum(importe))> sum(total) then 1.00 else 100.00 end as ratio
from #Tempo
group by ruc, razon

drop table #tempo
drop table #Cli
drop table #inven
GO
