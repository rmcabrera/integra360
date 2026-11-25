CREATE PROCEDURE [dbo].[usp_lista_cliente_proveedor_reg]
	@Estado [char](1),
	@Rela [varchar](25),
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @Estado char(1) , @Rela varchar(25), @alma char(2)
--select @Estado='', @Rela='', @alma='00'

set quoted_identifier off
set nocount on 

declare @SQLString nvarchar(4000)
declare @Condi varchar(200)
declare @Condialma varchar(400)


if @Estado is null or rtrim(@Estado)=''  
begin
	if @rela is null or rtrim(@rela)='' set @Condi ='' else set @Condi ="where tipo_rela='"+@Rela +"'"
	
end 
else
begin 
	if @rela is null or rtrim(@rela)='' set @Condi="where isnull(esta_acti,'0')="+@estado else set @Condi="where isnull(esta_acti,'0')="+@estado +" and tipo_rela='" +@rela+"'"
end

if @alma='00' set @Condialma ='' 
else 
begin
	if @condi='' set @condialma=" where C.codi_clie_prov in (select distinct F.codi_clie_prov from factura F (nolock) where F.codi_alma="+@alma+")"
	else set @Condialma =" and C.codi_clie_prov in (select distinct F.codi_clie_prov from factura F (nolock) where F.codi_alma="+@alma+")"
end

create table #User (codi_clie char(5), creado_por varchar(50) null, modi_por varchar(50) null)

insert #User
select codi_clie, max(creado_por) creado_por, max(modi_por) modi_por
from(
	select right(desc_even,5) codi_clie, 
			(select upper(login) from usuarios U(nolock) where U.codi_usua=max(V.codi_pers)) creado_por, null modi_por
	from VISO_EVEN V(nolock)
	where desc_even like '%Tuvo Éxito al Registrar al Cliente/Proveedor con código%'
	and desc_even not like '%No Tuvo Éxito al Registrar al Cliente/Proveedor con código%'
	group by right(desc_even,5)

	union all

	select right(desc_even,5) codi_clie, null creado_por,
			(select upper(login) from usuarios U(nolock) where U.codi_usua=max(V.codi_pers)) modi_por
	from VISO_EVEN V(nolock)
	where desc_even like '%Tuvo Éxito al Modificar al Cliente/Proveedor con código%'
	and desc_even not like '%No Tuvo Éxito al Modificar al Cliente/Proveedor con código%'
	group by right(desc_even,5)
) as sql
group by codi_clie

--select * from #User

set @SQLSTring ="select codi_clie_prov, razo_soci, apel_1, apel_2, nomb_1, nomb_2,
		(select nemo from dbo.tipo_docu_iden td (nolock) where td.codi_tipo_docu_iden = c.codi_tipo_docu_iden ) docu,
		ruc, tipo_pers, denominacion, tipo_rela, dv, direccion,
		(select distinct top 1 (select nemo_alma from almacen A (nolock) where A.codi_alma=F.codi_alma )
			from factura F (nolock) where F.codi_clie_prov=c.codi_clie_prov) Sucur, tele_1, tele_2, 
			(select isnull(creado_por, modi_por) from #User where codi_clie=c.codi_clie_prov) fax, 
			e_mail
			
		from cliente_proveedor C (nolock) " +@Condi + @Condialma

execute sp_executesql @SQLString

drop table #User

set quoted_identifier on
GO
