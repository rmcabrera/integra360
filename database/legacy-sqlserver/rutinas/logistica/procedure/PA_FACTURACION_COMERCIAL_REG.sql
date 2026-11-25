CREATE PROCEDURE [dbo].[PA_FACTURACION_COMERCIAL_REG]
	@tipo [char](1),
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](8),
	@codi_clie_prov [varchar](5)
WITH EXECUTE AS CALLER
AS
--declare @tipo as char(1) , @codi_alma char(2)  , @fec1 datetime , @fec2 datetime , @nro_docu varchar(8) , @codi_clie_prov varchar(5)
--select @tipo ='F', @codi_alma ='19', @fec1 ='01/01/2020', @fec2 ='15/01/2020', @nro_docu =null , @codi_clie_prov =null

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

set nocount on 
if @tipo='N'  --POR NRO DOCUMENTO
begin
	select codi_fact, f.codi_alma , f.fech_fact, f.codi_tipo_docu , d.nemo as 'Docum', f.ser_fact , 
	f.nro_fact ,   case when left(tipo_pers,1)='N' 
			then apel_1+isnull(' '+cp.apel_2,'') + isnull(' '+cp.nomb_1,'') + isnull(' '+cp.nomb_2,'') 
		else razo_soci end denominacion , 
			f.codi_mone , f.tcambio, tp.desc_tipo_medio_pago , F.valo_fact, F.dscto_fact, F.subtota_fact , F.igv_fact , F.tota_Fact  , F.estado,
	TI.desc_imp, f.contabilizado , A.nemo_alma , f.impreso , f.tota_exonerado, 
		cod_usua_vende, (select apel_1 + isnull(' ' +apel_2,'')+ isnull(' ' +nomb_1,'')+ isnull(' ' +nomb_2,'')
			from usuarios u (nolock) where u.codi_usua=cod_usua_vende) vende, F.guia_fact, F.creacion, cast(nro_fact as numeric) nro_fact_order,
		(select nemo from tipo_docu_iden t(nolock) where t.Codi_Tipo_Docu_Iden=Cp.Codi_Tipo_Docu_Iden) docu_iden, ruc,
		convert(char(10),creacion,103) as fecha_reg, convert(char(8),creacion,108) as hora_reg
		
	from 	dbo.factura F (nolock)  inner join dbo.Almacen A (nolock) on F.codi_alma=A.codi_alma
		inner join dbo.tipo_documento D (nolock) on F.codi_tipo_docu=D.codi_tipo_docu
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_prov=cp.codi_clie_prov
		inner join dbo.tipo_pago TP (nolock) on F.codi_tipo_pago=TP.codi_tipo_medio_pago
		inner join dbo.tipo_impuestos TI (nolock) on F.cod_imp=TI.cod_imp
	where F.codi_alma=@codi_alma and  f.nro_fact =@nro_docu
end

else if @tipo='C'  -- POR CLIENTE
begin
	select codi_fact, f.codi_alma , f.fech_fact, f.codi_tipo_docu , d.nemo as 'Docum' , f.ser_fact ,
	 f.nro_fact , 
	case when left(tipo_pers,1)='N' 
			then apel_1+isnull(' '+cp.apel_2,'') + isnull(' '+cp.nomb_1,'') + isnull(' '+cp.nomb_2,'') 
		else razo_soci end denominacion , 
	f.codi_mone , f.tcambio, tp.desc_tipo_medio_pago , F.valo_fact, F.dscto_fact, F.subtota_fact , F.igv_fact , F.tota_Fact  , F.estado,
	TI.desc_imp, f.contabilizado , A.nemo_alma , f.impreso , f.tota_exonerado, 
		cod_usua_vende, (select apel_1 + isnull(' ' +apel_2,'')+ isnull(' ' +nomb_1,'')+ isnull(' ' +nomb_2,'')
			from usuarios u (nolock) where u.codi_usua=cod_usua_vende) vende, F.guia_fact, F.creacion, cast(nro_fact as numeric) nro_fact_order,
	(select nemo from tipo_docu_iden t(nolock) where t.Codi_Tipo_Docu_Iden=Cp.Codi_Tipo_Docu_Iden) docu_iden, ruc,
	convert(char(10),creacion,103) as fecha_reg, convert(char(8),creacion,108) as hora_reg
	
	from 	dbo.factura F (nolock) inner join dbo.Almacen A (nolock)  on F.codi_alma=A.codi_alma
		inner join dbo.tipo_documento D (nolock) on F.codi_tipo_docu=D.codi_tipo_docu
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_prov=cp.codi_clie_prov
		inner join dbo.tipo_pago TP (nolock) on F.codi_tipo_pago=TP.codi_tipo_medio_pago
		inner join dbo.tipo_impuestos TI (nolock) on F.cod_imp=TI.cod_imp
	where F.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
	 and  (cast(convert(varchar(10), F.fech_fact , 103) as datetime) between @fec1 and @fec2) and F.codi_clie_prov = @codi_clie_prov
	order by f.codi_alma, f.codi_tipo_docu, f.ser_fact, f.nro_fact
