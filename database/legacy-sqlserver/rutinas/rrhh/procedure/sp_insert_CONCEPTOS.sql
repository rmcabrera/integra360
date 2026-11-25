CREATE PROCEDURE [dbo].[sp_insert_CONCEPTOS]
	@CODI_CONC_1 [char](6),
	@DESC_CONC_2 [varchar](60),
	@ESTA_ACTI_3 [bit],
	@Codi_Sub_Concep_Sunat [smallint]
WITH EXECUTE AS CALLER
AS
INSERT INTO [CONCEPTOS] 
	 ( [CODI_CONC],
	 [DESC_CONC],
	 [ESTA_ACTI],
	 Codi_Sub_Concep_Sunat) 
 
VALUES 
	( @CODI_CONC_1,
	  @DESC_CONC_2,
	  @ESTA_ACTI_3,
	  @Codi_Sub_Concep_Sunat)
GO
