CREATE FUNCTION [dbo].[F_INGR_PROD](@prod [char](8), @fec [datetime])
RETURNS [numeric](12, 3) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @i numeric(12,3)
	
	declare @rt numeric(12,3)

	select @i=sum(ingresos) from
	(select productos.codi_prod, productos.desc_prod,nro_docu_cont as  DCMTO ,nro_docu as Guia, fech_nota_ingr as FEcha, denominacion as Concepto, 
			cantidad as Ingresos, 0 as Egresos, desc_unid_medi
		from nota_ingreso, detalle_nota_ingreso, cliente_proveedor, PRODUCTOS , unidad_medida
		where nota_ingreso.codi_nota_ingr= detalle_nota_ingreso.codi_nota_ingr 
			and cliente_proveedor.codi_clie_prov=nota_ingreso.codi_clie_prov AND PRODUCTOS.CODI_PROD=detalle_nota_ingreso.codi_prod
			and unidad_medida.codi_unid_medi=productos.codi_unid_medi ) as SL 
		where CAST(convert(char(10),fecha,103) AS smalldatetime) <= @fec and codi_prod=@prod  group by codi_prod
	if (@i is null) set @i=0
	
	set @rt=@i 
	return @rt
END
GO
