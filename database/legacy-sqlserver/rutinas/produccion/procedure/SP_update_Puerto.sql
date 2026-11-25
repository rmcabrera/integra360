CREATE PROCEDURE [dbo].[SP_update_Puerto]
	@Codi_Puer [char](2),
	@Desc_Puer [varchar](30)
WITH EXECUTE AS CALLER
AS
UPDATE [Puerto] 

SET  [Codi_Puer]	 = @Codi_Puer,
	 [Desc_Puer]	 = @Desc_Puer

WHERE 
	( [Codi_Puer]	 = @Codi_Puer AND
	 [Desc_Puer]	 = @Desc_Puer)
GO
