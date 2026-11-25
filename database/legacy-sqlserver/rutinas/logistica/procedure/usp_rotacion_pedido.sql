CREATE PROCEDURE [dbo].[usp_rotacion_pedido]
	@fec1 [datetime],
	@fec2 [datetime],
	@prod [char](8),
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime , @fec2 datetime , @prod char(8), @alma char(2)
--select @fec1 ='01/01/2017', @fec2 ='10/01/2017', @prod ='00080427', @alma='07'

set nocount on 

declare @anio_ini int 
declare @anio_fin int 
declare @l_stock_ante  numeric(12,2)
declare @l_stock_final  numeric(12,2)
declare @l_rotacion int 
declare @l_val_rotacion numeric(12,2) 
declare @fx datetime 

set @anio_ini  = YEAR(@fec1)
set @anio_fin  = YEAR(@fec2)

select @l_stock_ante = sum(cant_ingr - cant_sali) 
from KARDEX (nolock)
where periodo=@anio_ini and codi_prod=@prod and 
		cast(convert(char(10),fech_tran,103) as datetime)<@fec1  and codi_alma=@alma

select @l_stock_final = sum(cant_ingr - cant_sali) 
from KARDEX (nolock)
where periodo=@anio_fin and codi_prod=@prod and 
		cast(convert(char(10),fech_tran,103) as datetime)<=@fec2  and codi_alma=@alma


if @l_stock_ante is null set @l_stock_ante=0
if @l_stock_final is null set @l_stock_final=0

declare @Rx table (idd int , glosa varchar(100) , fecha datetime, cantidad int )

insert @Rx
select 1 as idd,'Stock Anterior' as Glosa, dateadd(d, -1, @fec1) as fecha,  @l_stock_ante as cantidad
union all
select 2 , cast(nro_guia as varchar) nro_guia, fech_Tras, cantidad
from GUIA A (nolock)
join GUIA_DETALLE B  (nolock)
on A.codi_guia=B.Codi_Guia
where A.codi_alma_desti=@alma and 
		B.codi_prod = @prod and 
			fech_tras between @fec1 and @fec2
union all
select 3, 'Stock Actual' as Glosa, @fec2 as fecha,  @l_stock_final  as cantidad
order by fecha

insert @Rx
select 4, 'Rotación', @fec2 , SUM(cantidad*case when idd = 3 then -1 else 1 end)
from @Rx

select @l_rotacion= cantidad from @Rx R where idd=4

declare @cant int 
declare @l_valor int 
declare @l_dias_trans int

set @l_valor =@l_stock_ante

declare c1 cursor for select fecha, cantidad from @Rx where idd in (2) order by fecha
open c1
fetch c1 into @fx, @cant
while @@FETCH_STATUS=0
begin
	--select @fx, @cant, @l_stock_ante, @l_rotacion
	set @l_valor = 	@l_valor  + @cant
	if @l_stock_final<=0 
	begin
		if @l_rotacion<=@l_valor  	
		begin
			set @l_dias_trans= datediff(d, @fx , @fec2)
			--select 1 , @l_dias_trans, @fx
		end 
	end
	else
	begin
		if @l_rotacion<=@l_valor  	
		begin
			set @l_dias_trans= datediff(d, @fx , @fec2)
			--select 1 , @l_dias_trans, @fx
		end 	
	end
	
	fetch c1 into @fx , @cant
end
close c1
deallocate c1

declare @l_porc numeric(12,2)
declare @l_coefi numeric(12,2)
set @l_val_rotacion = isnull((select rotacion from PRODUCTOS (nolock) where CODI_PROD=@prod), 60)

set @l_porc = isnull((select cast(@l_dias_trans / @l_val_rotacion *100 as numeric(12,2))),0)

set @l_coefi= isnull((select cast(SUM(cantidad) *@l_porc/100.00 as numeric(12,2))
					from @Rx where idd in (1,2)),0)

select idd, glosa, fecha, cantidad,  dateadd(d,@l_val_rotacion, @fx) as fechaRota, @l_dias_trans as diasTrans,
		@l_porc as Porc, @l_coefi as Coef, @l_rotacion - @l_coefi as  Analisis,
		(select desc_prod from PRODUCTOS P (nolock) where p.CODI_PROD=@prod) as Producto,
		@l_val_rotacion as TiempoRotacion,
		(select nemo_alma from Almacen as A (nolock) where a.codi_alma =@alma) as Alma,
		(select (select des_lin_pro from LINEA_FAMILIA_PRO L (nolock) where L.cod_lin_pro= F.cod_lin_pro )
				from FAMILIA_PRODUCTO F (nolock) 
				where CODI_FAMI_PROD in (
					select CODI_FAMI_PROD from SUB_FAMILIA_PRODUCTO (nolock)
						where CODI_SUB_FAMI_PROD in (
							select CODI_SUB_FAMI_PROD from PRODUCTOS P (nolock) where p.CODI_PROD=@prod))) as Linea		,
		(select (select DESC_SUB_FAMI_PROD from SUB_FAMILIA_PRODUCTO (nolock)
						where CODI_SUB_FAMI_PROD in (
							select CODI_SUB_FAMI_PROD from PRODUCTOS P (nolock) where p.CODI_PROD=@prod))) as Subfa

from @Rx R
GO
