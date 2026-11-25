CREATE PROCEDURE [dbo].[sp_delete_nro_cuen]
	@nro_cuen [char](7)
WITH EXECUTE AS CALLER
AS
DELETE [cuentas_contable] 

WHERE 
	( [nro_cuen]	 = @nro_cuen)
GO
