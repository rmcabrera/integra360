CREATE PROCEDURE [dbo].[usp_lista_oc_ulti_comp]
	@tipo [char](1),
	@oc [char](10),
	@codi_prod [varchar](255)
WITH EXECUTE AS CALLER
AS
--declare @tipo char(1), @oc char(10), @codi_prod varchar(255)
--select @tipo='N', @oc='0000001173', @codi_prod='00080354,00011582'

set nocount on

if @tipo='N'-- NUEVO
begin
	create table #Tx (producto varchar(8) null)
	declare @ct int
	declare @Ax varchar(255), @Inser varchar(8)
	
	set  @ct=0
	set @Ax=@codi_prod
	while len(@AX)>0 and @Ct<=100
	begin
		set  @ct=@ct +1
		if patindex('%,%',@ax)>0 
		begin
			set @Inser = substring(@Ax,1, patindex('%,%',@ax)- 1)
			set @Ax = substring(@Ax,patindex('%,%',@ax)+ 1, len(@AX) - len(@Inser))
		end
		else
		begin
			set @Inser = @Ax
			set @Ax=''
		end
		if rtrim(@Inser)<>''
			insert #Tx 
			select @Inser
	end
	
	--select * from #Tx
	select C.codi_prod, dbo.f_producto(C.codi_prod) producto, C.precio, C.fecha, C.codi_deta_orde_comp 
	from
	(select codi_prod,precio, fecha, B.codi_deta_orde_comp
	      from orden_de_compra a
	      join detalle_orden_compra B
	      on A.codi_orde_comp=B.codi_orde_comp) C
	join 
	(select codi_prod, max(fecha) fecha, max(B.codi_deta_orde_comp) codi_deta_orde_comp
	      from orden_de_compra a
	      join detalle_orden_compra B
	      on A.codi_orde_comp=B.codi_orde_comp
	      where codi_prod in (select * from #Tx)-- and A.codi_orde_comp<>@oc -- and fecha<= ?
	      group by codi_prod) D
	on c.codi_prod=D.codi_prod and c.fecha=d.fecha

	drop table #tx
end
if @tipo='G'
begin
	declare @Tx table (prod char (8) null)

	insert @Tx
	select codi_prod 
	from detalle_orden_compra (nolock) where codi_orde_comp=@oc
	
	select C.codi_prod, dbo.f_producto(C.codi_prod) producto, C.precio, C.fecha , C.codi_deta_orde_comp
	from
	(select codi_prod,precio, fecha, codi_deta_orde_comp
	      from orden_de_compra a
	      join detalle_orden_compra B
	      on A.codi_orde_comp=B.codi_orde_comp) C
	join 
	(select codi_prod, max(fecha) fecha, max(codi_deta_orde_comp) codi_deta_orde_comp
	      from orden_de_compra a
	      join detalle_orden_compra B
	      on A.codi_orde_comp=B.codi_orde_comp
	      where codi_prod in (select * from @Tx) and A.codi_orde_comp<>@oc -- and fecha<= ?
	      group by codi_prod) D
	on c.codi_prod=D.codi_prod and c.fecha=d.fecha
end
GO
