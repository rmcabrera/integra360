CREATE PROCEDURE [dbo].[sp_delete_UNIDAD_NEGOCIO]
	@codi_unid_nego_1 [char](2)
WITH EXECUTE AS CALLER
AS
DELETE [UNIDAD_NEGOCIO] 

WHERE 
	( [codi_unid_nego]	 = @codi_unid_nego_1)
GO
