CREATE FUNCTION [dbo].[uf_valor_labor_invenn](@fec1 [datetime], @per [char](4), @clie [char](5), @codi_alma [char](2))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
begin
	--declare @per char(4), @fec1 datetime , @clie char(5), @codi_alma char(2)
	--select  @per ='2018', @fec1 ='06/12/2018' , @clie ='04554', @codi_alma ='00'

	declare @alma table (codi_alma char(2) null)

	if @codi_alma='00'
		insert @alma
		select codi_alma from almacen(nolock)
	else
		insert @alma
		select @codi_alma

	declare @Tx table ( total numeric(18,2) null)

	insert @Tx
	select  round(stock * precio_s,2) total
	from(
	select 
		  sum(cant_ingr - cant_sali) as stock,  
		  dbo.uf_ulti_prec_compr(codi_prod) precio_s
	from kardex as KF (nolock)
	where fech_tran<=@fec1 and
				left((select cuentas_contable.nro_cuen from cuentas_contable , productos where 
					cuentas_contable.nro_cuen= productos.nro_cuen and codi_prod=kf.codi_prod),2)<>'33'
			and periodo=@per and codi_prod in (select codi_prod from productos where isnull(@clie,'')='' or codi_clie_prov=@clie)
			--and codi_prod='00081554'
			and codi_alma in (select A.codi_alma from @Alma A)
		 group by codi_prod) as SQL

	return (select sum(total) from @Tx)

end
GO