end

else if @tipo='P'  -- Provisionadas 
begin
	select codi_fact, f.codi_alma , f.fech_fact, f.codi_tipo_docu , d.nemo as 'Docum' , f.ser_fact , 
	f.nro_fact , 
	case when left(tipo_pers,1)='N' 
			then apel_1+isnull(' '+cp.apel_2,'') + isnull(' '+cp.nomb_1,'') + isnull(' '+cp.nomb_2,'') 
		else razo_soci end denominacion , 
	f.codi_mone , f.tcambio, tp.desc_tipo_medio_pago , F.valo_fact,
	 F.dscto_fact, F.subtota_fact , F.igv_fact , F.tota_Fact  , F.estado,
	TI.desc_imp, f.contabilizado , A.nemo_alma , f.impreso , f.tota_exonerado, 
		cod_usua_vende, (select apel_1 + isnull(' ' +apel_2,'')+ isnull(' ' +nomb_1,'')+ isnull(' ' +nomb_2,'')
			from usuarios u (nolock) where u.codi_usua=cod_usua_vende) vende, F.guia_fact, F.creacion, cast(nro_fact as numeric) nro_fact_order,
	(select nemo from tipo_docu_iden t(nolock) where t.Codi_Tipo_Docu_Iden=Cp.Codi_Tipo_Docu_Iden) docu_iden, ruc,
	convert(char(10),creacion,103) as fecha_reg, convert(char(8),creacion,108) as hora_reg
	
	from 	dbo.factura F (nolock) inner join dbo.Almacen A (nolock) on F.codi_alma=A.codi_alma
		inner join dbo.tipo_documento D (nolock) on F.codi_tipo_docu=D.codi_tipo_docu
		inner join dbo.cliente_proveedor cp (nolock) on f.codi_clie_prov=cp.codi_clie_prov
		inner join dbo.tipo_pago TP (nolock) on F.codi_tipo_pago=TP.codi_tipo_medio_pago
		inner join dbo.tipo_impuestos TI (nolock) on F.cod_imp=TI.cod_imp, guia_fact
	where F.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
	 and   (cast(convert(varchar(10), F.fech_fact , 103) as datetime) between @fec1 and @fec2) and (F.contabilizado='0' or F.contabilizado is null)
	order by f.codi_alma, f.codi_tipo_docu, f.ser_fact, f.nro_fact
end

else

---SOLO ENTRE FECHAS
select codi_fact, f.codi_alma , f.fech_fact, f.codi_tipo_docu , d.nemo as 'Docum' , f.ser_fact , f.nro_fact ,
	case when left(tipo_pers,1)='N' 
			then apel_1+isnull(' '+cp.apel_2,'') + isnull(' '+cp.nomb_1,'') + isnull(' '+cp.nomb_2,'') 
		else razo_soci end denominacion , 
	  f.codi_mone , f.tcambio, tp.desc_tipo_medio_pago , F.valo_fact, F.dscto_fact, F.subtota_fact , F.igv_fact , F.tota_Fact  , F.estado,
	TI.desc_imp, f.contabilizado , A.nemo_alma , f.impreso , f.tota_exonerado, 
		cod_usua_vende, (select apel_1 + isnull(' ' +apel_2,'')+ isnull(' ' +nomb_1,'')+ isnull(' ' +nomb_2,'')
			from usuarios u (nolock) where u.codi_usua=cod_usua_vende) vende, F.guia_fact, F.creacion, cast(nro_fact as numeric) nro_fact_order,
	(select nemo from tipo_docu_iden t(nolock) where t.Codi_Tipo_Docu_Iden=Cp.Codi_Tipo_Docu_Iden) docu_iden, ruc,
	convert(char(10),creacion,103) as fecha_reg, convert(char(8),creacion,108) as hora_reg
	
from dbo.factura F (nolock) inner join dbo.Almacen A (nolock) on F.codi_alma=A.codi_alma
	left join dbo.tipo_documento D (nolock) on F.codi_tipo_docu=D.codi_tipo_docu
	left join dbo.cliente_proveedor cp (nolock) on f.codi_clie_prov=cp.codi_clie_prov
	left join dbo.tipo_pago TP (nolock) on F.codi_tipo_pago=TP.codi_tipo_medio_pago
	left join dbo.tipo_impuestos TI (nolock) on F.cod_imp=TI.cod_imp

where 	F.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) and 
		(cast(convert(varchar(10), F.fech_fact , 103) as datetime) between @fec1 and @fec2)
order by f.codi_alma, f.codi_tipo_docu, f.ser_fact, f.nro_fact
GO
