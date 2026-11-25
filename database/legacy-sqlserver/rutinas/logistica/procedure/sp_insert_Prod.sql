CREATE PROCEDURE [dbo].[sp_insert_Prod]
	@CODI_PROD [char](8),
	@DESC_PROD [varchar](100),
	@CODI_SUB_FAMI_PROD [char](4),
	@CODI_UNID_MEDI [char](2),
	@CODI_MONE [char](2),
	@PREC_PROM [decimal](9, 4),
	@STOCK [decimal](9, 4),
	@STOC_MINI [decimal](9, 4),
	@STOC_MAXI [decimal](9, 4),
	@PUNT_REPE [decimal](9, 4),
	@FECH_VENC [datetime],
	@ESTA_PROD [varchar](25),
	@STOC_TEMP [decimal](9, 4),
	@UBICACION [varchar](50),
	@NRO_CUEN [char](7)
WITH EXECUTE AS CALLER
AS
INSERT INTO [PRODUCTOS] 
	 ( [CODI_PROD],
	 [DESC_PROD],
	 [CODI_SUB_FAMI_PROD],
	 [CODI_UNID_MEDI],
	 [CODI_MONE],
	 [PREC_PROM],
	 [STOCK],
	 [STOC_MINI],
	 [STOC_MAXI],
	 [PUNT_REPE],
	 [FECH_VENC],
	 [ESTA_PROD],
	 [STOC_TEMP],
	 [UBICACION],
	 [NRO_CUEN]) 
 
VALUES 
	( @CODI_PROD,
	 @DESC_PROD,
	 @CODI_SUB_FAMI_PROD,
	 @CODI_UNID_MEDI,
	 @CODI_MONE,
	 @PREC_PROM,
	 @STOCK,
	 @STOC_MINI,
	 @STOC_MAXI,
	 @PUNT_REPE,
	 @FECH_VENC,
	 @ESTA_PROD,
	 @STOC_TEMP,
	 @UBICACION,
	 @NRO_CUEN)
GO
