CREATE PROCEDURE [dbo].[usp_reporte_fact_deta]
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](8)
WITH EXECUTE AS CALLER
AS
--declare  @codi_alma char(2)  , @fec1 datetime , @fec2 datetime , @nro_docu varchar(8) 
--select  @codi_alma ='02', @fec1 ='01/05/2013', @fec2 ='31/05/2013', @nro_docu =null 

set nocount on

declare @alma table (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock)
END
ELSE
BEGIN
	insert @alma
	Select codi_alma from almacen  (nolock) where codi_alma = @codi_alma
END

select F.codi_fact, f.codi_alma , f.fech_fact, f.codi_tipo_docu , d.nemo as 'Docum' , f.ser_fact , f.nro_fact ,
	case when left(tipo_pers,1)='N' 
			then apel_1+isnull(' '+cp.apel_2,'') + isnull(' '+cp.nomb_1,'') + isnull(' '+cp.nomb_2,'') 
		else razo_soci end denominacion , 
	  f.codi_mone , f.tcambio, tp.desc_tipo_medio_pago , F.valo_fact, F.dscto_fact, F.subtota_fact , F.igv_fact , F.tota_Fact  , F.estado,
	TI.desc_imp, f.contabilizado , CASE WHEn @codi_alma='00' then 'TODOS' else A.nemo_alma end nemo_alma, 
	cant_item,	codi_prod, Dt.desc_item, 
	prec_item, 
	case when estado='A' then 0 else case when codi_imp=1 then round(impo_item/(1+Dt.igv/100.00),2) else impo_item end end venta, 
	case when estado='A' then 0 else case when codi_imp=1 then round(round((impo_item/(1+Dt.igv/100.00)),2)*igv/100.00,2) else 0 end  end igv, 
	case when estado='A' then 0 else case when codi_imp=1 then impo_item else impo_item end  end total 		
from 	dbo.factura F (nolock) inner join dbo.Almacen A (nolock) on F.codi_alma=A.codi_alma
	inner join dbo.tipo_documento D (nolock) on F.codi_tipo_docu=D.codi_tipo_docu
	inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_prov=cp.codi_clie_prov
	inner join dbo.tipo_pago TP (nolock) on F.codi_tipo_pago=TP.codi_tipo_medio_pago
	inner join dbo.tipo_impuestos TI (nolock) on F.cod_imp=TI.cod_imp
	join factura_Detalle DT (nolock) on DT.codi_fact=F.codi_fact
where 	F.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
		and (cast(convert(varchar(10), F.fech_fact , 103) as datetime) between @fec1 and @fec2)
order by f.codi_alma, f.codi_tipo_docu, f.ser_fact, f.nro_fact
GO
