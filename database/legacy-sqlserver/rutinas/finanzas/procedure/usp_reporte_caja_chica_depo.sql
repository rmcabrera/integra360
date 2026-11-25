CREATE PROCEDURE [dbo].[usp_reporte_caja_chica_depo]
	@recibo [char](10)
WITH EXECUTE AS CALLER
AS
--declare @recibo char(10)
--select @recibo='SSD000409'

set quoted_identifier off
set nocount on 

declare @SQLString nvarchar(4000)
declare @Condi varchar(200)

if not (rtrim(@recibo)='' or @recibo is null ) set @Condi=" where A.codi_depo = '"+ @recibo+"'" else set @Condi=''

create table #Tx (codi_depo char(9) null, codi_docu char(10) null, tipo_rela char(2) null, docu char(5) null,
		   ser_Fact char(5) null, nro_fact char(10) null, tota_fact numeric(12,3) null, empresa varchar(150) null,
		   codi_clie_prov char(5) null, importe numeric(18,3) null, codigo char(10) null)
		   
set @SQLSTring ="select codi_depo, 
		  case when tipo_rela='S' then (select cast(nro_vale as varchar) from registro_vale rv(nolock) 
				where rv.codi_vale = codi_docu) else codi_docu end codi_docu, 
		  tipo_rela, 
		 (select nemo from tipo_documento T(nolock) where T.codi_tipo_docu=A.codi_tipo_docu) docu, 
		 isnull(ser_fact,'') ser_fact, isnull(nro_fact,'') nro_fact, isnull(tota_fact,0) tota_fact,
		 (select top 1 razon_social from empresa (nolock)) empresa,
		 (case when len(codi_docu)=10 then (select codi_clie_prov from factura f(nolock) where F.codi_fact = A.codi_docu) 
		 else (case when tipo_rela='S' then (select codi_clie_prov from registro_vale rv(nolock) where rv.codi_vale=A.codi_docu) else
		(select codi_clie_prov from caja_chica C(nolock) where C.nro_recibo = A.codi_docu) end) end) cliente, importe, codi_docu
from dbo.caja_chica_depo A(nolock)" + @Condi

insert #Tx
execute sp_executesql @SQLString

select codi_depo, codi_docu, tipo_rela, docu,
       ser_Fact, nro_fact, tota_fact, empresa,
       (select case when isnull(razo_soci,'')='' then denominacion else razo_soci end
       from cliente_proveedor cp(nolock) where cp.codi_clie_prov = T.codi_clie_prov) cliente,
        (select ruc from cliente_proveedor c(nolock) where C.codi_clie_prov=T.codi_clie_prov) ruc,
	(select ruc from empresa (nolock) ) ruc_empr,
	(case when len(codi_docu)=10 then 'FAC.' else (case when tipo_rela='S' then 'VALE' else 'REC.' end) end) tipo, 
	isnull((select sum(importe) from caja_chica_depo cc(nolock) 
		where cc.codi_docu = T.codigo and cc.codi_depo = T.codi_depo and tipo_rela='S' group by cc.codi_docu),0) depo,
	isnull((select sum(importe) from caja_chica_depo cc(nolock) 
		where cc.codi_docu = T.codigo and tipo_rela='S' group by cc.codi_docu),0) depo_acum
			
from #Tx T

drop table #tx
GO
