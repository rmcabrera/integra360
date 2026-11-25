CREATE PROCEDURE [dbo].[sp_carg_trab_plan]
	@codi_tipo_pers [char](2),
	@orde_por [char](1),
	@MES [int],
	@ANIO [int],
	@FECH_INIC_MES [datetime],
	@FECH_FINA_MES [datetime],
	@codi_pers [char](5) OUTPUT
WITH EXECUTE AS CALLER
AS
DECLARE @CODI_PERS_AUXI CHAR(5)
DECLARE @CODI_TIPO_PERS_AUXI CHAR(2)
DECLARE @LI_CONT_VACA integer
DECLARE @LI_CONT_VACA_2 integer
DECLARE @FECH_INIC_PLAN DATETIME
DECLARE @FECH_FINA_PLAN DATETIME
Declare @ls_indi_grab char(1)

Create Table #Pers_Temp (Codi_pers char(5))

if upper(@orde_por) = 'C' 
BEGIN
	IF @CODI_TIPO_PERS = '01' 
	BEGIN
		Declare Curs_CARG_TRAB Cursor for 
		Select DISTINCT P.CODI_PERS , P.APEL_1, P.APEL_2, P.NOMB_1, P.NOMB_2
		From PERSONAL P, personal_por_tipo_trabajador ptt
		WHERE (P.ESTA_ACTI = 1 and ( p.fech_cese is null or p.fech_cese > @fech_inic_mes) ) and p.codi_pers = ptt.codi_pers
			and ptt.codi_tipo_pers = '01' and p.fech_ingre <= @fech_fina_mes		
		;
	END
	ELSE
	BEGIN
		Declare Curs_CARG_TRAB Cursor for 
		Select DISTINCT P.CODI_PERS,  P.APEL_1, P.APEL_2, P.NOMB_1, P.NOMB_2
		From PERSONAL P , personal_por_tipo_trabajador ptt
		WHERE (P.ESTA_ACTI = 1 and ( p.fech_cese is null or p.fech_cese > @fech_inic_mes) ) and p.codi_pers = ptt.codi_pers
			and ( ptt.codi_tipo_pers = '02' OR ptt.codi_tipo_pers = '05') and p.fech_ingre <= @fech_fina_mes		
		;
	END
END
ELSE
BEGIN
	IF @CODI_TIPO_PERS = '01' 
	BEGIN
		Declare Curs_CARG_TRAB Cursor for 
		Select DISTINCT P.CODI_PERS  , P.APEL_1, P.APEL_2, P.NOMB_1, P.NOMB_2
		From PERSONAL P , personal_por_tipo_trabajador ptt
		WHERE (P.ESTA_ACTI = 1 and ( p.fech_cese is null or p.fech_cese > @fech_inic_mes) ) and p.codi_pers = ptt.codi_pers
			and ptt.codi_tipo_pers = '01' and p.fech_ingre <= @fech_fina_mes		
		ORDER BY P.APEL_1, P.APEL_2, P.NOMB_1, P.NOMB_2;
	END
	ELSE
	BEGIN
		Declare Curs_CARG_TRAB Cursor for 
		Select DISTINCT P.CODI_PERS ,P.APEL_1, P.APEL_2, P.NOMB_1, P.NOMB_2
		From PERSONAL P , personal_por_tipo_trabajador ptt
		WHERE (P.ESTA_ACTI = 1 and ( p.fech_cese is null or p.fech_cese > @fech_inic_mes) ) and p.codi_pers = ptt.codi_pers
			and ( ptt.codi_tipo_pers = '02' OR ptt.codi_tipo_pers = '05') and p.fech_ingre <= @fech_fina_mes				
		ORDER BY P.APEL_1, P.APEL_2, P.NOMB_1, P.NOMB_2;
	END
END

declare @Ap1 varchar(50)
declare @Ap2 varchar(50)
declare @Ap3 varchar(50)
declare @Ap4 varchar(50)

Open Curs_CARG_TRAB;
Fetch Next From Curs_CARG_TRAB into @CODI_PERS_AUXI, @ap1,@ap2,@ap3,@ap4
WHILE @@FETCH_STATUS = 0
	Begin
		DECLARE curs_sele_tipo_trab Cursor for 
		Select codi_TIPO_pers From PERSONAL_POR_TIPO_TRABAJADOR 
		Where CODI_PERS = @CODI_PERS_auxi;
		Open Curs_Sele_Tipo_Trab;
		Fetch Next From Curs_Sele_Tipo_Trab into @codi_TIPO_pers_auxi;
		while @@fetch_Status = 0 
		begin
			Fetch Next From Curs_Sele_Tipo_Trab into @codi_TIPO_pers_auxi;
		end
 		Close Curs_Sele_Tipo_Trab;
		Deallocate Curs_Sele_Tipo_Trab;
		IF @CODI_TIPO_PERS_AUXI = @CODI_TIPO_PERS 
		begin
			set @ls_indi_grab = '0'
			SET @LI_CONT_VACA = (Select Count(codi_pers) From Vacaciones 
			Where fech_inic <= @FECH_INIC_MES AND Fech_Term >= @Fech_inic_Mes and esta_acti = 1 and codi_pers = @CODI_PERS_auxi)
			if @LI_CONT_VACA <= 0 
			begin
				set @ls_indi_grab = '1'
			end
			Else
			begin
				SET @LI_CONT_VACA_2 = (Select Count(codi_pers) From Vacaciones 
				Where fech_term >= @FECH_INIC_MES AND Fech_Term < @Fech_fina_Mes and esta_acti = 1 and codi_pers = @CODI_PERS_auxi)
				if @LI_CONT_VACA_2 > 0 
				begin
					set @ls_indi_grab = '1'
				end
				else
				begin
					set @ls_indi_grab = '0'
				end
			end
			if @ls_indi_grab = '1'
			begin
				Insert Into #Pers_Temp(codi_pers) Values (@codi_pers_auxi)
			end
			
		end
		Fetch Next From Curs_CARG_TRAB into @CODI_PERS_AUXI, @ap1,@ap2,@ap3,@ap4
	End
Close Curs_CARG_TRAB;
Deallocate Curs_CARG_TRAB;

Select codi_pers
From #Pers_Temp
GO
