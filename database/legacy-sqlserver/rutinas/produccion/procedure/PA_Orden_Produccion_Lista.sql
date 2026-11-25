CREATE PROCEDURE [dbo].[PA_Orden_Produccion_Lista]
	@f1 [smalldatetime],
	@f2 [smalldatetime]
WITH EXECUTE AS CALLER
AS
Select 	OP.Codi_Orde_Produc, 
		OP.Nro_Orde_Produc, 
		OP.fecha_Orde_Produc,
		(Case 
			when OP.tipo_pers = 'J' 
			then   CP.DENOMINACION 
			else   OP.cliente end  ) as DENOMINACION,
		OP.descripcion,
		OP.Cantidad,
		OP.fecha_entrega,
		OP.nro_oc_clie,
		OP.estado,
		OP.codi_clie,
		OP.nro_docu,
		OP.cliente,
		OP.direccion,
		OP.NroOrdeFisico

	From 	Orden_Produccion OP 
				left  join Cliente_Proveedor 	CP 	on CP.codi_clie_prov 	= OP.Codi_Clie
	Where cast(convert(char(10),OP.fecha_Orde_Produc,103) as smalldatetime)	 between @f1 and @f2
GO
