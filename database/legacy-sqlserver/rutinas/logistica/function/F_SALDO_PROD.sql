CREATE FUNCTION [dbo].[F_SALDO_PROD](@prod [char](8), @fec [datetime])
RETURNS [numeric](12, 3) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @i numeric(12,3)
	declare @e numeric(12,3)
	declare @rt numeric(12,3)

	select @i=sum(ingresos), @e=sum(egresos) from
	(select productos.codi_prod, productos.desc_prod,nro_docu_cont as  DCMTO ,nro_docu as Guia, fech_nota_ingr as FEcha, denominacion as Concepto, 
			cantidad as Ingresos, 0 as Egresos, desc_unid_medi
		from nota_ingreso, detalle_nota_ingreso, cliente_proveedor, PRODUCTOS , unidad_medida
		where nota_ingreso.codi_nota_ingr= detalle_nota_ingreso.codi_nota_ingr 
			and cliente_proveedor.codi_clie_prov=nota_ingreso.codi_clie_prov AND PRODUCTOS.CODI_PROD=detalle_nota_ingreso.codi_prod
			and unidad_medida.codi_unid_medi=productos.codi_unid_medi 
	union
	select productos.codi_prod, productos.desc_prod,right(docu_sali_mate.codi_docu_sali,6) as DCMTO, nro_docu_sali as GUIa, fech_emis as Fecha, desc_unid_oper,
		 0, cantidad as Egresos  ,desc_unid_medi
		from docu_sali_mate, detalle_docu_sali , unid_oper, productos, unidad_medida
			where docu_sali_mate.codi_docu_sali= detalle_docu_sali.codi_docu_sali and 
			unid_oper.codi_unid_oper=docu_sali_mate.codi_unid_oper_rece and productos.codi_prod=detalle_docu_sali.codi_prod
			and unidad_medida.codi_unid_medi=productos.codi_unid_medi) as SL 
		where CAST(convert(char(10),fecha,103) AS smalldatetime) <= @fec and codi_prod=@prod  group by codi_prod
	if (@i is null) set @i=0
	if (@e is null) set @e=0
	set @rt=@i - @e

	return @rt
END
GO
