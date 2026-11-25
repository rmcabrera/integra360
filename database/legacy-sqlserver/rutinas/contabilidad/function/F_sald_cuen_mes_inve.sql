CREATE FUNCTION [dbo].[F_sald_cuen_mes_inve](@cuenta [char](7), @mes [char](2), @anio [char](4), @fecha [datetime], @indi [char](1), @inve [smallint], @prov [char](5), @Unid_oper [char](5))
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
	declare @MESINIC numeric(10,0)
	declare @diainic numeric(10,0)
	declare @anioinic integer
	SET @diainic = datepart(day, @fecha)
	SET @Mesinic = datepart(month, @fecha)
	SET @anioinic = datepart( year, @fecha)
	if @indi = 'M' 
	begin
		set @rc=0
		set @ra=0
		set @rca = 0
		set @raa = 0
		if @inve = 1
		begin
			if @prov = '' 
			begin	
				if @unid_oper = '' 
				begin
					Select @rc = sum ( importe ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta and mes < @mes and anio=@anio 
							 and (subdia <> 'X' or subdia <> 'S')
					) suma	
						
				end
				else
				begin
					Select @rc = sum (  isnull( importe, 0 )  ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta and anio=@anio and mes < @mes
							and codi_unid_oper = @Unid_oper  and (subdia <> 'X'  or subdia <> 'S')
					) suma
				end				
			end
			else
			begin
				if @unid_oper = '' 
				begin
					Select @rc = sum (  isnull( importe, 0 )  ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta and anio=@anio and mes < @mes 
							and codi_clie_prov = @prov and (subdia <> 'X'   or subdia <> 'S')
					) suma
				End
				else
				begin
					Select @rc = sum (  isnull( importe, 0 )  ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta and anio=@anio and mes < @mes 
							and codi_clie_prov = @prov and codi_unid_oper = @Unid_oper and (subdia <> 'X' or subdia <> 'S')
					) suma
				END
			end
		end
		else
		begin
			if @mes = '01' 
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
			if @prov = '' 
			begin			
				if @Unid_oper = ''
				begin
					Select @rc = sum (  isnull( importe, 0 )  ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
							and cast( anio as integer) = cast( @anio as integer)  and cast( mes as integer) < cast( @mes as integer) 
							and ( subdia <> 'X' )
					) suma					
					
					Select @rca = sum (  isnull( importe, 0 )  ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
							and ( cast( anio as integer) = cast( @anio as integer) -1 )  and cast( mes as integer) <= 12 
							and ( subdia <> 'X' )
					) suma
				end
				else
				begin
					Select @rc = sum (  isnull( importe, 0 )  ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
							and cast( anio as integer) = cast( @anio as integer)  and cast( mes as integer) < cast( @mes as integer) 
							and codi_unid_oper = @Unid_oper  and ( subdia <> 'X' )
					) suma
					Select @rca = sum (  isnull( importe, 0 )  ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
							and ( cast( anio as integer) = cast( @anio as integer) -1  ) and cast( mes as integer) <= 12 
							and codi_unid_oper = @Unid_oper and ( subdia <> 'X' )
					) suma		
				end
			end
			else
			begin		
				if @Unid_oper = ''
				begin
					Select @rc = sum (  isnull( importe, 0 )  ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
							and cast( anio as integer) = cast( @anio as integer) and cast( mes as integer) < cast( @mes as integer) 
							and codi_clie_prov = @prov and ( subdia <> 'X' )
					) suma			
					Select @rca = sum (  isnull( importe, 0 )  ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
							and ( cast( anio as integer) = cast( @anio as integer) -1 ) and cast( mes as integer) <= 12 
							  and codi_clie_prov = @prov and ( subdia <> 'X' )
					) suma
				end
				else
				begin		
					Select @rc = sum (  isnull( importe, 0 )  ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
							and cast( anio as integer) = cast( @anio as integer)  and cast( mes as integer) < cast( @mes as integer) 
							and codi_clie_prov = @prov and codi_unid_oper = @Unid_oper and ( subdia <> 'X' )
					) suma
					Select @rca = sum (  isnull( importe, 0 )  ) 
					from
					( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
						from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
							and ( cast( anio as integer) = cast( @anio as integer) -1 ) and cast( mes as integer) <= 12  
							  and codi_clie_prov = @prov and codi_unid_oper = @Unid_oper and ( subdia <> 'X' )
					) suma
				end
			end
		end
		if(@rc is null) set @rc=0
		if(@ra is null) set @ra=0
		if(@rca is null) set @rca = 0
		if(@raa is null) set @raa = 0
		set @rc = @rc + @rca
		set @ra = @ra + @raa
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
			set @ffa = @fecha
			if @inve = 1
			BEGIN
				if @prov = ''
				begin
					if @Unid_oper = ''
					begin
						Select @rca = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and anio=@anio and fecha < @ffa and ( subdia <> 'X' )
						) suma
					END
					else
					begin		
						Select @rca = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and anio=@anio and fecha < @ffa and ( subdia <> 'X' )
								and codi_unid_oper = @Unid_oper 
						) suma
					END
				end
				else
				begin
					if @Unid_oper = ''
					begin
						Select @rca = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and anio=@anio and fecha < @ffa 
								and ( subdia <> 'X' ) and codi_clie_prov = @prov
						) suma
					end
					else
					begin
						Select @rca = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and anio=@anio and fecha < @ffa 
								and ( subdia <> 'X' ) and codi_clie_prov = @prov and codi_unid_oper = @Unid_oper 
						) suma
					end	
				end
			end
			else
			begin
				if @prov = ''
				begin
					if @Unid_oper = ''
					begin
			
						Select @rc = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and cast( anio as integer) = cast( @anio as integer)  and fecha < @ffa
								and ( subdia <> 'X' )
						) suma
						Select @rca = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and ( cast( anio as integer) = cast( @anio as integer) -1  ) and cast( mes as integer) <= 12 
								and ( subdia <> 'X' )
						) suma
					end
					else
					begin

						Select @rc = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and cast( anio as integer) = cast( @anio as integer)  and fecha < @ffa
								and codi_unid_oper = @Unid_oper and ( subdia <> 'X' )
						) suma
						Select @rca = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and ( cast( anio as integer) = cast( @anio as integer) -1 ) and cast( mes as integer) <= 12 
								and codi_unid_oper = @Unid_oper and ( subdia <> 'X' )
						) suma
					end
				end
				else
				begin
					if @Unid_oper = ''
					begin

						Select @rc = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and cast( anio as integer) = cast( @anio as integer)  and fecha < @ffa
								and codi_clie_prov = @prov and ( subdia <> 'X' )
						) suma
						Select @rca = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and ( cast( anio as integer) = cast( @anio as integer) -1 ) and cast( mes as integer) <= 12 
								and codi_clie_prov = @prov and ( subdia <> 'X' )
						) suma
					end
					else
					begin

						Select @rc = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and cast( anio as integer) = cast( @anio as integer)  and fecha < @ffa
								and codi_unid_oper = @Unid_oper and codi_clie_prov = @prov and ( subdia <> 'X' )
						) suma
						Select @rca = sum (  isnull( importe, 0 )  ) 
						from
						( 	select Sum( case cargo_abono  when 'C' then importe when 'A' then -1 * importe  end ) as importe 
							from movi_contables where left( nro_cuen , len(@cuenta ) ) =@cuenta 
								and ( cast( anio as integer) = cast( @anio as integer) -1  ) and cast( mes as integer) <= 12 
								and codi_unid_oper = @Unid_oper and codi_clie_prov = @prov and ( subdia <> 'X' )
						) suma
					end
				end				
			end
		end
		if(@rc is null) set @rc=0
		if(@ra is null) set @ra=0
		if(@rca is null) set @rca = 0
		if(@raa is null) set @raa = 0		
		set @rc = @rc + @rca
		set @ra = @ra + @raa
	end
	set @r = @rc - @ra	
	return @r
END
GO
