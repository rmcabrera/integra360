CREATE PROCEDURE [dbo].[PA_Libro_Mayor_ple]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes  char(2)    
--select @anio ='2014', @mes  ='02'   
      
set nocount on       
set quoted_identifier off      
    
declare @tipo char(1)    
declare @SQLString nvarchar(2000)      
declare @Condi varchar(10)      
    
select @tipo='D'    
    
create table #TX (nro_cuen char(7) null, clase varchar(250) null, subclase varchar(250) null, linea_clase varchar(250) null, cuenta varchar(250) null,      
    fecha datetime, glosa varchar(250) null, debe numeric(12,2) null, haber numeric(12,2) null, registro varchar(11) null, serie varchar(20) null,      
    nro_docu varchar(20) null, compr varchar(10) null, subdia char(1) null,codi_contable char(10), docu char(4) null , banco char(7) null,
	anio char(4), mes char(2), estado char(1) null, codi_mone char(2) null , codi_clie char(5) null )      
      
if @Tipo='D' set @Condi ="=" else set @Condi="<="      
      
set @SQLString = "SELECT  nro_cuen,       
    (select desc_clas_cuen  from clases_cuentas clc (nolock) where clc.codi_clas_cuen  = left(M.nro_cuen,2) )  as Clase,      
    (select desc_subc   from sub_clas_cuen sc  (nolock) where sc.codi_subc   = left(M.nro_cuen,3) )  as Sub_Clase,      
    (select desc_LCC    from Linea_clase_c Lc  (nolock) where Lc.codi_LCC   = left(M.nro_cuen,5) )  as Linea_Clase,      
    (select desc_cuen   from cuentas_contable cc  (nolock) where cc.nro_cuen   = M.nro_cuen )   as Cuenta,      
    cast(convert(char(10),fecha,103) as datetime) as fecha,      
    glosa,       
    DEBE  = case when cargo_abono='C' THEN IMPORTE ELSE 0 END ,      
    HABER = case when cargo_abono='A' THEN IMPORTE ELSE 0 END ,      
    registro, 
    case when rtrim(ISNULL(serie,''))='' then 
				(select top 1 serie from Movi_Contables XX (nolock) 
						where XX.Registro=M.registro and not ISNULL(serie,'')='' /*and subdia in ('C','V','D')*/)
				else SERIE end 
		as serie, 
    nro_docu, compr, subdia,codi_contable  , codi_tipo_docu    , 
		banco, anio, mes, null, codi_mone, codi_Clie_prov
   FROM MOVI_CONTABLES M (nolock)        
	WHERE anio = '" + @ANIO + "' and mes " +@Condi+"'"+  @MES +"' order by nro_cuen, fecha,codi_contable"               
insert #Tx      
execute sp_executesql @SQLString      

insert #Tx       
SELECT  nro_cuen,       
    (select desc_clas_cuen  from clases_cuentas clc (nolock) where clc.codi_clas_cuen  = left(a.nro_cuen,2) )  as Clase,      
    (select desc_subc   from sub_clas_cuen sc  (nolock) where sc.codi_subc   = left(a.nro_cuen,3) )  as Sub_Clase,      
    (select desc_LCC    from Linea_clase_c Lc  (nolock) where Lc.codi_LCC   = left(a.nro_cuen,5) )  as Linea_Clase,      
    (select desc_cuen   from cuentas_contable cc  (nolock) where cc.nro_cuen   = a.nro_cuen )   as Cuenta,      
    cast(convert(char(10),fecha,103) as datetime) as fecha,      
    glosa,       
    DEBE  = case when cargo_abono='C' THEN IMPORTE ELSE 0 END ,      
    HABER = case when cargo_abono='A' THEN IMPORTE ELSE 0 END ,      
    registro, 
        case when rtrim(ISNULL(serie,''))='' then 
				(select top 1 serie from Movi_Contables XX (nolock) 
						where XX.Registro=A.registro and not ISNULL(serie,'')='' /*and subdia in ('C','V','D')*/)
				else SERIE end 
		as serie, 
     nro_docu, A.compr, subdia,codi_contable  , codi_tipo_docu    , banco, a.anio, a.mes, estado, codi_mone,
	codi_Clie_prov
   FROM MOVI_CONTABLES A (nolock)   
   join OPERAC_SUNAT_PLE B (nolock)     
   on A.anio=B.anio_regis and A.mes =B.mes_regis and A.subdia=B.subdia_regis and A.compr=B.compr
	WHERE B.anio = @ANIO and B.mes = @MES 
order by nro_cuen, fecha,codi_contable

                
select anio+mes+'00'+'|'+
		case when subdia='V' then
			anio+mes+'V'+cast(cast(docu as int) as varchar)+  rtrim(case when serie='-' then '' else  '-'+rtrim(serie)+'-' end)+rtrim(nro_docu)+'COD:'+codi_contable+'|'      
		else
			anio+mes+subdia+rtrim(compr)+'COD:'+codi_contable +'|'
		end +
	case subdia when 'S' then 'A' when 'X' then 'C' else 'M' end + rtrim(compr) +'|' +
	rtrim(isnull(nro_cuen,''))+'|'+
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
	replace(case when rtrim(glosa)='' then 'Glosa' else  cast(rtrim(isnull(replace(glosa,'/','-'),'Glosa')) as varchar(100)) end,'|','')+'|'+
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

	case when estado is null then 
		case when mes=cast(@mes as int) and anio=cast(@ANIO as int) then '1' else '1' end 
	else estado end  +'|'+
	'|'
from #Tx  t
--where not(debe=0 and haber=0)  -- and subdia='C'
      
drop table #Tx      
      
set quoted_identifier on
GO
