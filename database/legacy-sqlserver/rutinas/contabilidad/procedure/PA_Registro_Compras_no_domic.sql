CREATE PROCEDURE [dbo].[PA_Registro_Compras_no_domic]
	@mes [char](2),
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
--declare @mes  char(2), @anio char(4)             
--select @mes  ='08',@anio ='2022'
           
set nocount on         

declare @l_diahabil datetime
declare @anio_x int, @mes_x int
declare @l_diahabil_actual datetime


set @l_diahabil_actual = dbo.f_dia_habil(@anio, @mes, 5)
set @l_diahabil_actual = dateadd(d,1,@l_diahabil_actual)
--- obtener 5 día hábil del mes siguiente
if @mes='12' 
begin
	set @mes_x=1
	set @anio_x = cast(@anio as int) + 1 
end
else
begin
	set @mes_x=cast(@mes as int ) + 1
	set @anio_x=cast(@anio as int)
end
set @l_diahabil = dbo.f_dia_habil(@anio_x, @mes_x, 5)
---select @l_diahabil
---- Fin Día Hábil

select correlativo as compr,
	   periodo,
       fecha,
	   codi_tipo_docu,
	   case when codi_tipo_docu='01' or codi_tipo_docu='03' or codi_tipo_docu='04' or codi_tipo_docu='07' or codi_tipo_docu='08' then  
			case when isnumeric(serie)=1 then right('0000'+serie,4) else serie end
	   when codi_tipo_docu='50' then ''
		    else serie end as serie,		    
	   NRO,
	   --case when codi_tipo_docu in ('07','87' ,'97') then base_impo_4 else 0 end as valor_adquis,
	   base_impo_4 as valor_adquis,
	   otros,
	   total,

	   --'00' as tipo_compr, 
	   TIPO_DOCU_ND_NC as tipo_compr,

	   --serie serie_dua,
	   SERIE_ND_NC as serie_dua,

	   case when anio_dua <>'0' then anio_dua else '' end anio_dua,
	   --right(FECHA_ND_NC,4) as anio_dua,
	   
	   --case when NRO_COMPR_NO_DOMIC='' then '-' else NRO_COMPR_NO_DOMIC end as nro_compr,
	   NRO_DOCU_ND_NC as nro_compr,
	   
	   codi_mone, pais,
	   
	   left(clie_Prov,60) razon_no_domic, ruc as ruc_no_domic, 
	   
	   --'' as nro_iden, 
	   ruc as nro_iden,

	   --'' as razon_benef,
	   left(clie_Prov,60) as razon_benef,

	   convenio, '00' as tipo_renta, indi
	         
