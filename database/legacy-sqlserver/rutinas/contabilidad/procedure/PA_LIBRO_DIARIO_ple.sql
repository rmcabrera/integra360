CREATE PROCEDURE [dbo].[PA_LIBRO_DIARIO_ple]
	@ANIO [char](4),
	@MES [char](2)
WITH EXECUTE AS CALLER
AS
--declare   @ANIO CHAR(4) ,  @MES CHAR(2) , @SUBDIA CHAR(1)         
--select @ANIO ='2015' ,  @MES ='11' , @SUBDIA =''        

set nocount on        
      
declare @ta table (compr varchar(10) null, fecha datetime, glosa varchar(250) null,codi_libro int,      
 nro_comp varchar(40), nro_cuen char(7) null, desc_cuen varchar(150),debe numeric(12,2) null, haber numeric(12,2) null,      
 dolar numeric(12,2) null,orden int,cargo_abono char(1),codi_contable char(10),subdia char(1), anio char(4) , 
	mes char(2) , codi_unid_oper char(5) null, docu char(4) null, serie varchar(20) null, nro_docu varchar(20) null, estado char(1) null,
	codi_mone char(2) null, codi_clie char(5) null)      
      
insert @ta            
SELECT        
  COMPR,         
  FECHA,        
  GLOSA,        
  CODI_LIBRO,        
  isnull(rtrim(serie),' ') + ' ' + rtrim(nro_docu) as NRO_COMPR,        
  NRO_CUEN,        
  (SELECT DESC_CUEN FROM CUENTAS_CONTABLE C(nolock) WHERE C.NRO_CUEN = M.NRO_CUEN) AS DESC_CUEN,        
  DEBE    =  case when cargo_abono ='C' THEN IMPORTE ELSE 0 END,        
  HABER = case when cargo_abono = 'A' THEN IMPORTE ELSE 0 END ,        
  DOLAR  = case when codi_mone='02' THEN IMPORTE_D ELSE 0 END,         
  subdiario.orden , cargo_abono , codi_contable ,subdia      , anio, mes, codi_unid_oper  ,
	codi_tipo_docu, 
	case when rtrim(ISNULL(serie,''))='' then 
				(select top 1 serie from Movi_Contables XX (nolock) 
						where XX.Registro=M.registro and not ISNULL(serie,'')='' /*and subdia in ('C','V','D')*/)
				else SERIE end 
		as serie, 	
	 nro_docu, null, codi_mone, codi_Clie_prov
 FROM  MOVI_CONTABLES M (nolock) INNER JOIN SUBDIARIO (nolock)ON SUBDIARIO.NEMOTEC =M.SUBDIA         
 WHERE ANIO=@ANIO AND MES = @MES        
 ORDER BY SUBDIARIO.ORDEN ,  CAST(COMPR AS BIGINT),codi_contable        


insert @ta         
SELECT        
  A.COMPR,         
  FECHA,        
  GLOSA,        
  CODI_LIBRO,        
  isnull(serie,' ') + ' ' + nro_docu as NRO_COMPR,        
  NRO_CUEN,        
  (SELECT DESC_CUEN FROM CUENTAS_CONTABLE C(nolock) WHERE C.NRO_CUEN = a.NRO_CUEN) AS DESC_CUEN,        
  DEBE    =  case when cargo_abono ='C' THEN IMPORTE ELSE 0 END,        
  HABER = case when cargo_abono = 'A' THEN IMPORTE ELSE 0 END ,        
  DOLAR  = case when codi_mone='02' THEN IMPORTE_D ELSE 0 END,         
  subdiario.orden , cargo_abono , codi_contable ,subdia      , A.anio, A.mes, codi_unid_oper  ,
	codi_tipo_docu,
		case when rtrim(ISNULL(serie,''))='' then 
				(select top 1 serie from Movi_Contables XX (nolock) 
						where XX.Registro=A.registro and not ISNULL(serie,'')='' /*and subdia in ('C','V','D')*/)
				else SERIE end 
		as serie, 
	 nro_docu, estado, codi_mone, codi_clie_prov
 FROM  MOVI_CONTABLES A(nolock) INNER JOIN SUBDIARIO (nolock)ON SUBDIARIO.NEMOTEC =A.SUBDIA         
 join OPERAC_SUNAT_PLE B 
 on A.anio=B.anio_regis and A.mes =B.mes_regis and A.subdia=B.subdia_regis and A.compr=B.compr
	WHERE B.anio = @ANIO and B.mes = @MES 
  ORDER BY SUBDIARIO.ORDEN ,  CAST(A.COMPR AS BIGINT),codi_contable  
 
