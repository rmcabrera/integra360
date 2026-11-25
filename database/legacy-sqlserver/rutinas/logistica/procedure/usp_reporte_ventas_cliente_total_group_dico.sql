CREATE PROCEDURE [dbo].[usp_reporte_ventas_cliente_total_group_dico]
	@calma [char](2),
	@FI [datetime],
	@FF [datetime]
WITH EXECUTE AS CALLER
AS
--declare @calma char(2), @FI datetime, @FF datetime  
--select @calma ='03', @FI ='01/03/2020', @FF ='02/03/2020'

set nocount on 

declare @alma table (codi_alma char(2) null)
IF @calma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock)
END
ELSE
BEGIN
	insert @alma
	Select @calma
END

declare @Tx table ( idx int identity , cliente varchar(200) null, vcostocont numeric(18,6) null  , vventacont numeric(18,6) null,
			vcostocred numeric(18,6) null, vventacred numeric(18,6) null, codi_clie_prov char(5) null, ticket int, dias int )

declare @Rx table ( idx int , cliente varchar(200) null, vcostocont numeric(18,6) null  , vventacont numeric(18,6) null,
		    vcostocred numeric(18,6) null, vventacred numeric(18,6) null, acum numeric(18,6) null, 
		    Estado char(1) null, codi_clie_prov char(5) null, ticket int, dias int, estado_2 char(1) null)

insert @tx
SELECT --factura.codi_clie_prov,
	(Select isnull(denominacion,'NO DEFINIDO') from si_agrog.dbo.cliente_proveedor (nolock) 
		where codi_clie_prov=si_agrog.dbo.FACTURA.CODI_CLIE_PROV) CLIENTE,   
	SUM((case when codi_tipo_pago=1 then (CANT_ITEM * PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + si_agrog.dbo.f_igv(fech_fact)/100 end)) else 0 end)) VCOSTOCONT,
	SUM((case when codi_tipo_pago=1 then (CANT_ITEM * PREC_ITEM * (CASE WHEN si_agrog.dbo.factura.codi_mone='01' THEN 1 ELSE si_agrog.dbo.factura.tcambio END)) else 0 end)) VVENTACONT,
	SUM((case when codi_tipo_pago<>1 then (CANT_ITEM * PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + si_agrog.dbo.f_igv(fech_fact)/100 end)) else 0 end)) VCOSTOCRED,
	SUM((case when codi_tipo_pago<>1 then (CANT_ITEM * PREC_ITEM * (CASE WHEN si_agrog.dbo.factura.codi_mone='01' THEN 1 ELSE si_agrog.dbo.factura.tcambio END)) else 0 end)) VVENTACRED,
	si_agrog.dbo.FACTURA.codi_clie_prov,
	count(distinct si_agrog.dbo.factura.codi_fact) as Ticket,
	count(distinct convert(char(10),fech_fact,103) ) as Dias
	
FROM si_agrog.dbo.FACTURA (nolock),   
	 si_agrog.dbo.FACTURA_DETALLE (nolock),
	 si_agrog.dbo.PRODUCTOS (nolock)
WHERE   ( si_agrog.dbo.FACTURA_DETALLE.CODI_FACT = si_agrog.dbo.FACTURA.CODI_FACT ) 
	and  ( si_agrog.dbo.PRODUCTOS.CODI_PROD =* si_agrog.dbo.FACTURA_DETALLE.CODI_PROD ) 
	and  ( ISNULL(si_agrog.dbo.FACTURA.ESTADO,'')<>'A') 
	and (cast(convert(varchar(10), si_agrog.dbo.FACTURA.fech_fact , 103) as datetime) between @FI and @FF)
	and si_agrog.dbo.FACTURA.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
GROUP BY si_agrog.dbo.FACTURA.CODI_CLIE_PROV
order by vventacont desc

insert @tx
SELECT --factura.codi_clie_prov,
	(Select isnull(denominacion,'NO DEFINIDO') from si_dcvp.dbo.cliente_proveedor (nolock) 
		where codi_clie_prov=si_dcvp.dbo.FACTURA.CODI_CLIE_PROV) CLIENTE,   
	SUM((case when codi_tipo_pago=1 then (CANT_ITEM * PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + si_dcvp.dbo.f_igv(fech_fact)/100 end)) else 0 end)) VCOSTOCONT,
	SUM((case when codi_tipo_pago=1 then (CANT_ITEM * PREC_ITEM * (CASE WHEN si_dcvp.dbo.factura.codi_mone='01' THEN 1 ELSE si_dcvp.dbo.factura.tcambio END)) else 0 end)) VVENTACONT,
	SUM((case when codi_tipo_pago<>1 then (CANT_ITEM * PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + si_dcvp.dbo.f_igv(fech_fact)/100 end)) else 0 end)) VCOSTOCRED,
	SUM((case when codi_tipo_pago<>1 then (CANT_ITEM * PREC_ITEM * (CASE WHEN si_dcvp.dbo.factura.codi_mone='01' THEN 1 ELSE si_dcvp.dbo.factura.tcambio END)) else 0 end)) VVENTACRED,
	si_dcvp.dbo.FACTURA.codi_clie_prov,
	count(distinct si_dcvp.dbo.factura.codi_fact) as Ticket,
	count(distinct convert(char(10),fech_fact,103) ) as Dias
	
FROM si_dcvp.dbo.FACTURA (nolock),   
	 si_dcvp.dbo.FACTURA_DETALLE (nolock),
	 si_dcvp.dbo.PRODUCTOS (nolock)
WHERE   ( si_dcvp.dbo.FACTURA_DETALLE.CODI_FACT = si_dcvp.dbo.FACTURA.CODI_FACT ) 
	and  ( si_dcvp.dbo.PRODUCTOS.CODI_PROD =* si_dcvp.dbo.FACTURA_DETALLE.CODI_PROD ) 
	and  ( ISNULL(si_dcvp.dbo.FACTURA.ESTADO,'')<>'A') 
	and (cast(convert(varchar(10), si_dcvp.dbo.FACTURA.fech_fact , 103) as datetime) between @FI and @FF)
	and si_dcvp.dbo.FACTURA.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
GROUP BY si_dcvp.dbo.FACTURA.CODI_CLIE_PROV
order by vventacont desc

declare @sum numeric(18,6), @cont int

set @sum= (select sum(vventacont) from @tx ) * 80/100.00

insert @RX
select idx, cliente , vcostocont , vventacont , vcostocred , vventacred  , 
		(select sum(vventacont) from @Tx A where A.idx<=T.idx) Acum, '0', codi_clie_prov, ticket , dias, 0
from @tx T

update @Rx set estado='1'
where acum<=@sum

set @cont = round((select max(idx) from @Rx ) * 20/100.00,0)

update @Rx set estado='2'
where idx<=@cont

declare @sum_80 numeric(18,6), @cont_80 int
set @sum_80= (select sum(vventacont) from @RX where estado<>'0') * 80/100.00

update @Rx set estado_2='1'
where acum<=@sum_80

set @cont_80 = round((select max(idx) from @Rx  where estado<>'0') * 20/100.00,0)

update @Rx set estado_2='2'
where idx<=@cont_80

--select @sum_80,@cont_80 

select cliente, vcostocont, vventacont, vcostocred, vventacred, estado, codi_clie_prov, ticket, dias, estado_2,
	   dbo.uf_vende_x_cliente_group_dico(@calma,@FI,@FF,CODI_CLIE_PROV) as vendedor	   
	   
from @Rx T
GO
