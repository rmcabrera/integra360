CREATE FUNCTION [dbo].[f_dia_habil](@pi_anio [int], @pi_mes [int], @Nd_hab [int])
RETURNS [datetime] WITH EXECUTE AS CALLER
AS 
BEGIN 
--	declare @pi_anio int, @pi_mes int, @Nd_hab int
--	select @pi_anio =2013, @pi_mes =9 , @Nd_hab =5
	
	declare  @l_dia int , @l_c int, @l_ct int
	declare @ld_rt datetime 
	
	set @l_dia = 0 
	--set @l_dia  = dbo.f_ultimo_dia(@pi_mes, @pi_anio)
	
	set @l_ct=1
	
	while @l_ct<=@Nd_hab  
	begin
		set @l_dia = @l_dia + 1 
		set @l_ct = @l_ct + 1
		--select @l_dia, @l_ct
		select @l_C =isnull(count(*),0) from dbo.feriados (nolock)  where mes=@pi_mes and anio=@pi_anio and dia=@l_dia
		if @l_c is null set @l_c=0
				
		if @l_c > 0 
			set @l_ct = @l_ct - 1 
		else
		begin
			set @ld_rt = cast(  cast(@l_dia as char(2)) +'/'+ right('00'+cast(@pi_mes as varchar) ,2)  +'/'+cast(@pi_anio as varchar) as datetime)
			if upper(left(datename(dw, @ld_rt) ,2))  in ('SU','DO','SA','SÁ')  set @l_ct = @l_ct - 1 
		end	
		
	end
	
	set @ld_rt = cast(  cast(@l_dia as char(2)) +'/'+ right('00'+cast(@pi_mes as varchar) ,2)  +'/'+cast(@pi_anio as varchar) as datetime)
	
	return @ld_rt
	--select @ld_rt
END
GO
