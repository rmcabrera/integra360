CREATE FUNCTION [dbo].[F_Dias_falta_eo](@codi_pers [char](5), @codi_tipo_pers [char](2), @fi [datetime], @ff [datetime])
RETURNS [smallint] WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @ND decimal(9,0)
	Declare @NDv decimal(9,0)
	Declare @NDR decimal(9,0)
	Declare @nro_dias decimal(9,0)
	Declare @nro_dias_vaca decimal(9,0)
	Declare @nro_dias_vaca_tota decimal(9,0)
	Declare @nro_dias_tota decimal(9,0)
	Declare @nro_dias_auxi decimal(9,0)

	Declare @cont_inic_vaca smallint
	declare @fiv datetime
	declare @ffv datetime
	if @codi_tipo_pers = '01' 
	begin
		set @ND = (Select  isnull( Sum( round( isnull( valor, 0 )  , 0 )) , 0 )   From Planilla_de_empleados PE, Planilla_empleado_conceptos PEC 
				where pe.codi_pers = @codi_pers and pe.fech_inic >= @fi and  pe.fech_term < @ff  and pe.codi_plan_empl = pec.codi_plan_empl 
				and pe.indi_tiem = 'M'  and ( pec.codi_conc = '500000' or  pec.codi_conc = '500006' or  pec.codi_conc = '500007' ))

	end
	if @codi_tipo_pers = '02' 
	begin
		set @ND = (Select isnull( Sum( round(valor , 0 )) , 0 ) From Planilla_de_obreros PE, Planilla_obrero_conceptos PEC 
				where pe.codi_pers = @codi_pers and pe.fech_inic >= @fi and  pe.fech_term < @ff  and pe.codi_plan_obre = pec.codi_plan_obre
				and pe.indi_tiem = 'M'  and ( pec.codi_conc = '500000' or  pec.codi_conc = '500006' or  pec.codi_conc = '500007' ))
	end
--Vacaciones
	set @nro_dias = 0
	set @nro_dias_vaca = 0
	set @nro_dias_vaca_tota = 0
	set @cont_inic_vaca =  0
	set @cont_inic_vaca = ( Select isnull( count(fech_inic) , 0 ) From Vacaciones 
				where  ( fech_inic >= @fi  and  fech_term <= @ff )  And codi_pers = @codi_pers ) --and ( codi_tipo_vaca = '01' or codi_tipo_vaca = '03') )
	IF @CONT_INIC_VACA > 0 
	BEGIN
		set @nro_dias = (Select isnull( sum( isnull( nro_dias , 0 ) ) , 0 ) From vacaciones    
				where  ( fech_inic >= @fi  and  fech_term <= @ff )  And codi_pers = @codi_pers ) --and ( codi_tipo_vaca = '01' or codi_tipo_vaca = '03') )
	END

	set @nro_dias_vaca_tota =  @nro_dias_vaca_tota + @nro_dias
	set @nro_dias = 0
	set @cont_inic_vaca =  0

	set @cont_inic_vaca = ( Select isnull( count(fech_inic) , 0 ) From Vacaciones 
				where  ( fech_inic >= @fi  and fech_inic <= @ff and fech_term > @ff )  And codi_pers = @codi_pers ) --and ( codi_tipo_vaca = '01' or codi_tipo_vaca = '03') )
	IF @CONT_INIC_VACA > 0 
	BEGIN
		set @fiv = (Select fech_inic From vacaciones    
				where  ( fech_inic >= @fi  and fech_inic <= @ff and fech_term > @ff )  And codi_pers = @codi_pers ) --and ( codi_tipo_vaca = '01' or codi_tipo_vaca = '03') )
		set @ffv = @ff
		set @nro_dias = isnull( datediff(day, @fiv, @ffv) , 0)


	END
	set @nro_dias_vaca_tota =  @nro_dias_vaca_tota + @nro_dias
	set @nro_dias = 0
	set @cont_inic_vaca =  0		

	set @cont_inic_vaca = ( Select isnull( count(fech_inic) , 0 ) From Vacaciones 
				where  ( fech_inic < @fi  and  fech_term >= @fi and fech_term <= @ff )  And codi_pers = @codi_pers ) --and ( codi_tipo_vaca = '01' or codi_tipo_vaca = '03'))

	IF @CONT_INIC_VACA > 0 
	BEGIN
		set @ffv = (Select fech_term From vacaciones    
				where  ( fech_inic < @fi  and  fech_term >= @fi and fech_term <= @ff )  And codi_pers = @codi_pers ) --and ( codi_tipo_vaca = '01' or codi_tipo_vaca = '03') )
		set @fiv = @fi
		set @nro_dias = isnull( datediff(day, @fiv, @ffv) , 0)

	END
	set @nro_dias_vaca_tota =  @nro_dias_vaca_tota + @nro_dias

