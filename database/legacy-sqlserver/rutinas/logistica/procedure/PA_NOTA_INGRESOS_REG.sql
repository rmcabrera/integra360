CREATE PROCEDURE [dbo].[PA_NOTA_INGRESOS_REG]
	@tipo [char](1),
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](8),
	@codi_clie_prov [varchar](5),
	@nro_ingreso [char](10)
WITH EXECUTE AS CALLER
AS
--declare @tipo as char(1) , @codi_alma char(2)  , @fec1 datetime , @fec2 datetime , @nro_docu varchar(8) , @codi_clie_prov varchar(5) , @nro_ingreso char(10)
--select @tipo='F', @codi_alma='01', @fec1='01/07/2018', @fec2='23/07/2018', @nro_docu='', @codi_clie_prov='', @nro_ingreso=''

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

if @tipo='N'  --POR NRO DOCUMENTO
begin
SELECT  NI.CODI_NOTA_INGR , NI.NRO_NOTA_INGR , NI.codi_alma , A.nemo_alma ,
	NI.FECH_NOTA_INGR , TD.nemo as 'DOCU_INGRESO' , NI.NRO_SERI , rtrim(NI.NRO_DOCU) as 'NRO_DOCU' , 
	(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_SOLI) as  'UNID_OPER_SOLI' ,
	(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_DEST) as  'UNID_OPER_DEST' ,	
	NI.TIPO_NOTA_INGR , TIS.DESC_TIPO_IS , 
	---DATOS COMPRA
	(SELECT NEMO FROM TIPO_DOCUMENTO WHERE CODI_TIPO_DOCU=NI.CODI_TIPO_DOCU_CONT) AS 'DOCU_CONTABLE' ,
	NI.NRO_SERI_DOCU_CONT, NI.NRO_DOCU_CONT, 
	NI.CODI_CLIE_PROV , CP.DENOMINACION ,  
	---
	NI.codi_alma_desti , isnull((select nemo_alma from almacen where codi_alma=NI.codi_alma_desti),'') as 'ALMA_DESTINO',   
	NI.ESTADO , NI.codi_docu_sali, fech_reg_fact as FECHA_DOCU_CONT, codi_mone, prec_tota, tipo_camb, 
	prec_tota * (case when codi_mone='02' then tipo_Camb else 1 end) prec_tota_soles,
	case month(fech_reg_fact) when '01' then 'Enero' when '02' then 'Febrero' when '03' then 'Marzo' when '04' then 'Abril' 
	when '05' then 'Mayo' when '06' then 'Junio' when '07' then 'Julio' when '08' then 'Agosto' when '09' then 'Septiembre' 
	when '10' then 'Octubre' when '11' then 'Noviembre' else 'Diciembre' end mes, dbo.uf_nro_orde_comp(NI.CODI_NOTA_INGR) nro_orde_comp,
	isnull(igv,0) igv, observaciones

FROM NOTA_INGRESO  NI inner join Almacen A on NI.codi_alma=A.codi_alma
	inner join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = NI.TIPO_NOTA_INGR
	LEFT join tipo_documento TD on TD.codi_tipo_docu=NI.CODI_TIPO_DOCU
	LEFT JOIN CLIENTE_PROVEEDOR CP ON NI.CODI_CLIE_PROV=CP.CODI_CLIE_PROV

WHERE A.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)  and  rtrim(NI.NRO_DOCU) = @nro_docu

end

