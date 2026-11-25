CREATE PROCEDURE [dbo].[SP_ACTU_NRO_ORDE_PEDI_sali]
WITH EXECUTE AS CALLER
AS
Declare @codi_plan char(10)
Declare @codi_docu_sali char(10)
Declare @cont integer

set @cont = 0
Declare Curs_Carg_ORDE_PEDI Cursor For
Select CODI_ORDE_PEDI, codi_docu_sali
From Docu_sali_mate 
where codi_orde_pedi is not null
order by codi_docu_sali;

OPEN Curs_Carg_ORDE_PEDI;
fetch next from Curs_Carg_ORDE_PEDI into @codi_plan, @codi_docu_sali;
While @@fetch_status = 0
begin
	Insert Into Docu_sali_x_orde_pedi (codi_docu_sali, codi_orde_pedi)
	Values (@codi_docu_sali, @codi_plan )
	
	fetch next from Curs_Carg_ORDE_PEDI into @codi_plan, @codi_docu_sali;
end

close Curs_Carg_ORDE_PEDI;
Deallocate Curs_Carg_ORDE_PEDI;
GO
