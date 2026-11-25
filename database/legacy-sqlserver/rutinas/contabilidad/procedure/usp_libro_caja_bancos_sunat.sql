CREATE PROCEDURE [dbo].[usp_libro_caja_bancos_sunat]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2) 
--select @anio ='2014' , @mes ='03' 

set nocount on 

declare @ls_codi_mone_cuen char(2)
declare @desc_mone varchar(20)
declare @nro_cuen char(7) 
declare @fec datetime, @saldo numeric(12,2)

declare @TC table (cuenta char(7) null)

create table  #RX (compr varchar(10) null, fecha datetime null, codi int null, glosa varchar(200) null,
		  clie varchar(123) null, serie char(5) null, nro varchar(10) null, cuen char(7) null,
		    descr varchar(100) null, deudo numeric(12,2) null, acree numeric(12,2) null, dolar numeric(12,2) null,
			docu char(4) null, conta char(10) null, banco varchar(50) null, cta varchar(40) null, grupo char(7) null)


insert @TC
select nro_cuen
from cuentas_contable (nolock) where left(nro_cuen,2)='10' and left(nro_cuen,3) not in ('101','102','103')

declare c1 cursor for select cuenta from @TC
open c1
fetch c1 into @nro_cuen
while @@fetch_status=0
begin
	insert #RX
	exec PA_LIBRO_CAJA_BANCOS_CUENTA @anio =@anio, @mes =@mes , @nro_cuen 	=@nro_cuen
	fetch c1 into @nro_cuen
end 
close c1
deallocate c1

select compr , fecha , codi , glosa ,  clie , serie , nro , cuen ,  descr , deudo , acree , dolar ,docu , conta , banco , cta , grupo
from #Rx
where not (deudo=0 and acree=0)
order by cuen,fecha

drop table #RX
GO
