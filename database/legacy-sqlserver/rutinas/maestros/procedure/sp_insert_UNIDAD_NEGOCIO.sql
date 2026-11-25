CREATE PROCEDURE [dbo].[sp_insert_UNIDAD_NEGOCIO]
	@codi_unid_nego_1 [char](2),
	@desc_unid_nego_1 [varchar](50)
WITH EXECUTE AS CALLER
AS
INSERT INTO [UNIDAD_NEGOCIO] 
	 ( [codi_unid_nego],
	 [desc_unid_nego]) 
 
VALUES 
	( @codi_unid_nego_1,
	 @desc_unid_nego_1)
GO