else if @tipo='I'  --POR NRO DE INGRESO
begin
	SELECT  NI.CODI_NOTA_INGR , NI.NRO_NOTA_INGR , NI.codi_alma , A.nemo_alma ,
		NI.FECH_NOTA_INGR , TD.nemo as 'DOCU_INGRESO' , NI.NRO_SERI , rtrim(NI.NRO_DOCU) as 'NRO_DOCU' , 
		(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_SOLI) as  'UNID_OPER_SOLI' ,
		(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_DEST) as  'UNID_OPER_DEST' ,	
		NI.TIPO_NOTA_INGR , TIS.DESC_TIPO_IS , 
		---DATOS COMPRA
		(SELECT NEMO FROM TIPO_DOCUMENTO WHERE CODI_TIPO_DOCU=NI.CODI_TIPO_DOCU_CONT) AS 'DOCU_CONTABLE' ,
		NI.NRO_SERI_DOCU_CONT, NI.NRO_DOCU_CONT, 
		NI.CODI_CLIE_PROV , CP.DENOMINACION ,  
		---
		NI.codi_alma_desti , isnull((select nemo_alma from almacen where codi_alma=NI.codi_alma_desti),'') as 'ALMA_DESTINO',   
		NI.ESTADO ,  NI.codi_docu_sali, fech_reg_fact as FECHA_DOCU_CONT, codi_mone, prec_tota, tipo_camb, 
		prec_tota * (case when codi_mone='02' then tipo_Camb else 1 end) prec_tota_soles,
		case month(fech_reg_fact) when '01' then 'Enero' when '02' then 'Febrero' when '03' then 'Marzo' when '04' then 'Abril' 
		when '05' then 'Mayo' when '06' then 'Junio' when '07' then 'Julio' when '08' then 'Agosto' when '09' then 'Septiembre' 
		when '10' then 'Octubre' when '11' then 'Noviembre' else 'Diciembre' end mes, dbo.uf_nro_orde_comp(NI.CODI_NOTA_INGR) nro_orde_comp,
		isnull(igv,0) igv, observaciones
	
	FROM NOTA_INGRESO  NI inner join Almacen A on NI.codi_alma=A.codi_alma
		inner join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = NI.TIPO_NOTA_INGR
		LEFT join tipo_documento TD on TD.codi_tipo_docu=NI.CODI_TIPO_DOCU
		LEFT JOIN CLIENTE_PROVEEDOR CP ON NI.CODI_CLIE_PROV=CP.CODI_CLIE_PROV
	
	WHERE A.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) and  rtrim(NI.NRO_NOTA_INGR) = @nro_ingreso
end

else if @tipo='T'  --
-- SOLO TRASLADOS : ENTRE LAS FECHAS Y POR ALMACEN 
SELECT  NI.CODI_NOTA_INGR , NI.NRO_NOTA_INGR , NI.codi_alma , A.nemo_alma ,
	NI.FECH_NOTA_INGR , TD.nemo as 'DOCU_INGRESO' , NI.NRO_SERI , rtrim(NI.NRO_DOCU) as 'NRO_DOCU' , 
	(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_SOLI) as  'UNID_OPER_SOLI' ,
	(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_DEST) as  'UNID_OPER_DEST' ,	
	NI.TIPO_NOTA_INGR , TIS.DESC_TIPO_IS , 
	---DATOS COMPRA
	(SELECT NEMO FROM TIPO_DOCUMENTO WHERE CODI_TIPO_DOCU=NI.CODI_TIPO_DOCU_CONT) AS 'DOCU_CONTABLE' ,
	NI.NRO_SERI_DOCU_CONT, NI.NRO_DOCU_CONT, 
	NI.CODI_CLIE_PROV , CP.DENOMINACION ,  
	---
	NI.codi_alma_desti , isnull((select nemo_alma from almacen where codi_alma=NI.codi_alma_desti),'') as 'ALMA_DESTINO',   
	NI.ESTADO ,   NI.codi_docu_sali, fech_reg_fact as FECHA_DOCU_CONT, codi_mone, prec_tota, tipo_camb, 
	prec_tota * (case when codi_mone='02' then tipo_Camb else 1 end) prec_tota_soles,
	case month(fech_reg_fact) when '01' then 'Enero' when '02' then 'Febrero' when '03' then 'Marzo' when '04' then 'Abril' 
	when '05' then 'Mayo' when '06' then 'Junio' when '07' then 'Julio' when '08' then 'Agosto' when '09' then 'Septiembre' 
	when '10' then 'Octubre' when '11' then 'Noviembre' else 'Diciembre' end mes, dbo.uf_nro_orde_comp(NI.CODI_NOTA_INGR) nro_orde_comp,
	isnull(igv,0) igv, observaciones

FROM NOTA_INGRESO  NI inner join Almacen A on NI.codi_alma=A.codi_alma
	inner join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = NI.TIPO_NOTA_INGR
	LEFT join tipo_documento TD on TD.codi_tipo_docu=NI.CODI_TIPO_DOCU
	LEFT JOIN CLIENTE_PROVEEDOR CP ON NI.CODI_CLIE_PROV=CP.CODI_CLIE_PROV

    	where A.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) and  NI.TIPO_NOTA_INGR='23' and ( convert(varchar(10), NI.FECH_NOTA_INGR , 103)  between @fec1 and @fec2 )

