CREATE PROCEDURE [dbo].[usp_lista_lotes_vales]
	@condi [nvarchar](4000)
WITH EXECUTE AS CALLER
AS
--declare @condi nvarchar(4000)          
--select @condi =' and codi_vale in (1,2)'          
          
--select * from PRODUCTOS_LOTES_VALE_CRED        
        
set nocount on          
SET QUOTED_IDENTIFIER OFF          
          
declare @Ax nvarchar(4000) , @ct int , @Inser char(5)          
create table #TX (vale numeric(18) null)          
          
declare @X varchar(50)          
set @X =' and codi_Vale in ('          
set  @ct=0          
          
set @Ax=substring(@condi, len(@X) + 1, len(@Condi)  - len(@X)  - 1 )          
          
while len(@AX)>0 and @Ct<=300          
begin          
 set  @ct=@ct +1          
 if patindex('%,%',@ax)>0           
 begin          
  set @Inser = substring(@Ax,1, patindex('%,%',@ax)- 1)          
  set @Ax = substring(@Ax,patindex('%,%',@ax)+ 1, len(@AX) - len(@Inser) - 1)          
 end          
 else          
 begin          
  set @Inser = @Ax          
  set @Ax=''          
 end          
 if rtrim(@Inser)<>''          
  insert #TX          
  select @Inser          
end          
        
select r.codi_prod_alma_lote, sum(cantidad) Cantidad,codi_prod,lote,fec_vence,    
(select desc_prod from productos p (nolock) where p.codi_prod=al.codi_prod ) desc_prod ,  
CODI_ALMA      
from dbo.PRODUCTOS_LOTES_VALE_CRED R (nolock)       
 left join  PRODUCTO_ALMACEN_LOTE al (nolock) on al.codi_prod_alma_lote=r.codi_prod_alma_lote    
where codi_Vale in (select vale from #Tx)           
group by r.codi_prod_alma_lote,codi_prod,lote,fec_vence,CODI_ALMA      
        
         
        
drop table #tx          
    
    
SET QUOTED_IDENTIFIER ON
GO
