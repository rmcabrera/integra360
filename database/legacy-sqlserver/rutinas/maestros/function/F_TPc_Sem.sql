CREATE FUNCTION [dbo].[F_TPc_Sem](@fecha [datetime])
RETURNS [numeric](12, 3) WITH EXECUTE AS CALLER
AS 
BEGIN 
/*  Declare @Fech datetime*/
  Declare @Tpc numeric(12,3)
/*  Select  @Fech =Fech_Term from semana where codi_sema=@codi*/
  Select @tpc= venta   from tipo_cambio_a_dolar where 
     convert(char(10),fech_camb,103) = convert(char(10),@fecha, 103) and codi_mone_camb = '02'
  if (@tpc=Null )
   begin
    set @tpc=0
  end
  return @tpc
END
GO
