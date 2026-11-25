CREATE PROCEDURE [dbo].[sp_insert_sist_pens]
	@CODI_sist_pens [char](2),
	@DESC_sist_pens [varchar](50)
WITH EXECUTE AS CALLER
AS
INSERT INTO [Sistema_Pensiones] 
	 ( [CODI_sist_pens],
	 [DESC_sist_pens])
 
VALUES 
	( @CODI_sist_pens,
	 @DESC_sist_pens)
GO
