CREATE TRIGGER [dbo].[Delete_VENTA_CREDITO] ON [dbo].[FACTURA]
FOR DELETE 
AS
	Declare @codi_fact char(10);

	 select @codi_fact=codi_fact from deleted;  	
	
	delete FACTURA_CREDITO where codi_fact = @codi_fact;
GO
