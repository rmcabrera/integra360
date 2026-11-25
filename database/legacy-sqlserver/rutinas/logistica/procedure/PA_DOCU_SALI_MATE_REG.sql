CREATE PROCEDURE [dbo].[PA_DOCU_SALI_MATE_REG]
	@tipo [char](1),
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](8),
	@codi_clie_prov [varchar](5),
	@nro_salida [char](10)
WITH EXECUTE AS CALLER
AS
--DECLARE @tipo as char(1) , @codi_alma char(2)  , @fec1 datetime , @fec2 datetime , @nro_docu varchar(8) , @codi_clie_prov varchar(5) , @nro_salida char(10) 
--SELECT  @tipo ='F' , @codi_alma ='01', @fec1 ='01/05/2017' , @fec2 ='23/05/2017', @nro_docu ='' , @codi_clie_prov ='', @nro_salida ='' 

SET NOCOUNT ON
if @tipo='N'  --POR NRO DOCUMENTO
begin
SELECT DS.CODI_DOCU_SALI ,  DS.NRO_SALI ,  DS.codi_alma , A.nemo_alma , DS.FECH_EMIS , DS.TIPO_SALI , TIS.DESC_TIPO_IS , DS.CODI_TIPO_DOCU_SALI,   
	TD.nemo as 'DOCU' , DS.NRO_SERI_DOCU_SALI , DS.NRO_DOCU_SALI , DS.CODI_UNID_OPER_RECE,   
	UO.nemo_uo , DS.CODI_ORDE_PEDI , DS.CODI_PERS_EMIS , DS.CODI_PERS_RECE , DS.CODI_CLIE_PROV ,   
	DS.codi_alma_desti ,  isnull((select nemo_alma from almacen where codi_alma=DS.codi_alma_desti),'') as 'ALMA_DESTINO',   
	DS.MOTIVO , DS.OBSERVACION , DS.TIPO_DEST , DS.CODI_PERS_RECI_MATE,   
	DS.MOTI_SALI , DS.ESTADO  , DS.CODI_FACT , DS.condicion,
	(select nro_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) nro_fact,
	(select fech_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) fecha_fact,
	isnull((select sum(cantidad * prec_costo) from detalle_docu_sali D(nolock) where D.codi_docu_sali=DS.codi_docu_sali),0) total,
	(select codi_orden_pedi from registro_orden_pedido R(nolock) where R.codi_guia in
			(select codi_guia from guia G(nolock) where G.codi_docu_sali=DS.codi_docu_sali)) as nro_orde_pedi
	
    FROM DOCU_SALI_MATE   DS inner join Almacen A on DS.codi_alma=A.codi_alma
	LEFT join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = DS.TIPO_SALI
	LEFT join tipo_documento TD on TD.codi_tipo_docu=DS.CODI_TIPO_DOCU_SALI
	left join Unid_Oper UO on UO.codi_unid_oper=ds.codi_unid_oper_rece

   WHERE A.codi_alma=@codi_alma   and  DS.NRO_DOCU_SALI = @nro_docu
end

else if @tipo='S'  --POR NRO de salida
begin
	SELECT DS.CODI_DOCU_SALI ,  DS.NRO_SALI ,  DS.codi_alma , A.nemo_alma , DS.FECH_EMIS , DS.TIPO_SALI , TIS.DESC_TIPO_IS , DS.CODI_TIPO_DOCU_SALI,   
		TD.nemo as 'DOCU' , DS.NRO_SERI_DOCU_SALI , DS.NRO_DOCU_SALI , DS.CODI_UNID_OPER_RECE,   
		UO.nemo_uo , DS.CODI_ORDE_PEDI , DS.CODI_PERS_EMIS , DS.CODI_PERS_RECE , DS.CODI_CLIE_PROV ,   
		DS.codi_alma_desti ,  isnull((select nemo_alma from almacen where codi_alma=DS.codi_alma_desti),'') as 'ALMA_DESTINO',   
		DS.MOTIVO , DS.OBSERVACION , DS.TIPO_DEST , DS.CODI_PERS_RECI_MATE,   
		DS.MOTI_SALI , DS.ESTADO  , DS.CODI_FACT  , DS.condicion,
		(select nro_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) nro_fact,
		(select fech_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) fecha_fact,
		isnull((select sum(cantidad * prec_costo) from detalle_docu_sali D(nolock) where D.codi_docu_sali=DS.codi_docu_sali),0) total,
		(select codi_orden_pedi from registro_orden_pedido R(nolock) where R.codi_guia in
			(select codi_guia from guia G(nolock) where G.codi_docu_sali=DS.codi_docu_sali)) as nro_orde_pedi
		
	    FROM DOCU_SALI_MATE   DS inner join Almacen A on DS.codi_alma=A.codi_alma
		LEFT join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = DS.TIPO_SALI
		LEFT join tipo_documento TD on TD.codi_tipo_docu=DS.CODI_TIPO_DOCU_SALI
		left join Unid_Oper UO on UO.codi_unid_oper=ds.codi_unid_oper_rece
	
	   WHERE A.codi_alma=@codi_alma   and  DS.NRO_SALI = @nro_salida
