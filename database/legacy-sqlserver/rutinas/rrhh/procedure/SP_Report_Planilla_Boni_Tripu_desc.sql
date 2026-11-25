CREATE PROCEDURE [dbo].[SP_Report_Planilla_Boni_Tripu_desc]
	@sem [char](8),
	@emb [char](5),
	@per [char](5)
WITH EXECUTE AS CALLER
AS
begin
 SELECT planilla_bonitri_conceptos.codi_plan_btri,   
	         planilla_bonitri_conceptos.CODI_CONC,   
	         planilla_bonitri_conceptos.AFECTO,   
	         planilla_bonitri_conceptos.VALOR,   
	         planilla_bonitri_conceptos.MONTO,   
	         planilla_boni_tripu.CODI_PERS,    
	         PERSONAL.CODI_CARG,   
	         CARGOS.DESC_CARGO,   
	         CONCEPTOS.DESC_CONC  
	    FROM planilla_boni_tripu,   
	         planilla_bonitri_conceptos,   
	         CARGOS,   
	         PERSONAL,   
	         CONCEPTOS  
	   WHERE ( planilla_bonitri_conceptos.codi_plan_btri = planilla_boni_tripu.codi_plan_btri ) and  
	         ( PERSONAL.CODI_CARG = CARGOS.CODI_CARG ) and  
	         ( PERSONAL.CODI_PERS = planilla_boni_tripu.CODI_PERS ) and  
	         ( CONCEPTOS.CODI_CONC = planilla_bonitri_conceptos.CODI_CONC ) and  
	         ( ( planilla_boni_tripu.CODI_SEMA = @sem ) AND  
	         ( planilla_boni_tripu.CODI_UNID_OPER = @emb ) AND  
	         ( left(planilla_bonitri_conceptos.CODI_CONC,1) = '2' ) AND  
	         ( planilla_bonitri_conceptos.CODI_CONC <> '299999' ) AND  
	         ( planilla_boni_tripu.CODI_PERS = @per ) )  

end
GO
