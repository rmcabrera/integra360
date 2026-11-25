CREATE PROCEDURE [dbo].[ups_reporte_factura]
	@fec1 [datetime],
	@fec2 [datetime],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime, @fec2 datetime, @codi_alma char(2)  
--select @fec1='01/11/2015', @fec2='11/11/2015', @codi_alma='03'  
  
set nocount on  
declare @alma table (codi_alma char(2) null)  
if @codi_alma = '00'  
begin  
 insert @alma  
 Select codi_alma from dbo.almacen (nolock)  
end   
else  
begin insert @alma  
 Select codi_alma from dbo.almacen (nolock) where codi_alma = @codi_alma  
  
end  
  
create table #Lx (codi_Fact char(10), linea char(2) null, importe numeric(12,2) null)

insert #LX
select codi_Fact,linea, sum(impo_item) as impor
from  
  (select D.codi_Fact,(select cod_lin_pro from familia_producto Y (nolock) where Y.CODI_FAMI_PROD in 
		(select codi_fami_prod from sub_familia_producto X (nolock)
				where X.codi_sub_fami_prod in (select CODI_SUB_FAMI_PROD from productos P (nolock) where p.CODI_PROD=D.CODI_PROD))) as Linea,
		case when estado='A' then 0 else IMPO_ITEM end as IMPO_ITEM 
  from FACTURA_DETALLE D (nolock) 
  join FACTURA F 
  on F.CODI_FACT=D.codi_Fact
	where cast(convert(varchar(10),fech_fact,103) as smalldatetime) between @fec1 and @fec2   
			and isnull(f.codi_alma,'') collate sql_latin1_general_cp1_ci_as in 
					(Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)   ) SQ
  group by codi_Fact,Linea

create table #Rx (codi_Fact char(10), pesti numeric(12,2) null, semi numeric(12,2) null, herra numeric(12,2) null,
					fertic numeric(12,2) null, nutri numeric(12,2) null, fertig numeric(12,2) null)

insert #Rx
select codi_Fact, 
		sum(case when linea ='01' then importe else 0 end),
		sum(case when linea ='02' then importe else 0 end),
		sum(case when linea ='03' then importe else 0 end),
		sum(case when linea ='04' then importe else 0 end),
		sum(case when linea ='05' then importe else 0 end),
		sum(case when linea ='06' then importe else 0 end)
--		sum(case when linea not in ('01','02','03','04','05','06') then importe else 0 end)
from #Lx  
group by codi_fact
    
select F.codi_fact, (ltrim(rtrim(ser_fact)) + ' - ' + ltrim(rtrim(nro_fact))) doc,fech_fact,   
 (select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end  
 from dbo. cliente_proveedor c(nolock) where c.codi_clie_prov=f.codi_clie_prov) cliente,  
 (select desc_cultivo from dbo.cultivos B(nolock) where B.cod_cultivo=f.cod_cultivo) cultivo,  
  hectarea, tota_fact,  
 (select razon_social from dbo.empresa (nolock)) empresa,  
 (select ruc from dbo.empresa (nolock)) ruc, codi_alma, 
  isnull(case when fecha_siembra is null then nro_dias 
		else datediff(D,fecha_siembra,GETDATE()) end ,0) as  nro_dias ,
 (select desc_zona from zonas where cod_zona=f.cod_zona) zona ,
	pesti,  semi,herra, fertic, nutri, fertig
from dbo.factura F(nolock)  
join #Rx R
on F.CODI_FACT=R.codi_fact
where cast(convert(varchar(10),fech_fact,103) as smalldatetime) between @fec1 and @fec2   
and isnull(f.codi_alma,'') collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)   
  
drop table #Lx
drop table #Rx
GO
