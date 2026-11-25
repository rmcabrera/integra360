CREATE PROCEDURE [dbo].[usp_repo_fact_resu_tota_x_vend]
	@fec1 [datetime],
	@fec2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime , @fec2 datetime, @alma char(2)  
--select @fec1 ='01/09/2017' , @fec2='13/09/2017' , @alma ='18'  
  
set nocount on  
set QUOTED_IDENTIFIER OFF  
  
declare @SQLSTRING nvarchar(4000)  
declare @Condi varchar(100)  
declare @ParmString nvarchar(100)  
  
set @ParmString = "@fec1 as datetime, @fec2 as datetime "  
if @alma ='' or @alma is null set @Condi='' else set @Condi=" and F.codi_alma =" +@alma  
  
set @SQLString ="  
  select upper((select apel_1 + isnull(' ' +apel_2, '') + isnull(' ' +nomb_1,'') + isnull(' ' +nomb_2,'')  
    from usuarios U (nolock)  where U.codi_usua=f.cod_usua_vende)) Vendedor,  
   max(tota_fact) tota_fact,   
   f.cod_usua_vende,   
   F.codi_mone codi_mone,  
   SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when codi_imp=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end))) tota_costo       
  from factura F (nolock)   
  join factura_detalle D (nolock)  
  on F.codi_fact = D.codi_fact  
  where cast(convert(char(10),fech_fact,103) as smalldatetime) between @fec1 and @fec2 and isnull(F.estado,'')<> 'A'  " +@Condi +   
 "   
 group by cod_usua_vende, F.codi_Fact,codi_mone  
 order by 1,2,3,4"  
  
create table #Rx (vendedor varchar(150) , tota_fact numeric(12,2) , codi_vende char(5) , codi_mone char(2), tota_costo numeric(12,4))  
  
insert #Rx  
execute sp_executesql @SQLString, @ParmString, @fec1=@fec1, @fec2=@fec2  
  
select vendedor, sum(tota_fact) as tota_fact, codi_vende, codi_mone,  
  sum(tota_costo) as Tota_costo  
from #Rx  
group by vendedor, codi_Vende, codi_mone  
  
drop table #Rx
GO
