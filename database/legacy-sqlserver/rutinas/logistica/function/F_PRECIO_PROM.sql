CREATE FUNCTION [dbo].[F_PRECIO_PROM](@prod [char](8), @f1 [datetime], @f2 [datetime])
RETURNS [numeric](12, 4) WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @aux char(8)
	Declare @i int
	Declare @f int
	declare	@saldo numeric(12,4)
	declare	@promed numeric(12,4)
	declare	@saldoval numeric(12,4)
	set @aux=''
	
	Declare C1 cursor for 
	select 2 as Ind,productos.codi_prod, codi_sub_fami_prod,productos.desc_prod,nro_docu_cont as  DCMTO ,nro_docu as Guia, fech_nota_ingr as FEcha, denominacion as Concepto, 
		cantidad as Ingresos, 0 as Egresos, simb_unid_medi as desc_unid_medi, 
		dbo.F_PRECIO_UNIT (nota_ingreso.codi_nota_ingr, detalle_nota_ingreso.nro_item_nota_ingr) as PU, 0.0000 as Prom, 
		dbo.F_PRECIO_UNIT (nota_ingreso.codi_nota_ingr, detalle_nota_ingreso.nro_item_nota_ingr)*cantidad as I,0.0000 as E,
		0.00 as SaldoCan, 0.0000 as SaldoVal
	from nota_ingreso, detalle_nota_ingreso, cliente_proveedor, PRODUCTOS , unidad_medida
	where nota_ingreso.codi_nota_ingr= detalle_nota_ingreso.codi_nota_ingr 
		and cliente_proveedor.codi_clie_prov=nota_ingreso.codi_clie_prov AND PRODUCTOS.CODI_PROD=detalle_nota_ingreso.codi_prod
		and unidad_medida.codi_unid_medi=productos.codi_unid_medi and PRODUCTOS.CODI_PROD=@prod
	union
	select 2,productos.codi_prod, codi_sub_fami_prod,productos.desc_prod,right(docu_sali_mate.codi_docu_sali,6) as DCMTO, nro_docu_sali as GUIa, fech_emis as Fecha, desc_unid_oper,
		 0, cantidad as Egresos   , simb_unid_medi, 0, detalle_docu_sali.prec_prom,0, detalle_docu_sali.prec_prom*cantidad,0,0
		from docu_sali_mate, detalle_docu_sali , unid_oper, productos, unidad_medida
			where docu_sali_mate.codi_docu_sali= detalle_docu_sali.codi_docu_sali and 
			unid_oper.codi_unid_oper=docu_sali_mate.codi_unid_oper_rece and productos.codi_prod=detalle_docu_sali.codi_prod
			and unidad_medida.codi_unid_medi=productos.codi_unid_medi and PRODUCTOS.CODI_PROD=@prod	
	
	
--for i=1 to f
--	if aux<>dw_p.object.codi_prod[i] then
--		saldo=dw_p.object.ingresos[i] - dw_p.object.egresos[i]
--		dw_p.object.saldocan[i]=saldo
--		dw_p.object.i[i]= dw_p.object.ingresos[i]*dw_p.object.pu[i]
--		dw_p.object.e[i]= dw_p.object.egresos[i]*dw_p.object.prom[i]		
--		saldoval=dw_p.object.i[i] - dw_p.object.e[i]
--		if dw_p.object.pu[i]>0 then
--			dw_p.object.saldoval[i]=saldoval
--			if saldo<>0 then promed=saldoval/saldo
--		else
--			promed=0
--		end if
--		dw_p.object.prom[i]=promed
--	else
--		saldo=saldo + dw_p.object.ingresos[i] - dw_p.object.egresos[i]
--		dw_p.object.saldocan[i]=saldo

--		dw_p.object.i[i]= dw_p.object.ingresos[i]*dw_p.object.pu[i]
--		if dw_p.object.pu[i]>0 then
--			saldoval=saldoval + dw_p.object.i[i] - dw_p.object.e[i]				
--			if saldo<>0 then promed=saldoval/saldo
--		else
--			promed=dw_p.object.prom[i - 1]
--			dw_p.object.e[i]= dw_p.object.egresos[i]*promed									
--			saldoval=saldoval +dw_p.object.i[i] - dw_p.object.e[i]				
--		end if
--		dw_p.object.prom[i]=promed
	--	dw_p.object.saldoval[i]=saldoval
--	end if
--	aux=dw_p.object.codi_prod[i]
--next

	return @promed
END
GO
