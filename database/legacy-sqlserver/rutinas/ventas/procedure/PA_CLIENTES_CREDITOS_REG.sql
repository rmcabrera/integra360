CREATE PROCEDURE [dbo].[PA_CLIENTES_CREDITOS_REG]
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
declare @alma table (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen
END
ELSE
BEGIN
	insert @alma
	Select codi_alma from almacen where codi_alma = @codi_alma
END

set nocount on 

select cp.codi_clie_prov,cp.denominacion, cc.codi_credito, cc.fec_inic_cred, cc.monto_cred, cc.estado , 
(case when tipo_pago=1 then 'Campaña' when tipo_pago=2 then 'Rotativo' when tipo_pago=3 then 'Moroso' when tipo_pago=4 then 'Especial' else 'Otro' end) observa_cred,
(cc.monto_cred - sum(isnull(fc.monto,0))) + 
isnull((select  sum(case c.codi_mone when '01' then importe else 0 end) 
from caja_chica c (nolock), factura f (nolock), factura_credito fcr (nolock)
where c.codi_alma=cc.codi_alma and c.codi_clie_prov=cp.codi_clie_prov and tipo_io=1
and cast(ser_fact as int)=cast(serie as int) and cast(nro_fact as int)=cast(nro_docu as int) and c.codi_tipo_docu=f.codi_tipo_docu
and fcr.codi_fact=f.codi_fact and codi_credito=cc.codi_credito),0) as saldo_favor ,
 cc.codi_mone  , (select nemo_alma from almacen where codi_alma=cc.codi_alma) nemo_alma,  cp.ruc nro_docu_iden,
(Select doc_garantia from documento_garantia where codi_docg=isnull(cc.doc_garantia,0)) doc_garantia,
cc.fec_fin_cred,
(select nomb_1+' '+apel_1 from usuarios where codi_usua=codi_usua_responsa) responsable

from cliente_creditos cc (nolock)
inner join cliente_proveedor cp (nolock) on cp.codi_clie_prov = cc.codi_clie_prov
inner join factura_credito fc (nolock) on fc.codi_credito=cc.codi_credito
where cc.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) and cc.codi_mone='01'
group by cp.codi_clie_prov,cp.denominacion, cc.codi_credito, cc.fec_inic_cred , cc.monto_cred, cc.estado , cc.observa_cred , cc.codi_mone , cc.codi_alma , cp.ruc, cc.doc_garantia, cc.tipo_pago, cc.fec_fin_cred, cc.codi_usua_responsa

union all

select cp.codi_clie_prov,cp.denominacion, cc.codi_credito, cc.fec_inic_cred, cc.monto_cred, cc.estado , 
(case when tipo_pago=1 then 'Campaña' when tipo_pago=2 then 'Rotativo' when tipo_pago=3 then 'Moroso' when tipo_pago=4 then 'Especial' else 'Otro' end) observa_cred,
(cc.monto_cred - sum(isnull(fc.monto,0))) + 
isnull((select  sum(case c.codi_mone when '01' then importe else 0 end) 
from caja_chica c (nolock), factura f (nolock), factura_credito fcr (nolock)
where c.codi_alma=cc.codi_alma and c.codi_clie_prov=cp.codi_clie_prov and tipo_io=1
and cast(ser_fact as int)=cast(serie as int) and cast(nro_fact as int)=cast(nro_docu as int) and c.codi_tipo_docu=f.codi_tipo_docu
and fcr.codi_fact=f.codi_fact and codi_credito=cc.codi_credito),0) as saldo_favor ,
 cc.codi_mone  , (select nemo_alma from almacen where codi_alma=cc.codi_alma) nemo_alma,  cp.ruc nro_docu_iden,
(Select doc_garantia from documento_garantia where codi_docg=isnull(cc.doc_garantia,0)) doc_garantia,
cc.fec_fin_cred,
(select nomb_1+' '+apel_1 from usuarios where codi_usua=codi_usua_responsa) responsable

from cliente_proveedor cp (nolock)
inner join cliente_creditos cc (nolock) on cp.codi_clie_prov = cc.codi_clie_prov
inner join factura_credito fc (nolock) on fc.codi_credito=cc.codi_credito 
where cc.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) and cc.codi_mone='02' 
group by cp.codi_clie_prov,cp.denominacion, cc.codi_credito, cc.fec_inic_cred , cc.monto_cred, cc.estado , cc.observa_cred , cc.codi_mone , cc.codi_alma , cp.ruc, cc.doc_garantia, cc.tipo_pago, cc.fec_fin_cred, cc.codi_usua_responsa

--- UNIMOS TODOS AQUELLOS QUE NO ESTEN EN FACTURA CREDITO
union all

select cp.codi_clie_prov,cp.denominacion, cc.codi_credito, cc.fec_inic_cred, cc.monto_cred, cc.estado , 
(case when tipo_pago=1 then 'Campaña' when tipo_pago=2 then 'Rotativo' when tipo_pago=3 then 'Moroso' when tipo_pago=4 then 'Especial' else 'Otro' end) observa_cred,
cc.monto_cred  as saldo_favor ,
cc.codi_mone  , (select nemo_alma from almacen where codi_alma=cc.codi_alma) nemo_alma,  cp.ruc nro_docu_iden,
(Select doc_garantia from documento_garantia where codi_docg=isnull(cc.doc_garantia,0)) doc_garantia,
cc.fec_fin_cred,
(select nomb_1+' '+apel_1 from usuarios where codi_usua=codi_usua_responsa) responsable

from cliente_creditos cc (nolock)
inner join cliente_proveedor cp (nolock) on cp.codi_clie_prov = cc.codi_clie_prov 
where cc.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) 
and cc.codi_credito not in (select codi_credito from factura f, factura_credito fc where codi_tipo_pago<>1 and f.codi_fact=f.codi_fact and codi_alma=cc.codi_alma)
GO
