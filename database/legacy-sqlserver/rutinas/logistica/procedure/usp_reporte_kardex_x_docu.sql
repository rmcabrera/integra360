CREATE PROCEDURE [dbo].[usp_reporte_kardex_x_docu]
	@F1 [datetime],
	@F2 [datetime],
	@anio [int],
	@codi [char](2)
WITH EXECUTE AS CALLER
AS
--declare @F1 datetime, @F2 datetime, @anio int, @codi char(2)
--select @F1='01/03/2011', @F2='01/03/2011', @anio=2011, @codi='02'

set nocount on

declare @Tx table (codi_alma char(2) null, fecha datetime null, codi_tipo_docu char(4) null, serie varchar(5) null, nro_docu varchar(20) null,
			valor_ingr numeric(12,4) null, valor_sali numeric(12,4) null, concepto varchar(250) null, fact char(10) null)

if @codi='00' 
	insert @TX
	select '' codi_alma, DATEADD(dd, -1, @F1) fecha,'' codi_tipo_docu, '' nro_seri,  '' nro_guia, 
	        sum(valo_ingr) - sum(valo_sali)  valo_ingr,  0 valo_sali,
		'SALDO ANTERIOR' Concepto, ''
	from dbo.kardex (nolock)
	where periodo=@anio and convert(char(10),fech_tran,103) < @F1 
	union all
	select codi_alma, fecha, codi_tipo_docu, nro_seri, nro_docu, sum(valo_ingr), sum(valo_sali), concepto,''
	from (select k.codi_alma,fech_tran fecha, 
			isnull(codi_tipo_docu_cont,N.codi_tipo_docu) codi_tipo_docu, 
			isnull(nro_seri_docu_cont,K.nro_seri) nro_seri, 
			isnull(nro_docu_cont, k.nro_guia) nro_docu,
			valo_ingr, valo_sali, concepto
		from dbo.kardex K (nolock) 
		join Nota_ingreso N (nolock)
		on K.codi_docu_i_o=N.codi_nota_ingr
		where periodo=@anio and convert(char(10),fech_tran,103) between @F1 and @F2 and i_o=1)  SQL
	group by codi_alma,codi_tipo_docu, nro_seri, nro_docu,fecha, concepto
	union all
	select codi_alma, fech_tran fecha, codi_tipo_docu, nro_seri, nro_guia , sum(valo_ingr), sum(valo_sali), concepto,
		(select codi_fact from docu_sali_mate F (nolock) where f.codi_docu_sali=K.codi_docu_i_o) Fact
	from dbo.kardex K (nolock) 
	where periodo=@anio and convert(char(10),fech_tran,103) between @F1 and @F2 and i_o=2
	group by codi_alma,codi_docu_i_o, codi_tipo_docu, nro_seri,  nro_guia,fech_tran , concepto
	order by 1
else		--------------- por almacen
	insert @TX
	select @codi codi_alma, DATEADD(dd, -1, @F1) fecha,'' codi_tipo_docu, '' nro_seri,  '' nro_guia, 
	        sum(valo_ingr_alma) - sum(valo_sali_alma)  valo_ingr,  0 valo_sali,
		'SALDO ANTERIOR' Concepto, ''
	from dbo.kardex (nolock)
	where periodo=@anio and convert(char(10),fech_tran,103) < @F1 and codi_alma=@codi
	union all
	select codi_alma, fecha, codi_tipo_docu, nro_seri, nro_docu, sum(valo_ingr_alma), sum(valo_sali_alma), concepto,''
	from (select k.codi_alma, fech_tran fecha, 
			isnull(codi_tipo_docu_cont,N.codi_tipo_docu) codi_tipo_docu, 
			isnull(nro_seri_docu_cont,K.nro_seri) nro_seri, 
			isnull(nro_docu_cont, k.nro_guia) nro_docu,
			valo_ingr_alma, valo_sali_alma, concepto
		from dbo.kardex K (nolock) 
		join Nota_ingreso N (nolock)
		on K.codi_docu_i_o=N.codi_nota_ingr
		where periodo=@anio and convert(char(10),fech_tran,103) between @F1 and @F2 and 
			K.codi_alma=@codi and i_o=1)  SQL
	group by codi_alma, codi_tipo_docu, nro_seri, nro_docu,fecha, concepto
	union all
	select codi_alma,fech_tran fecha, codi_tipo_docu, nro_seri, nro_guia , 
		sum(valo_ingr_alma), sum(valo_sali_alma), concepto,
		(select codi_fact from docu_sali_mate F (nolock) where f.codi_docu_sali=K.codi_docu_i_o) Fact
	from dbo.kardex K (nolock) 
	where periodo=@anio and convert(char(10),fech_tran,103) between @F1 and @F2 and codi_alma=@codi and i_o=2
	group by codi_alma, codi_docu_i_o,codi_tipo_docu, nro_seri,  nro_guia,fech_tran , concepto	
	order by 1

select codi_alma, 
	(select nemo_alma from almacen a (nolock) where A.codi_alma=X.codi_alma) almacen,
	fecha , codi_tipo_docu , 
	' ' +isnull((select desc_tipo_docu 
		from tipo_documento T (nolock) where T.codi_tipo_docu=X.codi_tipo_docu),'') Docu,
	serie , nro_docu , concepto  , valor_ingr , valor_sali ,
	(select razon_social from empresa (nolock)) empresa, 
	isnull((select ( select desc_tipo_medio_pago from tipo_pago X 
			(nolock) Where x.codi_tipo_medio_pago=F.codi_tipo_pago ) 
			from factura F (nolock) where F.codi_fact=fact ),'')  Tipo
from @Tx x
GO
