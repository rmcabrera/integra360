CREATE PROCEDURE [dbo].[SP_insert_FACTURA]
	@CODI_FACT_1 [char](10),
	@CODI_CLIE_PROV_1 [char](5),
	@FECH_FACT_1 [datetime],
	@SER_FACT_1 [char](5),
	@NRO_FACT_1 [char](10),
	@ORDE_FACT_1 [char](30),
	@TELE_FACT_1 [char](50),
	@GUIA_FACT_1 [char](70),
	@VENC_FACT_1 [datetime],
	@TIPO_FACT_1 [char](2),
	@CODI_MONE_1 [char](2),
	@VALO_FACT_1 [numeric](12, 3),
	@IGV_FACT_1 [numeric](12, 3),
	@TOTA_FACT_1 [numeric](12, 3),
	@CODI_ORDE_GRUA_1 [char](10)
WITH EXECUTE AS CALLER
AS
INSERT INTO [FACTURA] 
	 ( [CODI_FACT],
	 [CODI_CLIE_PROV],
	 [FECH_FACT],
	 [SER_FACT],
	 [NRO_FACT],
	 [ORDE_FACT],
	 [TELE_FACT],
	 [GUIA_FACT],
	 [VENC_FACT],
	 [TIPO_FACT],
	 [CODI_MONE],
	 [VALO_FACT],
	 [IGV_FACT],
	 [TOTA_FACT],
	[codi_orde_grua]) 
 
VALUES 
	( @CODI_FACT_1,
	 @CODI_CLIE_PROV_1,
	 @FECH_FACT_1,
	 @SER_FACT_1,
	 @NRO_FACT_1,
	 @ORDE_FACT_1,
	 @TELE_FACT_1,
	 @GUIA_FACT_1,
	 @VENC_FACT_1,
	 @TIPO_FACT_1,
	 @CODI_MONE_1,
	 @VALO_FACT_1,
	 @IGV_FACT_1,
	 @TOTA_FACT_1,
	 @CODI_ORDE_GRUA_1)
GO
