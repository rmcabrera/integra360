CREATE PROCEDURE [dbo].[usp_stock_prod_x_alma]
	@codi [char](10)
WITH EXECUTE AS CALLER
AS
--select * from kardex (nolock) where codi_prod='0000080932'

--declare @codi char(10)
--select @codi='0000001139'

set nocount on

declare @Tx table (codi_prod char(8) null, producto varchar(150) null, fecha datetime null,
		stock numeric(12,4) null, codi_alma varchar(50) null)

insert @Tx
select B.codi_prod, dbo.f_producto(B.codi_prod) producto, max(fecha) fecha, 
	isnull(sum(cant_ingr),0) - isnull(sum(cant_sali),0) stock, 
	(select isnull(nemo_alma,'') from almacen Z(nolock) where Z.codi_alma = A.codi_alma) codi_alma
from kardex A(nolock)
join detalle_orden_compra B(nolock)
on A.codi_prod = B.codi_prod
join orden_de_compra X(nolock)
on B.codi_orde_comp = X.codi_orde_comp
where B.codi_orde_comp=@codi and periodo=year(X.fecha) and 
cast(convert(char(10),A.fech_tran,103) as datetime)<=cast(convert(char(10),X.fecha,103) as datetime)
group by B.codi_prod, A.codi_alma
order by producto, A.codi_alma

declare @fec datetime, @fec_proy datetime, @fec_rot datetime
declare @anio char(4), @MS1 char(2), @MS2 char(2), @MS char(2), @fac int

select @fec = cast(convert(char(10),max(fecha),103) as datetime) from @Tx
select @fec_rot = cast(convert(char(10),dateadd(mm,-2,@fec) ,103) as datetime)
--select @fec_rot, @fec
select @anio= year(@fec)
select @MS= month(@fec)
--select @MS1 = right('00' + cast( month(dateadd(mm,-2,@fec)) as varchar),2 )
--select @MS2 = right('00' + cast( month(dateadd(mm,-1,@fec)) as varchar),2 )
SET @fec_proy = '01/'+cast(@MS as varchar)+'/'+cast(@anio as varchar)
select @fac = isnull(factor,0) from orden_de_compra (nolock) where codi_orde_comp=@codi

--select @MS1, @MS2
--select @fec_proy proy, @fec fec
--select datediff(dd, @fec_proy, dateadd(dd,1, @fec) )

--select distinct codi_prod from @Tx 

select 'STOCK' idd, codi_prod, producto, stock, LEFT(codi_alma,4) codi_alma
from @Tx

union all

select 'ROT.' idd, codi_prod, dbo.f_producto(D.codi_prod) producto, isnull(sum(cant_item),0) cc,
       (select isnull(LEFT(nemo_alma,4),'') from almacen Z(nolock) where Z.codi_alma = F.codi_alma) codi_alma
from factura F(nolock)
join factura_detalle D(nolock)
on F.codi_fact = D.codi_fact
--where year(F.fech_fact)=@anio and month(fech_fact) between @MS1 and @MS2 and
where cast(convert(char(10), fech_fact, 103) as datetime) between @fec_rot and @fec and
D.codi_prod in (select distinct codi_prod from @Tx )
group by D.codi_prod, F.codi_alma

union all

select 'PROY.' idd, codi_prod, dbo.f_producto(D.codi_prod) producto, 
	sum(cant_item) cc,
	--cast(datediff(dd, @fec_proy, dateadd(dd,1, @fec)) as numeric(12,4) ) cc,
	/*round(count(codi_prod) / 
	(case when cast(datediff(dd, @fec_proy, dateadd(dd,1, @fec)) as numeric(12,4) )=0 then 1 
		else 
		    cast(datediff(dd, @fec_proy, dateadd(dd,1, @fec) ) as numeric(12,4) ) end) * @fac,2) cc,*/
       (select isnull(LEFT(nemo_alma,4),'') from almacen Z(nolock) where Z.codi_alma = F.codi_alma) codi_alma
from factura F(nolock)
join factura_detalle D(nolock)
on F.codi_fact = D.codi_fact
where cast(convert(char(10),fech_fact, 103) as datetime) between @fec_proy and cast(convert(char(10),@fec, 103) as datetime) and
D.codi_prod in (select distinct codi_prod from @Tx )
group by D.codi_prod, F.codi_alma
GO