-- Fin Vacaciones
-- Licencias
	set @nro_dias = 0
	set @nro_dias_vaca = 0
	set @cont_inic_vaca =  0
	set @cont_inic_vaca = ( Select isnull( count(fech_inic) , 0 ) From Licencias_por_personal 
				where  ( fech_inic >= @fi  and  fech_term <= @ff )  And codi_pers = @codi_pers and goce_habe = 1 )
	IF @CONT_INIC_VACA > 0 
	BEGIN
		set @nro_dias = (Select isnull( sum( isnull( nro_dias_remu , 0 ) ) , 0 ) From Licencias_por_personal    
				where  ( fech_inic >= @fi  and  fech_term <= @ff )  And codi_pers = @codi_pers and goce_habe = 1 )
	END
	set @nro_dias_vaca_tota =  @nro_dias_vaca_tota + @nro_dias
	set @nro_dias = 0
	set @cont_inic_vaca =  0

	set @cont_inic_vaca = ( Select isnull( count(fech_inic) , 0 ) From Licencias_por_personal 
				where  ( fech_inic >= @fi  and fech_inic <= @ff and fech_term > @ff )  And codi_pers = @codi_pers and goce_habe = 1 )
	IF @CONT_INIC_VACA > 0 
	BEGIN
		set @fiv = (Select fech_inic From Licencias_por_personal    
				where  ( fech_inic >= @fi  and fech_inic <= @ff and fech_term > @ff )  And codi_pers = @codi_pers and goce_habe = 1 ) 
		set @ffv = @ff
		set @nro_dias = isnull( datediff(day, @fiv, @ffv) , 0) + 1

		set @ndr = (Select  isnull( sum( isnull( nro_dias_remu , 0 ) ) , 0 )  From Licencias_por_personal
				where  ( fech_inic >= @fi  and fech_inic <= @ff and fech_term > @ff )  And codi_pers = @codi_pers and goce_habe = 1 ) 
		if @ndr 	< @nro_dias 
		begin
			set @nro_dias = @ndr
		end

	END
	set @nro_dias_vaca_tota =  @nro_dias_vaca_tota + @nro_dias
	set @nro_dias = 0
	set @cont_inic_vaca =  0		

	set @cont_inic_vaca = ( Select isnull( count(fech_inic) , 0 ) From Licencias_por_personal 
				where  ( fech_inic < @fi  and  fech_term >= @fi and fech_term <= @ff )  And codi_pers = @codi_pers and goce_habe = 1  )

	IF @CONT_INIC_VACA > 0 
	BEGIN
		set @ffv = (Select fech_term From Licencias_por_personal    
				where  ( fech_inic < @fi  and  fech_term >= @fi and fech_term <= @ff )  And codi_pers = @codi_pers and goce_habe = 1)
		set @fiv = @fi
		set @nro_dias = isnull( datediff(day, @fiv, @ffv) , 0) + 1

		set @ndr = (Select  isnull( sum( isnull( nro_dias_remu , 0 ) ) , 0 )  From Licencias_por_personal
				where  ( fech_inic < @fi  and  fech_term >= @fi and fech_term <= @ff )  And codi_pers = @codi_pers and goce_habe = 1)
		if @ndr 	< @nro_dias 
		begin
			set @nro_dias = @ndr
		end
	END
	set @nro_dias_vaca_tota =  @nro_dias_vaca_tota + @nro_dias
--Fin Licencias

	set @nro_dias_tota = @nd + @nro_dias_vaca_tota

	set @ndv = isnull( datediff(day, @fi , @ff) , 0) - 1

	set @ndv = isnull( @ndv , 0 ) - isnull( @nro_dias_tota , 0 )
	if @ndv < 0 begin set @ndv = 0 end

	Return @ndv
--	Return @nro_dias_auxi
END
GO
