CREATE PROCEDURE [dbo].[usp_validar_fact_vs_kardex]
	@per [char](4)
WITH EXECUTE AS CALLER
AS
--declare @per char(4)
--select @per='2018'

set nocount on 

declare @fi datetime, @ff datetime

create table #Fx (codi_fact char(10), serie varchar(20) ,nro_fact varchar(20), fecha datetime, tipo_docu char(4), estado char(1) null)
create table #Sx (codi_Docu_sali char(10),codi_fact char(10), serie varchar(20),nro_fact varchar(20), fecha datetime, tipo_docu char(4))
create table #Rx (codi_fact  char(10), codi_prod char(8), cantidad numeric(12,2), serie varchar(20) , nro_fact  varchar(20), 
					fecha datetime, DEsc_prod varchar(200) , codi_alma char(2), Almacen varchar(50) , 
					Empresa varchar(200 ), Docu varchar(50) null)
					
set @fi = cast('01/01/'+@per as datetime)
set @ff = cast('31/12/'+@per as datetime)

			
insert #Fx
select codi_fact ,ser_fact, nro_fact, fech_fact , codi_tipo_docu ,estado
from FACTURA (nolock) where fech_fact between @fi and @ff
--		and codi_fact=0000681050

insert #Sx
select CODI_DOCU_SALI, F.codi_fact , F.serie, F.nro_fact, F.fecha, F.tipo_docu
from DOCU_SALI_MATE D (nolock) 
left join #Fx F
on D.CODI_FACT = F.CODI_FACT 
where fech_emis between @fi and @ff ---and codi_docu_sali=0000721283

insert #Rx
select A.codi_fact, codi_prod, cantidad , A.serie, A.nro_fact, A.fecha,
		(select desc_prod from productos P (nolock) where p.codi_prod=D.codi_prod) DEsc_prod, D.codi_alma,
		(select NEMO_ALMA from almacen x (nolock) where x.codi_alma=D.codi_alma) Almacen,
		(select razon_social from empresa (nolock)) Empresa,
		(select desc_tipo_docu from tipo_documento T (nolock) where t.codi_tipo_docu=A.tipo_Docu) Docu
from detalle_docu_sali  D (nolock)
join #Sx A (nolock)
on A.codi_docu_sali=D.codi_docu_sali
where not exists (select * from kardex (nolock) 
			where periodo=@per and i_o=2 and codi_docu_i_o=D.codi_docu_sali and item=D.codi_deta_docu_sali)

insert #Rx
select A.codi_fact, codi_prod, cant_item , serie, nro_fact, fecha,
		(select desc_prod from productos P (nolock) where p.codi_prod=B.codi_prod) DEsc_prod, B.codi_alma,
		(select NEMO_ALMA from almacen x (nolock) where x.codi_alma=B.codi_alma) Almacen,
		(select razon_social from empresa (nolock)) Empresa,
		(select desc_tipo_docu from tipo_documento T (nolock) where t.codi_tipo_docu=a.tipo_docu) Docu 
from #Fx A (nolock) 
join Factura_detalle B (nolock)
on A.codi_fact=B.codi_Fact
where A.codi_Fact not in (select isnull(D.codi_Fact,'') from #Sx D(nolock))
	and  isnull(estado,'')<>'A' and codi_prod is not null

select codi_fact, codi_prod, cantidad, serie, nro_fact, fecha, desc_prod, codi_alma, almacen, empresa, docu 
from #Rx

drop table #Sx
drop table #Fx
drop table #Rx
GO
