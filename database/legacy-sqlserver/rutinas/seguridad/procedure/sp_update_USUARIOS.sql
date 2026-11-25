CREATE PROCEDURE [dbo].[sp_update_USUARIOS]
	@CODI_USUA [char](5),
	@APEL_1 [varchar](25),
	@APEL_2 [varchar](25),
	@NOMB_1 [varchar](25),
	@NOMB_2 [varchar](50),
	@CODI_PERS [char](5),
	@LOGIN [varchar](50),
	@CLAVE [varchar](50),
	@FECH_INIC_VIGE [datetime],
	@ESTA_CLAV [bit],
	@CODI_CARG [char](4)
WITH EXECUTE AS CALLER
AS
UPDATE [USUARIOS] 

SET  [APEL_1]	 = @APEL_1,
	 [APEL_2]	 = @APEL_2,
	 [NOMB_1]	 = @NOMB_1,
	 [NOMB_2]	 = @NOMB_2,
	 [CODI_PERS]	 = @CODI_PERS,
	 [LOGIN]	 = @LOGIN,
	 [CLAVE]	 = @CLAVE,
	 [FECH_INIC_VIGE]	 = @FECH_INIC_VIGE,
	 [ESTA_CLAV]	 = @ESTA_CLAV,
	 [CODI_CARG]	 = @CODI_CARG 

WHERE 
	( [CODI_USUA]	 = @CODI_USUA)
GO
