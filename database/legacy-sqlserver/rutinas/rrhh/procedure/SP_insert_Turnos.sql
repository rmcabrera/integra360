CREATE PROCEDURE [dbo].[SP_insert_Turnos]
	@Codi_turno [char](2),
	@Desc_Turno [varchar](50)
WITH EXECUTE AS CALLER
AS
INSERT INTO [Turnos] 
	 ( [Codi_Turn],
	 [Desc_Turn]) 
 
VALUES 
	( @Codi_Turno,
	 @Desc_Turno)
GO
