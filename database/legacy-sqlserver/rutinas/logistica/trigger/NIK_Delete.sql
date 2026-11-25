CREATE TRIGGER [dbo].[NIK_Delete] ON [dbo].[DETALLE_NOTA_INGRESO] 
FOR DELETE 
AS
	Declare @pro varchar(8)
	Declare @nota varchar(10)
	declare @fec datetime
	declare @codi_alma_aux char(2)
	Declare @ite char(12)
	
	declare CDelete cursor for select codi_prod , codi_nota_ingr , nro_item_nota_ingr , codi_alma from deleted  
	open cDelete
	fetch CDelete into @pro, @nota, @ite , @codi_alma_aux
	while @@FETCH_STATUS=0 
	begin
		select @fec = fech_tran from kardex (nolock) where codi_docu_i_o=@nota 
			and codi_alma=@codi_alma_aux  and item =@ite and codi_prod=@pro and i_o='1' 
	
		delete from kardex where codi_docu_i_o=@nota and codi_alma=@codi_alma_aux and 	
					codi_prod=@pro and i_o='1' and item=@ite 

		exec SP_KARDEX_DELETE @maxf = @fec, @prod =@pro ,@codi_alma= @CODI_ALMA_AUX
	
		fetch CDelete into @pro , @nota , @ite  , @codi_alma_aux
	end
	close CDelete
	deallocate CDelete
GO
