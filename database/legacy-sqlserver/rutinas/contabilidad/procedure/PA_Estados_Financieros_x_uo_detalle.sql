CREATE PROCEDURE [dbo].[PA_Estados_Financieros_x_uo_detalle]
	@anio [char](4),
	@mes_i [char](2),
	@mes_f [char](2),
	@tipo [int],
	@uo [char](5),
	@cta [char](7)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes_i  char(2), @mes_f char(2), @tipo int, @uo char(5), @cta char(7) 
--select @anio='2014', @mes_i ='01', @mes_f='01', @tipo =1, @uo='00001', @cta='77'

set nocount on
   
Select anio, mes, subdia, compr, 
	  (case cargo_abono when 'A' then importe else -1*importe end) as monto, 
	  glosa, left(MC.nro_cuen,len(E.nro_cuen)) as Cod, codi_unid_oper
from movi_contables MC(nolock)
join estados_financieros_detalle E(nolock)
on left(MC.nro_cuen,len(E.nro_cuen)) = E.nro_cuen
join estados_financieros EF(nolock)
on E.Id = EF.id
where MC.anio= @anio and MC.mes between @mes_i AND @mes_f and MC.subdia <>'X' and EF.tipo=@tipo 
	and left(MC.nro_cuen,2)=@cta and isnull(codi_unid_oper,'')=@uo
	--and (isnull(@uo,'')='' or MC.codi_unid_oper=@uo)
order by mes, subdia, cast(compr as numeric)
GO
