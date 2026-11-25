CREATE PROCEDURE [dbo].[Sp_Reporte_Gerencial_Pesca]
	@annio [numeric](12, 3)
WITH EXECUTE AS CALLER
AS
Begin
	declare @aux numeric(12,3)	
	declare @cemb char(5)
	declare @emb char(100)
	declare @sdias numeric(12,3)
	declare @sdiae numeric(12,3)
	declare @stone numeric(12,3)
	declare @prd numeric(12,3)
	declare @pre numeric(12,3)
	declare @horas numeric(12,3)
	declare @fech_zarp datetime
	declare @fech_arri datetime
	Create Table #Temporal ( codi_emba char(5) Null,
	embarcaciones char(100) Null ,capacidad numeric(12,3) null,
	dias numeric(12,3) Null, DiasE numeric(12,3) Null , toneS numeric(12,3) null,
	toneE numeric(12,3) null, pescareal numeric(12,3) null, efectS numeric(12,3) null,
	efectE numeric(12,3) null)
	Declare CEmb Cursor For Select codi_unid_oper,desc_unid_oper, capa_neta from embarcaciones
   	    open CEmb
		fetch 	Cemb into @cemb, @emb, @aux
		WHILE @@FETCH_STATUS = 0
		    begin	
			set @sdias=0
			set @sdiae=0
			set @stone=0
			set @prd=0
			set @pre=0
			select  -- @sdias = sum( ( DATEDIFF( day, fech_zarp ,fech_arri )+1 )  ), 
			          @sdiae = count(pesc_real), 
			          @stone = sum(pesc_real) from zarpes
			    where codi_unid_oper=@cemb and year(fech_repo)=@annio  and pesc_real>0
			    group by codi_unid_oper
			
			Declare curs_carg_dias_sali cursor for
			select fech_zarp , fech_arri 
			from zarpes 
			where codi_unid_oper=@cemb and year(fech_repo)=@annio and pesc_real>0 
			group by codi_unid_oper, fech_repo, fech_zarp , fech_arri 
			order by fech_repo;
			open curs_carg_dias_sali ;
			fetch curs_carg_dias_sali into @fech_zarp, @fech_arri;
			while @@FETCH_STATUS = 0
			begin
				set @horas = 0
				set @horas = isnull ( datediff( hh, @fech_zarp, @fech_arri ), 0 )
				/*if @cemb = '12705'
				begin
					print @emb
					print @fech_zarp
					print @fech_arri
					print @horas 
				end  */
				set @horas = @horas / 24 
				if @horas > 0 and @horas < 0.5 begin set @horas = 1 end
				set @horas = round( @horas , 0 )

				set @sdias  = @sdias  + @horas
				/*if @cemb = '12705'
				begin
					print @sdias 
					print ' ------------------------------------------------------------'
				end */
				fetch curs_carg_dias_sali into @fech_zarp, @fech_arri;
			end			
			close curs_carg_dias_sali ;
			deallocate curs_carg_dias_sali ;


			set @prd=@sdias * @aux
			set @pre=@sdiae * @aux
			insert into #temporal(codi_emba, embarcaciones  ,
				capacidad , dias , DiasE  , toneS , toneE ,
				 pescareal , efectS , efectE )
			values (@cemb,@emb, @aux,@sdias, @sdiae  ,@prd, 
				@pre,@stone, @stone/@prd, @stone/@pre)
			fetch 	Cemb into @cemb, @emb, @aux
		  end
	    close CEmb	
	   DEALLOCATE Cemb
	select * from #temporal 
end
GO
