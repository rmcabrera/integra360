CREATE PROCEDURE [dbo].[sp_insert_Usuarios]
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
INSERT INTO [USUARIOS] 
	 ( [CODI_USUA],
	 [APEL_1],
	 [APEL_2],
	 [NOMB_1],
	 [NOMB_2],
	 [CODI_PERS],
	 [LOGIN],
	 [CLAVE],
	 [FECH_INIC_VIGE],
	 [ESTA_CLAV],
	 [CODI_CARG]) 
 
VALUES 
	( @CODI_USUA,
	 @APEL_1,
	 @APEL_2,
	 @NOMB_1,
	 @NOMB_2,
	 @CODI_PERS,
	 @LOGIN,
	 @CLAVE,
	 @FECH_INIC_VIGE,
	 @ESTA_CLAV,
	 @CODI_CARG)
GO
