CREATE PROCEDURE [dbo].[PA_Guia_Lista]
	@f1 [smalldatetime],
	@f2 [smalldatetime]
WITH EXECUTE AS CALLER
AS
Select  G.codi_guia,
	G.Serie_Guia,
	G.Nro_Guia,
	G.Fecha_Guia,
	D.Desc_Domi,
	G.PuntoLlegada,
  	(Case 
		when G.tipo_pers = 'J' 
		then CP.ruc
		else CN.nro_docu end  ) as RUC_g,
	 (Case 
		when G.tipo_pers = 'J' 
		then CP.DENOMINACION 
		else CN.apellidos + ' ' + CN.nombres end ) as DENOMINACION_g,
	UT.plac_unid_tran	,
	(select denominacion from cliente_proveedor where codi_clie_prov  = G.Codi_Prov_Trans) as deno_trans
From GUIA G
		LEFT  	join DOMICILIO	D  			on D.codi_domi  	= g.codi_domi
		left	join CLIENTE_PROVEEDOR CP		on CP.codi_clie_prov 	= g.codi_clie_prov
		LEFT 	join UNIDAD_TRANSPORTE UT		on UT.Codi_Unid_Tran	= g.Codi_Unid_Tran
		left 	join CLIENTE_NATURAL	CN		on CN.id_clie_natu	= g.id_clie_natu
WHERE 	G.Fecha_guia between @f1 and @f2
GO
