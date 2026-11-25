CREATE PROCEDURE [dbo].[PA_REPO_USO_IQF]
	@mes [numeric](18, 0),
	@anio [numeric](18, 0)
WITH EXECUTE AS CALLER
AS
Select cast(ka.fecha as smalldatetime) as Fecha,
       (Select desc_prod from productos where codi_prod = ka.codi_prod) as IQF,
       (Select desc_prod from productos where codi_prod = ka.codi_prod) as IQF_comercial,
	ka.concen_iqf as concen,
	ka.cantidad as canti,
       (Select SIMB_UNID_MEDI from unidad_medida where codi_unid_medi = ka.codi_unid_medi) as unid_medi,
	ka.ProdServIQF as nom_PS,
	ka.Canti_ProdServIQF as Canti_PS,
	(Select SIMB_UNID_MEDI from unidad_medida where codi_unid_medi = ka.UM_ProdServIQF) as UM_PS,
	ka.DeseIQF as nom_DESecho,
	ka.Canti_DeseIQF as canti_des,
	(Select SIMB_UNID_MEDI from unidad_medida where codi_unid_medi = ka.UM_DeseIQF) as um_D,
	ka.Canti_RHPM_IQF as Canti_RHPM,
	(Select SIMB_UNID_MEDI from unidad_medida where codi_unid_medi = ka.UM_RHPM_IQF) as um_rhpn,
	ka.Moti_RHPM_IQF,
	'Produc.:' + ka.Observaciones as obser
from kardex_almacenes ka inner join Productos p on p.codi_prod = ka.codi_prod
Where month(ka.fecha)= @MES AND year(ka.fecha)  = @ANIO  and	p.iqf = 1

UNION

Select 
	cast(ds.FECH_EMIS as smalldatetime) as Fecha,
       (Select desc_prod from productos where codi_prod = dds.codi_prod) as IQF,
       (Select desc_prod from productos where codi_prod = dds.codi_prod) as IQF_comercial,
	dds.concen_iqf as concen,
	dds.cantidad as canti,
       (Select SIMB_UNID_MEDI from unidad_medida where codi_unid_medi = p.codi_unid_medi) as unid_medi,
	dds.ProdServIQF as nom_PS,
	dds.Canti_ProdServIQF as Canti_PS,
	(Select SIMB_UNID_MEDI from unidad_medida where codi_unid_medi = dds.UM_ProdServIQF) as UM_PS,
	dds.DeseIQF as nom_DESecho,
	dds.Canti_DeseIQF as canti_des,
	(Select SIMB_UNID_MEDI from unidad_medida where codi_unid_medi = dds.UM_DeseIQF) as um_D,
	dds.Canti_RHPM_IQF as Canti_RHPM,
	(Select SIMB_UNID_MEDI from unidad_medida where codi_unid_medi = dds.UM_RHPM_IQF) as um_rhpn,
	dds.Moti_RHPM_IQF,
	dds.Observaciones as obser
From docu_sali_mate ds inner join detalle_docu_sali dds  on dds.codi_docu_sali = ds.codi_docu_sali
		     inner join Productos p 		  on p.codi_prod = dds.codi_prod
Where month(ds.fech_emis) = @mes and year (ds.fech_emis) = @anio  And p.iqf = 1
GO
