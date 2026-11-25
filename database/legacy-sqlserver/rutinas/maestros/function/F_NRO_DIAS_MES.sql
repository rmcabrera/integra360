CREATE FUNCTION [dbo].[F_NRO_DIAS_MES](@anio [int], @mes [int])
RETURNS [int] WITH EXECUTE AS CALLER
AS 
BEGIN 

declare  @li_Ud int

if  @mes = 1	 set  @li_Ud = 31 ;

if  @mes = 2
begin
      If dbo.f_Bisiesto(@anio)=1
	begin
		set @li_Ud = 29
	end

	Else
	begin
		set @li_Ud = 28
	end
end

if  @mes = 3	 set  @li_Ud = 31 ;
if  @mes = 4	 set  @li_Ud = 30 ;
if  @mes = 5	 set  @li_Ud = 31 ;
if  @mes = 6	 set  @li_Ud = 30 ;
if  @mes = 7	 set  @li_Ud = 31 ;
if  @mes = 8	 set  @li_Ud = 31 ;
if  @mes = 9	 set  @li_Ud = 30 ;
if  @mes = 9	 set  @li_Ud = 30 ;
if  @mes = 10	 set  @li_Ud = 31 ;
if  @mes = 11	 set  @li_Ud = 30 ;
if  @mes = 12	 set  @li_Ud = 31 ;

Return @li_Ud


END
GO