from         
(     
	select anio, cast(anio as varchar)+cast(mes as varchar)+'00' periodo,          
	
	rtrim(isnull(cast(compr as varchar),'')) correlativo, max(fecha) fecha,          
	rtrim(isnull(convert(char(10), max(fecha_venc)  ,103),'')) fecha_venc,             
	
	isnull( max(codi_tipo_docu),'00')  codi_tipo_docu,            
	
	isnull(case when isnull( max(codi_tipo_docu),'0') = '50' or isnull( max(codi_tipo_docu),'0') = '50' then  
	
	cast(max(CODI_ADUANA) as varchar) else  case when  rtrim(cast((max(sr_COMPR)) as varchar)) ='' or rtrim(cast((max(sr_COMPR)) as varchar)) ='0' then
	 '-' else  cast((max(sr_COMPR)) as varchar) end end,'-') serie,             
	 
	isnull(case when isnull( max(TIPO_DOCU_ND_NC),'0') in ('50','52') or isnull( max(TIPO_DOCU_ND_NC),'0') in ('50','52') then  
	(  case when cast(max(ANIO_DUA_DSI ) as varchar)<>'0' then  cast(max(ANIO_DUA_DSI ) as varchar) else null end) else  '0' end,'') anio_dua,           

	max(NRO_COMPR) NRO,            
	'' numero_final,          
	isnull(cast(max(CODI_SUNAT) as varchar),'0') CODI_SUNAT,            
	isnull(cast(max(RUC) as varchar),'-') ruc,            
	isnull( max(clie_Prov),'-') clie_Prov,           
	isnull(cast(sum(base_impo) as varchar),'0.00') base_impo,isnull(cast(sum(igv) as varchar),'0.00') igv,             
	isnull(cast(sum(base_impo_2) as varchar),'0.00') base_impo_2,isnull(cast(sum(igv_2) as varchar),'0.00') igv_2,             
	isnull(cast(sum(base_impo_3) as varchar),'0.00') base_impo_3, isnull(cast(sum(igv_3) as varchar),'0.00') igv_3,             
	isnull(sum(base_impo_4),0) base_impo_4,             
	isnull(cast(sum(isc) as varchar),'0.00') isc,         
	isnull(sum(otros),0) otros,        
	isnull(sum(total),0) total,            
	case when max(codi_mone)='01' then '' else isnull(cast(cast(max(tipo_cambio) as numeric(18,3)) as varchar),'0.000') end tipo_cambio,          
	isnull(convert(char(10),max(FECHA_ND_NC),103),'01/01/0001') FECHA_ND_NC ,        
	isnull(right('00'+cast(max(TIPO_DOCU_ND_NC) as varchar),2),'00') TIPO_DOCU_ND_NC , 
	isnull(cast(max(SERIE_ND_NC ) as varchar),'-')SERIE_ND_NC ,         
	isnull(cast(max(NRO_DOCU_ND_NC)as varchar),'-') NRO_DOCU_ND_NC,           
	rtrim(isnull(max(NRO_COMPR_NO_DOMIC),'-'))  NRO_COMPR_NO_DOMIC ,         
	case when max(cast(detraccion as int))=1 then isnull(convert(char(10),max(fecha_detrac),103),'01/01/0001') else '01/01/0001' end fecha_detrac,        
	case when max(cast(detraccion as int))=1 then  isnull(cast(max(nro_detrac) as varchar),'0') else '0' end nro_detrac,        
	cast(max(cast(detraccion as int)) as varchar) marca_reten,        
	case when (mes = cast( @mes as int )  and anio = cast( @anio as int ) )  
		--and ( month(max(fecha)) = cast( @mes as int )  and year(max(fecha)) = cast( @anio as int ) )  
		then case when max(codi_tipo_docu) in ('03','15','16') or isnull(cast(sum(igv) as varchar),'0.00')='0.00' then '0' else 
			'1' end 
	when anio + mes <> @anio + @mes
		then '9' 
		else case when max(codi_tipo_docu)in ('03','15','16') then '0' else '6' end end  indi ,		
	max(Codi_Contable) codi_contable, max(Nro_Cuen) nro_cuen,             
	max(Registro) registro,  max(Glosa) glosa ,  max(num_spot) num_spot, max(fecha_spot) fecha_spot ,            
			  ' ' Cargo_Abono, Mes, 'C' Subdia, max(Codi_Vouc) Codi_Vouc ,     
	  max(codi_nota_ingr) codi_nota_ingr ,            
	  sum(importe) importe , max(nro_fact) nro_fact, max(codi_unid_oper) codi_unid_oper ,            
	max(tipo_venta) tipo_Venta ,            
	sum(Dolares) dolares       , case when max(codi_mone) ='01' then 'PEN' else 'USD' end as  codi_mone        ,
	max(pais) as pais, right('00'+max(convenio),2) as convenio
            
 from             
     (SELECT            
  Compr, fecha, fecha_venc ,  codi_mone,        
  (select codi_sunat from tipo_documento t (nolock) where t.codi_tipo_docu = MOVI_CONTABLES.codi_tipo_docu)codi_tipo_docu,            
  /*right(codi_tipo_docu,2) codi_tipo_docu , */CODI_ADUANA , ANIO_DUA_DSI,             
   isnull(ltrim(rtrim(cast(serie as varchar))),'') as sr_COMPR,          
 isnull(ltrim(rtrim(cast(nro_docu as varchar))),'') as NRO_COMPR ,            
            
     case when isnull(tipo_venta,'1')='1' and 
		 ( left(nro_cuen,2) not in ('42','43','40') or 	nro_cuen in ('4221101','4211102') ) 
			and (otros=0 or isnull(otros,0)=0)     
		   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as BASE_IMPO,   

     case when isnull(tipo_venta,'1')='1' and  (left(nro_cuen,2) in ('40'))     
     then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as IGV,

     case when isnull(tipo_venta,'1')='2' and 
		( left(nro_cuen,2) not in ('42','43','40') or nro_cuen in ('4221101','4211102') )
			and (otros=0 or isnull(otros,0)=0)     
		   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end  as BASE_IMPO_2,   

     case when isnull(tipo_venta,'1')='2' and   (left(nro_cuen,2) in ('40'))     
  then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as IGV_2,

     case when isnull(tipo_venta,'1')='3' and 
		  ( left(nro_cuen,2) not in ('42','43','40') or nro_cuen in ('4221101','4211102') ) 
			and (otros=0 or isnull(otros,0)=0)     
		   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as BASE_IMPO_3,   

     case when isnull(tipo_venta,'1')='3' and  (left(nro_cuen,2) in ('40'))     
     then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as IGV_3,

     case when isnull(tipo_venta,'1')='4' and 
	 	 ( left(nro_cuen,2) not in ('42','43','40') or nro_cuen in ('4221101','4211102') ) 
			and (otros=0 or isnull(otros,0)=0)     
		   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as BASE_IMPO_4,   
            
      0.0 AS ISC,               
     case when (left(nro_cuen,2) not in ('42','43','40') or  nro_cuen in ('4221101','4211102') ) 
		and otros<>0     
  	 then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as Otros,  

     case when (left(nro_cuen,2) in ('42','43')  and nro_cuen not in ('4221101','4211102') )
   then (case when cargo_abono='A' then Importe else -1*Importe end) else 0 end  as TOTAL,

   ' ' AS NRO_COMPR_NO_DOMIC, num_spot nro_detrac, FECHA_spot fecha_detrac, Tipo_Cambio, 
  FECHA_ND_NC, 
  --right(TIPO_DOCU_ND_NC,2) TIPO_DOCU_ND_NC, 
  (select codi_sunat from tipo_documento t (nolock) where t.codi_tipo_docu = MOVI_CONTABLES.TIPO_DOCU_ND_NC) TIPO_DOCU_ND_NC,
  SERIE_ND_NC  , NRO_DOCU_ND_NC,            
  Codi_Contable, Nro_Cuen,  --CAMPOS DE MAS             
   Registro, Glosa,  num_spot, fecha_spot,--CAMPOS DE MAS             
          Cargo_Abono, Mes, Subdia, Codi_Vouc, codi_nota_ingr, importe, nro_fact, codi_unid_oper ,     --CAMPOS DE MAS             
            
  TIPO_DOCU_IDEN.CODI_SUNAT as codi_sunat,             
  --CLIENTE_PROVEEDOR.RUC as ruc,            

  case when left(nro_cuen,2)='40' and (upper(CLIENTE_PROVEEDOR.denominacion) like '%SUNAT%' 
				or upper(CLIENTE_PROVEEDOR.denominacion) like '%SUPERINTENDENCIA NACIONAL DE ADMINISTRACION TRIBUTARIA%') then '' else
  CLIENTE_PROVEEDOR.RUC end ruc, 
          
  case when left(nro_cuen,2)='40' and (upper(CLIENTE_PROVEEDOR.denominacion) like '%SUNAT%' 
				or upper(CLIENTE_PROVEEDOR.denominacion) like '%SUPERINTENDENCIA NACIONAL DE ADMINISTRACION TRIBUTARIA%') then '' else
  case when left(tipo_pers,1)='N'then apel_1+isnull(' ' +apel_2,'') + isnull(' ' +nomb_1,'') + isnull(' ' +nomb_2,'')	
				else razo_soci end end clie_Prov, 
    
  isnull(TIPO_VENTA,1) tipo_venta,            
   case when left(nro_cuen,2) in ('42','43')    
   then (case when cargo_abono='A' then Importe_d else -1*Importe_d end) else 0 end as Dolares,	

   anio ,detraccion     ,
   isnull(rtrim((select codi_nacion_sunat from nacion N (nolock) where N.Codi_Nacion=CLIENTE_PROVEEDOR.CODI_NACION)),'') as pais,
   /*isnull(rtrim((select cod_sunat from convenio_evita_doble_tributacion C(nolock) where C.cod_conv_evita_dob_tribu=codi_conv_evita_dt)),'')*/ '' as convenio
   
 FROM dbo.MOVI_CONTABLES (nolock) INNER JOIN CLIENTE_PROVEEDOR (nolock) ON MOVI_CONTABLES.CODI_CLIE_PROV= CLIENTE_PROVEEDOR.CODI_CLIE_PROV            
 INNER JOIN TIPO_DOCU_IDEN (nolock) ON  TIPO_DOCU_IDEN.CODI_TIPO_DOCU_IDEN=CLIENTE_PROVEEDOR.CODI_TIPO_DOCU_IDEN            
 WHERE (Subdia = 'C' AND  Mes  = @mes AND  Anio = @anio
		and MOVI_CONTABLES.codi_tipo_docu in (select T.codi_tipo_docu from tipo_documento T(nolock) where upper(desc_tipo_docu) like '%NO DOMICILIADO%') 
		)
		 ) SQL            

 group by anio, mes,  compr            
) SQLD
GO
