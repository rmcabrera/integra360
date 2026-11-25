CREATE PROCEDURE [dbo].[sp_carg_stoc_ante]
WITH EXECUTE AS CALLER
AS
declare @codi_prod char(8)
declare @stock decimal

DELETE FROM PROD_ANTE;

Declare Curs_Carg_stoc_ante Cursor For		
Select codi_prod, isnull(stock,0)
From Productos

Open Curs_Carg_stoc_ante
Fetch Curs_Carg_stoc_ante into @codi_prod, @stock;
while @@fetch_status = 0 
Begin	
	Insert Into prod_ante (Codi_prod, stock)
	Values (@codi_prod, @stock)
	
	Fetch Curs_Carg_stoc_ante into @codi_prod, @stock;
End
Close Curs_Carg_stoc_ante
Deallocate Curs_Carg_stoc_ante
GO
