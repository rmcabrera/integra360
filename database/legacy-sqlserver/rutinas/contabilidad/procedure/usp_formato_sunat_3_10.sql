CREATE PROCEDURE [dbo].[usp_formato_sunat_3_10]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4) , @mes char(2) 
--select @anio ='2013', @mes ='12'

set nocount on

declare @TX table (nro_cuen char(7) null, codi_clie_prov char(5) null, registro varchar(11) null, saldo numeric(12,2) null, fecha datetime null, 
		docu varchar(30) null)

insert @TX
SELECT nro_Cuen, null codi_clie_prov, NULL, sum(importe*case when cargo_abono='A' then 1 else -1 end) saldo,
	NULL, --(select min(fecha) from movi_contables x (nolock) where isnull(x.registro,'')=isnull(m.registro,'') and left(nro_Cuen,2)='19'),
	NULL --(select min(rtrim(isnull(serie,'')) +'-'+ isnull(nro_docu,'')) from movi_contables x (nolock) where isnull(x.registro,'')=isnull(m.registro,'') and left(nro_Cuen,2)='19')
FROM  Movi_Contables as M (nolock)  
WHERE 	M.anio = @anio and M.mes<= @mes and 
		LEFT(M.nro_cuen,2) ='40' and M.subdia not in ('X') --AND CODI_CLIE_PROV=73387 
GROUP BY M.Nro_Cuen --, m.codi_clie_prov --, isnull(M.registro,'')
having  sum(importe*case when cargo_abono='A' then 1 else -1 end)<>0


select 1 as id,  
	(select nro_docu_iden from personal P (nolock) where p.codi_rela=t.codi_clie_prov)Rucclie,
	isnull((select apel_1+isnull(' ' +apel_2,'') + isnull(' '+nomb_1,'')+ isnull(' ' +nomb_2,'') 
			from personal P (nolock) where p.codi_rela=t.codi_clie_prov), dbo.f_cliente_proveedor(t.codi_clie_prov)) Cliente,
	null,
	saldo, 0,
	fecha,
	(select ruc from empresa (nolock)) ruc,
	(select razon_social from empresa (nolock)) empresa,	
	nro_cuen,
	(select desc_cuen from cuentas_contable c (nolock) where c.nro_cuen=T.nro_cuen) Cuenta,
	null
from @Tx T
order by cliente, nro_cuen
GO
