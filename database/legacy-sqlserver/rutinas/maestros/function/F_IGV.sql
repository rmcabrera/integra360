CREATE FUNCTION [dbo].[F_IGV](@fecha [datetime])
RETURNS [numeric](12, 3) WITH EXECUTE AS CALLER
AS 
BEGIN 
  Declare @Tpc numeric(12,3)
  Select  @Tpc =valor  from valores_unitarios_anuales (nolock) where 
	codi_valo_unit='2' and @fecha between fech_asig and fech_asig_fin
  if (@tpc=Null )
   begin
    set @tpc=0
  end
  return @tpc
END
GO
