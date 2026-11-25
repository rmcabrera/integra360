CREATE PROCEDURE [dbo].[PA_validar_libro_mayor_fechas]
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes  char(2)      
--select @anio ='2012', @mes  ='01'       
        
set nocount on         
set quoted_identifier off        
      
declare @tipo char(1)      
declare @SQLString nvarchar(2000)        
declare @Condi varchar(10)        
      
select @tipo='D'      
      
create table #TX (nro_cuen char(7) null, clase varchar(250) null, subclase varchar(250) null, linea_clase varchar(250) null, cuenta varchar(250) null,        
    fecha datetime, glosa varchar(250) null, debe numeric(12,2) null, haber numeric(12,2) null, registro varchar(11) null, serie char(5) null,        
    nro_docu varchar(20) null, compr varchar(10) null, subdia char(1) null,codi_contable char(10))        
        
if @Tipo='D' set @Condi ="='" else set @Condi="<='"        
        
set @SQLString = "SELECT  nro_cuen,         
    (select desc_clas_cuen  from clases_cuentas clc (nolock) where clc.codi_clas_cuen  = left(movi_contables.nro_cuen,2) )  as Clase,        
    (select desc_subc   from sub_clas_cuen sc  (nolock) where sc.codi_subc   = left(movi_contables.nro_cuen,3) )  as Sub_Clase,        
    (select desc_LCC    from Linea_clase_c Lc  (nolock) where Lc.codi_LCC   = left(movi_contables.nro_cuen,5) )  as Linea_Clase,        
    (select desc_cuen   from cuentas_contable cc  (nolock) where cc.nro_cuen   = movi_contables.nro_cuen )   as Cuenta,        
    cast(convert(char(10),fecha,103) as datetime) as fecha,        
    glosa,         
    DEBE  = case when cargo_abono='C' THEN IMPORTE ELSE 0 END ,        
    HABER = case when cargo_abono='A' THEN IMPORTE ELSE 0 END ,        
    registro, serie , nro_docu, compr, subdia,codi_contable        
   FROM MOVI_CONTABLES (nolock)        
   WHERE anio = '" + @ANIO + "' and mes " +@Condi+  @MES +"'order by nro_cuen, fecha,codi_contable"        
        
        
        
insert #Tx        
execute sp_executesql @SQLString        
      
      
      
      
declare @ta table (nro_cuen char(7) null, clase varchar(250) null, subclase varchar(250) null, linea_clase varchar(250) null, cuenta varchar(250) null,        
    fecha datetime, glosa varchar(250) null, debe numeric(12,2) null, haber numeric(12,2) null, registro varchar(11) null, serie char(5) null,        
    nro_docu varchar(20) null, compr varchar(10) null, subdia char(1) null,idd int IDENTITY,codi_contable char(10))        
      
insert @ta      
      
select nro_cuen, clase, subclase, linea_clase, cuenta,  fecha , glosa , debe, haber , registro , serie ,  nro_docu , compr , subdia,codi_contable    
from #Tx        
where not (subdia in ('A', 'S','X','K') and left(nro_cuen,1)='9')        
union all        
select nro_cuen, max(clase), max(subclase), max(linea_clase), max(cuenta),          
 max(fecha) ,         
        case subdia  when 'A' then 'Automático' when 'K' then 'Consumos del Mes' when 'S' then 'Saldos Iniciales' when 'X' then 'Asiento de Cierre' else '' end ,        
        sum(debe), sum(haber) , '' registro , '' serie ,  '' nro_docu , '' compr , subdia ,max(codi_contable)     
from #Tx        
where subdia in ('A', 'S','X','K') and left(nro_cuen,1)='9'        
group by nro_cuen, subdia       
      
      
      
select compr,fecha,rtrim(isnull(nro_cuen,'')) nro_cuen,subdia,@mes mes ,@anio anio  
from @ta      
where not(debe=0 and haber=0)    and cast(convert(char(10),fecha,103) as datetime)>CAST(CAST(dbo.f_ultimo_dia  (cast(@mes AS INT), CAST(@anio AS int) ) AS VARCHAR)+'/'+RIGHT('00'+@MES,2)+'/'+@ANIO AS DATETIME)  
        
drop table #Tx        
        
set quoted_identifier on
GO
