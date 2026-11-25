CREATE PROCEDURE [dbo].[sp_update_unid_oper_nota_ingr]
WITH EXECUTE AS CALLER
AS
Declare @codi_orde_comp char(10)
Declare  @codi_nota_ingr char(10)
Declare  @codi_unid_oper_soli char(5)
Declare  @codi_unid_oper_dest char(5)

Declare Curs_Carg_ni_x_oc Cursor for
Select codi_orde_comp, codi_nota_ingr
from nota_ingr_por_orde_comp
order by codi_nota_ingr;
Open Curs_Carg_ni_x_oc;
Fetch NEXT FROM Curs_Carg_ni_x_oc into @codi_orde_comp, @codi_nota_ingr;
WHILE @@FETCH_STATUS = 0
Begin
	set @codi_unid_oper_soli = (Select codi_unid_oper_soli from orden_de_compra where codi_orde_comp = @codi_orde_comp)
	set @codi_unid_oper_dest = (Select codi_unid_oper_dest from orden_de_compra where codi_orde_comp = @codi_orde_comp)

	update nota_ingreso 
	Set codi_unid_oper_soli = @codi_unid_oper_soli, codi_unid_oper_dest = @codi_unid_oper_dest
	where codi_nota_ingr = @codi_nota_ingr;

	print @codi_orde_comp
	print @codi_nota_ingr
	print @codi_unid_oper_soli
	print @codi_unid_oper_dest
	Fetch NEXT FROM Curs_Carg_ni_x_oc into @codi_orde_comp, @codi_nota_ingr;
end

Close Curs_Carg_ni_x_oc;
Deallocate Curs_Carg_ni_x_oc;
GO
