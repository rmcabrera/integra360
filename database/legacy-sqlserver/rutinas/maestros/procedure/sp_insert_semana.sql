CREATE PROCEDURE [dbo].[sp_insert_semana]
	@CODI_SEMA [char](8),
	@NRO_SEMA [smallint],
	@FECH_INIC [datetime],
	@FECH_TERM [datetime],
	@ANIOMES [char](6),
	@CODI_TIPO_PERS [char](2)
WITH EXECUTE AS CALLER
AS
INSERT INTO [SEMANA] 
	 ( [CODI_SEMA],
	 [NRO_SEMA],
	 [FECH_INIC],
	 [FECH_TERM],
	 [ANIOMES],
	 [CODI_TIPO_PERS]) 
 
VALUES 
	( @CODI_SEMA,
	 @NRO_SEMA,
	 @FECH_INIC,
	 @FECH_TERM,
	 @ANIOMES,
	 @CODI_TIPO_PERS)
GO
