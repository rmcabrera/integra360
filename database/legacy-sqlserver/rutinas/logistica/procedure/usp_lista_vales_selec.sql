CREATE PROCEDURE [dbo].[usp_lista_vales_selec]
	@condi [nvarchar](4000)
WITH EXECUTE AS CALLER
AS
--declare @condi nvarchar(4000)    
--select @condi =' and codi_vale in (1,2)'    
    
--select * from registro_vale_detalle  
  
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
    
create table #Tempo (codi_prod char(8) , prec_unit numeric(18,4) null, cantidad numeric(18,4) null,     
  total  numeric(12,3) null, descr varchar(200) null , costo numeric(12,4 ) null , codi_imp int null)    
    
DECLARE @SQLString NVARCHAR(4000)    
DECLARE @ParmDefinition NVARCHAR(500)    
    
set @SQLString="select codi_prod, max(prec_item),sum(cantidad) Cantidad ,  max(prec_item)*sum(cantidad) Total,    
  (select desc_prod from dbo.productos P (nolock) where P.codi_prod =R.codi_prod) Descr,    
	prec_costo Costo,    
 (select cod_impuesto from dbo.productos P (nolock) where P.codi_prod=R.codi_prod)  codi_imp    
 from dbo.registro_vale_Detalle R (nolock)    
 where not (codi_prod is null or codi_prod='') and codi_Vale in (select vale from #Tx)     
 group by codi_prod, prec_costo"    
    
set @SQLString= @SQLString + " union all select '' codi_prod, prec_item,sum(cantidad) Cantidad ,sum(impo_item) Total,    
  desc_item Descr, prec_costo Costo, 1 codi_imp    
 from dbo.registro_vale_Detalle R (nolock)    
 where (codi_prod is null or codi_prod='')  and codi_Vale in (select vale from #Tx)     
 group by desc_item, prec_item, prec_costo"    
    
insert #Tempo     
EXECUTE sp_executesql @SQLString    
    
select codi_prod , prec_unit , cantidad , total  , descr  , costo ,codi_imp    
from #Tempo    
    
drop table #tempo    
drop table #tx    
SET QUOTED_IDENTIFIER ON
GO
