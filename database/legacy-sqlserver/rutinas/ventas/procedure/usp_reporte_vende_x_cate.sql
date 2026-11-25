CREATE PROCEDURE [dbo].[usp_reporte_vende_x_cate]
	@fec1 [datetime],
	@fec2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fec1  datetime , @fec2 datetime , @alma char(2)
--select @fec1 ='30/03/2017' , @fec2 ='30/03/2017', @alma ='05'

set nocount on 
set QUOTED_IDENTIFIER off

declare @SQLString nvarchar(4000)  , @Condi varchar(100), @Condi2 varchar(100), @Condi3 varchar(100)
declare @ParmDefinition nvarchar(100)

SET @ParmDefinition = "@fec1 datetime , @fec2 datetime "
if rtrim(@alma)='' or @alma is null set @Condi='' else set @Condi=" and F.codi_alma="+@alma
if rtrim(@alma)='' or @alma is null set @Condi2='' else set @Condi2=" and codi_alma="+@alma
if rtrim(@alma)='' or @alma is null set @Condi3='' else set @Condi3=" and D.codi_alma="+@alma

create table #Tempo (codi_clie_prov char(5) null,  codi_tipo_docu char(4) null, serie char(5) null, codi_prod char(8) null,
			categoria varchar(100) null, cant_item numeric(12,4) null, venta numeric(18,8) null,
			valor_igv numeric(18,6) null, precio_venta numeric(18,6) null, codi_vend char(5) null)

set @SQLSTring ="select  codi_clie_prov, 
		codi_tipo_docu,
		ser_fact,  codi_prod,
		(select S.desc_sub_fami_prod from dbo.sub_Familia_producto S (nolock)
			where S.codi_sub_fami_prod in (select DP.codi_sub_fami_prod from dbo.productos DP(nolock) where DP.codi_prod=d.codi_prod)) Categoria,
		cant_item,  
		cast( case when codi_imp=1 then cast(round(impo_item/(1+igv/100),2) as numeric(12,2)) else impo_item end * 
			case when codi_mone='01' then 1 else tcambio end as numeric(12,4)) As Venta ,  
		cast(case when codi_imp=1 then cast((impo_item - round(impo_item/(1+igv/100),2)) as numeric(12,2)) else 0 /*cast(round(impo_item*igv/100,2)as numeric(12,2))*/ *
			case when codi_mone='01' then 1 else tcambio end  end as numeric(12,4)) Valor_IGV, 
		cast( case when codi_imp=1 then impo_item else impo_item /*+ cast(round(impo_item*igv/100,2) as numeric(12,2))*/ end *
			case when codi_mone='01' then 1 else tcambio end as numeric(12,4)) Precio_Venta, cod_usua_vende
		--isnull((select R.codi_usua from registro_vale R (nolock) where R.codi_fact=F.codi_Fact), F.cod_usua_vende) codi_usua
	from dbo.factura F (nolock) 
	join dbo.factura_detalle D (nolock)
	on F.codi_Fact=D.codi_fact
	where cast(convert(char(10),fech_fact,103) as smalldatetime) between @fec1 and @fec2 and isnull(F.estado,'')<> 'A' " +@condi  

insert #Tempo
EXECUTE sp_executesql @SQLString, @ParmDefinition, @fec1 = @fec1 ,@fec2=@fec2


select  codi_vend, /*codi_clie_prov,
	(select case when razo_soci is null or rtrim(razo_soci) ='' then denominacion else razo_soci end from dbo.cliente_proveedor C (nolock)
				where C.codi_clie_prov=SQ.codi_clie_prov ) Cliente,
	(select ruc from dbo.cliente_proveedor C (nolock)
				where C.codi_clie_prov=SQ.codi_clie_prov ) RUC,*/
	(select apel_1+ isnull(' '+apel_2,'') + isnull(' ' +nomb_1,'') from usuarios U (nolock) where U.codi_usua collate sql_latin1_general_cp1_ci_as  =codi_vend) usuarios,
	codi_prod,
	Categoria,
	(select desc_prod from dbo.productos P where P.codi_prod collate sql_latin1_general_cp1_ci_as  =SQ.codi_prod) desc_item,
	(select upper(desc_unid_medi) from dbo.unidad_medida U (nolock) where U.codi_unid_medi collate sql_latin1_general_cp1_ci_as  in (
		select P.codi_unid_medi from dbo.productos P (nolock) where P.codi_prod collate sql_latin1_general_cp1_ci_as =SQ.codi_prod)) Unidad,
	sum(cant_item) cantidad,  
	sum(Venta) Venta,  
	sum(Valor_IGV) IGV, 
	sum(Precio_Venta) PRECIO,
	(select top 1 razon_social from dbo.empresa (nolock) ) Empresa,
	(select dbo.f_cliente_proveedor(x.codi_clie_prov) from productos x (nolock) where x.codi_prod=Sq.codi_prod) as Labo
	--sum(p_neto) p_neto
from 
	(select codi_clie_prov , codi_tipo_docu , serie as ser_fact , codi_prod ,categoria , cant_item , venta ,valor_igv , precio_venta , 
		codi_vend
		from #Tempo) SQ
group by codi_vend, Categoria,codi_prod
order by codi_vend, Categoria,codi_prod


drop table #Tempo

set QUOTED_IDENTIFIER on
GO
