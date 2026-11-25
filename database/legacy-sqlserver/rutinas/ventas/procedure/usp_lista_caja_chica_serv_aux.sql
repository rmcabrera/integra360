CREATE PROCEDURE [dbo].[usp_lista_caja_chica_serv_aux]
	@tipo [char](1),
	@recibo [varchar](255),
	@id [int]
WITH EXECUTE AS CALLER
AS
--declare @tipo char(1), @recibo varchar(255), @id int
--select @tipo='L', @recibo='PRE005296,PRE005290', @id=697

set nocount on
if @tipo='N'
begin
	create table #Tx (recibo varchar(10) null)
	declare @ct int
	declare @Ax varchar(255), @Inser varchar(10)
		
	set  @ct=0
	set @Ax=@recibo
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
		
		select distinct cc.nro_recibo, cc.fecha, 
			dbo.f_cliente_proveedor(cc.codi_clie_prov) proveedor, cc.importe 
		from dbo.caja_chica cc(nolock)
		join orden_solicitud_Servicio D(nolock)
		on D.codi_orden_soli = cc.codi_orden_soli
		where cc.tipo_contab='067' and cc.nro_recibo in (select recibo from #Tx)
		
		drop table #Tx
end

if @tipo='L'
begin
	select distinct cc.nro_recibo, cc.fecha, 
		dbo.f_cliente_proveedor(cc.codi_clie_prov) proveedor, cc.importe 
	from dbo.caja_chica cc(nolock)
	join liquidacion_deta D(nolock)
	on D.codi_liqu = cc.codi_liqu
	where cc.tipo_contab='067' and D.codi_liqu=@id
end
GO