end

else if @tipo='P'  -- Lista los traslados Pendientes
begin
	SELECT DS.CODI_DOCU_SALI ,  DS.NRO_SALI ,  DS.codi_alma , A.nemo_alma , DS.FECH_EMIS , DS.TIPO_SALI , TIS.DESC_TIPO_IS , DS.CODI_TIPO_DOCU_SALI,   
		TD.nemo as 'DOCU' , DS.NRO_SERI_DOCU_SALI , DS.NRO_DOCU_SALI , DS.CODI_UNID_OPER_RECE,   
		UO.nemo_uo , DS.CODI_ORDE_PEDI , DS.CODI_PERS_EMIS , DS.CODI_PERS_RECE , DS.CODI_CLIE_PROV ,   
		DS.codi_alma_desti ,  isnull((select nemo_alma from almacen where codi_alma=DS.codi_alma_desti),'') as 'ALMA_DESTINO',   
		DS.MOTIVO , DS.OBSERVACION , DS.TIPO_DEST , DS.CODI_PERS_RECI_MATE,   
		DS.MOTI_SALI , DS.ESTADO  , DS.CODI_FACT  , DS.condicion,
		(select nro_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) nro_fact,
		(select fech_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) fecha_fact,
		isnull((select sum(cantidad * prec_costo) from detalle_docu_sali D(nolock) where D.codi_docu_sali=DS.codi_docu_sali),0) total,
		(select codi_orden_pedi from registro_orden_pedido R(nolock) where R.codi_guia in
			(select codi_guia from guia G(nolock) where G.codi_docu_sali=DS.codi_docu_sali)) as nro_orde_pedi
		
	    FROM DOCU_SALI_MATE   DS inner join Almacen A on DS.codi_alma=A.codi_alma
		LEFT join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = DS.TIPO_SALI
		LEFT join tipo_documento TD on TD.codi_tipo_docu=DS.CODI_TIPO_DOCU_SALI
		left join Unid_Oper UO on UO.codi_unid_oper=ds.codi_unid_oper_rece
	
	   WHERE A.codi_alma=@codi_alma   and  ds.tipo_sali='17' and DS.condicion='P'
end

else if @tipo='T'  -- Lista los traslados Todos
begin
	SELECT DS.CODI_DOCU_SALI ,  DS.NRO_SALI ,  DS.codi_alma , A.nemo_alma , DS.FECH_EMIS , DS.TIPO_SALI , TIS.DESC_TIPO_IS , DS.CODI_TIPO_DOCU_SALI,   
		TD.nemo as 'DOCU' , DS.NRO_SERI_DOCU_SALI , DS.NRO_DOCU_SALI , DS.CODI_UNID_OPER_RECE,   
		UO.nemo_uo , DS.CODI_ORDE_PEDI , DS.CODI_PERS_EMIS , DS.CODI_PERS_RECE , DS.CODI_CLIE_PROV ,   
		DS.codi_alma_desti ,  isnull((select nemo_alma from almacen where codi_alma=DS.codi_alma_desti),'') as 'ALMA_DESTINO',   
		DS.MOTIVO , DS.OBSERVACION , DS.TIPO_DEST , DS.CODI_PERS_RECI_MATE,   
		DS.MOTI_SALI , DS.ESTADO  , DS.CODI_FACT  , DS.condicion,
		(select nro_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) nro_fact,
		(select fech_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) fecha_fact,
		isnull((select sum(cantidad * prec_costo) from detalle_docu_sali D(nolock) where D.codi_docu_sali=DS.codi_docu_sali),0) total,
		(select codi_orden_pedi from registro_orden_pedido R(nolock) where R.codi_guia in
			(select codi_guia from guia G(nolock) where G.codi_docu_sali=DS.codi_docu_sali)) as nro_orde_pedi
		
	    FROM DOCU_SALI_MATE   DS inner join Almacen A on DS.codi_alma=A.codi_alma
		LEFT join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = DS.TIPO_SALI
		LEFT join tipo_documento TD on TD.codi_tipo_docu=DS.CODI_TIPO_DOCU_SALI
		left join Unid_Oper UO on UO.codi_unid_oper=ds.codi_unid_oper_rece
	
	   WHERE A.codi_alma=@codi_alma   and  ds.tipo_sali not in ('08','12')  and i_s='S' and ( convert(varchar(10), DS.FECH_EMIS , 103)  between @fec1 and @fec2 )
