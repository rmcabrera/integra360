CREATE PROCEDURE [dbo].[usp_stock_cancelado_all]
	@per [int]
WITH EXECUTE AS CALLER
AS
--declare @per int   
--select @per=2018
  
set nocount on   
  
declare @cod char(8)  
  
create table #Rp (idd int, codi_prod char(8),  desc_prod varchar(150) ,   
     codi_alma char(2) , nemo_alma varchar(50) , stock int, letras int, pendiente numeric(12,2) null, saldo numeric(12,2) null,  
      cancelado numeric(12,2) null, empresa varchar(150) ,  
       prec_prom numeric(12,4) null, valorizado numeric(12,2)  null)   
  
declare @PX table (codi_prod char(8))  
  
insert @Px  
select distinct codi_prod  
from kardex (nolock) where periodo=@per  
  
declare c1 cursor for select codi_prod from @Px  
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
  
select  R.codi_prod,  desc_prod, stock, empresa, prec_prom,   
  case when Valorizado<0 then 0 else Valorizado end as Valorizado,   
   registro, cantidad ,  
   (select top 1 case when M.codi_mone='01' then 'S/' else 'US$' end   
      from movi_contables M(nolock) where M.registro=l.registro and subdia='L' and cargo_abono='A'  
        and not glosa like 'Diferencia de Cambio automático%') as Mone,
  (select top 1 dbo.f_cliente_proveedor(m.codi_clie_prov)  
      from movi_contables M(nolock) where M.registro=l.registro and subdia='L' and cargo_abono='A'  
        and not glosa like 'Diferencia de Cambio automático%') Proveedor,
  (select top 1 case when M.codi_mone='01' then importe else importe_d end   
      from movi_contables M(nolock) where M.registro=l.registro and subdia='L' and cargo_abono='A'  
        and not glosa like 'Diferencia de Cambio automático%') Importe,  
        cancelado
from #Rp R   
left join letras_productos L (nolock)  
on R.codi_prod=l.codi_prod  
where  cancelado >0 --pendiente=0 and stock<>0  
order by 2  
  
drop table #Rp
GO
