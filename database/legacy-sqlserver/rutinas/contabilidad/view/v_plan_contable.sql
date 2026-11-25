CREATE VIEW [dbo].[v_plan_contable]
AS
select  top 100 percent  a.codi_clas_cuen , A.desc_clas_Cuen, isnull(B.codi_subc,'') codi_subc, isnull(B.desc_subc,'') Desc_Subc, 
	  isnull(B4.codi_subc_4,'') codi_subc_4, isnull(B4.desc_sub_4,'') Desc_Subc_4, 
       isnull(C.codi_lcc,'') codi_lcc, isnull(C.desc_lcc,'') Desc_lcc, isnull(D.nro_cuen,'') nro_cuen, isnull(D.desc_cuen,'') Desc_cuen,
	nro_sub_cuen, cta_6, tipo_cuen, codi_mone
from dbo.CLASES_CUENTAS A (nolock)
left join dbo.SUB_CLAS_CUEN B (nolock)
on A.codi_clas_cuen = B.codi_clas_cuen 
left join dbo.sub_clase_cont_4 B4 (nolock)
on b.codi_subc = B4.codi_subc
left join dbo.LINEA_CLASE_C C (nolock)
on B4.codi_subc_4= C.codi_subc_4
left join dbo.CUENTAS_CONTABLE D (nolock)
on C.codi_lcc= D.codi_lcc
order by A.codi_clas_cuen, B.codi_subc, C.codi_lcc, D.nro_cuen
GO
