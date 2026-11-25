CREATE TRIGGER [dbo].[DSK_Delete] ON [dbo].[DETALLE_DOCU_SALI] 
FOR DELETE 
AS
	Declare @pro varchar(8)
	Declare @nota varchar(10)
	Declare @ite char(12)
	declare  @fec datetime
	----- por almacen ----
	declare @codi_alma_aux char(2)
	---------------------------------------------
	declare CDelete cursor for select codi_prod , codi_docu_sali ,  codi_deta_docu_sali , codi_alma 	from deleted  
	open cDelete
	fetch CDelete into @pro, @nota, @ite , @codi_alma_aux
	while @@FETCH_STATUS=0 
	begin
		select @fec = fech_tran from kardex (nolock) where codi_docu_i_o=@nota and 	
			codi_prod=@pro and i_o='2' and item =@ite and codi_alma=@codi_alma_aux
	
		delete from kardex where codi_docu_i_o=@nota and 	
			codi_prod=@pro and i_o='2' and item=@ite  and codi_alma=@codi_alma_aux
	
		exec SP_KARDEX_DELETE @maxf = @fec,   @prod =@pro   , @codi_alma= @CODI_ALMA_AUX

		fetch CDelete into @pro , @nota , @ite  , @codi_alma_aux
	end
	close CDelete
	deallocate CDelete
GO
