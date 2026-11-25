CREATE PROCEDURE [dbo].[usp_control_usuario]
	@fec [datetime],
	@tipo [char](1),
	@codi [char](5)
WITH EXECUTE AS CALLER
AS
--declare @fec datetime, @tipo char(1), @codi char(5)   
--select @fec= '24/10/2011', @tipo='T', @codi='00002'  
  
set nocount on  

declare @fit1 datetime, @fst1 datetime, @fit2 datetime, @fst2 datetime
set @Fit1=dateadd(hh,5,@fec )  
set @Fst1=dateadd(hh,14,@fec )  
set @Fit2=dateadd(mi,841,@fec )  
set @Fst2=dateadd(mi,1439,@fec )  
if @tipo='T'  
begin  
select codi_usua,  
	min(case when hora between @fit1 and @fst1 then hora else null end)AS 'Minimo_1',   
	(case when max(tipo)='2' then max(case when hora between @fit1 and @fst1 then hora else null end) else null end) AS 'Maximo_1' ,
	min(case when hora between @fit2 and @fst2 then hora else null end)AS 'Minimo_2',     
   	(case when max(tipo)='2' then max(case when hora between @fit2 and @fst2 then hora else null end) else null end) AS 'Maximo_2' 
from acceso (nolock)  
where cast(convert(char(10),fecha_acce,103)  as datetime )= @fec  
group by codi_usua 
end   
  
else  
  
select codi_usua,  

 min(case when hora between @fit1 and @fst1 then hora else null end)AS 'Minimo_1',   
(case when max(tipo)='2' then max(case when hora between @fit1 and @fst1 then hora else null end) else null end) AS 'Maximo_1' , 
 min(case when hora between @fit2 and @fst2 then hora else null end)AS 'Minimo_2',  
(case when max(tipo)='2' then max(case when hora between @fit2 and @fst2 then hora else null end) else null end) AS 'Maximo_2'  
   
from acceso (nolock)  
where cast(convert(char(10),fecha_acce,103)  as datetime )= @fec and codi_usua=@codi  
group by codi_usua
GO
