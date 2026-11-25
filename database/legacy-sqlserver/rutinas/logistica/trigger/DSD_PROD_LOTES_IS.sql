CREATE TRIGGER [dbo].[DSD_PROD_LOTES_IS] ON [dbo].[PRODUCTOS_LOTES_INGRE_SALI] 
FOR DELETE
AS

	Declare @codigo numeric(12)
	Declare @cantidad numeric(12,4)
	declare @alma char(2)
	declare @prod char(8)
	
	declare Cdelete cursor for select codi_prod_alma_lote,  case when io=1 then -1 else 1 end*cantidad 
	from Deleted
	open CDelete
	fetch CDelete into @codigo, @cantidad  
	while @@FETCH_STATUS=0 
	begin
		select @alma= codi_alma , @prod = codi_prod from PRODUCTO_ALMACEN_LOTE (nolock)
		where codi_prod_alma_lote= @codigo

		update PRODUCTO_ALMACEN_LOTE set stock  = isnull(stock,0)  + @cantidad
		where codi_prod_alma_lote= @codigo
		
		update almacen_producto set stock_alma = isnull(stock_alma,0) + @cantidad,
									STOCK_temp_alma  = isnull(STOCK_temp_alma,0) + @cantidad
		where codi_alma=@alma and codi_prod=@prod

		fetch CDelete into @codigo, @cantidad  
	end
	close CDelete
	deallocate CDelete
GO
