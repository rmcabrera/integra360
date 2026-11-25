CREATE PROCEDURE [dbo].[Sp_Informe_Pesca_Obser]
	@semana [char](8),
	@fecha [datetime]
WITH EXECUTE AS CALLER
AS
Begin
	Declare @Emb char(25)
	Declare @CEmb char(5)
	Declare @Obs varchar(150)	
	Declare @Obs2 varchar(150)	
	Declare @Obs3 varchar(150)	
	Declare @Obsed varchar(250)	
	Declare @Obsd1 varchar(250)	
	Declare @Obsd2 varchar(250)	
	Declare @Obsd3 varchar(250)	
	Declare @Obsd4 varchar(250)	
	Declare @Obsd5 varchar(250)	
	Declare @Obsd6 varchar(250)	
	Declare @Obsd7 varchar(250)	
	Declare @Obsd8 varchar(250)	
	declare @patron_n varchar(120)	
	Declare @codi_zarp char(10)	
	Declare @patron char(7)	
	declare @cont smallint
	declare @orden smallint
	Create Table #Temporal (  codi_emba char(5) Null,
	embarcaciones char(50) Null , observacion varchar(250) Null, observacion1 varchar(250) Null, observacion2 varchar(250) Null, 
	observacion3 varchar(250) Null , observacion4 varchar(250) Null, observacion5 varchar(250) Null, observacion6 varchar(250) Null, observacion7 varchar(250) Null,
	orden smallint null , patron char(5) null , patron_n varchar(120) null, observacion8 varchar(250) Null, observacion9 varchar(250) Null, observacion10 varchar(250) Null)

	Declare CEmb Cursor For 
	Select e.codi_unid_oper,desc_unid_oper, orden, Z.codi_zarp
		from embarcaciones e, zarpes z
		where e.codi_unid_oper *= z.codi_unid_oper and e.estado = '1'
			and  convert(char(10),z.fech_repo,103) = convert(char(10),@fecha, 103) and z.codi_sema=@semana
   	  open CEmb
 	  fetch 	Cemb into @cemb, @emb, @orden, @codi_zarp
	 WHILE @@FETCH_STATUS = 0
	   begin	
		SET @obs=''
		SET @obs2=''
		SET @obs3=''
		SET @obsed=''
		SET @obsd1=''
		SET @obsd2=''
		SET @obsd3=''
		SET @obsd4=''
		SET @obsd5=''
		SET @patron=''
		select  	@obs= isnull( obse_pesc , '') , @obs2 = isnull( obse_pesc2, '' ), @obs3 = isnull( obse_pesc3, '' ) , @patron = isnull( codi_patr , '')  --, @codi_zarp = codi_zarp
		from zarpes	
  		    where convert(char(10),fech_repo,103) = convert(char(10),@Fecha, 103) and codi_unid_oper=@cemb and codi_sema=@semana and codi_zarp = @codi_zarp
		set @cont = 0
--		print @codi_zarp
		set @patron_n = ''
		Select @patron_n = apel_1 + ' ' + apel_2 + ' ' + isnull(nomb_1, '') + ' ' + isnull( nomb_2,'') from personal where codi_pers = @patron 
		DEclare curs_carg_obse cursor for
		Select isnull( desc_obse , '') from zarp_obse where codi_zarp = @codi_zarp;
		Open curs_carg_obse;
		Fetch curs_carg_obse into @obsed;
		while @@fetch_status = 0 
		begin
			set @cont = @cont + 1 
			if @cont >= 1 AND @CONT<= 2
			begin 
				set @obsd1 = @obsd1 +' ' + @obsed
			end
			if @cont >= 3 AND @CONT<= 4
			begin 
				set @obsd2 = @obsd2 +' ' + @obsed
			end
			if @cont >= 5 AND @CONT<= 6
			begin 
				set @obsd3 = @obsd3 + ' ' + @obsed
			end
			if @cont >= 7 AND @CONT<= 8
			begin 
				set @obsd4 = @obsd4 +' ' + @obsed
			end
			if @cont >= 9 AND @CONT<= 10
			begin 
				set @obsd5 = @obsd5 + ' ' + @obsed
			end
			if @cont >= 11 AND @CONT<= 12
			begin 
				set @obsd6 = @obsd6 + ' ' + @obsed
			end
			if @cont >= 13 
			begin 
				set @obsd7 = @obsd7 + ' ' +@obsed
			end
			Fetch curs_carg_obse into @obsed;
		end
		close curs_carg_obse;
		deallocate curs_carg_obse;
    		insert into #temporal(codi_emba ,embarcaciones, observacion, observacion1, observacion2, observacion3, observacion4, observacion5, 
					observacion6, observacion7, orden, patron, patron_n , observacion8, observacion9, observacion10) 
		values(@cemb, @emb, @obs , @obs2 , @obs3 , @obsd1, @obsd2, @obsd3,  @obsd4, @obsd5, @orden, @patron, @patron_n,
					@obsd6, @obsd7, @obsd8
			 )
 	  fetch 	Cemb into @cemb, @emb, @orden, @codi_zarp
	  end
	  close CEmb	
	  DEALLOCATE Cemb
	select * from #temporal ORDER BY ORDEN
end
GO
