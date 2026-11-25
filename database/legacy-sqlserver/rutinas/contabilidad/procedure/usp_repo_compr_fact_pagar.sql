CREATE PROCEDURE [dbo].[usp_repo_compr_fact_pagar]
	@anio [char](4),
	@mes [char](2),
	@compr [varchar](10),
	@prov [char](5)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2), @compr varchar(10) , @prov char(5)
--select @anio ='2009', @mes ='01', @compr ='1', @prov='05723'


set nocount on 

select M.anio, M.mes, M.subdia, M.compr , fecha, nro_cuen , codi_nota_ingr, registro , codi_clie_prov, 
	codi_tipo_docu, serie , nro_docu, importe, importe_d
from movi_contables M (nolock)
where M.anio=@anio and M.mes=@mes and (M.subdia in ('C') or substring(M.registro,4,1)='C') and M.compr=@compr and  codi_clie_prov=@prov
GO
