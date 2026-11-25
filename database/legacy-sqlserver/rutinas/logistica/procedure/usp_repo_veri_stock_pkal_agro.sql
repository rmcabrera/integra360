CREATE PROCEDURE [dbo].[usp_repo_veri_stock_pkal_agro]
	@Anio [int],
	@prod [char](8)
WITH EXECUTE AS CALLER
AS
--declare @Anio int, @prod char(8)
--select @Anio=2014, @prod='00011516'

set nocount on 

declare @Tx table ( idd int , codi_prod char(8), stock numeric(12,4) null, kardex numeric(12,4) null,
			Almacen numeric(12,4) null, Lote numeric(12,4) null, Vale numeric(12,4) null, codi_alma char(2) )

insert @Tx
select 1 as IDD, A.codi_prod , A.stock, isnull(B.StockK,0), StockA, isnull(D.StockL,0), isnull(E.StockV,0), '00'
from productos A (nolock)
	left join (select codi_prod, sum(cant_ingr - cant_sali) StockK
		from kardex (nolock) where periodo=@Anio
		group by codi_prod) B
	on A.codi_prod=B.codi_prod
	join (select codi_prod, sum(stock_alma)  StockA
		from almacen_producto (nolock)
		group by codi_prod) C
	on A.codi_prod=C.codi_prod
	join (select codi_prod, sum(stock) StockL
		from producto_almacen_lote (nolock)
		group by codi_prod) D
	on A.codi_prod=D.codi_prod
	join (select codi_prod, sum(cantidad) StockV
		from registro_vale rv(nolock)
		join registro_vale_detalle rvd(nolock)
		on rv.codi_vale=rvd.codi_vale
		where (codi_fact is null or codi_fact='') and isnull(rv.estado,'')<>'N'
		group by codi_prod) E
	on A.codi_prod=E.codi_prod 
	where not(isnull(stock,0)=isnull(stockK,0) and isnull(stock,0)=isnull(StockA,0) and isnull(stock,0)=isnull(StockL,0) and isnull(stock,0)=isnull(StockV,0))
union all
select 2 as IDD, B.codi_prod ,0.00 Stock, StockK, StockA, StockL, StockV, B.codi_alma
	from (select codi_prod, codi_alma, sum(cant_ingr - cant_sali) StockK
		from kardex (nolock) where periodo=@Anio
		group by codi_prod,codi_alma) B
	join (select codi_prod, codi_alma, sum(stock_alma)  StockA
		from almacen_producto (nolock)
		group by codi_prod, codi_alma) C
	on B.codi_prod=C.codi_prod and B.codi_alma=C.codi_alma
	join (select codi_prod, codi_alma, sum(stock) StockL
		from producto_almacen_lote (nolock)
		group by codi_prod,codi_alma) D
	on B.codi_prod=D.codi_prod and B.codi_alma=D.codi_alma
	join (select codi_prod, rv.codi_alma, sum(cantidad) StockV
		from registro_vale rv(nolock)
		join registro_vale_detalle rvd(nolock)
		on rv.codi_vale=rvd.codi_vale
		where (codi_fact is null or codi_fact='') and isnull(rv.estado,'')<>'N'
		group by codi_prod,rv.codi_alma) E
	on B.codi_prod=E.codi_prod and B.codi_alma=E.codi_alma
	where not (stockK=stockA and stockK=StockL and stockK=StockV)


select  idd, codi_prod, 
    (select desc_prod from productos P (nolock) where P.codi_prod collate sql_latin1_general_cp1_ci_as =T.codi_prod ) Desc_prod,
	stock , kardex , Almacen , Lote , Vale, codi_alma ,
	isnull((select nemo_alma from almacen A (nolock) where A.codi_alma=T.codi_alma collate sql_latin1_general_cp1_ci_as),'GENERAL') Desc_Alma
from @Tx T
where codi_alma<>'00' and (isnull(@prod,'')='' or codi_prod=@prod)
order by codi_alma
GO
