CREATE PROCEDURE [dbo].[UP_DETALLE_SALDO_CTA_10]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4) , @mes char(2) 
--select @anio ='2009', @mes ='12'

set nocount on

declare @TX table (nro_cuen char(7) null,  desc_cuen varchar(100) null , desc_banc varchar(50) null, 
		nro_cta varchar(30) null, simbolo varchar(10) null,  codi_mone varchar(10) null,
		cargo numeric(12,2) null , abono numeric(12,2) null )

insert @TX
SELECT Movi_Contables.Nro_Cuen ,
       ctas_contable.desc_cuen , ctas_contable.desc_banc, 
	ctas_contable.NRO_CTA_CTE_BANC, 
	ctas_contable.SIMBOLO , 
	ctas_contable.CODI_MONE ,
        cargo= sum( case when Movi_Contables.cargo_abono='C' THEN importe ELSE 0 END ),
        abono= sum( case when Movi_Contables.cargo_abono='A' THEN importe ELSE 0 END )
FROM  Movi_Contables (nolock) inner join 
	(SELECT  cuentas_contable.nro_cuen , CUENTAS_CONTABLE.DESC_CUEN,   
	         CUENTAS_CONTABLE.NRO_CTA_CTE_BANC ,   
	         BANCOS.DESC_BANC , MONEDAS.SIMBOLO , MONEDAS.CODI_MONE
	 FROM CUENTAS_CONTABLE (nolock)  left join BANCOS (nolock)  on CUENTAS_CONTABLE.CODI_BANC = BANCOS.CODI_BANC
		inner join MONEDAS (nolock)   on  ( CUENTAS_CONTABLE.CODI_MONE = MONEDAS.CODI_MONE )    
	where left(nro_cuen,2)='10') ctas_contable 
on movi_contables.nro_cuen=ctas_contable.nro_cuen
WHERE 	Movi_Contables.anio = @anio and Movi_Contables.mes<= @mes and 
		LEFT(Movi_Contables.nro_cuen,2) ='10' and Movi_Contables.subdia not in ('X') 
GROUP BY Movi_Contables.Nro_Cuen , 
	 ctas_contable.desc_cuen , ctas_contable.desc_banc , ctas_contable.NRO_CTA_CTE_BANC , ctas_contable.SIMBOLO , ctas_contable.CODI_MONE


select nro_cuen ,  desc_cuen  , desc_banc , nro_cta , simbolo ,  codi_mone , 
		case when cargo - abono >0 then cargo - abono else 0 end, 
		case when cargo - abono <0 then abs(cargo - abono) else 0 end
from @Tx
GO
