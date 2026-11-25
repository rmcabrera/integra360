CREATE PROCEDURE [dbo].[usp_alterta_pago_polizas]
	@fecha_hoy [datetime]
WITH EXECUTE AS CALLER
AS
--declare @fecha_hoy datetime          
--select @fecha_hoy='30/11/2012'          
        
          
declare @fech_adqui datetime,@fech_vigen datetime,@n_meses_pago int, @dia_pago int,@dias_aviso int,@codi_poli numeric(18,0)          
declare @i int          
          
declare @dia int,@mes int ,@anio int          
declare @fech_aux datetime          
declare @t_fechas table (fecha datetime,codi_poli numeric(18,0))          
          
DECLARE c1 CURSOR FOR           
select fech_adqui,fech_vigen,n_meses_pago,dia_pago,dias_aviso,codi_poli from polizas (nolock)         
 WHERE FECH_VIGEN>=@FECHA_HOY        
OPEN c1           
 FETCH NEXT FROM c1 INTO @fech_adqui, @fech_vigen, @n_meses_pago,@dia_pago,@dias_aviso,@codi_poli          
 WHILE @@FETCH_STATUS = 0           
 BEGIN           
          
          
 set @i=1          
           
 --set @dia=day(@fech_adqui)          
 set @dia=@dia_pago          
 set @fech_aux=@fech_adqui          
          
 /**Inicia con la primera fecha*/          
 IF @dia<=day(@fech_adqui)      
 begin      
  if  month(@fech_adqui)=12      
  begin       
   insert @t_fechas          
   select cast(right('00'+cast(@dia as varchar),2)+'/'+right(('00'+'1'),2)+'/'+right(('0000'+cast(year(@fech_aux)+1 as varchar)),4) as datetime),@codi_poli          
   set @mes=1        
   set @anio=year(@fech_aux)+1      
  end      
  else      
  begin      
   insert @t_fechas          
   select cast(right('00'+cast(@dia as varchar),2)+'/'+right(('00'+cast(month(@fech_aux)+1 as varchar)),2)+'/'+right(('0000'+cast(year(@fech_aux) as varchar)),4) as datetime),@codi_poli          
   set @mes=month(@fech_aux) +1         
   set @anio=year(@fech_aux)          
  end      
 end      
 else      
 begin      
  insert @t_fechas          
  select cast(right('00'+cast(@dia as varchar),2)+'/'+right(('00'+cast(month(@fech_aux) as varchar)),2)+'/'+right(('0000'+cast(year(@fech_aux) as varchar)),4) as datetime),@codi_poli          
          
  set @mes=month(@fech_aux)          
  set @anio=year(@fech_aux)          
      
 end      
      
 --select @mes,@anio          
 /***/          
          
          
 WHILE @i < @n_meses_pago          
 BEGIN          
          
   if @mes=12           
   begin          
       set @mes=0            
       set @anio=@anio+1          
        insert @t_fechas          
        select cast(right('00'+cast(@dia as varchar),2)+'/'+right(('00'+cast(@mes+1 as varchar)),2)+'/'+right(('0000'+cast(@anio as varchar)),4) as datetime),@codi_poli          
   end           
   else          
   begin          
  insert @t_fechas          
  select cast(right('00'+cast(@dia as varchar),2)+'/'+right(('00'+cast(@mes+1 as varchar)),2)+'/'+right(('0000'+cast(@anio as varchar)),4) as datetime),@codi_poli          
   end          
          
            
 --  select @fech_aux          
          
   set @i=@i+1          
   set @mes=@mes+1          
          
 END          
FETCH NEXT FROM c1           
INTO @fech_adqui, @fech_vigen, @n_meses_pago,@dia_pago,@dias_aviso,@codi_poli          
END           
 CLOSE c1           
 DEALLOCATE c1           
          
        
          
          
select t.codi_poli,fecha fecha_pago,dbo.uf_dia_pago(DATEADD(DAY, -1*dias_aviso, fecha)) fecha_aviso,        
descripcion+isnull('-'+tipo,'') poliza,codi_clie_prov,(select desc_unid_oper from unid_oper (nolock) where codi_unid_oper=p.codi_unid_oper) unidad,        
rtrim((select simbolo from monedas (nolock) where codi_mone=p.codi_mone))+' '+cast(monto_mensual as varchar) monto  
from @t_fechas t left join  polizas p (nolock)  on p.codi_poli=t.codi_poli        
where dbo.uf_dia_pago(DATEADD(DAY, -1*dias_aviso, fecha)) =@fecha_hoy
GO
