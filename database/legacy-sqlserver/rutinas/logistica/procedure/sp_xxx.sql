CREATE PROCEDURE [dbo].[sp_xxx]
WITH EXECUTE AS CALLER
AS
DECLARE @CODI_PROD char(20)
DECLARE @DESC_PROD char(200)
DECLARE @Stock Decimal(9,2)
DECLARE @Ubicacion char(200)
DECLARE @c Integer

Declare Curs_productos Cursor for 
Select codi_prod, desc_prod, IsNull (Stock, 0), IsNull(Ubicacion,'') From Excel;

Open Curs_Productos;
Fetch Next From Curs_Productos into @Codi_Prod, @Desc_Prod, @Stock, @Ubicacion;
WHILE @@FETCH_STATUS = 0
Begin
	Set @c = (Select Count(Codi_Prod) From Productos Where Codi_Prod = @Codi_Prod)
	If @c > 0 
	Begin
		Update Productos Set Stock= @Stock, Ubicacion=@Ubicacion, DESC_PROD = @desc_prod From Productos Where codi_prod = @codi_prod
	End
	Else
	Begin
		Insert Into Productos(codi_prod, desc_prod, codi_sub_fami_prod, codi_unid_medi, codi_mone, prec_prom, stock, stoc_mini, stoc_maxi, punt_repe, fech_venc,esta_prod, stoc_temp, ubicacion, nro_cuen)
		Values (@Codi_Prod, @Desc_Prod, substring(@codi_prod,1,4) , '22', '01', 0,@stock,2,10,2,'01/12/2003', 'B', 0, @ubicacion, '' )
	End
	Fetch Next From Curs_Productos into @Codi_Prod, @Desc_Prod, @Stock, @Ubicacion;
End
Close Curs_Productos;
Deallocate Curs_Productos;
GO
