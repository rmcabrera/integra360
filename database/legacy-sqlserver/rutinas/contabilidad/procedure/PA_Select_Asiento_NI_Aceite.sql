CREATE PROCEDURE [dbo].[PA_Select_Asiento_NI_Aceite]
	@mes [char](2),
	@anio [char](4),
	@compr [char](10)
WITH EXECUTE AS CALLER
AS
SELECT   Movi_Contables.Codi_Contable,   
         Movi_Contables.Subdia,   
         Movi_Contables.Compr,   
         Movi_Contables.Codi_Mone,   
         Movi_Contables.Fecha,   
         Movi_Contables.Nro_Cuen,   
         Movi_Contables.Nro_Sub_Cuen,   
         Movi_Contables.Codi_Clie_Prov,   
         Movi_Contables.Serie,   
         Movi_Contables.Nro_Docu,   
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
         Movi_Contables.fecha_spot,   
         Movi_Contables.num_spot ,
         Movi_Contables.codi_nota_ingr
    FROM Movi_Contables
    WHERE Movi_Contables.anio=@anio and 
	  Movi_Contables.mes =@mes  and 
	  Movi_Contables.subdia='C' and
	  Movi_Contables.compr =@compr
GO
