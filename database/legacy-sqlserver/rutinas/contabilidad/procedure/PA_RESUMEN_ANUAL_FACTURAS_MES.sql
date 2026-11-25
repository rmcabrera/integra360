CREATE PROCEDURE [dbo].[PA_RESUMEN_ANUAL_FACTURAS_MES]
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime , @f2 datetime
--select @f1 ='01/08/2010', @f2 ='30/08/2010'

set nocount on

begin
 
CREATE TABLE #TOTAL (mes int  , total decimal(9,2))
declare @cont int
set @cont=0

while @cont <12
	begin
		set @cont = @cont  + 1
		insert into  #TOTAL values ( @cont , 0 );
	end

select  
(case  mes when 1 then 'A - Enero'
	      when 2 then 'B - Febrero' 
	      when 3 then 'C - Marzo' 
	      when 4 then 'D - Abril' 
	      when 5 then 'E - Mayo' 
	      when 6 then 'F - Junio'
	      when 7 then 'G - Julio' 
	      when 8 then 'H - Agosto' 
	      when 9 then 'I - Setiembre' 
	      when 10 then 'J - Octubre'
	      when 11 then 'K - Noviembre'
	      when 12 then 'L - Diciembre' else '' end) mes  ,

	 sum(total) as Total  

from 

( select mes , total from  #TOTAL
union all

SELECT    mes,  sum(  isnull(Importe,0) ) as 'Total'
 
        FROM 

	(SELECT  CLIENTE_PROVEEDOR.codi_clie_prov, CLIENTE_PROVEEDOR.DENOMINACION ,Movi_Contables.mes, Movi_Contables.anio,
		case  Movi_Contables.codi_tipo_docu
		when '0007' then (-1) * sum(isnull(Movi_Contables.Importe,0)) else sum(isnull(Movi_Contables.Importe,0)) end  as Importe

	FROM Movi_Contables (nolock), CLIENTE_PROVEEDOR  (nolock)
                
	WHERE (CLIENTE_PROVEEDOR.CODI_CLIE_PROV = Movi_Contables.Codi_Clie_Prov )  and ( Movi_Contables.Subdia = 'V' ) 
		--  And ( Movi_Contables.Anio = @anio) 
		and cast( convert(char(10), fecha ,103) as datetime ) between @f1 and @f2 
		and left(nro_cuen,1)='1'  

	group by CLIENTE_PROVEEDOR.codi_clie_prov,  CLIENTE_PROVEEDOR.DENOMINACION , Movi_Contables.codi_tipo_docu ,
		   Movi_Contables.mes, Movi_Contables.anio) as Ventas group by mes    ) as V

group by mes

drop table #TOTAL

end
GO
