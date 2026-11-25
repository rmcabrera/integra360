CREATE PROCEDURE [dbo].[proc_actu_stoc_con_kard]
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
Declare @codi_prod as char(8)
Declare @codi_kard as char(20)
Declare @fech_maxi as datetime
Declare @io as integer
Declare @cant_sald as decimal(18,4)

Update productos 
set stock = 0 --, stoc_temp = 0


declare Curs_reco_kard cursor for
select distinct codi_prod
from kardex
order by codi_prod

open Curs_reco_kard;
fetch Curs_reco_kard into @codi_prod
while @@fetch_status  = 0
begin
	SET @cant_sald = 0

	Select @fech_maxi = max( fech_tran ) from kardex where codi_prod = @codi_prod and periodo = @anio

	Select @io = max(i_o) from kardex where codi_prod = @codi_prod and fech_tran = @fech_maxi and periodo = @anio

	Select @codi_kard = max(codi_kard)  from kardex where codi_prod = @codi_prod and fech_tran = @fech_maxi and i_o = @io and periodo = @anio
	SET @cant_sald = 0
	Select @cant_sald = cant_saldo from kardex where codi_kard = @codi_kard;

--	print @codi_prod	
--	print @fech_maxi	
--	print @codi_kard	
--	print @io	
--	print @codi_kard
--	print @cant_sald

	update productos 
	set stock = @cant_sald --, stoc_temp = @cant_sald
	from productos
	where codi_prod = @codi_prod
	
	fetch Curs_reco_kard into @codi_prod
end
close Curs_reco_kard;
deallocate Curs_reco_kard;
GO
