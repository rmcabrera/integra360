CREATE PROCEDURE [dbo].[SP_insert_FACTURA_PESCA]
	@CODI_FACT_PESC_1 [char](10),
	@CODI_CLIE_PROV_1 [char](5),
	@FECH_EMIS_1 [datetime],
	@VALO_VENT_1 [numeric](12, 2),
	@IGV_1 [numeric](12, 2),
	@VALO_TOTA_1 [numeric](12, 2),
	@CODI_MONE_1 [char](2),
	@SER_FACT_1 [char](3),
	@NRO_FACT_1 [char](10),
	@TIPO_FACT_1 [char](2),
	@CODI_UNID_OPER_1 [char](5),
	@detr_tota_1 [numeric](12, 3),
	@CODI_SEMA_1 [char](8),
	@PORC_DETR_1 [numeric](12, 3)
WITH EXECUTE AS CALLER
AS
INSERT INTO [FACTURA_PESCA] 
	 ( [CODI_FACT_PESC],
	 [CODI_CLIE_PROV],
	 [FECH_EMIS],
	 [VALO_VENT],
	 [IGV],
	 [VALO_TOTA],
	 [CODI_MONE],
	 [SER_FACT],
	 [NRO_FACT],
	 [TIPO_FACT],
	[CODI_UNID_OPER],
	[DETR_TOTA],
	[codi_sema],
	[PORC_DETR]) 
 
VALUES 
	( @CODI_FACT_PESC_1,
	 @CODI_CLIE_PROV_1,
	 @FECH_EMIS_1,
	 @VALO_VENT_1,
	 @IGV_1,
	 @VALO_TOTA_1,
	 @CODI_MONE_1,
	 @SER_FACT_1,
	 @NRO_FACT_1,
	 @TIPO_FACT_1,
	@CODI_UNID_OPER_1,
	@DETR_TOTA_1,
	@codi_sema_1,
	@PORC_DETR_1)
GO
