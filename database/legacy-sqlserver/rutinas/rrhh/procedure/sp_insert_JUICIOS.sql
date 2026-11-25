CREATE PROCEDURE [dbo].[sp_insert_JUICIOS]
	@CODI_JUIC_1 [char](6),
	@CODI_PERS_2 [char](5),
	@NRO_JUIC_3 [int],
	@FECH_JUIC_4 [datetime],
	@MOTI_JUIC_5 [varchar](100),
	@ESTA_ACTI_6 [bit],
	@TIPO_DESC_7 [bit],
	@CODI_MONE_8 [char](2),
	@MONT_DESC_9 [decimal](9, 2),
	@INTE_TIEM_DESC_10 [varchar](20),
	@apli_toda_remu [bit],
	@pers_bene_juic [varchar](200)
WITH EXECUTE AS CALLER
AS
INSERT INTO [JUICIOS] 
	 ( [CODI_JUIC],
	 [CODI_PERS],
	 [NRO_JUIC],
	 [FECH_JUIC],
	 [MOTI_JUIC],
	 [ESTA_ACTI],
	 [TIPO_DESC],
	 [CODI_MONE],
	 [MONT_DESC],
	 [INTE_TIEM_DESC],
	 [APLI_TODA_REMU],
	 [PERS_BENE_JUIC]) 
 
VALUES 
	( @CODI_JUIC_1,
	 @CODI_PERS_2,
	 @NRO_JUIC_3,
	 @FECH_JUIC_4,
	 @MOTI_JUIC_5,
	 @ESTA_ACTI_6,
	 @TIPO_DESC_7,
	 @CODI_MONE_8,
	 @MONT_DESC_9,
	 @INTE_TIEM_DESC_10,
	 @APLI_TODA_REMU,
	 @PERS_BENE_JUIC)
GO
