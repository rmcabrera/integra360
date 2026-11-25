CREATE PROCEDURE [dbo].[PA_Personal_Derecho_Hab_Exporta]
	@anio [int],
	@mes [int]
WITH EXECUTE AS CALLER
AS
set nocount on 
--mostramos los derechos de habientes de todo el personal que su fecha de ingreso sea menor o igual al periodo
--
if @mes=12 
begin
	set @mes=1 
	set @anio=@anio + 1
end
else
begin
	set @mes=@mes + 1 
end
----

SELECT 
	cast( (select td.Codi_Sunat from dbo.TIPO_DOCU_IDEN td (nolock) where td.Codi_Tipo_Docu_Iden=PERSONAL.Codi_Tipo_Docu_Iden
	and personal.codi_pers not in ('00000') ) as varchar(2)) + '|'+   
	PERSONAL.NRO_DOCU_IDEN + '|'+   

	cast( (select td.Codi_Sunat from dbo.TIPO_DOCU_IDEN td (nolock) where td.Codi_Tipo_Docu_Iden= DERECHO_HABIENTE.Codi_Tipo_Docu_Iden) as varchar(2)) + '|'+   

	DERECHO_HABIENTE.NRO_DOCU_IDEN  + '|'+   
		 
	DERECHO_HABIENTE.APEL_1 + '|'+
	DERECHO_HABIENTE.APEL_2 + '|'+   
	DERECHO_HABIENTE.NOMB_1 + ' ' +    isnull(DERECHO_HABIENTE.NOMB_2,'') + '|'+ 

	isnull(convert(varchar(10), DERECHO_HABIENTE.fech_naci,103),'') + '|'+
	isnull(Case when  DERECHO_HABIENTE.SEXO='F' then '2' else '1' end ,'') + '|'+

	isnull(cast(VINCULO_FAMILIAR.Codi_Vinc_Fami_Sunat as varchar(1)) ,'')+ '|'+   
	isnull(cast(DERECHO_HABIENTE.tipo_doc_acred_pater as varchar(1)),'') + '|'+   
	isnull(DERECHO_HABIENTE.nro_doc_acred_pater ,'') + '|'+   

	isnull(Case when  DERECHO_HABIENTE.SITUACION=1 then '10' else '11' end ,'') + '|'+
  
	isnull(convert(varchar(10), DERECHO_HABIENTE.fech_alta,103),'') + '|'+
            
	isnull(cast(MOTI_BAJA_DH.Codi_Moti_Baja_DH_Sunat as varchar(1)),'') + '|'+ 

	isnull(convert(varchar(10), DERECHO_HABIENTE.fech_baja,103),'') + '|'+
  
	isnull(cast(DERECHO_HABIENTE.nro_resolu_direct as varchar(20)) ,'') + '|'+   
	isnull(DERECHO_HABIENTE.DOMICILIO , '') + '|'+   
	isnull(VIA.Codi_Via_Sunat,'') + '|'+   
	isnull(DERECHO_HABIENTE.Nomb_via,'') + '|'+   
	isnull(DERECHO_HABIENTE.Num_via,'') + '|'+   

                isnull(DERECHO_HABIENTE.Interior_via,'') + '|'+   
	isnull(cast(ZONA.Codi_Zona_Sunat as varchar(2)),'') + '|'+   
  
 	isnull(cast(DERECHO_HABIENTE.Nomb_Zona as varchar(20)),'') + '|'+   
	isnull(cast(DERECHO_HABIENTE.referencia as varchar(40)),'') + '|'+  
 
	isnull(cast(UBIGEO_DISTRITO.Codi_Ubi_Dist_Sunat as varchar(6)),'') + '|'  as datos  

    FROM dbo.DERECHO_HABIENTE (nolock) join  dbo.PERSONAL (nolock) on  PERSONAL.CODI_PERS = DERECHO_HABIENTE.CODI_PERS   
         left join dbo.VINCULO_FAMILIAR (nolock) on DERECHO_HABIENTE.Codi_Vinc_Fami = VINCULO_FAMILIAR.Codi_Vinc_Fami
         left join dbo.MOTI_BAJA_DH (nolock) on DERECHO_HABIENTE.Codi_Moti_Baja_DH = MOTI_BAJA_DH.Codi_Moti_Baja_DH 
         left join dbo.VIA (nolock) on via.codi_via=DERECHO_HABIENTE.codi_via   
         left join dbo.ZONA  (nolock) on zona.codi_zona=   DERECHO_HABIENTE.codi_zona
         left join dbo.UBIGEO_DISTRITO (nolock) on UBIGEO_DISTRITO.Codi_Ubi_Dist= DERECHO_HABIENTE.Codi_Ubi_Dist 
		and personal.esta_acti in (1) and personal.codi_pers not in ('00000')
		and personal.codi_pers not in (select P.codi_pers from dbo.personal  P (nolock) 
			             where P.esta_acti=1 and year(P.fech_ingre)=@anio and month(P.fech_ingre)=@mes)
GO