end

else if @tipo='G'  -- Lista los traslados Todos
begin
	SELECT DS.CODI_DOCU_SALI ,  DS.NRO_SALI ,  DS.codi_alma , A.nemo_alma , DS.FECH_EMIS , DS.TIPO_SALI , TIS.DESC_TIPO_IS , DS.CODI_TIPO_DOCU_SALI,   
		TD.nemo as 'DOCU' , DS.NRO_SERI_DOCU_SALI , DS.NRO_DOCU_SALI , DS.CODI_UNID_OPER_RECE,   
		UO.nemo_uo , DS.CODI_ORDE_PEDI , DS.CODI_PERS_EMIS , DS.CODI_PERS_RECE , DS.CODI_CLIE_PROV ,   
		DS.codi_alma_desti ,  isnull((select nemo_alma from almacen where codi_alma=DS.codi_alma_desti),'') as 'ALMA_DESTINO',   
		DS.MOTIVO , DS.OBSERVACION , DS.TIPO_DEST , DS.CODI_PERS_RECI_MATE,   
		DS.MOTI_SALI , DS.ESTADO  , DS.CODI_FACT  , DS.condicion,
		(select nro_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) nro_fact,
		(select fech_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) fecha_fact,
		isnull((select sum(cantidad * prec_costo) from detalle_docu_sali D(nolock) where D.codi_docu_sali=DS.codi_docu_sali),0) total,
		(select codi_orden_pedi from registro_orden_pedido R(nolock) where R.codi_guia in
			(select codi_guia from guia G(nolock) where G.codi_docu_sali=DS.codi_docu_sali)) as nro_orde_pedi
		
	    FROM DOCU_SALI_MATE   DS inner join Almacen A on DS.codi_alma=A.codi_alma
		LEFT join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = DS.TIPO_SALI
		LEFT join tipo_documento TD on TD.codi_tipo_docu=DS.CODI_TIPO_DOCU_SALI
		left join Unid_Oper UO on UO.codi_unid_oper=ds.codi_unid_oper_rece
	
	   WHERE A.codi_alma=@codi_alma   --and  i_s='S' 	   
	   and ( convert(varchar(10), DS.FECH_EMIS , 103)  between @fec1 and @fec2 )
end

else
   --- POR FECHAS

   SELECT DS.CODI_DOCU_SALI ,  DS.NRO_SALI ,  DS.codi_alma , A.nemo_alma , DS.FECH_EMIS , DS.TIPO_SALI , TIS.DESC_TIPO_IS , DS.CODI_TIPO_DOCU_SALI,   
	TD.nemo as 'DOCU' , DS.NRO_SERI_DOCU_SALI , DS.NRO_DOCU_SALI , DS.CODI_UNID_OPER_RECE,   
	UO.nemo_uo , DS.CODI_ORDE_PEDI , DS.CODI_PERS_EMIS , DS.CODI_PERS_RECE , DS.CODI_CLIE_PROV ,   
	DS.codi_alma_desti ,  isnull((select nemo_alma from almacen where codi_alma=DS.codi_alma_desti),'') as 'ALMA_DESTINO',   
	DS.MOTIVO , DS.OBSERVACION , DS.TIPO_DEST , DS.CODI_PERS_RECI_MATE,   
	DS.MOTI_SALI , DS.ESTADO  , DS.CODI_FACT  , DS.condicion,
	(select nro_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) nro_fact,
	(select fech_fact from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) fecha_fact,
	--(select isnull(cast(convert(char(10),fech_fact,103)as smalldatetime),'') from dbo.factura F(nolock) where F.codi_fact=DS.codi_fact) fecha_fact	
	isnull((select sum(cantidad * prec_costo) from detalle_docu_sali D(nolock) where D.codi_docu_sali=DS.codi_docu_sali),0) total,
	(select codi_orden_pedi from registro_orden_pedido R(nolock) where R.codi_guia in
		(select codi_guia from guia G(nolock) where G.codi_docu_sali=DS.codi_docu_sali)) as nro_orde_pedi
	
    FROM DOCU_SALI_MATE   DS inner join Almacen A on DS.codi_alma=A.codi_alma
	LEFT join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = DS.TIPO_SALI
	LEFT join tipo_documento TD on TD.codi_tipo_docu=DS.CODI_TIPO_DOCU_SALI
	left join Unid_Oper UO on UO.codi_unid_oper=ds.codi_unid_oper_rece

    where A.codi_alma=@codi_alma and
	 ( convert(varchar(10), DS.FECH_EMIS , 103)  between @fec1 and @fec2 )
GO
