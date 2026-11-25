CREATE PROCEDURE [dbo].[INSERTAR_PERSONAL_TIPO_TRABAJADOR]
	@CODI_TIPO_PERS [char](2)
WITH EXECUTE AS CALLER
AS
Declare @codi_pers char(5)


DECLARE Curs_carg_TRAB CURSOR FOR
SELECT CODI_PERS  from PERSONAL 
where ESTA_ACTI = 1 ORDER BY CODI_PERS;
Open Curs_carg_TRAB;
Fetch Curs_carg_trab into @codi_pers;
While @@fetch_status  = 0
Begin
	Insert Into Personal_por_tipo_trabajador (CODI_PERS, CODI_TIPO_PERS) Values (@codi_pers, @codi_tipo_pers)
	Fetch Curs_carg_trab into @codi_pers;
End
Close Curs_carg_trab;
Deallocate Curs_carg_trab;
GO
