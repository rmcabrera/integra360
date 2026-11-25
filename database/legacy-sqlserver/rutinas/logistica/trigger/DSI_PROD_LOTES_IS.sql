CREATE TRIGGER [dbo].[DSI_PROD_LOTES_IS] ON [dbo].[PRODUCTOS_LOTES_INGRE_SALI] 
FOR INSERT
AS

	Declare @codigo numeric(12)
	Declare @cantidad numeric(12,4)
	declare @alma char(2)
	declare @prod char(8)
	
	declare CINsert cursor for select codi_prod_alma_lote,  case when io=1 then 1 else -1 end*cantidad 
	from Inserted
	open CINsert
	fetch CINsert into @codigo, @cantidad  
	while @@FETCH_STATUS=0 
	begin
		select @alma= codi_alma , @prod = codi_prod from PRODUCTO_ALMACEN_LOTE (nolock)
		where codi_prod_alma_lote= @codigo

		update PRODUCTO_ALMACEN_LOTE set stock  = isnull(stock,0)  + @cantidad
		where codi_prod_alma_lote= @codigo
					
		update almacen_producto set stock_alma = isnull(stock_alma,0) + @cantidad,
									STOCK_temp_alma  = isnull(STOCK_temp_alma,0) + @cantidad
		where codi_alma=@alma and codi_prod=@prod

		fetch CINsert into @codigo, @cantidad  
	end
	close CINsert
	deallocate CINsert
GO
