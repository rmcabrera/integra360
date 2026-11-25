CREATE PROCEDURE [dbo].[usp_stock_pendiente_conso]
	@prod [char](8),
	@per [int],
	@tipo [char](1)
WITH EXECUTE AS CALLER
AS
--declare @prod char(8), @per int , @tipo char(1)
--select @prod='00082054', @per=2021, @tipo='R'

set nocount on

create table #Sx (codi_prod char(8) , stock numeric(12,2), desc_prod varchar(50) null, 
				  CodLinea char(2) null, DesLinea varchar(50) null)
create table #Ax (codi_prod char(8) , codi_alma char(2) , stock numeric(12,2))
create table #Rx (registro varchar(10) , cantidad numeric(12,2))
create table #Lp (registro varchar(10) , importe numeric(12,2))
create table #Dx (codi_prod char(8) , letras int, pendiente int , saldo numeric(12,2), prec_prom numeric(12,4) null)
create table #Rp (idd int, codi_prod char(8), codi_alma char(2) , stock int, letras int, pendiente numeric(12,2), saldo numeric(12,2) ,
						cancelado numeric(12,2), prec_prom numeric(12,4) null, desc_prod varchar(50) null,
						CodLinea char(2) null, DesLinea varchar(50) null) 

declare @l_fec datetime
declare @stock numeric(12,2)
declare @pendiente numeric(12,2)
 
insert #Sx
select codi_prod, sum(cant_ingr - cant_sali) as stock, si_agrog.dbo.f_producto(codi_prod),
	   (select (select cod_lin_pro from si_agrog.dbo.familia_producto f (nolock)  
				where f.codi_fami_prod=s.codi_fami_prod) from si_agrog.dbo.sub_familia_producto S (nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from si_agrog.dbo.productos P (nolock) where P.codi_prod=k.codi_prod)) as CodLinea,
		
		(select (select (select des_lin_pro from si_agrog.dbo.LINEA_FAMILIA_PRO L (nolock) where l.cod_lin_pro=F.cod_lin_pro) 
				 from si_agrog.dbo.familia_producto f (nolock)  
				where f.codi_fami_prod=s.codi_fami_prod) from si_agrog.dbo.sub_familia_producto S (nolock)
			where S.codi_sub_fami_prod in  (select P.codi_sub_fami_prod from si_agrog.dbo.productos P (nolock) where P.codi_prod=k.codi_prod)) as DesLinea	

from si_agrog.dbo.kardex K(nolock)
where periodo=@per and codi_prod=@prod
group by codi_prod

union all

select codi_prod, sum(cant_ingr - cant_sali) as stock, si_dcvp.dbo.f_producto(codi_prod),
		(select (select cod_lin_pro from si_dcvp.dbo.familia_producto f (nolock)  
				where f.codi_fami_prod=s.codi_fami_prod) from si_dcvp.dbo.sub_familia_producto S (nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from si_dcvp.dbo.productos P (nolock) where P.codi_prod=k.codi_prod)) as CodLinea,
		
		(select (select (select des_lin_pro from si_dcvp.dbo.LINEA_FAMILIA_PRO L (nolock) where l.cod_lin_pro=F.cod_lin_pro) 
				 from si_dcvp.dbo.familia_producto f (nolock)  
				where f.codi_fami_prod=s.codi_fami_prod) from si_dcvp.dbo.sub_familia_producto S (nolock)
			where S.codi_sub_fami_prod in (select P.codi_sub_fami_prod from si_dcvp.dbo.productos P (nolock) where P.codi_prod=k.codi_prod)) as DesLinea	
	
from si_dcvp.dbo.kardex K(nolock)
where periodo=@per and codi_prod=@prod
group by codi_prod

set @stock  = isnull((select sum(stock) from #Sx),0)

set @l_fec = cast(convert(char(10),(select getdate()),103) as datetime)

insert #Rx 
select registro, cantidad
from si_agrog.dbo.LETRAS_PRODUCTOS (nolock)
where codi_prod=@prod

union all

select registro, cantidad
from si_dcvp.dbo.LETRAS_PRODUCTOS (nolock)
where codi_prod=@prod

insert #Lp 
select registro , sum(importe*case when cargo_abono='A' then 1 else -1 end) 
from si_agrog.dbo.movi_contables (nolock) 
where  anio=@per and registro in (select x.registro from #Rx X)
group by registro
having sum(importe*case when cargo_abono='C' then 1 else -1 end)<>0

union all

select registro , sum(importe*case when cargo_abono='A' then 1 else -1 end) 
from si_dcvp.dbo.movi_contables (nolock) 
where  anio=@per and registro in (select x.registro from #Rx X)
group by registro
having sum(importe*case when cargo_abono='C' then 1 else -1 end)<>0

insert #Dx
select @prod as producto,count(a.registro) as Letras, isnull(round(sum(cantidad),0),0) as Pendiente, 
		isnull(sum(importe),0) as Deuda,
		
		si_agrog.dbo.uf_precio_prom(@l_Fec, @prod) + si_dcvp.dbo.uf_precio_prom(@l_Fec, @prod)
						
from #Rx A
join #Lp B
on A.registro=B.registro

set @pendiente  = isnull((select sum(pendiente) from #dx ),0)
	
insert #Rp
select 1 as idd, a.codi_prod, '00' as codi_alma, stock, letras, pendiente , saldo, stock - pendiente as Cancelado,
		Prec_Prom, desc_prod, CodLinea, DesLinea
		
from #sx A
join #Dx B
on A.codi_prod=B.codi_prod

if @tipo='D' 
begin
	insert #Ax
	select codi_prod, codi_alma, sum(cant_ingr - cant_sali) as stock
	from kardex (nolock)
	where periodo=@per and codi_prod=@prod
	group by codi_prod, codi_alma

	insert #Rp
	select 2 as idd, a.codi_prod, codi_alma, stock, letras,  
			cast(stock*case when @stock<>0 then (pendiente/@stock) else 0 end as numeric(12,2)) as pendiente, 
			cast(cast(stock*case when @stock<>0 then (pendiente/@stock) else 0 end as numeric(12,2)) *
						case when @pendiente<>0 then (saldo/@pendiente) else 1 end as numeric(12,2)) as saldo,	
			cast(round(stock*case when @stock<>0 then (@stock - pendiente)/@stock else 1 end ,2) as numeric(12,2)) as Cancelado,
			Prec_Prom, ''
	from #Ax A
	join #Dx B
	on A.codi_prod=B.codi_prod

end 

select idd, codi_prod, 
		/*(select  desc_prod from productos P (nolock) where P.codi_prod=A.codi_prod) as*/ Desc_prod,
		codi_alma, 
		isnull((select nemo_alma from almacen X (nolock) where x.codi_alma=A.codi_alma ),'GENERAL' ) as NemoAlma,
		stock, letras, pendiente, 
		cast(round(prec_prom * pendiente ,2) as numeric(12,2) ) as saldo, cancelado,
		(select razon_social from empresa (nolock)) as Empresa,
		prec_prom, 	
		case when cancelado>0 then cast(round(prec_prom * cancelado ,2) as numeric(12,2) )  else 0 end as Valorizado,
		CodLinea, DesLinea
		
from #Rp A


drop table #Sx 
drop table #Ax 
drop table #Rx 
drop table #Lp 
drop table #Dx 
drop table #Rp
GO
