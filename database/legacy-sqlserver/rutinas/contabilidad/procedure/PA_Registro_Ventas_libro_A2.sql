CREATE PROCEDURE [dbo].[PA_Registro_Ventas_libro_A2]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2)          
--select  @anio ='2023', @mes ='10'
         
set quoted_identifier off          
set nocount on           
declare @SQLString nvarchar(4000), @cond varchar(100)          
        
create table #Cx (codi_clie char(5))         
create table #Ax (codi_clie char(5))         

create table #tx ( compr varchar(10) null, fecha datetime null, fecha_venc datetime null,          
   docu char(4) null, serie varchar(5) null,          
   nro_docu varchar(20) null, codi_clie_prov char(5) null,           
   vfexp numeric(12,2) null, base_impo numeric(12,2) null, exo numeric(12,2) null,          
   inafecta numeric(12,2) null, isc numeric(12,2) null, icbp numeric(12,2) null, igv numeric(12,2) null, otros numeric(12,2) null,          
   total numeric(12,2) null, tpc numeric(12,4) null, fecha_nd_nc datetime null,          
   tipo_docu_nd_nc char(4) null, serie_nd_nc varchar(6) null, nro_docu_nd_nc varchar(20) null,          
   dolar numeric(12,2) null, anio char(4) null, mes char(2) null, estado char(1) null, codi_mone char(2),
   empre_ruc varchar(15) null, empre_razon varchar(150) null)          
        
        
insert #Cx
select codi_clie_prov from cliente_proveedor 
where upper(razo_soci) like 'VARIOS%' or 
		upper(razo_soci) like 'ANULADO%'          

insert #Ax
select codi_clie_prov from cliente_proveedor 
where upper(razo_soci) like 'ANULADO%'          
         
