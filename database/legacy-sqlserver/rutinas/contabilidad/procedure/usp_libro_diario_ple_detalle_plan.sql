CREATE PROCEDURE [dbo].[usp_libro_diario_ple_detalle_plan]
	@ANIO [char](4),
	@MES [char](2)
WITH EXECUTE AS CALLER
AS
--declare @ANIO CHAR(4) ,  @MES CHAR(2) 
--select @ANIO ='2015' ,  @MES ='10'

set nocount on        
      
      
SELECT  @anio+@mes+'01' +'|'+
	nro_cuen +'|'+
	replace(left(desc_cuen,90),'/','-') +'|'+	
	'01' +'|'+
	'PLAN CONTABLE GENERAL EMPRESARIAL'+'|'+
	nro_cuen +'|'+
	replace(left(desc_cuen,90),'/','-') +'|'+
	case when @mes='01' then '1' else '1' end +'|'
from cuentas_contable (nolock)
GO
