CREATE TRIGGER [dbo].[DNI_Insert] ON [dbo].[DETALLE_NOTA_INGRESO] 
FOR INSERT
AS
	Declare @pro varchar(8)
	Declare @item varchar(12)
	Declare @nota varchar(10)

	declare CINsert cursor for select codi_prod,  nro_item_nota_ingr , codi_nota_ingr from Inserted
	open CINsert
	fetch CINsert into @pro, @item,  @nota
	while @@FETCH_STATUS=0 
	begin

		exec SP_Kardex_insert @codi=@nota, @det =@item, @prod=@pro, @tp='1'

		fetch CINsert into @pro, @item,  @nota
	end
	close CINsert
	deallocate CINsert
GO
