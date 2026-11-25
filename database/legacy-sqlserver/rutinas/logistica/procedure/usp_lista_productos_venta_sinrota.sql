CREATE PROCEDURE [dbo].[usp_lista_productos_venta_sinrota]
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @alma char(2)
--select @alma ='19'

set nocount on

create table #Px(codi_prod char(8) null, desc_prod varchar(150) null, codi_alma char(2) null, 
				ultimaventa datetime null , plazo datetime null, diassinventa int null, color int null)

insert #Px
select codi_prod, 
		(select desc_prod from productos P(nolock) where P.codi_prod=sql.codi_prod) as desc_prod,
		codi_alma, 
		cast(convert(char(10),ultimaventa,103) as datetime) as ultimaventa, 
		cast(convert(char(10),plazo,103) as datetime) as plazo,
		DATEDIFF(D,plazo, getdate()) diassinventa,
		isnull((select count(*) from productos_sin_venta P(nolock) where P.codi_prod=sql.codi_prod and P.codi_alma=sql.codi_alma 
			and P.ultimaventa=cast(convert(char(10),sql.ultimaventa,103) as datetime) and P.plazo=cast(convert(char(10),sql.plazo,103) as datetime)),0) color
from(
	select codi_prod, codi_alma, max(fech_tran) ultimaventa, dateadd(d,7,max(fech_tran)) plazo
	from kardex (nolock)
	where periodo <= year(getdate()) and codi_alma = @alma
	and concepto like '%VENTA,%'
	--and codi_prod='00081459'
	group by codi_prod, codi_alma) as sql
where DATEDIFF(D,plazo, getdate())>=7
order by desc_prod


--select * from #Px

create table #Sx(prod char(8) null, stock numeric(18,2) null)

insert #Sx
select K.codi_prod, sum(cant_ingr) - sum(cant_sali) as stock
from kardex K(nolock)
join #Px P
on K.codi_prod = P.codi_prod
where year(fech_tran)=year(getdate()) and K.codi_alma = P.codi_alma
group by K.codi_prod, k.codi_alma

--select * from #Sx

select codi_prod, desc_prod, codi_alma, 
	   ultimaventa, plazo, diassinventa, color, 
	   isnull(stock,0) as stock
	   
from #Px P
left join #Sx S
on P.codi_prod = S.prod
where isnull(stock,0) > 0
order by desc_prod


drop table #Px
drop table #Sx
GO
