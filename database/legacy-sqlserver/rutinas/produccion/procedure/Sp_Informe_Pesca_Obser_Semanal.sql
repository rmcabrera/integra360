CREATE PROCEDURE [dbo].[Sp_Informe_Pesca_Obser_Semanal]
	@semana [char](8)
WITH EXECUTE AS CALLER
AS
Begin
	Declare @Emb char(25)
	Declare @CEmb char(5)
	Declare @Obs char(150)	
	Declare @Fini datetime
	Declare @Fter datetime
	Declare @ini datetime
	Declare @ter datetime
	Declare @Faux datetime

	Create Table #Temporal ( fecha datetime null, codi_emba char(5) Null,
	embarcaciones char(25) Null , observacion varchar(150) Null)

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
		SET @obs=Null
		select  	@obs=obse_pesc from zarpes	
  		    where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103) 
			and codi_unid_oper=@cemb and codi_sema=@semana
    		insert into #temporal(fecha,codi_emba ,embarcaciones, observacion ) 
		values(@Faux,@cemb, @emb, @obs )
		fetch Cemb into @cemb, @emb
	   end
	    close CEmb	
	    DEALLOCATE Cemb
	    set @Faux=DATEADD(day,1,@Faux)
	end
	select * from #temporal
end
GO
