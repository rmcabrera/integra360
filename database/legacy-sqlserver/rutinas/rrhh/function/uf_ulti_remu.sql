CREATE FUNCTION [dbo].[uf_ulti_remu](@anio [int], @mes [int], @pers [char](5))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
begin
	--declare @anio int , @mes int , @pers char(5)
	--select @anio=2014 , @mes=11, @pers='00052'

	declare @Tx table (anio char(4) null, mes char(2) null)
	declare @ax int, @xm int, @xa int
	declare @ct int
	declare @rt numeric(12,2)
	set @ct =0
	set @ax = @mes
	set @xa = @anio
	while @ct<4
	begin
		if @ax - 1 >0 
		begin
			set @xm =@ax - 1
			set @ax = @ax - 1
		end
		else
		begin
			set @xm =12
			set @ax = 12
			set @xa = @xa - 1 
		end
		insert @tx
		select @xa, right('0'+cast(@xm as varchar),2)
		
		set @ct=@ct +1 
	end
		
	set @rt =  isnull((select sum(valor) 
			from planilla_de_empleados P (nolock) 
			join planilla_empleado_conceptos B (nolock)
			on P.codi_plan_empl=B.codi_plan_empl
			where B.codi_conc='199998' and P.codi_tipo_plan in ('01','03') and p.codi_pers=@pers and indi_tiem='M'
				and anio+mes in (select anio+mes from @Tx)),0) +	
		   isnull((select sum(valor) 
			from planilla_de_obreros P (nolock) 
			join planilla_obrero_conceptos B (nolock)
			on P.codi_plan_obre=B.codi_plan_obre
			where B.codi_conc='199998' and P.codi_tipo_plan in ('01','03') and p.codi_pers=@pers and indi_tiem='M'
				and anio+mes in (select anio+mes from @Tx)),0) +
		 isnull((select sum(valor) 
			from planilla_de_tripulantes P (nolock) 
			join planilla_tripulante_conceptos B (nolock)
			on P.codi_plan_trip=B.codi_plan_trip
			where B.codi_conc='199998' and P.codi_tipo_plan in ('01','03') and p.codi_pers=@pers 
			and mesanio in (select anio+mes from @Tx)),0)		

	if @rt is null set @rt =0
	
	--select @rt
	return @RT
end
GO
