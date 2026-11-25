CREATE PROCEDURE [dbo].[PA_VENTAS_SIN_CON_PROVISIONADAS]
	@TIPO [char](1),
	@FEC1 [datetime],
	@FEC2 [datetime]
WITH EXECUTE AS CALLER
AS
BEGIN


IF @TIPO='C' ---CONTABILIZADAS
	begin
		SELECT FACTURA.Codi_Fact, FACTURA.codi_tipo_docu ,TIPO_DOCUMENTO.desc_tipo_docu,
		 FACTURA.Ser_Fact, FACTURA.Nro_Fact, FACTURA.Fech_Fact,
		 FACTURA.codi_clie_prov, MONEDAS.SIMBOLO,FACTURA.ESTADO
		 
		FROM FACTURA 
			inner join CLIENTE_PROVEEDOR  	on CLIENTE_PROVEEDOR.CODI_CLIE_PROV 	= FACTURA.Codi_Clie_prov
			inner join MONEDAS			on MONEDAS.CODI_MONE 			= FACTURA.CODI_MONE
			inner join TIPO_DOCUMENTO		on TIPO_DOCUMENTO.codi_tipo_docu		= FACTURA.codi_tipo_docu
			
		 WHERE ( FACTURA.FECH_FACT BETWEEN @FEC1 AND @FEC2) AND  ( FACTURA.contabilizado = 0 or FACTURA.contabilizado is null ) --AND FACTURA.ESTADO<> 'E' 
	end

else

	begin
		SELECT FACTURA.Codi_Fact, FACTURA.codi_tipo_docu ,TIPO_DOCUMENTO.desc_tipo_docu,
		 FACTURA.Ser_Fact, FACTURA.Nro_Fact, FACTURA.Fech_Fact,
		 FACTURA.codi_clie_prov, MONEDAS.SIMBOLO,FACTURA.ESTADO
		 
		FROM FACTURA 
			inner join CLIENTE_PROVEEDOR  	on CLIENTE_PROVEEDOR.CODI_CLIE_PROV 	= FACTURA.Codi_Clie_prov
			inner join MONEDAS			on MONEDAS.CODI_MONE 			= FACTURA.CODI_MONE
			inner join TIPO_DOCUMENTO		on TIPO_DOCUMENTO.codi_tipo_docu		= FACTURA.codi_tipo_docu
			
		 WHERE ( FACTURA.FECH_FACT BETWEEN @FEC1 AND @FEC2) AND  ( FACTURA.contabilizado = 0 or FACTURA.contabilizado is null ) --AND FACTURA.ESTADO<> 'E' 
	end

END
GO
