CREATE PROCEDURE [dbo].[usp_formato_sunat_3_4]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4) , @mes char(2) 
--select @anio ='2013', @mes ='12'

set nocount on

declare @TX table (nro_cuen char(7) null, codi_clie_prov char(5) null, registro varchar(11) null, saldo numeric(12,2) null, fecha datetime null)

insert @TX
SELECT nro_Cuen, codi_clie_prov, registro, sum(importe*case when cargo_abono='C' then 1 else -1 end) saldo,
	(select min(fecha) from movi_contables x (nolock) where x.registro=m.registro and left(nro_Cuen,2)='14')
FROM  Movi_Contables as M (nolock)  
WHERE 	M.anio = @anio and M.mes<= @mes and 
		LEFT(M.nro_cuen,2) ='14' and M.subdia not in ('X') --AND CODI_CLIE_PROV=73387 
		and not (registro is null or ltrim(registro)='') 
GROUP BY m.codi_clie_prov, M.Nro_Cuen , M.registro
having  sum(importe*case when cargo_abono='C' then 1 else -1 end)<>0

select nro_cuen ,  
	(select desc_cuen  from cuentas_contable c (nolock) where c.nro_cuen=T.nro_cuen) desc_cuen,
	dbo.f_cliente_proveedor(codi_clie_prov) Cliente,saldo, fecha,
	(select razon_social from empresa (nolock)) empresa,
	(select ruc from empresa (nolock)) ruc,
	(select (select codi_sunat from tipo_docu_iden t (nolock) where t.codi_tipo_docu_iden=c.codi_tipo_docu_iden )
		from cliente_proveedor c (nolock) where c.codi_clie_prov=t.codi_clie_prov) tipo,
	(SELECT ruc from cliente_proveedor c (nolock) where c.codi_clie_prov=t.codi_clie_prov) Rucclie
from @Tx T
GO
