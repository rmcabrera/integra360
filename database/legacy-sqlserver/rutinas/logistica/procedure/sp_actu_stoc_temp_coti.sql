CREATE PROCEDURE [dbo].[sp_actu_stoc_temp_coti]
WITH EXECUTE AS CALLER
AS
declare @codi_prod char(8)
declare @codi_op char(10)
declare @codi_dop char(12)
declare @stock decimal(9,4)
declare @cant decimal(9,4)

Declare Curs_carg_pedi_coti Cursor for
Select codi_orde_pedi
From Orden_de_pedido
where estado = 'C'
order by codi_orde_pedi ;
Open Curs_carg_pedi_coti ;
Fetch Curs_carg_pedi_coti into @codi_op;
while @@fetch_status = 0 
Begin	
	Declare Curs_carg_deta_op cursor for
	Select codi_deta_orde_pedi , codi_prod, ISNULL( cantidad , 0)
	From detalle_orden_de_pedido
	where codi_orde_pedi = @codi_op;
	Open Curs_carg_deta_op ;
	Fetch Curs_carg_deta_op into @codi_dop, @codi_prod, @cant
	while @@fetch_status = 0 
	begin
		update productos
		set stoc_temp = stoc_temp - @cant
		from productos
		where codi_prod = @codi_prod;
		Fetch Curs_carg_deta_op into @codi_dop, @codi_prod, @cant
	end
	Close Curs_carg_deta_op;
	Deallocate Curs_carg_deta_op;
	Fetch Curs_carg_pedi_coti into @codi_op;
End
Close Curs_carg_pedi_coti
Deallocate Curs_carg_pedi_coti
GO
