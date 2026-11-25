CREATE PROCEDURE [dbo].[usp_mercaderias_sunat]
	@per [int],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @per int, @fec2 datetime
--select @per=2017,  @fec2='31/12/2017'

set nocount on 

declare @Esta varchar(200)
set @Esta=''

select @Esta= direccion from empresa (nolock)

SELECT codi_prod,
	 (select (select desc_tipo_exis from tipo_existencia T (nolock) where t.codi_tipo_exis=P.codi_tipo_exis)
		 from productos P (nolock) where P.codi_prod=k.codi_prod) Existencia,
	 (select desc_prod from productos P (nolock) where p.codi_prod=k.codi_prod) descripcion,
	 (select (select codi_sunat from unidad_medida U (nolock) where u.codi_unid_medi=p.codi_unid_medi)
			 from productos P (nolock) where p.codi_prod=k.codi_prod) Unidad,
	sum(cant_ingr  - cant_sali) as cantidad, 
	dbo.uf_precio_prom(@fec2, codi_prod) promedio, 
	sum(valo_ingr_alma  - valo_sali_alma) as costo,  
--	sum(valo_ingr  - valo_sali) /sum(cant_ingr  - cant_sali), 
	(select razon_social from empresa E (nolock)) Razon_social,
	(select ruc from empresa E (nolock)) Ruc,
	@ESTa Establecimiento
    FROM KARDEX K (nolock)
   WHERE  periodo=@per and cast(convert(char(10),fech_tran,103) as datetime)<= @fec2 
   		and left((select cuentas_contable.nro_cuen from cuentas_contable , productos where 
				cuentas_contable.nro_cuen= productos.nro_cuen and codi_prod=k.codi_prod),2)<>'33'
group by codi_prod
--having sum(cant_ingr  - cant_sali)<>0
GO