else if @tipo='C'  --
-- SOLO COMPRAS : ENTRE LAS FECHAS Y POR ALMACEN 
SELECT  NI.CODI_NOTA_INGR , NI.NRO_NOTA_INGR , NI.codi_alma , A.nemo_alma ,
	NI.FECH_NOTA_INGR , TD.nemo as 'DOCU_INGRESO' , NI.NRO_SERI , rtrim(NI.NRO_DOCU) as 'NRO_DOCU' , 
	(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_SOLI) as  'UNID_OPER_SOLI' ,
	(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_DEST) as  'UNID_OPER_DEST' ,	
	NI.TIPO_NOTA_INGR , TIS.DESC_TIPO_IS , 
	---DATOS COMPRA
	(SELECT NEMO FROM TIPO_DOCUMENTO WHERE CODI_TIPO_DOCU=NI.CODI_TIPO_DOCU_CONT) AS 'DOCU_CONTABLE' ,
	NI.NRO_SERI_DOCU_CONT, NI.NRO_DOCU_CONT, 
	NI.CODI_CLIE_PROV , CP.DENOMINACION ,  
	---
	NI.codi_alma_desti , isnull((select nemo_alma from almacen where codi_alma=NI.codi_alma_desti),'') as 'ALMA_DESTINO',   
	NI.ESTADO ,   NI.codi_docu_sali, fech_reg_fact as FECHA_DOCU_CONT, codi_mone, prec_tota, tipo_camb, 
	prec_tota * (case when codi_mone='02' then tipo_Camb else 1 end) prec_tota_soles,
	case month(fech_reg_fact) when '01' then 'Enero' when '02' then 'Febrero' when '03' then 'Marzo' when '04' then 'Abril' 
	when '05' then 'Mayo' when '06' then 'Junio' when '07' then 'Julio' when '08' then 'Agosto' when '09' then 'Septiembre' 
	when '10' then 'Octubre' when '11' then 'Noviembre' else 'Diciembre' end mes, dbo.uf_nro_orde_comp(NI.CODI_NOTA_INGR) nro_orde_comp,
	isnull(igv,0) igv, observaciones

FROM NOTA_INGRESO  NI inner join Almacen A on NI.codi_alma=A.codi_alma
	inner join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = NI.TIPO_NOTA_INGR
	LEFT join tipo_documento TD on TD.codi_tipo_docu=NI.CODI_TIPO_DOCU
	LEFT JOIN CLIENTE_PROVEEDOR CP ON NI.CODI_CLIE_PROV=CP.CODI_CLIE_PROV

    	where A.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) and  NI.TIPO_NOTA_INGR='01' and ( convert(varchar(10), NI.FECH_NOTA_INGR , 103)  between @fec1 and @fec2 )

else if @tipo='O'  --
-- SOLO COMPRAS : ENTRE LAS FECHAS Y POR ALMACEN 
SELECT  NI.CODI_NOTA_INGR , NI.NRO_NOTA_INGR , NI.codi_alma , A.nemo_alma ,
	NI.FECH_NOTA_INGR , TD.nemo as 'DOCU_INGRESO' , NI.NRO_SERI , rtrim(NI.NRO_DOCU) as 'NRO_DOCU' , 
	(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_SOLI) as  'UNID_OPER_SOLI' ,
	(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_DEST) as  'UNID_OPER_DEST' ,	
	NI.TIPO_NOTA_INGR , TIS.DESC_TIPO_IS , 
	---DATOS COMPRA
	(SELECT NEMO FROM TIPO_DOCUMENTO WHERE CODI_TIPO_DOCU=NI.CODI_TIPO_DOCU_CONT) AS 'DOCU_CONTABLE' ,
	NI.NRO_SERI_DOCU_CONT, NI.NRO_DOCU_CONT, 
	NI.CODI_CLIE_PROV , CP.DENOMINACION ,  
	---
	NI.codi_alma_desti , isnull((select nemo_alma from almacen where codi_alma=NI.codi_alma_desti),'') as 'ALMA_DESTINO',   
	NI.ESTADO ,   NI.codi_docu_sali, fech_reg_fact as FECHA_DOCU_CONT, codi_mone, prec_tota, tipo_camb, 
	prec_tota * (case when codi_mone='02' then tipo_Camb else 1 end) prec_tota_soles,
	case month(fech_reg_fact) when '01' then 'Enero' when '02' then 'Febrero' when '03' then 'Marzo' when '04' then 'Abril' 
	when '05' then 'Mayo' when '06' then 'Junio' when '07' then 'Julio' when '08' then 'Agosto' when '09' then 'Septiembre' 
	when '10' then 'Octubre' when '11' then 'Noviembre' else 'Diciembre' end mes, dbo.uf_nro_orde_comp(NI.CODI_NOTA_INGR) nro_orde_comp,
	isnull(igv,0) igv, observaciones

