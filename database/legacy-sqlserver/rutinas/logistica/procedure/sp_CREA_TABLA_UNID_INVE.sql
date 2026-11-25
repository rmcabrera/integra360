CREATE PROCEDURE [dbo].[sp_CREA_TABLA_UNID_INVE]
WITH EXECUTE AS CALLER
AS
declare @codi_prod char(8)
declare @UBICA VARchar(250)
declare @desc_prod VARchar(250)
declare @stock decimal(9,2)
declare @stoc_ante decimal(9,2)
declare @stoc_post decimal(9,2)
declare @CANT_INGR decimal(9,2)
declare @cant_sali decimal(9,2)

declare @i integer
declare @cant decimal(9,2)

Declare Curs_carg_PROD_desp_inve Cursor for
Select isnull( left( codi_PROD, 8 ) , ''), isnull( DESC_PROD, '') , isnull( STOCK, 0 ) , isnull(UBICACION , '')
From PROD_DESP_INVE
order by codi_prod ;
Open Curs_carg_PROD_desp_inve ;
Fetch Curs_carg_PROD_desp_inve into @codi_prod, @desc_prod, @stock, @ubica;
while @@fetch_status = 0 
Begin	
	if @codi_prod <> '' 
	begin
		Select @stoc_Ante = isnull( stock , 0 ) from prod_ante_inven where left(codi_prod, 8) = left( @codi_prod, 8) 
		
		Select @cant_ingr = isnull( sum(isnull( dni.cantidad , 0 ) ) , 0 )  From Nota_ingreso ni, detalle_nota_ingreso dni 
					where dni.codi_prod = @codi_prod and ni.codi_nota_ingr = dni.codi_nota_ingr and ni.fech_nota_ingr > '20040711' and ni.fech_nota_ingr < '20040718'
		
		Select @cant_sali = isnull( sum(isnull( dds.cantidad , 0 ) ) , 0 )  From docu_sali_mate ds, detalle_docu_sali dds 
					where dds.codi_prod = @codi_prod and ds.codi_docu_sali = dds.codi_docu_sali and ds.fech_emis > '20040711' and ds.fech_emis < '20040718'
		
		UPDATE PROD_DESP_INVE 
		SET STOC_ANTE = @STOC_ANTE, cant_ingr = @cant_ingr, cant_sali = @cant_sali, dife = @stock + @cant_ingr - @cant_sali - @stoc_ante
		From prod_desp_inve
		where codi_prod = @codi_prod;
		
		
		
	end 
	Fetch Curs_carg_PROD_desp_inve into @codi_prod, @desc_prod, @stock, @ubica;
End
Close Curs_carg_PROD_desp_inve
Deallocate Curs_carg_PROD_desp_inve

Select *
from #prod_ante_desp
GO
