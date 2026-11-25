CREATE PROCEDURE [dbo].[PA_Factura_Lista]
	@f1 [smalldatetime],
	@f2 [smalldatetime],
	@tipo [char](1)
WITH EXECUTE AS CALLER
AS
if @tipo  = 'C'
  begin 
	  SELECT FACTURAS.Codi_Fact,   
	         	   FACTURAS.Serie_Fact,   
	                FACTURAS.Nro_Fact,   
	         	   FACTURAS.Fecha_Fact,   
		  (Case 
			when facturas.tipo_pers = 'J' 
			then  Cliente_proveedor.ruc
			else   nro_docu       		end  ) as ruc,
		  (Case 
			when facturas.tipo_pers = 'J' 
			then Cliente_proveedor.DENOMINACION 
			else cliente		 	end ) as DENOMINACION,
		 MONEDAS.SIMBOLO,
		 FACTURAS.ESTADO,
		 FACTURAS.codi_clie,
		 TIPO_DOCUMENTO.desc_tipo_docu,
		 FACTURAS.codi_tipo_docu,
		 FACTURAS.tipo_pers,
		 (Select top 1 descripcion from facturas_detalle where codi_fact = facturas.codi_fact) item
	    FROM FACTURAS 
				inner join CLIENTE_PROVEEDOR  	on CLIENTE_PROVEEDOR.CODI_CLIE_PROV 	= FACTURAS.Codi_Clie
				inner join MONEDAS			on MONEDAS.CODI_MONE 			= FACTURAS.CODI_MONE
				inner join TIPO_DOCUMENTO		on TIPO_DOCUMENTO.codi_tipo_docu		= FACTURAS.codi_tipo_docu
	
	  WHERE  FACTURAS.Fecha_Fact between @f1 and @f2 AND FACTURAS.ESTADO<> 'E' 
end
if @tipo  = 'G'
  begin
	  SELECT FACTURAS.Codi_Fact,   
	         	   FACTURAS.Serie_Fact,   
	                FACTURAS.Nro_Fact,   
	         	   FACTURAS.Fecha_Fact,   
		  (Case 
			when facturas.tipo_pers = 'J' 
			then  Cliente_proveedor.ruc
			else   nro_docu       		end  ) as ruc,
	         	  (Case 
			when facturas.tipo_pers = 'J' 
			then Cliente_proveedor.DENOMINACION 
			else cliente		 	end ) as DENOMINACION,
		 MONEDAS.SIMBOLO,
		 FACTURAS.ESTADO,
		 FACTURAS.codi_clie,
		 TIPO_DOCUMENTO.desc_tipo_docu,
		 FACTURAS.codi_tipo_docu,
		 FACTURAS.tipo_pers,
		 (Select top 1 descripcion from facturas_detalle where codi_fact = facturas.codi_fact) item
	    FROM FACTURAS 
				inner join CLIENTE_PROVEEDOR  	on CLIENTE_PROVEEDOR.CODI_CLIE_PROV 	= FACTURAS.Codi_Clie
				inner join MONEDAS			on MONEDAS.CODI_MONE 			= FACTURAS.CODI_MONE
				inner join TIPO_DOCUMENTO		on TIPO_DOCUMENTO.codi_tipo_docu		= FACTURAS.codi_tipo_docu	
	  WHERE  FACTURAS.Fecha_Fact between @f1 and @f2 and FACTURAS.entrega = 1 and FACTURAS.estado = 'P'
 end

if @tipo  = 'P'
  begin
	  SELECT FACTURAS.Codi_Fact,   
	         	   FACTURAS.Serie_Fact,   
	                FACTURAS.Nro_Fact,   
	         	   FACTURAS.Fecha_Fact,   
		  (Case 
			when facturas.tipo_pers = 'J' 
			then  Cliente_proveedor.ruc
			else   nro_docu       		end  ) as ruc,
		 (Case 
			when facturas.tipo_pers = 'J' 
			then Cliente_proveedor.DENOMINACION 
			else cliente		 	end ) as DENOMINACION,
		 MONEDAS.SIMBOLO,
		 FACTURAS.ESTADO,
		 FACTURAS.codi_clie,
		 TIPO_DOCUMENTO.desc_tipo_docu,
		 FACTURAS.codi_tipo_docu,
		 FACTURAS.tipo_pers,
		 (Select top 1 descripcion from facturas_detalle where codi_fact = facturas.codi_fact) item
	    FROM FACTURAS 
				inner join CLIENTE_PROVEEDOR  	on CLIENTE_PROVEEDOR.CODI_CLIE_PROV 	= FACTURAS.Codi_Clie
				inner join MONEDAS			on MONEDAS.CODI_MONE 			= FACTURAS.CODI_MONE
				inner join TIPO_DOCUMENTO		on TIPO_DOCUMENTO.codi_tipo_docu		= FACTURAS.codi_tipo_docu	
	  WHERE  FACTURAS.Fecha_Fact between @f1 and @f2  and ( FACTURAS.Provisionada = 0 or FACTURAS.Provisionada is null ) AND FACTURAS.ESTADO<> 'E' 
 end
GO
