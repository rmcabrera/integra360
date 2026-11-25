CREATE FUNCTION [dbo].[F_Tasa_Ries_nro_trab](@ANIO [char](4), @MES [char](2), @TIPO_RIES [char](2), @tipo_pers [char](2))
RETURNS [numeric](9, 2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt numeric(12,3)

	if @tipo_pers = '01' 
	begin
		set @rt = (Select count( distinct p.codi_pers) From personal p, planilla_de_empleados pl , personal_por_tipo_trabajador ptt
				where p.codi_pers = pl.codi_pers and pl.anio = @anio and pl.mes = @mes and pl.indi_tiem = 'M'
				and p.codi_tipo_ries = @tipo_ries and p.codi_pers = ptt.codi_pers and ptt.codi_tipo_pers = '01')
	end
	if @tipo_pers = '02' 
	begin
		set @rt = (Select count( distinct p.codi_pers) From personal p, planilla_de_obreros pl , personal_por_tipo_trabajador ptt
				where p.codi_pers = pl.codi_pers and pl.anio = @anio and pl.mes = @mes and pl.indi_tiem = 'M'
				and p.codi_tipo_ries = @tipo_ries and p.codi_pers = ptt.codi_pers and ptt.codi_tipo_pers = '02')
	end
	if (@RT is null) set @RT=0
	
	return @rt
END
GO