/*
select sum(debe), sum(haber) 
from @Ta
where not (debe=0 and haber=0) */
       

select anio+mes+'00'+'|'+
	case when subdia='V' then
		anio+mes+'V'+cast(cast(docu as int) as varchar) +rtrim(case when serie='-' then '' else  '-'+rtrim(serie)+'-' end)+rtrim(nro_docu)+'COD:'+codi_contable +'|'      
	else
		anio+mes+subdia+compr+'COD:'+codi_contable +'|'
	end +
	case subdia when 'S' then 'A' when 'X' then 'C' else 'M' end + compr +'|' +
	rtrim(isnull(nro_cuen,''))+'|' +
	'|'+
	'|'+
	case when codi_mone='01' then 'PEN' else 'USD' end +'|'+
	
	isnull(cast((select (select codi_sunat from TIPO_DOCU_IDEN T (nolock) where T.Codi_Tipo_Docu_Iden=C.Codi_Tipo_Docu_Iden)
		from CLIENTE_PROVEEDOR C (nolock)	 where C.CODI_CLIE_PROV=codi_clie) as varchar),'') +'|'+

	isnull((select ruc from CLIENTE_PROVEEDOR C (nolock)	 where C.CODI_CLIE_PROV=codi_clie),'') +'|'+

	isnull(cast((select codi_sunat from tipo_documento X (nolock) where X.CODI_TIPO_DOCU= t.docu ) as varchar),'00')+'|'+

	case when isnumeric(rtrim(serie))=1 then right('0000'+rtrim(serie),4) else isnull(serie,'') end +'|'+
	
	case when isnull(cast((select codi_sunat from tipo_documento X (nolock) where X.CODI_TIPO_DOCU= t.docu ) as varchar),'00')='00' then
		case when rtrim(isnull(nro_docu,''))='' then '00' else rtrim(isnull(nro_docu,'')) end 
	else
		rtrim(isnull(nro_docu,'')) end +'|'+
	'|'+
	'|'+

	convert(char(10),fecha,103)+'|'+
	left(case when rtrim(glosa)='' then 'Glosa' else  cast(rtrim(isnull(replace(glosa,'/','-'),'Glosa')) as varchar(80)) end ,80) +'|'+
	'|'+
	isnull(cast((debe) as varchar),'0.00')+'|'+
	isnull(cast((haber) as varchar),'0.00')+'|'+    

	case when subdia='C' then 
			'080100' + '&' + cast(anio as varchar)+cast(mes as varchar)+'00'  +'&' +       
			+ anio+mes + subdia+right('00000'+rtrim(isnull(cast(compr as varchar),'')),4) +'&' +       
			+case subdia when 'S' then 'A' when 'X' then 'C' else 'M' end + right('0000'+cast(cast(rtrim(isnull(cast(compr as varchar),'')) as int) as varchar),4)
		 when subdia='V' then 
			'140100' + '&' + anio+mes+'00' +'&' +
			+anio+mes+'V'+cast(cast(docu as int) as varchar) + rtrim(case when serie='-' then '' else  '-'+rtrim(serie)+'-' end)+rtrim(nro_docu)+'&'     
			+case 'V' when 'S' then 'A' when 'X' then 'C' else 'M' end + rtrim(compr)  
		 else '' end +'|'     +

	case when estado is null then case when mes=cast(@mes as int) and anio=cast(@ANIO as int) then '1' else 
		case when subdia='S' then '9' else '1' /*'8'*/ end end  
	else estado end +'|'+
	'|'
from @ta as T     
--where not(debe=0 and haber=0)
GO
