CREATE PROCEDURE [dbo].[sp_xxxco]
WITH EXECUTE AS CALLER
AS
DECLARE @CODI_PROD char(20)
DECLARE @DESC_PROD char(200)
DECLARE @DESC_PROD_auxi char(200)
DECLARE @Stock Decimal(9,2)
DECLARE @Stoc_AUXI Decimal(9,2)
DECLARE @Ubicacion char(200)
DECLARE @c Integer

Create Table #temp (codi_prod char (10), desc_prod_ANTI varchar(250), desc_prod_NEW varchar(250), STOC_ANTI DECIMAL(9,2), STOC_NEW DECIMAL (9,2))

Declare Curs_productos Cursor for 
Select codi_prod, desc_prod, IsNull (Stock, 0), IsNull(Ubicacion,'') From Excel;

Open Curs_Productos;
Fetch Next From Curs_Productos into @Codi_Prod, @Desc_Prod, @Stock, @Ubicacion;
WHILE @@FETCH_STATUS = 0
Begin
	Set @c = (Select Count(Codi_Prod) From Productos Where Codi_Prod = @Codi_Prod)
--	PRINT @C
	If @c > 0 
	Begin
--		PRINT @CODI_PROD
		Set @desc_prod_auxi = (Select upper(desc_prod) From PRODUCTOS Where Codi_Prod = @Codi_Prod)
		Set @STOC_auxi = (Select upper(STOCK) From PRODUCTOS Where Codi_Prod = @Codi_Prod)
		if upper(@desc_prod) <> upper(@desc_prod_auxi)
		begin
			insert into #temp (codi_prod, desc_prod_ANTI, DESC_PROD_NEW, STOC_ANTI, STOC_NEW) 
			values (@codi_prod, @DESC_PROD_AUXI,  @desc_prod, @STOC_AUXI, @STOCK)
		end
		--Update Productos Set Stock= @Stock, Ubicacion=@Ubicacion From Productos Where codi_prod = @codi_prod
	End
--	Else
--	Begin
--		Insert Into Productos(codi_prod, desc_prod, codi_sub_fami_prod, codi_unid_medi, codi_mone, prec_prom, stock, stoc_mini, stoc_maxi, punt_repe, fech_venc,esta_prod, stoc_temp, ubicacion, nro_cuen)
--		Values (@Codi_Prod, @Desc_Prod, substring(@codi_prod,1,4) , '22', '01', 0,@stock,2,10,2,'01/12/2003', 'B', 0, @ubicacion, '' )
--	End
	Fetch Next From Curs_Productos into @Codi_Prod, @Desc_Prod, @Stock, @Ubicacion;
End
Close Curs_Productos;
Deallocate Curs_Productos;

select * from #temp
GO
