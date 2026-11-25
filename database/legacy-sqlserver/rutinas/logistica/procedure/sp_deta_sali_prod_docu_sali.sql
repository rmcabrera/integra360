CREATE PROCEDURE [dbo].[sp_deta_sali_prod_docu_sali]
	@codi_orde_pedi [char](10)
WITH EXECUTE AS CALLER
AS
DECLARE @NRO_CUEN_AUXI CHAR(7)
DECLARE @CODI_PROD CHAR(8)
DECLARE @CANT DECIMAL(18,4)
DECLARE @NRO_CUEN CHAR(7)
declare @li_cont integer
declare @li_cont_prod integer
declare @codi_docu_sali char(10)
declare @ld_cant decimal(18,4)
declare @ld_cant_sali decimal(18,4)
declare @ld_cant_inse decimal(18,4)
declare @ld_prec_prom decimal(18,4)

Create Table #PROD_ATEN
(Codi_prod Char(8), cantidad decimal(18,4), prec_prom decimal(18,4), nro_cuen char (7))

SET @NRO_CUEN_AUXI = (SELECT MAX(NRO_CUEN) FROM DETALLE_ORDEN_DE_PEDIDO WHERE CODI_ORDE_PEDI = @CODI_ORDE_PEDI)

DECLARE CURS_CARG_DETA_ORDE_PEDI CURSOR FOR
SELECT ISNULL(CODI_PROD,'0'), ISNULL(CANTIDAD,0), ISNULL(NRO_CUEN,@NRO_CUEN_AUXI)
FROM DETALLE_ORDEN_DE_PEDIDO
WHERE CODI_ORDE_PEDI = @CODI_ORDE_PEDI;

OPEN CURS_CARG_DETA_ORDE_PEDI;
FETCH CURS_CARG_DETA_ORDE_PEDI INTO @CODI_PROD, @CANT, @NRO_CUEN;

WHILE @@FETCH_STATUS = 0 
BEGIN
	set @li_cont = (Select count(codi_docu_sali) From Docu_Sali_Mate where codi_orde_pedi = @codi_orde_pedi ) 
--	print @li_cont
	set @ld_cant_sali = 0
	if @li_cont > 0 
	begin
		Declare curs_carg_sali_mate Cursor For
		SELECT ISNULL(CODI_docu_sali,'0')
		FROM Docu_sali_Mate
		WHERE CODI_ORDE_PEDI = @CODI_ORDE_PEDI;					
		open curs_carg_sali_mate;
		Fetch curs_carg_sali_mate into @codi_docu_sali;
		WHILE @@FETCH_STATUS = 0 
		BEGIN				
			set @li_cont_prod = (Select count(codi_docu_sali) From Detalle_Docu_sali Where Codi_docu_sali = @codi_docu_sali and codi_prod = @codi_prod)
			if @li_cont_prod > 0
			begin
				set @ld_cant = (Select isnull(sum(cantidad),0) From Detalle_Docu_sali Where Codi_docu_sali = @codi_docu_sali and codi_prod = @codi_prod)
			end
			else
			begin
				set @ld_cant = 0
			end
			set @ld_cant_sali = (@ld_cant_sali + @ld_cant)			
			Fetch curs_carg_sali_mate into @codi_docu_sali;
		end 
		CLOSE curs_carg_sali_mate;
		DEALLOCATE curs_carg_sali_mate;		
	end	

	set @ld_cant_inse = @cant - @ld_cant_sali
--	print @codi_prod
--	print @cant
--	print @ld_cant
--	print @ld_cant_sali
--	print @ld_cant_inse
	if @ld_cant_inse > 0 
	begin
		set @ld_prec_prom = (Select isnull(prec_prom,0) From productos Where codi_prod = @codi_prod)
		insert Into #Prod_aten (Codi_prod, Cantidad, prec_prom, nro_cuen)
		values (@codi_prod, @ld_cant_inse, @ld_prec_prom, @nro_cuen)	
	end
	FETCH CURS_CARG_DETA_ORDE_PEDI INTO @CODI_PROD, @CANT, @NRO_CUEN;
END
CLOSE CURS_CARG_DETA_ORDE_PEDI;
DEALLOCATE CURS_CARG_DETA_ORDE_PEDI;

Select *
from #Prod_aten
GO
