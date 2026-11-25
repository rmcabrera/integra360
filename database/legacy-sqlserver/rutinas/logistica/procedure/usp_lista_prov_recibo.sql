CREATE PROCEDURE [dbo].[usp_lista_prov_recibo]
	@anio [char](4),
	@cod_alma [char](2),
	@rec [varchar](255)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @cod_alma char(2), @rec varchar(255)
--select @anio='2012', @cod_alma='00', @rec='PRE003440,CAE002212'

set nocount on

declare @alma table (codi_alma char(2) null)
create table #Tx (recibo varchar(10) null)
declare @ct int
declare @Ax varchar(255), @Inser varchar(9)

if @cod_alma = '00'
begin
	insert @alma
	Select codi_alma from almacen (nolock)
end
else
begin
	insert @alma
	Select codi_alma from almacen (nolock) where codi_alma = @cod_alma
end

set  @ct=0
set @Ax=@rec
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

select codi_contable, codi_nota_ingr, codi_alma, 
	(select nemo_alma from almacen A(nolock) where A.codi_alma=movi_contables.codi_alma) almacen,
	anio, mes, subdia, compr, codi_clie_prov, dbo.f_cliente_proveedor(codi_clie_prov) cliente, codi_mone, importe
from movi_contables (nolock)
where anio=@anio and movi_contables.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
and codi_nota_ingr in (select recibo from #Tx)
order by cast(mes as int), codi_nota_ingr, subdia

drop table #Tx
GO
