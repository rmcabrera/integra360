CREATE PROCEDURE [dbo].[usp_compras_SUCUR_LABO_PRODUC_all]
	@TIPO [int],
	@tipo_pago [int],
	@ANIO [int],
	@CODI_CLIE_PROV [char](5),
	@CODI_ALMA [char](2)
WITH EXECUTE AS CALLER
AS
--declare @TIPO INT , @tipo_pago int , @ANIO INT, @CODI_CLIE_PROV CHAR(5) , @CODI_ALMA CHAR(2)  
--select @TIPO =1 , @tipo_pago = 0, @ANIO =2010, @CODI_CLIE_PROV ='04565', @CODI_ALMA ='00'
set nocount on

declare @alma table (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock)
END
ELSE
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock) where codi_alma = @codi_alma
END

if @tipo = 1
begin -- SUCURSAL POR LABORATORIO  
	select case when @codi_alma='00' then '' else suc.nemo_alma end nemo_alma,
	    cp.codi_clie_prov, cp.denominacion as laboratorio, prod.desc_prod , pres.desc_pres ,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '1' then fd.cantidad else 0 end) as cant_enero,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '2' then fd.cantidad else 0 end) as cant_febrero,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '3' then fd.cantidad else 0 end) as cant_marzo,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '4' then fd.cantidad else 0 end) as cant_abril,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '5' then fd.cantidad else 0 end) as cant_mayo,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '6' then fd.cantidad else 0 end) as cant_junio,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '7' then fd.cantidad else 0 end) as cant_julio,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '8' then fd.cantidad else 0 end) as cant_agosto,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '9' then fd.cantidad else 0 end) as cant_setiembre,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '10' then fd.cantidad else 0 end) as cant_octubre,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '11' then fd.cantidad else 0 end) as cant_noviembre,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '12' then fd.cantidad else 0 end) as cant_diciembre ,
	    ---valor venta--------------------	
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '1' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_ENERO ,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '2' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_FEBRERO,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '3' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end)as VALO_VENTA_MAR,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '4' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_ABRIL,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '5' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_MAYO,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '6' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_JUNIO,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '7' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_JULIO,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '8' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_AGOS,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '9' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_SET,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '10' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad * FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_OCT,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '11' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad * FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_NOV,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '12' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad * FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_DIC
	    ---fin de valor venta ----------
	   from almacen as suc (nolock) inner join nota_ingreso as fac (nolock) on suc.codi_alma=fac.codi_alma
		inner join detalle_nota_ingreso	as fd (nolock) on fac.codi_nota_ingr = fd.codi_nota_ingr
		inner join almacen_producto 	as ap (nolock) on (fd.codi_alma=ap.codi_alma and fd.codi_prod=ap.codi_prod)
		inner join productos		as prod (nolock) on ap.codi_prod = prod.codi_prod
		inner join presentacion 	as pres (nolock) on prod.cod_pres=pres.cod_pres
		inner join cliente_proveedor 	as cp (nolock) on fac.codi_clie_prov = cp.codi_clie_prov
	    where suc.codi_alma collate sql_latin1_general_cp1_ci_as in (select codi_alma from @alma)  and 
		year(isnull(fech_reg_fact, fech_guia_remi))=@anio   and  
		cp.codi_clie_prov=@codi_clie_prov and tipo_nota_ingr='01'
	 group by   case when @codi_alma='00' then '' else suc.nemo_alma end  , 
			cp.codi_clie_prov, cp.denominacion  , prod.desc_prod , pres.desc_pres
end 


ELSE if @tipo = 2
begin -- SOLO POR SUCURSAL 
	select case when @codi_alma='00' then '' else suc.nemo_alma end nemo_alma,
	    cp.codi_clie_prov, cp.denominacion as laboratorio, prod.desc_prod , pres.desc_pres ,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '1' then fd.cantidad else 0 end) as cant_enero,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '2' then fd.cantidad else 0 end) as cant_febrero,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '3' then fd.cantidad else 0 end) as cant_marzo,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '4' then fd.cantidad else 0 end) as cant_abril,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '5' then fd.cantidad else 0 end) as cant_mayo,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '6' then fd.cantidad else 0 end) as cant_junio,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '7' then fd.cantidad else 0 end) as cant_julio,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '8' then fd.cantidad else 0 end) as cant_agosto,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '9' then fd.cantidad else 0 end) as cant_setiembre,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '10' then fd.cantidad else 0 end) as cant_octubre,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '11' then fd.cantidad else 0 end) as cant_noviembre,
	    sum(case month(isnull(fech_reg_fact, fech_guia_remi)) when '12' then fd.cantidad else 0 end) as cant_diciembre ,
	    ---valor venta--------------------	
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '1' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * (FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   else 0 end) as VALO_VENTA_ENERO ,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '2' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end else 0 end) as VALO_VENTA_FEBRERO,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '3' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end else 0 end) as VALO_VENTA_MAR,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '4' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end else 0 end) as VALO_VENTA_ABRIL,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '5' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end else 0 end) as VALO_VENTA_MAYO,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '6' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end else 0 end) as VALO_VENTA_JUNIO,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '7' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end else 0 end) as VALO_VENTA_JULIO,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '8' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end else 0 end) as VALO_VENTA_AGOS,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '9' then  (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end else 0 end) as VALO_VENTA_SET,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '10' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad * FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end else 0 end) as VALO_VENTA_OCT,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '11' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad * FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end else 0 end) as VALO_VENTA_NOV,
	    SUM(case month(isnull(fech_reg_fact, fech_guia_remi)) when '12' then (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad * FD.prec_unit )* case when afecto=0 then 1 else case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end else 0 end) as VALO_VENTA_DIC
	    ---fin de valor venta ----------
	   from almacen as suc (nolock) inner join nota_ingreso as fac (nolock) on suc.codi_alma=fac.codi_alma
		inner join detalle_nota_ingreso	as fd (nolock) on fac.codi_nota_ingr = fd.codi_nota_ingr
		inner join almacen_producto 	as ap (nolock) on (fd.codi_alma=ap.codi_alma and fd.codi_prod=ap.codi_prod)
		inner join productos		as prod (nolock) on ap.codi_prod = prod.codi_prod
		inner join presentacion 	as pres (nolock) on prod.cod_pres=pres.cod_pres
		inner join cliente_proveedor 	as cp (nolock) on fac.codi_clie_prov = cp.codi_clie_prov
	    where suc.codi_alma collate sql_latin1_general_cp1_ci_as in (select codi_alma from @alma)  and 
		year(isnull(fech_reg_fact, fech_guia_remi))=@anio   and  
		 tipo_nota_ingr='01'
	 group by   case when @codi_alma='00' then '' else suc.nemo_alma end  , 
			cp.codi_clie_prov, cp.denominacion  , prod.desc_prod , pres.desc_pres

end
GO
