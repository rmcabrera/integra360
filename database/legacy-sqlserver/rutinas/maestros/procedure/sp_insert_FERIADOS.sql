CREATE PROCEDURE [dbo].[sp_insert_FERIADOS]
	@ANIO [char](4),
	@MES [char](2),
	@DIA [char](2),
	@DESC_FERI [varchar](50)
WITH EXECUTE AS CALLER
AS
INSERT INTO [FERIADOS] 
	 ([ANIO], 
	 [MES],
	 [DIA],
	 [DESC_FERI]) 
 
VALUES 
	( @ANIO,
	  @MES,
	 @DIA,
	 @DESC_FERI)
GO
