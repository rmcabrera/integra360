CREATE PROCEDURE [dbo].[usp_comision_producto]
	@mes [int],
	@anio [int]
WITH EXECUTE AS CALLER
AS
--declare  @mes int , @anio int    
--select  @mes =11 , @anio =2012    
      
declare @codi_alma char(2)       
select @codi_alma ='00'      
      
declare @alma table (codi_alma char(2) null)        
IF @codi_alma = '00'        
BEGIN        
 insert @alma        
 Select codi_alma from almacen (nolock)        
END        
ELSE        
BEGIN        
 insert @alma        
 Select @codi_alma        
END        
      
      
declare @t table (codi_prod char(8),desc_prod varchar(200),desc_pres varchar(252),codi_alma char(2),cantidad numeric(18,3),valor numeric(18,4),costo numeric(18,4))      
insert @t      
select distinct PROD.codi_prod ,prod.desc_prod, PRES.DESC_PRES ,fac.codi_alma,      
sum( FD.CANT_ITEM ) cantidad ,          
sum( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )  ) valor,      
sum( (CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO ) ) costo               
               
FROM FACTURA as FAC  (nolock)      
   inner join FACTURA_DETALLE  as FD  (nolock)on FAC.codi_fact = FD.codi_fact        
   inner join ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)        
   inner join PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod        
   INNER join PRESENTACION  AS PRES  (nolock)ON PROD.COD_PRES=PRES.COD_PRES        
   inner join Producto_Comision com (nolock) on prod.codi_prod=com.codi_prod      
where    month(fac.fech_fact)=@mes and year(fac.fech_fact)=@anio    
   AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)        
   AND fac.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)        
group by PROD.CODI_PROD,PRES.desc_pres,FAC.CODI_ALMA,PROD.DESC_PROD      
    
    
insert comisiones    
select mes,anio,codi_alma,sqlt.codi_prod,sqlt.desc_prod,sqlt.desc_pres,cantidad,valor,comision,valor_comision,    
codi_depen,isnull(p.desc_prod,'') desc_prod_depen,isnull(pres.desc_pres,'') desc_pres_depen    
from     
(    
/***Primero recuperamos los que no dependen de otro **/      
select @mes mes, @anio anio,codi_alma,codi_prod,desc_prod,desc_pres, cantidad,valor,      
case when valor < inicio then 0 else comision end  comision,      
case when valor<=fin then  cantidad *  (case when valor < inicio then 0 else comision end )       
 else (cantidad*fin/valor) * ( case when valor < inicio then 0 else comision end ) end valor_comision,'' codi_depen    
      
 from      
(      
select t.codi_prod,t.desc_prod,t.desc_pres,codi_alma,cantidad,valor,inicio,comision,fin      
from @t t inner join Producto_Comision com (nolock) on t.codi_prod=com.codi_prod       
where codi_depen is null or codi_depen='')Sql          
      
      
union      
/***Recuperamos los que dependen de otro **/      
select @mes mes,@anio anio,codi_alma,codi_prod,desc_prod,desc_pres,cantidad,valor,      
 case when nvo_valor < inicio then 0 else comision end  comision,      
case when nvo_valor<=fin then  nva_cantidad *  (case when nvo_valor < inicio then 0 else comision end )       
else (nva_cantidad * fin/nvo_valor)  * ( case when nvo_valor < inicio then 0 else comision end ) end valor_comision,codi_depen    
     
from      
(      
select codi_prod,desc_prod,desc_pres,codi_alma,nva_cantidad,case when cantidad = 0 then 0 else nva_cantidad*valor/cantidad end  nvo_valor,inicio,comision,fin,    
cantidad,valor ,codi_depen   
from      
(      
select t.codi_prod,t.desc_prod,t.desc_pres,codi_alma,cantidad,valor,inicio,comision,fin,codi_depen,      
isnull((select cantidad from @t b where b.codi_prod=com.codi_depen and b.codi_alma=t.codi_alma),0) cant_prod_depende,      
      
case when cantidad<= isnull((select cantidad from @t b where b.codi_prod=com.codi_depen and b.codi_alma=t.codi_alma),0) then      
   cantidad      
else      
 isnull((select cantidad from @t b where b.codi_prod=com.codi_depen and b.codi_alma=t.codi_alma),0)      
end nva_cantidad      
      
from @t t inner join Producto_Comision com (nolock) on t.codi_prod=com.codi_prod       
where not(codi_depen is null or codi_depen='')) SQl)sqlcad      
      
 ) sqlt left join productos p (nolock) on sqlt.codi_depen=p.codi_prod    
   left join PRESENTACION  AS PRES  (nolock) ON P.COD_PRES=PRES.COD_PRES
GO
