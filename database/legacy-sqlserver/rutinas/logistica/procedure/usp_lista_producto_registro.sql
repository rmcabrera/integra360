CREATE PROCEDURE [dbo].[usp_lista_producto_registro]
	@reg [varchar](11)
WITH EXECUTE AS CALLER
AS
--declare @reg varchar(11)
--select @reg ='2301C0156'

set nocount on 

declare @Tx table (codi_prod char(8), desc_prod varchar(150) null, cantidad int)

declare @tipo_docu char(4) , @serie varchar(10) , @nro varchar(20), @prov char(5)

if SUBSTRING(@reg,4,1)='C' or SUBSTRING(@reg,5,1)='C'
begin
	
	select @tipo_docu=codi_tipo_docu, @serie=serie, @nro= nro_docu , @prov = codi_Clie_prov
	from movi_contables (nolock)
	where subdia='C' and registro = @reg

	insert @TX
	select codi_prod, 
			(select desc_prod from productos P (nolock) where P.codi_prod=B.codi_prod) DescProd,
			sum(cantidad) as cantidad
	from NOTA_INGRESO A(nolock)
	join DETALLE_NOTA_INGRESO B (nolock)
	on A.CODI_NOTA_INGR = B.CODI_NOTA_INGR
	where CODI_TIPO_DOCU_CONT=@tipo_docu and 
			case when isnumeric(NRO_SERI_DOCU_CONT)=1 then 	cast(cast(NRO_SERI_DOCU_CONT as int) as varchar) else NRO_SERI_DOCU_CONT end =@serie and 
			case when isnumeric(NRO_DOCU_CONT)=1 then 	cast(cast(NRO_DOCU_CONT as int) as varchar) else NRO_DOCU_CONT end =@nro
			and codi_clie_prov=@prov 
	group by codi_prod

end
if SUBSTRING(@reg,4,1)='L' or SUBSTRING(@reg,5,1)='L'
begin
	insert @Tx
	select  codi_prod, 
			(select desc_prod from productos P (nolock) where P.codi_prod=B.codi_prod) DescProd,
			cantidad 
	from letras_productos b (nolock) 
	where registro=@reg
end 

select codi_prod, desc_prod, cantidad
from @Tx
GO
