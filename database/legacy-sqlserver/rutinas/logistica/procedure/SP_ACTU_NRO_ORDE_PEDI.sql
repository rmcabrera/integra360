CREATE PROCEDURE [dbo].[SP_ACTU_NRO_ORDE_PEDI]
WITH EXECUTE AS CALLER
AS
Declare @codi_plan char(10)
Declare @cont integer

set @cont = 0
Declare Curs_Carg_ORDE_PEDI Cursor For
Select O.CODI_ORDE_PEDI
from lista_de_requerimientos L, ORDEN_DE_PEDIDO O
where L.pedi_trab = 'S' AND O.CODI_LIST_REQU = L.CODI_LIST_REQU
--where L.pedi_trab = 'P' AND O.CODI_LIST_REQU = L.CODI_LIST_REQU
ORDER BY CODI_ORDE_PEDI;

OPEN Curs_Carg_ORDE_PEDI;
fetch next from Curs_Carg_ORDE_PEDI into @codi_plan;
While @@fetch_status = 0
begin
--	set @cont = CAST(@CODI_PLAN AS INTEGER)
	set @cont = @cont + 1
	update orden_de_pedido
	set nro_orde_pedi = cast(@cont as char(10))
	where codi_orde_pedi = @codi_plan
	print @cont
	fetch next from Curs_Carg_ORDE_PEDI into @codi_plan;
end

close Curs_Carg_ORDE_PEDI;
Deallocate Curs_Carg_ORDE_PEDI;
GO
