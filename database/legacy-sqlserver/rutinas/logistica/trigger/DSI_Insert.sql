CREATE TRIGGER [dbo].[DSI_Insert] ON [dbo].[DETALLE_DOCU_SALI] 
FOR INSERT
AS
	Declare @pro varchar(8)
	Declare @item varchar(12)
	Declare @nota varchar(10)

	declare CINsert cursor for select codi_prod,  codi_deta_docu_sali, codi_docu_sali  from Inserted
	open CINsert
	fetch CINsert into @pro, @item,  @nota
	while @@FETCH_STATUS=0 
	begin

		exec SP_Kardex_insert @codi=@nota, @det =@item, @prod=@pro, @tp='2'

		fetch CINsert into @pro, @item,  @nota
	end
	close CINsert
	deallocate CINsert
GO
