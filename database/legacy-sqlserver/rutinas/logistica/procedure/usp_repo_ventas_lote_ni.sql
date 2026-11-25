CREATE PROCEDURE [dbo].[usp_repo_ventas_lote_ni]
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime, @fec2 datetime   
--select @fec1='01/12/2017', @fec2='15/12/2017'  
  
set nocount on   
  
create table #Tx (codi_prod char(8), codi_prod_alma_lote numeric(12), lote varchar(100), cantidad int)  
  
insert #Tx  
select E.codi_prod, F.codi_prod_alma_lote, max(x.lote) as lote,  
  sum(F.cantidad) as cantidad  
from docu_sali_mate D(nolock)   
join detalle_docu_sali E (nolock)  
on d.codi_docu_sali=e.codi_docu_sali  
join PRODUCTOS_LOTES_INGRE_SALI F (nolock)  
on f.codi_deta_ingre_sali=E.codi_deta_docu_sali  
join producto_almacen_lote X (nolock)  
on X.codi_prod_alma_lote=F.codi_prod_alma_lote  
where d.fech_emis between @fec1 and @fec2 and tipo_sali='08'  
group by f.codi_prod_alma_lote, E.codi_prod  
  
declare @Vs table (codi_docu_sali char(10))  
  
insert @Vs  
select distinct N.codi_docu_sali  
from productos_lotes_ingre_sali A (nolock)  
join nota_ingreso N (nolock)  
on A.codi_ingr_sali=N.codi_nota_ingr  
join #Tx B  
on  a.codi_prod_alma_lote = b.codi_prod_alma_lote  
 where  io=1 and N.tipo_nota_ingr='23'  
  
declare @Nx table (fecha_nota datetime, tipo_Docu char(4) null, serie varchar(10) null, nro_docu varchar(10) null,  
     fecha_fact datetime null, lote varchar(100) null, nro_nota_ingr char(10))  
  
insert @Nx           
select distinct n.fech_nota_ingr, n.codi_tipo_docu_cont, n.nro_Seri_docu_cont, n.nro_docu_cont , n.fech_reg_fact,  
  (select x.lote from producto_almacen_lote x (nolock) where x.codi_prod_alma_lote=a.codi_prod_alma_lote) as Lote,  
  n.nro_nota_ingr  
from productos_lotes_ingre_sali A (nolock)  
join nota_ingreso N (nolock)  
on A.codi_ingr_sali=N.codi_nota_ingr  
where a.codi_prod_alma_lote in (select b.codi_prod_alma_lote   
          from @Vs A  
          join productos_lotes_ingre_sali B (nolock)  
          on A.codi_docu_sali=B.codi_ingr_sali   
          where io=2)  
   and io=1 and N.tipo_nota_ingr='01'            
  
select codi_prod,   
  (select x.desc_prod from productos x(nolock) where x.codi_prod=A.codi_prod) as Producto,  
  B.lote,   
  sum(cantidad) as cantidad,   
  max(fecha_nota) as fecha_nota,   
  max(nro_nota_ingr) as nro_nota,  
  max(tipo_docu) as tipo_docu,   
  max(serie) as serie,   
  max(nro_docu) as nro_docu,    
  max(fecha_Fact) as fecha_factura  
from #Tx A  
left join @Nx B  
on A.lote=B.lote  
where b.lote is not null  
group by codi_prod, B.lote  
order by producto, fecha_nota  
  
drop table #Tx
GO
