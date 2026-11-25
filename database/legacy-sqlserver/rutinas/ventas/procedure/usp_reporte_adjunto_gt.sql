CREATE PROCEDURE [dbo].[usp_reporte_adjunto_gt]
	@Fact [char](10)
WITH EXECUTE AS CALLER
AS
--declare @Fact char(10)
--select @Fact='0000000001'
set nocount on 

SELECT 	fecha,   
	(select plac_unid_tran from unidad_transporte U (nolock ) where U.codi_unid_oper =G.codi_unid_vehi) Placa,
	(select desc_trans from transportistas T (nolock) where T.codi_trans=G.codi_trans) Chofer,
	isnull(guia_remitente,'') guia_remitente, 
	casT(serie as varchar)+' - '+ cast(numero as varchar) as guia_transport,    
	cantidad, 
	peso, 
	observaciones, 
	descripcion, 
	(select desc_ubi_dist from ubigeo_distrito U (nolock) where U.codi_ubi_dist=G.dist_parT) Partida,
	(select desc_ubi_dist from ubigeo_distrito U (nolock) where U.codi_ubi_dist=G.dist_dest) Llegada,
	isnull(orden_despa,'') orden_despa, isnull(orden_venta ,'')orden_venta  ,
	(select case when razo_soci is null or rtrim(razo_soci)='' then denominacion 	
		else razo_soci end from cliente_proveedor C (nolock) where C.codi_clie_prov in 
			(select codi_clie_prov from factura F (nolock) where f.codi_fact=G.codi_fact)) Cliente,
	(select razon_social from empresa (nolock) ) Empresa,
	(select subtota_fact from factura F (nolock) where F.codi_fact=G.codi_fact) SubTotal,
	(select igv_fact from factura F (nolock) where F.codi_fact=G.codi_fact) IGV,
	(select tota_fact from factura F (nolock) where F.codi_fact=G.codi_fact) Total,
	(select valor_igv from factura F (nolock) where F.codi_fact=G.codi_fact) ValorIGV,
	(select codi_mone from factura F (nolock) where F.codi_fact=G.codi_fact) codi_mone
FROM GUIA_TRANSPORTISTA   G (nolock) 
join guia_transportista_detalle D (nolock)
on G.id_guia=D.id_guia
where codi_Fact=@Fact
GO
