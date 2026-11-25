CREATE PROCEDURE [dbo].[SP_insert_Puerto]
	@Codi_Puer [char](2),
	@Desc_Puer [varchar](30)
WITH EXECUTE AS CALLER
AS
INSERT INTO [Puerto] 
	 ( [Codi_Puer],
	 [Desc_Puer]) 
 
VALUES 
	( @Codi_Puer,
	 @Desc_Puer)
GO
