CREATE PROCEDURE [dbo].[sp_insert_Clie_Prov]
	@CODI_CLIE_PROV [char](5),
	@TIPO_PERS [varchar](12),
	@RAZO_SOCI [varchar](100),
	@NOMB_1 [varchar](30),
	@NOMB_2 [varchar](30),
	@APEL_1 [varchar](30),
	@APEL_2 [varchar](30),
	@RUC [varchar](15),
	@REPR_LEGA [varchar](120),
	@DENOMINACION [varchar](100),
	@DIRECCION [varchar](150),
	@TELE_1 [varchar](12),
	@TELE_2 [varchar](12),
	@FAX [varchar](12),
	@E_MAIL [varchar](50),
	@TIPO_RELA [varchar](25),
	@CODI_TIPO_DOCU_IDEN [tinyint]
WITH EXECUTE AS CALLER
AS
INSERT INTO [CLIENTE_PROVEEDOR] 
		 ( [CODI_CLIE_PROV],[TIPO_PERS], [RAZO_SOCI], [NOMB_1], [NOMB_2],[APEL_1], [APEL_2], [RUC], [REPR_LEGA],
		 [DENOMINACION], [DIRECCION], [TELE_1],	 [TELE_2], [FAX], [E_MAIL], [TIPO_RELA],  CODI_TIPO_DOCU_IDEN) 
	VALUES 
		( @CODI_CLIE_PROV, @TIPO_PERS, @RAZO_SOCI, @NOMB_1, @NOMB_2, @APEL_1, @APEL_2, @RUC, @REPR_LEGA,
		 @DENOMINACION,	 @DIRECCION, @TELE_1, @TELE_2, @FAX, @E_MAIL, @TIPO_RELA, @CODI_TIPO_DOCU_IDEN)
GO
