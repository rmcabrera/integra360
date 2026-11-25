CREATE PROCEDURE [dbo].[Sp_Estadistica_Pesca_espe]
	@anio [numeric](4, 0)
WITH EXECUTE AS CALLER
AS
Begin
	set nocount on
	declare @ter numeric(2)	
	declare @aux numeric(2)	
	declare @cemb char(5)
	declare @emb char(100)
	declare @espe char(2)
	declare @desc_espe varchar(50)
	declare @sdias numeric(12,3)
	declare @sdiae numeric(12,3)
	declare @stone numeric(12,3)
	declare @horas numeric(12,2)
	declare @m char(15)
	Declare @fech_zarp datetime
	Declare @fech_arri datetime
	Create Table #Temporal ( codi_emba char(5) Null,
	embarcaciones char(100) Null , dias numeric(12,3) Null, 
	DiasE numeric(12,3) Null , toneladas numeric(12,3) null, mes char(15) null,nm numeric(2) null, codi_espe char( 2 ), desc_espe varchar( 50 ) )
	set @aux=1
	set @ter=12
	while @aux<=@ter
 	begin
	Declare CEmb Cursor For 
	Select distinct codi_unid_oper, ( Select nemo_emba from embarcaciones where codi_unid_oper = z.codi_unid_oper  ) NEMO_EMBA, 
		dz.codi_espe, ( Select desc_espe from especies where codi_espe = dz.codi_espe ) desc_espe
	from zarpes z,  detalle_zarpe dz
	where z.codi_zarp = dz.codi_zarp and year(fech_repo)=@anio and codi_unid_oper in ( Select distinct codi_unid_oper from zarpes where year(fech_repo) = @anio )
		and codi_espe in ( Select codi_espe from especies where upper( desc_espe ) like 'ANCHOVETA%' )
   	    open CEmb
		fetch 	Cemb into @cemb, @emb, @espe, @desc_espe
		WHILE @@FETCH_STATUS = 0
		    begin	
			set @sdias=0
			set @sdiae=0
			set @stone=0
			select @sdiae = count(pesc_real), 
			          @stone = sum(pesc_real) 
			from zarpes z,  detalle_zarpe dz
			where z.codi_zarp = dz.codi_zarp and codi_unid_oper=@cemb and month(fech_repo)=@aux
				and year(fech_repo)=@anio and pesc_real>0 and dz.codi_espe = @espe
			group by codi_unid_oper, codi_espe
			
			Declare curs_carg_dias_sali cursor for
			select fech_zarp , fech_arri 
			from zarpes z,  detalle_zarpe dz
			where z.codi_zarp = dz.codi_zarp and codi_unid_oper=@cemb and month(fech_repo)=@aux
				and year(fech_repo)=@anio and pesc_real>0 and dz.codi_espe = @espe
			group by codi_unid_oper, fech_repo, fech_zarp , fech_arri , codi_espe
			order by fech_repo;
			open curs_carg_dias_sali ;
			fetch curs_carg_dias_sali into @fech_zarp, @fech_arri;
			while @@FETCH_STATUS = 0
			begin
				set @horas = 0
				set @horas = datediff( hh, @fech_zarp, @fech_arri )
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
			insert into #temporal( codi_emba,embarcaciones, dias, DiasE, toneladas, mes, nm, codi_espe, desc_espe)
			values (@cemb, @emb, @sdias, @sdiae , @stone, case @aux
				when 1 then 'Enero'
				when 2 then 'Febrero'
				when 3 then 'Marzo'
				when 4 then 'Abril'
				when 5 then 'Mayo'
				when 6 then 'Junio'
				when 7 then 'Julio'
				when 8 then 'Agosto'
				when 9 then 'Setiembre'
				when 10 then 'Octubre'
				when 11 then 'Noviembre'
				when 12 then 'Diciembre'  end , @aux, @espe, @desc_espe
				)
			fetch Cemb into @cemb, @emb, @espe, @desc_espe
		  end
	    close CEmb	
	   DEALLOCATE Cemb

-----------------------
	Declare CEmb1 Cursor For 
	Select distinct codi_unid_oper, ( Select nemo_emba from embarcaciones where codi_unid_oper = z.codi_unid_oper  ) NEMO_EMBA, 
		'02' codi_espe, 'Jurel/Caballa' desc_espe
	from zarpes z
	where year(fech_repo)=@anio and codi_unid_oper in ( Select distinct codi_unid_oper from zarpes where year(fech_repo) = @anio )
	and codi_zarp in ( Select codi_zarp from detalle_zarpe where not codi_espe in ( Select codi_espe from especies where upper( desc_espe ) like 'ANCHOVETA%' ) )
   	    open CEmb1
		fetch 	Cemb1 into @cemb, @emb, @espe, @desc_espe
		WHILE @@FETCH_STATUS = 0
		    begin	
			set @sdias=0
			set @sdiae=0
			set @stone=0
			select @sdiae = count(pesc_real), 
			          @stone = sum(pesc_real) 
			from zarpes z
			where codi_unid_oper=@cemb and month(fech_repo)=@aux and year(fech_repo)=@anio and pesc_real >0 
			and codi_zarp in (Select codi_zarp from detalle_zarpe 
					where not codi_espe in ( Select codi_espe from especies where upper( desc_espe ) like 'ANCHOVETA%' ) )
			group by codi_unid_oper
			
			Declare curs_carg_dias_sali1 cursor for
			select distinct fech_zarp , fech_arri 
			from zarpes z
			where codi_unid_oper=@cemb and month(fech_repo)=@aux and year(fech_repo)=@anio and pesc_real>0 
			and codi_zarp in (Select codi_zarp from detalle_zarpe 
					where not codi_espe in ( Select codi_espe from especies where upper( desc_espe ) like 'ANCHOVETA%' ) )
			group by codi_unid_oper, fech_repo, fech_zarp , fech_arri ;
			open curs_carg_dias_sali1 ;
			fetch curs_carg_dias_sali1 into @fech_zarp, @fech_arri;
			while @@FETCH_STATUS = 0
			begin
				set @horas = 0
				set @horas = datediff( hh, @fech_zarp, @fech_arri )
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
				fetch curs_carg_dias_sali1 into @fech_zarp, @fech_arri;
			end			
			close curs_carg_dias_sali1 ;
			deallocate curs_carg_dias_sali1 ;
			insert into #temporal( codi_emba,embarcaciones, dias, DiasE, toneladas, mes, nm, codi_espe, desc_espe)
			values (@cemb, @emb, @sdias, @sdiae , @stone, case @aux
				when 1 then 'Enero'
				when 2 then 'Febrero'
				when 3 then 'Marzo'
				when 4 then 'Abril'
				when 5 then 'Mayo'
				when 6 then 'Junio'
				when 7 then 'Julio'
				when 8 then 'Agosto'
				when 9 then 'Setiembre'
				when 10 then 'Octubre'
				when 11 then 'Noviembre'
				when 12 then 'Diciembre'  end , @aux, @espe, @desc_espe
				)
			fetch Cemb1 into @cemb, @emb, @espe, @desc_espe
		  end
	    close CEmb1
	   DEALLOCATE Cemb1

---------------------
	  set @aux = @aux +1
	end
	select * from #temporal 
	ORDER BY embarcaciones, nm
end
GO
