CREATE FUNCTION [dbo].[F_sald_cuen_mes_prov](@cuenta [char](7), @mes [char](2), @anio [char](4), @fecha [datetime], @indi [char](1), @cp [char](5), @cuo [char](5), @tipo [char](2))
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
	declare @MESINIC numeric(10,0)
	declare @diainic numeric(10,0)
	SET @diainic = datepart(day, @fecha)
	SET @Mesinic = datepart(month, @fecha)
	if @indi = 'M' 
	begin
		if @tipo = 'C'
		begin
			select @rc = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and mes < @mes and anio=@anio 
				and cargo_abono = 'C'  and subdia <> 'X'
			select @ra = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and mes < @mes and anio=@anio 
				and cargo_abono = 'A'  and subdia <> 'X'
		end
		if @tipo = 'P'
		begin
			select @rc = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and mes < @mes and anio=@anio 
				and cargo_abono = 'C' and codi_clie_prov = @cp and subdia <> 'X'
			select @ra = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and mes < @mes and anio=@anio 
				and cargo_abono = 'A' and codi_clie_prov = @cp and subdia <> 'X'
		end
		if @tipo = 'U'
		begin
			select @rc = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and mes < @mes and anio=@anio 
				and cargo_abono = 'C' and codi_unid_oper = @cuo and subdia <> 'X'
			select @ra = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and mes < @mes and anio=@anio 
				and cargo_abono = 'A' and codi_unid_oper = @cuo and subdia <> 'X'
		end
		if @tipo = 'PU'
		begin
			select @rc = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and mes < @mes and anio=@anio 
				and cargo_abono = 'C' and codi_unid_oper = @cuo and codi_clie_prov = @cp and subdia <> 'X'
			select @ra = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and mes < @mes and anio=@anio 
				and cargo_abono = 'A' and codi_unid_oper = @cuo and codi_clie_prov = @cp and subdia <> 'X'
		end
	end
	if @indi = 'F'
	begin
		if @diainic = 1 and @mesinic = 1 
		begin
			set @rc=0
			set @ra=0
			set @rca = 0
			set @raa = 0
		end
		else
		begin
			if @tipo = 'C'
			begin	
				set @fia  = cast( '01/'  + @mes + '/' + @anio as datetime)
				set @ffa = @fecha  --dateadd(day, 1, @fecha)
				select @rca = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and anio=@anio 
					and cargo_abono = 'C' and fecha < @ffa  and subdia <> 'X'
				select @raa = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and anio=@anio 
					and cargo_abono = 'A' and fecha < @ffa and subdia <> 'X'
			end
			if @tipo = 'P'
			begin	
				set @fia  = cast( '01/'  + @mes + '/' + @anio as datetime)
				set @ffa = @fecha  --dateadd(day, 1, @fecha)
				select @rca = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and anio=@anio 
					and cargo_abono = 'C' and fecha < @ffa and codi_clie_prov = @cp and subdia <> 'X'
				select @raa = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and anio=@anio 
					and cargo_abono = 'A' and fecha < @ffa and codi_clie_prov = @cp and subdia <> 'X'
			end
			if @tipo = 'U'
			begin	
				set @fia  = cast( '01/'  + @mes + '/' + @anio as datetime)
				set @ffa = @fecha  --dateadd(day, 1, @fecha)
				select @rca = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and anio=@anio 
					and cargo_abono = 'C' and fecha < @ffa and codi_unid_oper = @cuo and subdia <> 'X'
				select @raa = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and anio=@anio 
					and cargo_abono = 'A' and fecha < @ffa and codi_unid_oper = @cuo and subdia <> 'X'
			end
			if @tipo = 'PU'
			begin	
				set @fia  = cast( '01/'  + @mes + '/' + @anio as datetime)
				set @ffa = @fecha  --dateadd(day, 1, @fecha)
				select @rca = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and anio=@anio 
					and cargo_abono = 'C' and fecha < @ffa and codi_unid_oper = @cuo and codi_clie_prov = @cp and subdia <> 'X'
				select @raa = isnull( Sum(importe) , 0 ) from movi_contables where left( nro_cuen , len(@cuenta ) ) = @cuenta and anio=@anio 
					and cargo_abono = 'A' and fecha < @ffa and codi_unid_oper = @cuo and codi_clie_prov = @cp and subdia <> 'X'
			end
		end
		if(@rc is null) set @rc=0
		if(@ra is null) set @ra=0
		
		set @rc = @rc + @rca
		set @ra = @ra + @raa
	end
	if @indi = 'A'
	begin
		set @rc=0
		set @ra=0
		set @rca = 0
		set @raa = 0
		if(@rc is null) set @rc=0
		if(@ra is null) set @ra=0
		
		set @rc = @rc + @rca
		set @ra = @ra + @raa
	end
	set @r = @rc - @ra	
	return @r
END
GO
