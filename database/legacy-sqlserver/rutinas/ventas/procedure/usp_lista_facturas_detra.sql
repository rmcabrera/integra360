CREATE PROCEDURE [dbo].[usp_lista_facturas_detra]
	@anio [char](4),
	@ms [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @ms char(2)
--select @anio ='2025', @ms ='01'

declare @Tx table (chec char(1) null, codi_fact char(10) null, ser_Fact char(10) null, nro_fact char(20) null,
                   fech_fact datetime null, codi_clie_prov char(5) null, cliente varchar(250) null,
		   moneda char(5) null, tota_fact numeric(18,2) null, total_s numeric(18,2) null, 
		   cta_cte_emp char(50) null, nro_iden char(11) null)

set nocount on

insert @Tx
select '0' as chec, codi_fact, ser_fact, nro_fact, fech_fact, 
       codi_clie_prov, dbo.f_cliente_proveedor(codi_clie_prov) cliente,
      (select simbolo from monedas M(nolock) where M.codi_mone = F.codi_mone) moneda, 
       tota_fact, (case when codi_mone='01' then round(tota_fact,2) else round(tota_fact * tcambio,2) end) total_s,
      (select max(nro_cta_cte) from cta_cte_prov cc(nolock) where cc.codi_clie_prov in
	      (select codi_clie_prov from cliente_proveedor c(nolock) where c.ruc in 
			(select ruc from empresa (nolock) ) ) and isnull(detraccion,0)=1) cta_cte_emp,
      (select ruc from cliente_proveedor c(nolock) where c.codi_clie_prov=f.codi_clie_prov) nro_iden
from factura F(nolock)
where year(fech_Fact)=@anio and month(fech_fact)=@ms and detra=1 and codi_tipo_docu in ('0001')
and isnull(codi_fact,'') not in (select isnull(codi_fact,'') from detalle_detraccion(nolock) )
order by fech_fact desc


select  chec, codi_fact, ser_Fact, nro_fact,
        fech_fact, codi_clie_prov, cliente,
	moneda, tota_fact, total_s, cta_cte_emp,
	round( (isnull(total_s,0) * 1.5)/100,0) importe
from @Tx
where isnull(total_s,0) >= 700 --and isnull(nro_iden,'')<>''
GO
