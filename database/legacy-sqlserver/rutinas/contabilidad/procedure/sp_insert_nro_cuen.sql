CREATE PROCEDURE [dbo].[sp_insert_nro_cuen]
	@nro_cuen [char](7),
	@nro_sub_cuen [char](7),
	@desc_cuen [varchar](100),
	@codi_lcc [char](5)
WITH EXECUTE AS CALLER
AS
INSERT INTO [cuentas_contable] 
	 ( [nro_cuen],
	 [nro_sub_cuen],
	 [desc_cuen],
	 [CODI_LCC]) 
 
VALUES 
	(@nro_cuen,
	 @nro_sub_cuen,
	 @desc_cuen,
	 @codi_lcc)
GO
