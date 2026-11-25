CREATE PROCEDURE [dbo].[usp_stock_pendiente_all_x_sucur]
	@per [int]
WITH EXECUTE AS CALLER
AS
--declare @per int 
--select @per=2023

set nocount on 

declare @cod char(8)

create table #Rp (idd int, codi_prod char(8),  desc_prod varchar(150) , 
					codi_alma char(2) , nemo_alma varchar(50) , stock int, letras int, pendiente numeric(12,2) null, saldo numeric(12,2) null,
						cancelado numeric(12,2) null, empresa varchar(150) ,
						 prec_prom numeric(12,4) null, valorizado numeric(12,2)  null) 

create table #PX  (codi_prod char(8))

insert #Px
select distinct codi_prod
from kardex (nolock) where periodo=@per and fech_tran<='15/07/2023 23:59:59' --and codi_prod='00080428'

declare c1 cursor for select codi_prod from #Px
open c1 
fetch c1 into @cod
while @@FETCH_STATUS=0
begin
	
	insert #Rp
	exec usp_stock_pendiente @prod =@cod, @per =@per, @tipo ='R'

	fetch c1 into @cod
end 
close c1
deallocate c1

create table  #Su (codi_alma char(2) null, codi_prod char(8), cantidad int)
create table  #Prec (codi_alma char(2) null, codi_prod char(8), prec_venta numeric(12,2) null)
create table  #Fx (codi_alma char(2) null, codi_prod char(8), fecha datetime)

insert #Su
select k.codi_alma,k.codi_prod, sum(cant_ingr - cant_sali ) as Stock
from kardex K(nolock) 
join #Px P
on k.codi_prod=p.codi_prod
where periodo=@per and fech_tran<='15/07/2023 23:59:59' 
group by k.codi_alma, k.codi_prod
having sum(cant_ingr - cant_sali)<>0

insert #Prec
select A.codi_alma, a.codi_prod, 
	round( case when  codi_mone='01' then 
			(prec_costo * ( 1 +  prec_porc_uti_esp / 100) *  case when  cod_impuesto=3 then 1 else  (1 + dbo.f_igv(getdate())/100.00) end  ) 
		else 
			(prec_costo * ( 1 +  prec_porc_uti_esp / 100) *  case when cod_impuesto=3 then 1 else (1 + dbo.f_igv(getdate())/100.00) end  )* tcambio 
		end , nro_decim_precio ) as precio_venta
from #Su A
join almacen_producto B (nolock)
on A.codi_alma=B.codi_alma And A.codi_prod=B.codi_prod
join productos P (nolock)
on P.codi_prod=A.codi_prod


insert #Fx
select k.codi_alma,k.codi_prod,
		 max( case when i_o=1 and not (concepto like 'INVENTARIO,%' or (k.codi_alma='01' and concepto  like 'TRASL. SUCURSAL%') )
				then fech_Tran else null end) as fecha
from kardex K(nolock) 
join #Su P
on k.codi_alma= p.codi_alma and k.codi_prod=p.codi_prod
group by k.codi_alma, k.codi_prod
order by fecha


select idd, R.codi_prod, 
		Desc_prod,
		R.codi_alma, 
		Nemo_Alma,
		stock, 
		letras, 
		pendiente, 
		saldo, 
		cancelado,
		Empresa,
		prec_prom, 	
		
		case when Valorizado<0 then 0 else Valorizado end as Valorizado,
		
		(select (select cod_lin_pro  from familia_producto f (nolock)  
				where f.codi_fami_prod=s.codi_fami_prod) from sub_familia_producto S (nolock)
			where S.codi_sub_fami_prod in  (select P.codi_sub_fami_prod from productos P (nolock) where P.codi_prod=r.codi_prod)) as CodLinea,
		
		(select (select (select des_lin_pro from LINEA_FAMILIA_PRO L (nolock) where l.cod_lin_pro=F.cod_lin_pro) 
				 from familia_producto f (nolock)  
				where f.codi_fami_prod=s.codi_fami_prod) from sub_familia_producto S (nolock)
			where S.codi_sub_fami_prod in  (select P.codi_sub_fami_prod from productos P (nolock) where P.codi_prod=r.codi_prod)) as DesLinea,

		cast(case when cancelado<0 then cancelado*prec_prom else 0 end as numeric(12,2)) as NoPagado,

		(select s.desc_sub_fami_prod from sub_familia_producto S (nolock)
			where S.codi_sub_fami_prod in  (select P.codi_sub_fami_prod from productos P (nolock) where P.codi_prod=r.codi_prod)) as SubFamilia,

		dbo.F_Cliente_Proveedor((select P.codi_clie_prov from productos P (nolock) where P.codi_prod=r.codi_prod)) as Proveedor,
		(select codi_mone from productos P (nolock) where P.codi_prod=r.codi_prod) as codi_mone,
		case when (select top 1 ruc from empresa (nolock))='20531740786' then --DICOVI
				  case when A.codi_alma='12' then '15' 
				       when A.codi_alma='11' then '19' else A.codi_alma end
		else		  
			A.codi_alma end as Tienda,
		(select nemo_alma from almacen X (nolock) where x.codi_alma=A.codi_alma) NombTienda,
		A.cantidad as TiendaStock,
		B.fecha as FechaTienda,
		prec_venta
from #Rp R 
	join #Su a 
	on r.codi_prod=A.codi_prod
join #Fx B
	on a.codi_ALma=B.codi_alma and a.codi_prod=B.codi_prod
join #Prec C
on A.codi_alma=C.codi_alma and A.codi_prod=C.codi_prod	
--where codi_prod=00012282

drop table #Rp
drop table #Px
drop table #Su
drop table #Fx
drop table #Prec
GO
