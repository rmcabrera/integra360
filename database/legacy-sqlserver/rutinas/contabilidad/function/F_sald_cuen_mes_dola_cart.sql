CREATE FUNCTION [dbo].[F_sald_cuen_mes_dola_cart](@cuenta [char](7), @mes [char](2), @anio [char](4), @fecha [datetime], @indi [char](1), @cartera [smallint])
RETURNS [numeric](14, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @r numeric(14,2)
	declare @rc numeric(14,2)
	declare @ra numeric(14,2)
	declare @rca numeric(14,2)
	declare @raa numeric(14,2)
	declare @fia datetime
	declare @ffa datetime
	declare @mes_sald integer
	declare @anio_sald integer
	declare @mesinic numeric(10,0)
	declare @diainic numeric(10,0)
	declare @ANIOinic numeric(10,0)
	SET @diainic = datepart(day, @fecha)
	SET @Mesinic = datepart(month, @fecha)
	SET @ANIOinic = datepart(YEAR, @fecha)

	if @indi = 'M' 
	begin
		if @cartera = 0
		begin
			select @rc =Sum(importe_d) from movi_contables 
			where left( nro_cuen , len(@cuenta ) )  =@cuenta and mes < @mes and anio=@anio and cargo_abono = 'C' And isnull(cartera,0)<>1
			 and subdia <> 'X'	
			select @ra =Sum(importe_d) from movi_contables 
			where  left( nro_cuen , len(@cuenta ) )  =@cuenta and mes < @mes and anio=@anio and cargo_abono = 'A' And isnull(cartera,0)<>1
			 and subdia <> 'X'	
		end
		else
		begin
			select @rc =Sum(importe_d) from movi_contables 
			where left( nro_cuen , len(@cuenta ) )  =@cuenta and mes < @mes and anio=@anio and cargo_abono = 'C'  and subdia <> 'X'	

			select @ra =Sum(importe_d) from movi_contables 
			where  left( nro_cuen , len(@cuenta ) )  =@cuenta and mes < @mes and anio=@anio and cargo_abono = 'A'  and subdia <> 'X'
		end
/*		if @mes = '01' 
		begin
			if @anio = '2004' 
			begin
				set @mes_sald = 0
				set @anio_sald = 0
			end	
			else
			begin
				set @mes_sald = 12
				set @anio_sald = cast( @anio as integer) - 1
			end	
		end		
		else
		begin
			set @mes_sald = cast( @mes as integer) - 1
			set @anio_sald = cast( @anio as integer) 
		end
		select @rc =Sum(importe_d) from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
				and cast( mes as integer) <= @mes_sald and cast( anio as integer) <= @anio_sald and cargo_abono = 'C'
		select @ra=Sum(importe_d) from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
				and cast( mes as integer) <= @mes_sald and cast( anio as integer) <= @anio_sald and cargo_abono = 'A'
*/

		if(@rc is null) set @rc=0
		if(@ra is null) set @ra=0
	end
	else
	begin
		if @diainic = 1 and @mesinic = 1 and @anioinic = 2004
		begin
			set @rc=0
			set @ra=0
			set @rca = 0
			set @raa = 0
		end
		else
		begin
			set @fia  = cast( '01/'  + @mes + '/' + @anio as datetime)
			set @ffa = @fecha  --dateadd(day, 1, @fecha)
	--		select @rc =Sum(importe) from movi_contables where nro_cuen=@cuenta and mes < @mes and anio=@anio and cargo_abono = 'C'
	--		select @ra =Sum(importe) from movi_contables where nro_cuen=@cuenta and mes < @mes and anio=@anio and cargo_abono = 'A'
	
	--		select @rca =Sum(importe) from movi_contables where nro_cuen=@cuenta and anio=@anio and cargo_abono = 'C' and fecha >= @fia and fecha < @ffa
	--		select @raa =Sum(importe) from movi_contables where nro_cuen=@cuenta and anio=@anio and cargo_abono = 'A' and fecha >= @fia and fecha < @ffa
			if @cartera = 0
			begin			
				select @rca =Sum(importe_d) from movi_contables 
				where left( nro_cuen , len(@cuenta ) ) =@cuenta and anio= @anio and cargo_abono = 'C' and fecha < @ffa And isnull(cartera,0)<>1 and subdia <> 'X'	
				select @raa =Sum(importe_d) from movi_contables 
				where left( nro_cuen , len(@cuenta ) ) =@cuenta and anio= @anio and cargo_abono = 'A' and fecha < @ffa And isnull(cartera,0)<>1  and subdia <> 'X'	
			end
			else
			begin			
				select @rca =Sum(importe_d) from movi_contables 
				where left( nro_cuen , len(@cuenta ) ) =@cuenta and anio= @anio and cargo_abono = 'C' and fecha < @ffa  and subdia <> 'X'	
				select @raa =Sum(importe_d) from movi_contables 
				where left( nro_cuen , len(@cuenta ) ) =@cuenta and anio= @anio and cargo_abono = 'A' and fecha < @ffa  and subdia <> 'X'	
			end
		end
		if(@rc is null) set @rc=0
		if(@ra is null) set @ra=0
		if(@rca is null) set @rca = 0
		if(@raa is null) set @raa = 0
		
		set @rc = @rc + @rca
		set @ra = @ra + @raa

/*		if @diainic = 1 and @mesinic = 1 
		begin
			set @rc=0
			set @ra=0
			set @rca = 0
			set @raa = 0
		end
		else
		begin


			set @fia  = cast( '01/'  + @mes + '/' + @anio as datetime)
			set @ffa = @fecha -- dateadd(day, 1, @fecha)
	--		select @rc =Sum(importe_d) from movi_contables where nro_cuen=@cuenta and mes < @mes and anio=@anio and cargo_abono = 'C'
	--		select @ra =Sum(importe_d) from movi_contables where nro_cuen=@cuenta and mes < @mes and anio=@anio and cargo_abono = 'A'
	
			select @rca =Sum(importe_d) from movi_contables where left( nro_cuen , len(@cuenta ) )  = @cuenta and anio=@anio and cargo_abono = 'C' and fecha < @ffa
			select @raa =Sum(importe_d) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and anio=@anio and cargo_abono = 'A' and fecha < @ffa
		end	
		if(@rc is null) set @rc=0
		if(@ra is null) set @ra=0
		if(@rca is null) set @rca = 0
		if(@raa is null) set @raa = 0
		
		set @rc = @rc + @rca
		set @ra = @ra + @raa
*/
	end

	set @r = @rc - @ra	
	return @r
END
GO
