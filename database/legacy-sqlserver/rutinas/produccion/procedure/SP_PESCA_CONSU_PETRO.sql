CREATE PROCEDURE [dbo].[SP_PESCA_CONSU_PETRO]
	@semana [char](8)
WITH EXECUTE AS CALLER
AS
Begin
	Declare @Ini  char(10)
	Declare @Ter Char(10)
	Declare @Fini datetime
	Declare @FTer datetime
	Declare @FAux datetime
	Declare @Emb char(25)
	Declare @CEmb char(5)
	Declare @Acuton numeric(12,3)
	Declare @AcuGln numeric(12,3)

	Create Table #Temporal ( Fecha datetime Null, codi_emba char(5) Null,
	embarcaciones char(25) Null , tons numeric(12,3) null, glns numeric(12,3) null)
	Select  @Ini=convert(char(10),Fech_Inic,103) , 
		@Ter=convert(char(10),FEch_term,103)  from
	Semana where codi_Sema=@semana
	set @Fini=cast(@ini as datetime)
	set @Fter= cast(@ter as datetime)
	set @faux = @Fini
	while @Faux<=@FTer
	begin
	    Declare CEmb Cursor For Select codi_unid_oper,desc_unid_oper from embarcaciones
   	    open CEmb
		fetch 	Cemb into @cemb, @emb
		WHILE @@FETCH_STATUS = 0
		    begin	
	                   set @acuton=0
		     set @acugln=0		
    		      select  @acuton = pesc_real,  @acugln= comb_reci 
				from zarpes	
				where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103) 
					and codi_unid_oper=@cemb and codi_sema=@semana
	  		insert into #temporal(fecha, codi_emba ,embarcaciones, tons, glns ) 
				values(@Faux,@cemb, @emb,@acuton, @acugln )
			fetch Cemb into @cemb, @emb
		  end
	    close CEmb	
	   DEALLOCATE Cemb
	    set @Faux=DATEADD(day,1,@Faux)
	end	
		
	select * from #temporal 

end
GO
