create TRIGGER [dbo].[PAL_UPDATE]
   ON  [dbo].[PRODUCTO_ALMACEN_LOTE]
   AFTER UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

    -- Insert statements for trigger here
	
	if update(lote)	
	begin
--		select * from deleted
		--select * from producto_almacen_lote where codi_prod='00010003' and codi_alma='01'

		if (select count(*) from deleted where codi_alma='01')>0 
		begin
			
			update producto_almacen_lote set lote=(select i.lote from inserted i 
						where i.codi_prod_alma_lote=A.codi_prod_alma_lote and  i.codi_prod=a.codi_prod and i.codi_alma='01')
			from deleted A
				join producto_almacen_lote B (nolock)
			on A.codi_prod =B.codi_prod and A.lote=B.lote
			where B.codi_alma<>'01'

			
		end

	end

END
GO
