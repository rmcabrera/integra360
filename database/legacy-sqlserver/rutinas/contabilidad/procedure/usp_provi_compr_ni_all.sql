CREATE PROCEDURE [dbo].[usp_provi_compr_ni_all]
	@rec [char](10),
	@alma [char](2),
	@Codi_Clie_Prov [char](5)
WITH EXECUTE AS CALLER
AS
--declare @rec char(10), @alma char(2), @Codi_Clie_Prov char(5) 
--select @rec='PRE003454', @alma='01', @Codi_Clie_Prov ='05415'

set nocount on

declare @Tx table ( codi_contable char(10), subdia char(1) null, compr varchar(10) null, codi_mone char(2) null,
			fecha datetime null, nro_cuen char(7) null, nro_sub_cuen char(7) null, codi_clie_prov char(5) null,
			serie varchar(5) null, nro_docu varchar(10) null, codi_tipo_docu char(4) null, registro varchar(10) null,
			codi_unid_oper char(5) null, glosa varchar(200) null, cargo_abono char(1) null, importe numeric(12,2) null,
			igv numeric(12,2) null, otros numeric(12,2) null, total numeric(12,2) null, importe_d numeric(12,2) null,
			igv_d numeric(12,2) null, otros_d numeric(12,2) null, total_d numeric(12,2) null, mes char(2)null,
			anio char(4)null, codi_vouc char(10) null, tipo_cambio numeric(12,4) null, tipo_cambio_2 numeric(12,4) null,
			fecha_spot datetime null,  num_spot varchar(10) null, codi_nota_ingr char(10) null, denominacion varchar(100) null,
			tipo_venta char(1) null, fecha_venc datetime null, codi_alma char(2) null, id_flujo numeric(12,4) null, id_tipo_flujo numeric(12,4) null)

insert @Tx
 SELECT Movi_Contables.Codi_Contable,   
         Movi_Contables.Subdia,   
         Movi_Contables.Compr,   
         Movi_Contables.Codi_Mone,   
         Movi_Contables.Fecha,   
         Movi_Contables.Nro_Cuen,   
         Movi_Contables.Nro_Sub_Cuen,   
         Movi_Contables.Codi_Clie_Prov,   
         Movi_Contables.Serie,   
         Nro_Docu,    
         Movi_Contables.Codi_Tipo_Docu,   
         Movi_Contables.Registro,   
         Movi_Contables.Codi_Unid_Oper,   
         Movi_Contables.Glosa,   
         Movi_Contables.Cargo_Abono,   
         Movi_Contables.Importe,   
         Movi_Contables.IGV,   
         Movi_Contables.Otros,   
         Movi_Contables.Total,   
         Movi_Contables.Importe_d,   
         Movi_Contables.IGV_d,   
         Movi_Contables.Otros_d,   
         Movi_Contables.Total_d,   
         Movi_Contables.Mes,   
         Movi_Contables.Anio,   
         Movi_Contables.Codi_Vouc,   
         Movi_Contables.Tipo_Cambio,   
         Movi_Contables.Tipo_Cambio_2,   
         Movi_Contables.fecha_spot,   
         Movi_Contables.num_spot ,
         Movi_Contables.codi_nota_ingr ,
		(select denominacion from cliente_proveedor   (nolock) where codi_clie_prov=movi_contables.codi_clie_prov) as denominacion,
		tipo_venta, fecha_venc, codi_alma, id_flujo, id_tipo_flujo
    FROM Movi_Contables  (nolock)
   WHERE isnull(codi_nota_ingr,'') = @rec and codi_clie_prov=@codi_clie_prov and codi_alma=@alma

--	WHERE ( Movi_Contables.Codi_Clie_Prov = @Codi_Clie_Prov ) 
--	AND ( Movi_Contables.Subdia in ('C','H') OR (Subdia='M' and isnull(codi_nota_ingr,'')=@rec)) AND codi_alma=@alma


select codi_contable , subdia , compr , codi_mone , fecha , nro_cuen , nro_sub_cuen , codi_clie_prov ,
	serie , nro_docu , codi_tipo_docu , registro ,	codi_unid_oper , glosa , cargo_abono , importe ,
	igv , otros , total , importe_d , igv_d , otros_d , total_d , mes , anio , codi_vouc , tipo_cambio , tipo_cambio_2 ,
	fecha_spot ,  num_spot , codi_nota_ingr , denominacion , tipo_venta, fecha_venc, codi_alma, id_flujo, id_tipo_flujo
from @TX 
--where nro_docu=@nro_doc
ORDER BY serie, nro_docu, codi_contable
GO
