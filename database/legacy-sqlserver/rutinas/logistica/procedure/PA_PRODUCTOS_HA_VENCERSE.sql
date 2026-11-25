CREATE PROCEDURE [dbo].[PA_PRODUCTOS_HA_VENCERSE]
	@tipo [char](1),
	@codi_alma [char](2),
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
begin

if @tipo='A'
	begin
		SELECT A.nemo_alma, P.CODI_PROD,   P.DESC_PROD , Pre.desc_pres, SF.DESC_SUB_FAMI_PROD  , CP.denominacion ,PAL.lote, PAL.fec_vence , PAL.stock
		FROM Productos P inner join Almacen_Producto AP on P.CODI_PROD = AP.Codi_Prod  
			inner join almacen A on AP.codi_alma=A.codi_alma
			left join cliente_proveedor CP on P.codi_clie_prov = CP.codi_clie_prov
			inner join Presentacion PRE on P.cod_pres  = PRE.cod_pres
			inner join SUB_FAMILIA_PRODUCTO as SF on SF.CODI_SUB_FAMI_PROD = P.CODI_SUB_FAMI_PROD 	
			inner join PRODUCTO_ALMACEN_LOTE PAL on (AP.codi_prod=PAL.codi_prod and AP.codi_alma=PAL.codi_alma)
		
		where  A.codi_alma =@codi_alma and   ( PAL.fec_vence between  @fec1 and @fec2 )
	end 

else
   ---De todos los almacenes
	begin
		SELECT A.nemo_alma, P.CODI_PROD,   P.DESC_PROD , Pre.desc_pres, SF.DESC_SUB_FAMI_PROD  , CP.denominacion ,PAL.lote, PAL.fec_vence , PAL.stock
		FROM Productos P inner join Almacen_Producto AP on P.CODI_PROD = AP.Codi_Prod  
			inner join almacen A on AP.codi_alma=A.codi_alma
			left join cliente_proveedor CP on P.codi_clie_prov = CP.codi_clie_prov
			inner join Presentacion PRE on P.cod_pres  = PRE.cod_pres
			inner join SUB_FAMILIA_PRODUCTO as SF on SF.CODI_SUB_FAMI_PROD = P.CODI_SUB_FAMI_PROD 	
			inner join PRODUCTO_ALMACEN_LOTE PAL on (AP.codi_prod=PAL.codi_prod and AP.codi_alma=PAL.codi_alma)
		
		where   ( PAL.fec_vence between  @fec1 and @fec2 )
	end

end
GO
