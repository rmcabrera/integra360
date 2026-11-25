CREATE PROCEDURE [dbo].[sp_delete_Feriados]
	@anio [char](4),
	@MES [char](2),
	@DIA [char](2)
WITH EXECUTE AS CALLER
AS
DELETE [FERIADOS] 

WHERE 
	([ANIO]	 = @ANIO AND 
	 [MES]	 = @MES AND
	 [DIA]	 = @DIA )
GO
