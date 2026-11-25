CREATE PROCEDURE [dbo].[usp_lista_liquida_caja_chica]
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @alma char(2)  , @fec1 datetime, @fec2 datetime
--select @alma ='10', @fec1='01/01/2010' , @fec2='26/02/2011'

set nocount on

select a.nro_recibo, b.serie, b.nro, b.codi_liqu, '0' estado,
	(select isnull(U.desc_unid_oper,'') from dbo.unid_oper U(nolock) where U.codi_unid_oper=a.codi_unid_oper) unid_oper,
	(select isnull(X.desc_unid_oper,'') from dbo.unid_oper X(nolock) where X.codi_unid_oper=a.placa_carreta) carreta, isnull(a.importe,0) importe,
	tipo_io, a.fecha
from dbo.caja_chica a(nolock) 
left join dbo.liquidacion b(nolock)
on a.CODI_LIQU = b.codi_liqu
where A.tipo_contab='067' and codi_alma=@alma --and A.fecha between @fec1 and @fec2
and b.codi_liqu is null and a.tipo_io=0
order by a.fecha desc
GO
