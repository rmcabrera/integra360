CREATE PROCEDURE [dbo].[usp_repo_ulti_stock_prec]
	@alma [char](2),
	@anio [int],
	@f1 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @alma char(2) , @anio int , @f1 datetime 
--select @alma ='04' , @anio =2016 , @f1 ='20/04/2016'

set nocount on

set @f1 = cast(convert(char(10),@f1 ,103)+ ' 23:59:59' as datetime)

create table #Rx (codi_prod char(8) , stock int, precio numeric(12,4) null )

insert #Rx
select codi_prod, sum(cant_ingr - cant_sali) as Stock, dbo.uf_ulti_prec_compr(codi_prod) as UltiPrec
from kardex (nolock)
where periodo=@anio and (codi_alma=@alma or @alma='00') and fech_tran<=@f1 
group by codi_prod
having sum(cant_ingr - cant_sali)<>0
order by codi_prod


select A.codi_prod, desc_prod, dbo.f_cliente_proveedor(codi_clie_prov) as Laboratorio, A.stock, precio,  A.stock*precio as Total, 
		case when @alma='00' then 'TODOS' else (select nemo_alma from Almacen X (nolock) where X.codi_alma=@alma) end  as Almacen,
		(select razon_social from Empresa) Empresa
from #rx A
join productos B (nolock)
on A.codi_prod=B.codi_prod

drop table #Rx
GO
