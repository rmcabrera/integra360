CREATE FUNCTION [dbo].[uf_ulti_prec_costo](@prod [char](8), @alma [char](2))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
begin

	--declare @prod char(8), @alma char(2)
	--select @prod='00080387', @alma='00'

	declare @rt numeric(12,2)
	
	if @alma='00'
	begin
		set @rt = (select max(round( case when  codi_mone='01' then 
				(prec_costo * case when  cod_impuesto=3 then 1 else  (1 + dbo.f_igv(getdate())/100.00) end  ) 
		else 
				(prec_costo *  case when cod_impuesto=3 then 1 else (1 + dbo.f_igv(getdate())/100.00) end  )* tcambio 
		end, nro_decim_precio ) ) 
			
		from almacen_producto B(nolock)
		join productos P (nolock)
		on B.codi_prod=P.codi_prod
		where B.codi_prod=@prod and B.codi_alma in (select A.codi_alma from almacen A(nolock) where isnull(activo,'')='1')
		group by P.codi_prod)

	end
	else
	begin
		set @rt = (select max(round( case when  codi_mone='01' then 
				(prec_costo *  case when  cod_impuesto=3 then 1 else  (1 + dbo.f_igv(getdate())/100.00) end  ) 
		else 
				(prec_costo *   case when cod_impuesto=3 then 1 else (1 + dbo.f_igv(getdate())/100.00) end  )* tcambio 
		end, nro_decim_precio ) ) 
		
		from almacen_producto B(nolock)
		join productos P (nolock)
		on B.codi_prod=P.codi_prod
		where B.codi_prod=@prod and B.codi_alma=@alma and B.codi_alma in (select A.codi_alma from almacen A(nolock) where isnull(activo,'')='1')
		group by codi_alma, P.codi_prod)
	end
	
	return @rt
	
end
GO
