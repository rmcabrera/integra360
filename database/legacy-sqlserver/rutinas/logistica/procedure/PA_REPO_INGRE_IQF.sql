CREATE PROCEDURE [dbo].[PA_REPO_INGRE_IQF]
	@mes [numeric](18, 0),
	@anio [numeric](18, 0)
WITH EXECUTE AS CALLER
AS
Select cast(ka.fecha as smalldatetime) as Fecha,
       ka.codi_tipo_docu as docu_ingr,
     ('Mmpp-Aux' + 
	cast( 
		(Select nro_Ingr from nota_ingreso_aceite where codi_ingr=ka.codi_transa and codi_alma = ka.codi_alma)  
		as varchar(10)
	     ) 
      ) as nro_Ingre,
       (Select desc_prod from productos where codi_prod = ka.codi_prod) as IQF,
       (Select desc_prod from productos where codi_prod = ka.codi_prod) as IQF_comercial,
	ka.concen_iqf as concen,
	ka.cantidad as canti,
	ka.codi_unid_medi as unid_medi,
	ka.num_enva as num_enva,
	ka.codi_tipo_enva as tipo_enva,
	(Select Denominacion from cliente_proveedor where codi_clie_prov in (select codi_clie_prov from nota_ingreso_aceite where codi_ingr = ka.codi_transa and codi_alma = ka.codi_alma )) as Denomina,
	(Select nro_certificado from cliente_proveedor where codi_clie_prov  in (select codi_clie_prov from nota_ingreso_aceite where codi_ingr=ka.codi_transa and codi_alma = ka.codi_alma )) as nro_certi,
	ka.exceso as ex,
	ka.faltante as fal,
	ka.Observaciones as obser
from kardex_almacenes ka inner join Productos p on p.codi_prod = ka.codi_prod
Where month(ka.fecha)= @MES AND year(ka.fecha)  = @ANIO  and	p.iqf = 1

UNION

Select (Select cast(FECH_NOTA_INGR as smalldatetime) From Nota_Ingreso where CODI_NOTA_INGR = dni.CODI_NOTA_INGR) as Fecha,
       (Select CODI_TIPO_DOCU  			     From Nota_Ingreso where CODI_NOTA_INGR = dni.CODI_NOTA_INGR ) as docu_ingr,
       ( 'Sum-Mat:' +  
	cast( 
	      (Select NRO_NOTA_INGR From Nota_Ingreso where CODI_NOTA_INGR = dni.CODI_NOTA_INGR) as varchar(10) 
	    )
        )  as nro_Ingre,
       (Select desc_prod 			     from productos    where codi_prod = dni.codi_prod) as IQF,
       (Select desc_prod 			     from productos    where codi_prod = dni.codi_prod) as IQF_comercial,
	dni.concen_iqf	as concen,
	dni.cantidad	as canti,
       (Select codi_unid_medi 			     from productos    where codi_prod = dni.codi_prod) as unid_medi,
	dni.num_enva as num_enva,
	dni.codi_tipo_enva as tipo_enva,
	(Select Denominacion from cliente_proveedor where codi_clie_prov = (select codi_clie_prov from nota_ingreso where CODI_NOTA_INGR = dni.CODI_NOTA_INGR))as Denomina,
	(Select nro_certificado from cliente_proveedor where codi_clie_prov = (select codi_clie_prov from nota_ingreso where CODI_NOTA_INGR = dni.CODI_NOTA_INGR))as nro_certi,
	dni.exceso as ex,
	dni.faltante as fal,
	dni.Observaciones as obser 
From nota_ingreso ni inner join detalle_nota_ingreso dni  on dni.codi_nota_ingr = ni.codi_nota_ingr
		     inner join Productos p 		  on p.codi_prod = dni.codi_prod
Where month(ni.fech_nota_ingr) = @mes and year (ni.fech_nota_ingr) = @anio  And p.iqf = 1
GO
