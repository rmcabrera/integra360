CREATE PROCEDURE [dbo].[update_CLIENTE_PROVEEDOR_1]
	@CODI_CLIE_PROV_1 [char](1),
	@CODI_CLIE_PROV_2 [char](5),
	@TIPO_PERS_3 [varchar](12),
	@RAZO_SOCI_4 [varchar](100),
	@NOMB_1_5 [varchar](30),
	@NOMB_2_6 [varchar](30),
	@APEL_1_7 [varchar](30),
	@APEL_2_8 [varchar](30),
	@RUC_9 [varchar](15),
	@REPR_LEGA_10 [varchar](120),
	@DENOMINACION_11 [varchar](100),
	@DIRECCION_12 [varchar](150),
	@TELE_1_13 [varchar](12),
	@TELE_2_14 [varchar](12),
	@FAX_15 [varchar](12),
	@E_MAIL_16 [varchar](50),
	@TIPO_RELA_17 [varchar](25)
WITH EXECUTE AS CALLER
AS
UPDATE [CLIENTE_PROVEEDOR] 

SET  [CODI_CLIE_PROV]	 = @CODI_CLIE_PROV_2,
	 [TIPO_PERS]	 = @TIPO_PERS_3,
	 [RAZO_SOCI]	 = @RAZO_SOCI_4,
	 [NOMB_1]	 = @NOMB_1_5,
	 [NOMB_2]	 = @NOMB_2_6,
	 [APEL_1]	 = @APEL_1_7,
	 [APEL_2]	 = @APEL_2_8,
	 [RUC]	 = @RUC_9,
	 [REPR_LEGA]	 = @REPR_LEGA_10,
	 [DENOMINACION]	 = @DENOMINACION_11,
	 [DIRECCION]	 = @DIRECCION_12,
	 [TELE_1]	 = @TELE_1_13,
	 [TELE_2]	 = @TELE_2_14,
	 [FAX]	 = @FAX_15,
	 [E_MAIL]	 = @E_MAIL_16,
	 [TIPO_RELA]	 = @TIPO_RELA_17 

WHERE 
	( [CODI_CLIE_PROV]	 = @CODI_CLIE_PROV_1)
GO
