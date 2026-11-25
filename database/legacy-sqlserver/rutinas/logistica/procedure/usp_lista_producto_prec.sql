CREATE PROCEDURE [dbo].[usp_lista_producto_prec]
	@codi [char](2)
WITH EXECUTE AS CALLER
AS
--declare @codi char(2) 
--select @codi='01'

set nocount on
declare @Fech datetime
set @fech = cast(convert(char(10),getdate(),103) as smalldatetime)

select P.codi_prod, P.desc_prod,
       round((case when P.codi_mone='01' then 1 else tCambio end ) *
       isnull(A.prec_costo * (1 + A.prec_porc_uti_esp/100.00) * (case when P.cod_impuesto=3 then 1 else (1+ dbo.f_igv(@fech)/100.00 ) end),0.00),nro_decim_precio) prec_esp
from dbo.productos P(nolock)
join dbo.almacen_producto A(nolock)
on P.codi_prod=A.codi_prod
where codi_alma=@codi
order by 2
GO
