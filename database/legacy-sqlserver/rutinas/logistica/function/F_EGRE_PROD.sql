CREATE FUNCTION [dbo].[F_EGRE_PROD](@prod [char](8), @fec [smalldatetime])
RETURNS [numeric](12, 3) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @e numeric(12,3)
	declare @rt numeric(12,3)

	select @e=sum(egresos) from
	(select productos.codi_prod, productos.desc_prod,right(docu_sali_mate.codi_docu_sali,6) as DCMTO, nro_docu_sali as GUIa, fech_emis as Fecha, desc_unid_oper,
		 0 as Ingresos, cantidad as Egresos  ,desc_unid_medi
		from docu_sali_mate, detalle_docu_sali , unid_oper, productos, unidad_medida
			where docu_sali_mate.codi_docu_sali= detalle_docu_sali.codi_docu_sali and 
			unid_oper.codi_unid_oper=*docu_sali_mate.codi_unid_oper_rece and productos.codi_prod=detalle_docu_sali.codi_prod
			and unidad_medida.codi_unid_medi=productos.codi_unid_medi) as SL 
		where CAST(convert(char(10),fecha,103) AS smalldatetime) <= @fec and codi_prod=@prod  group by codi_prod
	if (@e is null) set @e=0
	set @rt= @e

	return @rt
END
GO
