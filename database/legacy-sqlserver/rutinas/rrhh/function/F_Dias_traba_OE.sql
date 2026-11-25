CREATE FUNCTION [dbo].[F_Dias_traba_OE](@FECH_INIC [datetime], @NUME_DIAS [smallint], @pers [char](5))
RETURNS [char](2) WITH EXECUTE AS CALLER
AS 
BEGIN  
	Declare @ND smallint
	Declare @NDA char(2)
	DECLARE @VM CHAR (2)	
	Declare @fech_auxi datetime
	Declare @fech_fina_mes datetime
	Declare @cade_sql_1 varchar(500)

	set @fech_auxi = dateadd(day, @nume_dias,  @fech_inic )
	set @fech_fina_mes = dateadd(month, 1,  @fech_inic )
	set @fech_fina_mes = dateadd(day, - 1,  @fech_fina_mes )

	Set @nda = cast ( datepart(day , @fech_auxi ) as char(2)   ) 
	Set @nda = '05' --Replicate ( '0',  len( @NDA) ) + @NDA
	
	set @cade_sql_1 = "Select d_" + @nda +" From Horas_laboradas " 
	set @cade_sql_1 =  @cade_sql_1 + " where year(fech_inic)  = " + cast( year(@fech_inic) as varchar(4) ) + " and month(fech_inic)  = " + cast( month(@fech_inic) as varchar(2) )
		
	exec @cade_sql_1  @nda 

	Return @nda
END
GO
