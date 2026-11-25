CREATE PROCEDURE [dbo].[SP_REGISTRO_COMPRAS]
	@mesa [char](6)
WITH EXECUTE AS CALLER
AS
Begin
	Declare @fec datetime
	DEclare @reg char(10)
	declare @doc char(4)
	declare @serie char(3)
	declare @num char(10)
	declare @rc char(20)
	declare @Social varchar(100)
	declare @cambio numeric(12,4)
	declare @gr numeric(12,2)
	declare @ngr numeric(12,2)
	declare @imp numeric(12,2)
	declare @tot numeric(12,2)
	declare @cuen char(7)
	declare @nsp char(10)
	declare @fsp datetime

	create table #temporal(fecha datetime null, registro char(10), td numeric(2), ser char(3) null, numero char(10) null, ruc char(20) null, razon varchar(100) null,
		tpc numeric(12,4) null, gravadas numeric(12,2) null, nogravadas numeric(12,2) null, igv numeric(12,2) null, total numeric(12,2) null, cuenta char(7) null, 
		nrospot char(10) null, fechaspot datetime null)
	
	declare C1 cursor for select fecha, registro, codi_tipo_docu, serie, nro_docu, codi_clie_prov, importe,nro_cuen, num_spot, fecha_spot from movicontables 
		where subdia='C' and mes=left(@mesa,2) and anio=right(@mesa,4)
	open C1
	fetch C1 into @fec
	while (@@FETCH_STATUS=0)
	begin
		fetch C1 into @fec
	end
	close C1
	deallocate C1
End
GO
