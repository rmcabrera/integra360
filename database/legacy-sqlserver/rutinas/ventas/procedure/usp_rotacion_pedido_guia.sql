CREATE PROCEDURE [dbo].[usp_rotacion_pedido_guia]
	@fec1 [datetime],
	@fec2 [datetime],
	@guia [int]
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime , @fec2 datetime , @guia int 
--select @fec1 ='01/01/2017', @fec2 ='20/01/2017', @guia=50400

set nocount on

declare @ls_prod char(8), @ls_alma char(2)

create table #TP (idd int, glosa varchar(100) , fecha datetime, cantidad int, fecharota datetime, dias_trans int null, porc numeric(12,2) null, 
					coef numeric(12,2) null, analisis numeric(12,2) null, producto varchar(200) null, tiemporotacion numeric(12,2) null, 
					alma varchar(50) null, linea varchar(50) null, subfamilia varchar(200) null)

declare x1 cursor for select codi_prod, b.codi_alma_desti
	from guia_Detalle A (nolock)
	join guia B  (nolock)
	on A.Codi_Guia=B.Codi_Guia
	where A.codi_guia=@guia

open x1
fetch x1 into @ls_prod, @ls_alma
while @@FETCH_STATUS=0
begin
	--select @ls_prod, @ls_alma
	insert #Tp
	exec dbo.usp_rotacion_pedido @fec1 =@fec1 , @fec2 =@fec2 , @prod =@ls_prod, @alma =@ls_alma

	fetch x1 into @ls_prod, @ls_alma
end

close x1
deallocate x1

declare  @ls_Serie int, @ls_guia int

select @ls_serie= ser_guia,  @ls_guia = nro_guia
	from guia as G(nolock)
	where codi_guia=@guia
	

select idd, glosa , fecha , cantidad , fecharota , dias_trans , porc , 
		coef , analisis , producto , tiemporotacion , alma , linea, @ls_Serie as serie, @ls_guia as nro_guia,
		subfamilia
from #Tp

drop table #tp
GO
