CREATE PROCEDURE [dbo].[usp_registro_guia_remision_deta]
	@tipo [char](2),
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime],
	@nro_docu [varchar](8),
	@codi_clie_prov [varchar](5)
WITH EXECUTE AS CALLER
AS
--declare @tipo as char(1) , @codi_alma char(2)  , @fec1 datetime , @fec2 datetime , @nro_docu varchar(8) , @codi_clie_prov varchar(5) 
--select @tipo ='F', @codi_alma ='01', @fec1 ='02/01/2012', @fec2 ='02/01/2012', @nro_docu ='', @codi_clie_prov =''

set nocount on 

declare @alma table (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen
END
ELSE
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock) where codi_alma = @codi_alma
END

if @tipo='N'  --POR NRO DOCUMENTO
begin
	SELECT F.codi_guia, F.ser_guia, F.nro_guia,
      (select nemo_alma from almacen A(nolock) where A.codi_alma=F.codi_alma) almacen,		
      (select nemo_alma from dbo.almacen A(nolock) where A.codi_alma=F.codi_alma_desti) destino, 
      F.fech_tras, 
      (select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,      	
      (select desc_moti_tras from motivo_traslado MT(nolock) where MT.codi_moti_tras = F.CODI_MOTI_TRAS) as 'moti_tras', 	
       punto_partida, punto_llegada, (select simbolo from monedas M(nolock) where M.codi_mone=F.codi_mone) moneda,
      (select nro_sali from dbo.docu_sali_mate S(nolock) where S.codi_docu_sali = F.codi_docu_sali) nro_sali,
      right('00' + cast(item_guia as varchar),2) item, codi_prod, dbo.F_producto(D.codi_prod) desc_prod,
      (select simb_unid_medi from unidad_medida UM(nolock) where UM.codi_unid_medi in
      		(select codi_unid_medi from productos P(nolock) where P.codi_prod=D.codi_prod)) UM, 
      D.cantidad
FROM DBO.GUIA F(NOLOCK)
JOIN DBO.GUIA_DETALLE D(NOLOCK)
ON F.codi_guia = D.codi_guia
where 	F.codi_alma in (Select codi_alma from @alma) and f.nro_guia =@nro_docu --cast(f.nro_guia as numeric) =@nro_docu
order by f.codi_alma, f.ser_guia, f.nro_guia

end

else if @tipo='C'  -- POR CLIENTE
begin
	SELECT F.codi_guia, F.ser_guia, F.nro_guia,
      (select nemo_alma from almacen A(nolock) where A.codi_alma=F.codi_alma) almacen,		
      (select nemo_alma from dbo.almacen A(nolock) where A.codi_alma=F.codi_alma_desti) destino, 
      F.fech_tras, 
      (select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,      	
      (select desc_moti_tras from motivo_traslado MT(nolock) where MT.codi_moti_tras = F.CODI_MOTI_TRAS) as 'moti_tras', 	
       punto_partida, punto_llegada, (select simbolo from monedas M(nolock) where M.codi_mone=F.codi_mone) moneda,
      (select nro_sali from dbo.docu_sali_mate S(nolock) where S.codi_docu_sali = F.codi_docu_sali) nro_sali,
      right('00' + cast(item_guia as varchar),2) item, codi_prod, dbo.F_producto(D.codi_prod) desc_prod,
      (select simb_unid_medi from unidad_medida UM(nolock) where UM.codi_unid_medi in
      		(select codi_unid_medi from productos P(nolock) where P.codi_prod=D.codi_prod)) UM, 
      D.cantidad
FROM DBO.GUIA F(NOLOCK)
JOIN DBO.GUIA_DETALLE D(NOLOCK)
ON F.codi_guia = D.codi_guia
where 	F.codi_alma in (Select codi_alma from @alma)
	and (convert(varchar(10), F.fech_tras, 103) between @fec1 and @fec2)
	and F.codi_clie_dest = @codi_clie_prov
order by f.codi_alma, f.ser_guia, f.nro_guia

end

else if @tipo='P'  -- Provisionadas 
begin
SELECT F.codi_guia, F.ser_guia, F.nro_guia,
      (select nemo_alma from almacen A(nolock) where A.codi_alma=F.codi_alma) almacen,		
      (select nemo_alma from dbo.almacen A(nolock) where A.codi_alma=F.codi_alma_desti) destino, 
      F.fech_tras, 
      (select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,      	
      (select desc_moti_tras from motivo_traslado MT(nolock) where MT.codi_moti_tras = F.CODI_MOTI_TRAS) as 'moti_tras', 	
       punto_partida, punto_llegada, (select simbolo from monedas M(nolock) where M.codi_mone=F.codi_mone) moneda,
      (select nro_sali from dbo.docu_sali_mate S(nolock) where S.codi_docu_sali = F.codi_docu_sali) nro_sali,
      right('00' + cast(item_guia as varchar),2) item, codi_prod, dbo.F_producto(D.codi_prod) desc_prod,
      (select simb_unid_medi from unidad_medida UM(nolock) where UM.codi_unid_medi in
      		(select codi_unid_medi from productos P(nolock) where P.codi_prod=D.codi_prod)) UM, 
      D.cantidad
FROM DBO.GUIA F(NOLOCK)
JOIN DBO.GUIA_DETALLE D(NOLOCK)
ON F.codi_guia = D.codi_guia
where 	F.codi_alma in (Select codi_alma from @alma)
	and (convert(varchar(10), F.fech_tras, 103) between @fec1 and @fec2)
order by f.codi_alma, f.ser_guia, f.nro_guia

end

else
	---SOLO ENTRE FECHAS

SELECT F.codi_guia, F.ser_guia, F.nro_guia,
      (select nemo_alma from almacen A(nolock) where A.codi_alma=F.codi_alma) almacen,		
      (select nemo_alma from dbo.almacen A(nolock) where A.codi_alma=F.codi_alma_desti) destino, 
      F.fech_tras, 
      (select nemo from tipo_documento T (nolock) where t.codi_tipo_docu='0009' ) as docum,      	
      (select desc_moti_tras from motivo_traslado MT(nolock) where MT.codi_moti_tras = F.CODI_MOTI_TRAS) as 'moti_tras', 	
       punto_partida, punto_llegada, (select simbolo from monedas M(nolock) where M.codi_mone=F.codi_mone) moneda,
      (select nro_sali from dbo.docu_sali_mate S(nolock) where S.codi_docu_sali = F.codi_docu_sali) nro_sali,
      right('00' + cast(item_guia as varchar),2) item, codi_prod, dbo.F_producto(D.codi_prod) desc_prod,
      (select simb_unid_medi from unidad_medida UM(nolock) where UM.codi_unid_medi in
      		(select codi_unid_medi from productos P(nolock) where P.codi_prod=D.codi_prod)) UM, 
      D.cantidad
FROM DBO.GUIA F(NOLOCK)
JOIN DBO.GUIA_DETALLE D(NOLOCK)
ON F.codi_guia = D.codi_guia
WHERE F.codi_alma in (Select codi_alma from @alma)
	--and (convert(varchar(10), F.fech_tras, 103) between '01/01/2012' and '06/01/2012')
	and cast(convert(varchar(10), F.fech_tras, 103) as datetime) between @fec1 and @fec2
order by f.codi_alma, f.ser_guia, f.nro_guia
GO