FROM NOTA_INGRESO  NI inner join Almacen A on NI.codi_alma=A.codi_alma
	inner join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = NI.TIPO_NOTA_INGR
	LEFT join tipo_documento TD on TD.codi_tipo_docu=NI.CODI_TIPO_DOCU
	LEFT JOIN CLIENTE_PROVEEDOR CP ON NI.CODI_CLIE_PROV=CP.CODI_CLIE_PROV

    	where A.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) and  NI.TIPO_NOTA_INGR not in ('01','23') and ( convert(varchar(10), NI.FECH_NOTA_INGR , 103)  between @fec1 and @fec2 )

else

--ENTRE LAS FECHAS Y POR ALMACEN
SELECT  NI.CODI_NOTA_INGR , NI.NRO_NOTA_INGR , NI.codi_alma , A.nemo_alma ,
	NI.FECH_NOTA_INGR , TD.nemo as 'DOCU_INGRESO' , NI.NRO_SERI , rtrim(NI.NRO_DOCU) as 'NRO_DOCU' , 
	(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_SOLI) as  'UNID_OPER_SOLI' ,
	(select desc_unid_oper from unid_oper where codi_unid_oper=NI.CODI_UNID_OPER_DEST) as  'UNID_OPER_DEST' ,	
	NI.TIPO_NOTA_INGR , TIS.DESC_TIPO_IS , 
	---DATOS COMPRA
	(SELECT NEMO FROM TIPO_DOCUMENTO WHERE CODI_TIPO_DOCU=NI.CODI_TIPO_DOCU_CONT) AS 'DOCU_CONTABLE' ,
	NI.NRO_SERI_DOCU_CONT, NI.NRO_DOCU_CONT, 
	NI.CODI_CLIE_PROV , CP.DENOMINACION ,  
	---
	NI.codi_alma_desti , isnull((select nemo_alma from almacen where codi_alma=NI.codi_alma_desti),'') as 'ALMA_DESTINO',   
	NI.ESTADO ,   NI.codi_docu_sali, fech_reg_fact as FECHA_DOCU_CONT, codi_mone, prec_tota, tipo_camb, 
	prec_tota * (case when codi_mone='02' then tipo_Camb else 1 end) prec_tota_soles,
	case month(fech_reg_fact) when '01' then 'Enero' when '02' then 'Febrero' when '03' then 'Marzo' when '04' then 'Abril' 
	when '05' then 'Mayo' when '06' then 'Junio' when '07' then 'Julio' when '08' then 'Agosto' when '09' then 'Septiembre' 
	when '10' then 'Octubre' when '11' then 'Noviembre' else 'Diciembre' end mes, dbo.uf_nro_orde_comp(NI.CODI_NOTA_INGR) nro_orde_comp,
	isnull(igv,0) igv, observaciones
	

FROM NOTA_INGRESO  NI inner join Almacen A on NI.codi_alma=A.codi_alma
	inner join TIPO_INGR_SALI TIS on TIS.CODI_TIPO_IS = NI.TIPO_NOTA_INGR
	LEFT join tipo_documento TD on TD.codi_tipo_docu=NI.CODI_TIPO_DOCU
	LEFT JOIN CLIENTE_PROVEEDOR CP ON NI.CODI_CLIE_PROV=CP.CODI_CLIE_PROV

    	where A.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma) and ( convert(varchar(10), NI.FECH_NOTA_INGR , 103)  between @fec1 and @fec2 )
GO
