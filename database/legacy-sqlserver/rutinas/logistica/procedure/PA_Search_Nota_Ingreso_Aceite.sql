CREATE PROCEDURE [dbo].[PA_Search_Nota_Ingreso_Aceite]
	@conta [bit]
WITH EXECUTE AS CALLER
AS
Select  codi_ingr, -- campo para recuperar
		codi_alma, -- campo para recuperar
		(Select desc_alma from almacen where codi_alma = ni.codi_alma) as Alma,
		nro_ingr , 
		fecha, 
		(select denominacion from cliente_proveedor where codi_clie_prov= ni.codi_clie_prov) as clieprov,
		(serfact  + '-'+  nrofact )  as  factu,
		total,
		codi_clie_prov,
		serfact,
		nrofact , codi_tipo_docu , subt , igv , codi_mone,
		fecha_fact
	
	From Nota_Ingreso_aceite ni 
	where ni.Contabilizado =@conta	and serfact is not null and nrofact is not null and fecha_fact is not null



/*
if @conta=0

	begin 
	Select  codi_ingr, -- campo para recuperar
		codi_alma, -- campo para recuperar
		(Select desc_alma from almacen where codi_alma = ni.codi_alma) as Alma,
		nro_ingr , 
		fecha, 
		(select denominacion from cliente_proveedor where codi_clie_prov= ni.codi_clie_prov) as clieprov,
		(serie_fact  + '-'+  nro_fact )  as  factu,
		total,
		codi_clie_prov,
		serie_fact,
		nro_fact
	
	From Nota_Ingreso_aceite ni 
	where ni.Contabilizado =0

	end

else

begin
	Select  codi_ingr, -- campo para recuperar
		codi_alma, -- campo para recuperar
		(Select desc_alma from almacen where codi_alma = ni.codi_alma) as Alma,
		nro_ingr , 
		fecha, 
		(select denominacion from cliente_proveedor where codi_clie_prov= ni.codi_clie_prov) as clieprov,
		(serie_fact  + '-'+  nro_fact )  as  factu,
		total,
		codi_clie_prov,
		serie_fact,
		nro_fact
	   
	From Nota_Ingreso_aceite ni 
	where ni.Contabilizado = 1

end


*/
GO
