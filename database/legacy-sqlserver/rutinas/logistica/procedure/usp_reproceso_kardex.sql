CREATE PROCEDURE [dbo].[usp_reproceso_kardex]
	@periodo [int],
	@producto [char](8)
WITH EXECUTE AS CALLER
AS
--declare @periodo int , @producto char(8) 
--select @periodo =2008, @producto =''

set nocount on

Declare @pro varchar(8)
Declare @item varchar(12)
Declare @nota varchar(10)
declare @io int

declare @Tempo table (i_o int, fecha datetime, codi_prod char(8), item char(12), codigo char(10))

if @producto =''  or @producto is null
begin
	insert @tempo
	select 1, fech_nota_ingr, codi_prod, nro_item_nota_ingr , A.codi_nota_ingr 
		from dbo.detalle_nota_ingreso a (nolock) 
	join dbo.nota_ingreso B(nolock) 
	on A.codi_nota_ingr = B.codi_nota_ingr and  year(fech_nota_ingr)  =@periodo
	
	
	insert @tempo
	select 2, fech_emis , codi_prod, codi_deta_docu_sali, A.codi_docu_sali
		from dbo.detalle_docu_sali A (nolock) 
	join dbo.docu_sali_mate B(nolock) 
	on A.codi_docu_sali = B.codi_docu_sali and year(fech_emis)  =@periodo
	
	delete from dbo.kardex where  periodo=@periodo
end
else
begin
	insert @tempo
	select 1, fech_nota_ingr, codi_prod, nro_item_nota_ingr , A.codi_nota_ingr 
		from dbo.detalle_nota_ingreso a (nolock) 
	join dbo.nota_ingreso B(nolock) 
	on A.codi_nota_ingr = B.codi_nota_ingr and   year(fech_nota_ingr)  =@periodo and codi_prod=@producto
	
		insert @tempo
	select 2, fech_emis , codi_prod, codi_deta_docu_sali, A.codi_docu_sali
		from dbo.detalle_docu_sali A (nolock) 
	join dbo.docu_sali_mate B(nolock) 
	on A.codi_docu_sali = B.codi_docu_sali and year(fech_emis)  =@periodo and codi_prod=@producto
	
	delete from dbo.kardex where codi_prod=@producto and  periodo=@periodo
end

declare C1X cursor for select i_o , codi_prod, item , codigo from @tempo
	order by codi_prod, fecha, i_o,item
open c1X
fetch c1X into @io, @pro, @item, @nota
while @@fetch_status =0
begin
	exec dbo.SP_Kardex_insert @codi=@nota, @det =@item, @prod=@pro, @tp=@io	

	fetch c1X into @io, @pro, @item, @nota
end
close c1X
deallocate c1X
GO
