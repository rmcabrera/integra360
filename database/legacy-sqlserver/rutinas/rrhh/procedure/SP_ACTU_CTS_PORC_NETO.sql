CREATE PROCEDURE [dbo].[SP_ACTU_CTS_PORC_NETO]
WITH EXECUTE AS CALLER
AS
Declare @codi_plan char(10)
Declare @PERS char(5)
Declare @cont integer
DECLARE @VALOR DECIMAL(9,2)
DECLARE @VALOR_neto DECIMAL(9,2)
DECLARE @VALORj1 DECIMAL(9,2)
set @cont = 0
Delete from planilla_cts_conceptos
where codi_conc = '999981';
Declare Curs_Carg_cts Cursor For
Select codi_plan_cts
From datos_cts 
order by codi_plan_cts;

OPEN Curs_Carg_cts ;
fetch next from Curs_Carg_cts  into @codi_plan;
While @@fetch_status = 0
begin
	set @valor = (Select valor From Planilla_cts_conceptos Where codi_plan_cts = @codi_plan and codi_conc = '999990' )
	set @valorj1 = (Select isnull( sum( isnull( valor , 0 ) ) , 0 ) From Planilla_cts_conceptos Where codi_plan_cts = @codi_plan and codi_conc >= '200011' and codi_conc < '200020' )
	
	set @VALOR_neto = @valor + @valorj1
	Insert Into Planilla_cts_conceptos (codi_plan_cts , codi_conc, afecto, valor, monto)
	Values (@codi_plan, '999981', 0, @VALOR_neto, 8.33)

	fetch next from Curs_Carg_cts  into @codi_plan;
end

close Curs_Carg_cts;
Deallocate Curs_Carg_cts;
GO
