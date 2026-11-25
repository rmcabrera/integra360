CREATE PROCEDURE [dbo].[usp_reporte_compras_vs_pagado]
	@anio [int],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @anio int,  @f2 datetime
--select @anio='2016',  @f2='31/12/2016'

set nocount on

Create table #NI (codi_clie_prov char(5) , codi_tipo_docu char(4) , serie varchar(20) , nro_docu varchar(20), codi_prod varchar(8),
					cantidad numeric(12,4) null, subtotal numeric(12,2) null, codi_mone char(2) null, codi_nota_ingr char(10)
					)

Create table #CC (codi_clie_prov char(5) , codi_tipo_docu char(4) , serie varchar(20) , nro_docu varchar(20), nro_cuen varchar(7),
					soles numeric(12,2) null, dolar numeric(12,2) null)

create table #PX ( codi_prod char(8) , stock numeric(12,4) null)

insert #Px
select codi_prod, sum(cant_ingr - cant_sali) as stock
from kardex k (nolock)
where periodo=@anio and cast(convert(char(10),fech_tran ,103) as datetime)<=@f2
group by codi_prod

insert #Ni
select codi_clie_prov , codi_tipo_docu_cont, nro_seri_docu_cont, nro_docu_cont, codi_prod, cantidad, 
		cantidad*prec_unit as subtotal, N.codi_mone, N.codi_nota_ingr
from nota_ingreso N (nolock) 
join detalle_nota_ingreso D (nolock)
on N.codi_nota_ingr=D.codi_nota_ingr
where year(fech_nota_ingr)=@anio and cast(convert(char(10),fech_nota_ingr ,103) as datetime)<=@f2 and tipo_nota_ingr not in ('04','23','37')

create table #FN (codi_clie_prov char(5) , codi_tipo_docu char(4) , serie varchar(20) , 
		nro_docu varchar(20), codi_mone char(2), subtotal numeric(12,2) )

insert #FN
select codi_clie_prov, codi_tipo_docu, serie, nro_docu, codi_mone,sum(subtotal) as sub 
from #Ni
group by codi_clie_prov, codi_tipo_docu, serie, nro_docu, codi_mone

--select * from #FN --where nro_docu=46002          

create table #Rx (codi_clie_prov char(5) , codi_tipo_docu char(4) , serie varchar(20) , 
		nro_docu varchar(20), codi_mone char(2),  registro varchar(11) null, importe numeric(12,2), importe_d numeric(12,2))

insert #Rx
select distinct F.codi_clie_prov, F.codi_tipo_docu, 
			case when isnumeric(F.serie)=1 then 
			cast(cast(F.serie as int) as varchar) else F.serie end ,
			 rtrim(F.nro_docu), F.codi_mone, M.registro, M.importe, M.importe_d
from #FN F
 join movi_contables M (nolock)
on F.codi_clie_prov=M.codi_clie_prov and F.codi_tipo_docu=M.codi_tipo_docu and 
	case when isnumeric(F.serie)=1 then 
			cast(cast(F.serie as int) as varchar) else F.serie end =case when isnumeric(M.serie)=1 then 
							cast(cast(M.serie as int) as varchar) else M.serie end and 
	rtrim(F.nro_docu)= rtrim(M.nro_docu)
	--and F.codi_mone=M.codi_mone
where subdia in ('C','M') and not rtrim(isnull(registro,''))='' 

create table #Cx (codi_clie_prov char(5) , codi_tipo_docu char(4) , serie varchar(20) , 
		nro_docu varchar(20),  registro varchar(11) null, importe numeric(12,2), importe_d numeric(12,2))

insert #CX
select A.codi_clie_prov, A.codi_tipo_docu, A.serie, A.nro_docu, A.registro, 
		sum(M.importe *case when cargo_Abono='A' then 1 else - 1 end) soles,
		sum(m.importe_d *case when cargo_Abono='A' then 1 else - 1 end) dolar
from #Rx A
join movi_contables M (nolock)
on A.registro=M.registro
where M.anio=@anio and fecha<=@f2
group by A.codi_clie_prov, a.codi_tipo_docu, A.serie, A.nro_docu, A.registro


create table #Prc (codi_clie_prov char(5) , codi_tipo_docu char(4) , serie varchar(20) , 
		nro_docu varchar(20),  registro varchar(11) null, importe numeric(12,2), importe_d numeric(12,2),
		porcentaje numeric(12,4) null)

insert #Prc
select A.codi_clie_prov, B.codi_tipo_docu, A.serie, A.nro_docu, A.registro, A.importe, B.importe,
		round(case when codi_mone='02' 
			then case when A.importe_d<>0 then 
					B.importe_d/ A.importe_d *100
					else 0 end 
			else case when A.importe<>0 then 
					B.importe/ A.importe  *100
					else 0 end 
			end ,2) as PorcDeuda
		
from #Rx A
join #Cx B
on A.codi_Clie_prov=B.codi_Clie_prov and A.codi_tipo_docu=B.codi_tipo_docu and 
		A.serie=B.serie and A.nro_docu=B.nro_docu and A.registro=B.registro

create table #PxC (codi_prod char(8),comprado numeric(12,2) ,  stock_pagado numeric(12,2) null)

insert #PxC
select codi_prod, sum(cantidad), sum(pagado)
from
(select codi_prod, cantidad, round(cantidad * isnull((select top 1 porcentaje/100.00 from #Prc A 
					where A.codi_clie_prov=B.codi_clie_prov and A.codi_tipo_docu=B.codi_tipo_docu and 
							A.serie=B.serie and A.nro_docu=B.nro_docu
							order by porcentaje desc),0),0) as pagado
from #Ni B) SQ
group by codi_prod

select A.codi_prod, 
		(select desc_prod from productos P (nolock) where p.codi_prod=A.codi_prod) NomProd,
		stock ,  comprado, stock_pagado
from #Px A
join #PxC B
on A.codi_prod=B.codi_prod

drop table #CC
drop table #Px
drop table #Ni
drop table #FN
drop table #RX
drop table #Cx
drop table #Prc
drop table #PxC
GO