set @SQLSTring ="SELECT compr,          
   max(fecha) fecha,           
   max(fecha_venc) fecha_venc,          
   --right(max(codi_Tipo_docu),2) Docu,          
   max(codi_tipo_docu)Docu,          
   max(serie) serie,          
   max(nro_docu) nro_docu,          
   max(codi_clie_prov) codi_clie_prov,          
            
	sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
			or left(nro_Cuen,4) in ('1311'))
			 and left(nro_cuen,2)<>'40' and isnull(tipo_venta ,'')='E'
                    then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  vfexp,

	sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
				or left(nro_Cuen,4) in ('1311'))
					and left(nro_cuen,2)<>'40' /*and isnull(tipo_venta,'') not in ('E','4','5','6')*/
					and not(nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta,'1')='4')
                        then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  BASE_IMPO,

	sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
			or left(nro_Cuen,4) in ('1311'))
				 and left(nro_cuen,2)<>'40' /*and isnull(tipo_venta,'') ='5'*/
					and (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4')
                    then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  EXO,

	/*sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
			or left(nro_Cuen,4) in ('1311'))
				 and left(nro_cuen,2)<>'40' and isnull(tipo_venta,'') ='6'
					then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)*/ 0.00  AS INAFECTA, 

   0.0 AS ISC,          0.0 AS ICBP,          
   sum(case when left(nro_cuen,2)='40' then  importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  igv,          
   0.0 as OTROS,          
	sum(case when left(nro_cuen,2) in ('12','13','14','16') and not 
				left(nro_Cuen,4) in ('1311') then  importe*case when cargo_abono='C' then 1 else -1 end  else 0 end)  total,

   max(tipo_cambio) tpc,          
   max(FECHA_ND_NC) fecha_nd_nc, max(TIPO_DOCU_ND_NC) tipo_docu_nd_nc,           
   max(SERIE_ND_NC) serie_nd_nc, max(NRO_DOCU_ND_NC) nro_docu_nd_nc,          
	sum(case when left(nro_cuen,2) in ('12','13','14','16') and not 
				left(nro_Cuen,4) in ('1311') then  importe_d*case when cargo_abono='C' then 1 else -1 end else 0 end) dolar, 
	anio, mes, '1'	, max(codi_mone),
	(select top 1 ruc from empresa (nolock)) empre_ruc, 
	(select top 1 razon_social from empresa (nolock)) empre_razon
	
 FROM Movi_Contables M(nolock)          
  where anio='"+@anio +"' and mes ='"+@mes+"' and subdia='V' and isnumeric(serie)=1 "+''+"          
  group by anio, mes , codi_tipo_docu,serie, compr          
order by cast(compr as int)"         
            
insert #TX (compr , fecha , fecha_venc ,docu , serie , nro_docu , codi_clie_prov ,           
  vfexp , base_impo , exo , inafecta , isc , icbp , igv , otros ,total , tpc , fecha_nd_nc ,          
  tipo_docu_nd_nc , serie_nd_nc , nro_docu_nd_nc ,dolar , anio, mes , estado, codi_mone,
  empre_ruc, empre_razon)          
execute sp_Executesql @SQLstring           
          
select empre_ruc+'|'
+empre_razon+'|'
+periodo+'|'        
+''+'|'
+fecha_emision+'|'      
+case when docu='14' then rtrim(fecha_venc) else '' end +'|'      
+docu+'|'        
+ ltrim(rtrim(case when rtrim(docu) ='01' or rtrim(docu)='03' or rtrim(docu)='04' or rtrim(docu)='07' or rtrim(docu)='08' then right('0000'+rtrim((serie)),4)      
	 else serie end ))+'|'       
+ cast(cast(rtrim(nro_docu) as int)as varchar) +'|'         
+importe_total_bol +'|'        
+/*case when cast(codi_clie_prov as varchar)='0' and indi='2' then '' else*/ cast(codi_clie_prov as varchar) /*end*/ +'|'        
+Ruc+'|'        
+left(Razon,100)+'|'        
+vfexp+'|'        
+case when rtrim(docu)='07' or rtrim(docu)='87' or rtrim(docu)='97' then base_impo else cast(abs(cast(base_impo as numeric(18,2))) as varchar) end +'|'        
+'0.00'+'|'
+case when rtrim(docu)='07' or rtrim(docu)='87' or rtrim(docu)='97' then igv else cast(abs(cast(igv as numeric(18,2))) as varchar) end +'|'        
+'0.00'+'|'
+exo+'|'        
+inafecta+'|'        
+isc+'|'        
+biarrozpilado+'|'        
+igvarrozpilado+'|'        
+isnull(cast(abs(cast( icbp as numeric(18,2))) as varchar),'0.00') +'|'
+otros+'|'        
+case when rtrim(docu)='07' or rtrim(docu)='87' or rtrim(docu)='97' then total else cast(abs(cast(total as numeric(18,2))) as varchar) end +'|'        
+codi_mone+'|'
+tpc+'|'        
+fecha_nd_nc+'|'        
+rtrim(tipo_docu_nd_nc)+'|'        
+ ltrim(rtrim(case when rtrim(tipo_docu_nd_nc) ='01' or rtrim(tipo_docu_nd_nc)='03' or rtrim(tipo_docu_nd_nc)='04' or rtrim(tipo_docu_nd_nc)='07' or rtrim(tipo_docu_nd_nc)='08'       
then case when isnumeric(serie_nd_nc)=1 then right('0000'+rtrim((serie_nd_nc)),4) else serie_nd_nc end
else serie_nd_nc end ))+'|' 
+nro_docu_nd_nc+'|' 
+''+'|'
+''+'|'
+''+'|'
+''+'|'
+''+'|'
+''+'|'
+''+'|'
+''+'|' --40
        
from         
(        
      
        
select         
anio+mes as periodo,
cast(compr as varchar) compr, case when codi_mone='01' then 'PEN' else 'USD' end as codi_mone,             
convert(char(10),fecha,103 ) fecha_emision,        
isnull(convert(char(10), fecha_venc,103),'')  fecha_venc,        
isnull((select codi_sunat from tipo_documento t (nolock) where t.codi_tipo_docu = docu),'00') docu     ,
case when isnull((select codi_sunat from tipo_documento t (nolock) where t.codi_tipo_docu = docu),'00') ='00' then '-' else  cast(serie as varchar) end  serie,      
cast(nro_docu as varchar) nro_docu,'' importe_total_bol,        

case when t.codi_clie_prov not in (select codi_clie from #Cx) then
	isnull((select (select cast(codi_sunat as int) from TIPO_DOCU_IDEN X (nolock) where x.codi_tipo_docu_iden=c.codi_tipo_docu_iden)        
	from cliente_proveedor c (nolock) where c.codi_clie_prov=t.codi_clie_prov),'')
	else '' end codi_clie_prov,      

case when t.codi_clie_prov not in (select codi_clie from #Cx) then isnull((select ruc from cliente_proveedor C (nolock) where C.codi_clie_prov = T.codi_clie_prov),'') 
	else '' end Ruc  ,  

case when t.codi_clie_prov not in (select codi_clie from #Cx) then isnull( (select case when upper(tipo_pers) ='JURÍDICA' then razo_soci else denominacion end         
  from cliente_proveedor C (nolock) where C.codi_clie_prov = T.codi_clie_prov),'') else '' end Razon ,           

isnull(cast(vfexp as varchar),'0.00')vfexp ,        
isnull(cast( base_impo as varchar),'0.00') base_impo,        
isnull(cast( exo as varchar),'0.00') exo,        
isnull(cast( inafecta as varchar),'0.00') inafecta,    
isnull(cast( isc as varchar),'0.00') isc,        
isnull(cast( icbp as varchar),'0.00') icbp,        
isnull(cast( igv as varchar),'0.00') igv,  
'0.00' biarrozpilado,        
'0.00' igvarrozpilado,        
isnull(cast( otros as varchar),'0.00') otros,        
isnull(cast( total as varchar),'0.00') total,        
/*case when codi_mone='01' then '' else*/ isnull(cast(cast(tpc as numeric (18,3)) as varchar),'0.000') /*end*/ tpc,         

case when codi_clie_prov in (select codi_clie from #Ax) then '01/01/0001' else
	case when isnull(convert(char(10),fecha_nd_nc,103),'01/01/0001')='01/01/1900' then '01/01/0001'
		else isnull(convert(char(10),fecha_nd_nc,103),'01/01/0001') end end fecha_nd_nc ,        

case when codi_clie_prov in (select codi_clie from #Ax) then '00' else	
	case when isnull(ltrim(rtrim(tipo_docu_nd_nc)),'00')='' then '00' else
		isnull((select codi_sunat from tipo_documento t (nolock) 
			where t.codi_tipo_docu = tipo_docu_nd_nc),'00') end  end tipo_docu_nd_nc,      

case when codi_clie_prov in (select codi_clie from #Ax) then '-' else	
	case when isnull( cast(serie_nd_nc as varchar) ,'-') ='' then '-' 
		else isnull( cast(serie_nd_nc as varchar) ,'-')  end end serie_nd_nc,      

case when codi_clie_prov in (select codi_clie from #Ax) then '-' else	
	case when isnull( cast(rtrim(nro_docu_nd_nc) as varchar),'-') ='' then '-' 
		else isnull( cast(rtrim(nro_docu_nd_nc) as varchar),'-')  end end nro_docu_nd_nc , 

case when codi_clie_prov in (select codi_clie from #Ax) and estado='1' then '2' else 
	case when month(fecha)=cast(@mes as int) and year(fecha)=cast(@ANIO as int) then '1' else T.estado /*'8'*/ end  end   indi,      
		dolar    , anio, mes,
rtrim(empre_ruc) empre_ruc, rtrim(empre_razon) empre_razon

from #Tx T          
) sqld        
--where docu='08'      
      
          
drop table #Tx          
drop table #Cx          
drop table #Ax          

set quoted_identifier on
GO
