CREATE PROCEDURE [dbo].[USP_acta_entrega]
	@codi_act [numeric](18, 0)
WITH EXECUTE AS CALLER
AS
--declare @codi_act numeric     
--select @codi_act=1    
    
DECLARE @x VARCHAR(5000),  @xf VARCHAR(5000)                         
declare @f varchar(500),@ff datetime    
    
set @x=''     
set @xf=''    
DECLARE c1 CURSOR FOR    
  select distinct desc_tipo_docu+ ' N° '+ rtrim(ser_Fact)+'-'+rtrim(nro_fact) as factura,    
  fech_fact    
  from acta_entrega_detalle e (nolock) join convenio c (nolock) on c.codi_conv=e.codi_conv    
         right join factura f (nolock) on f.codi_fact=c.codi_fact      
          join tipo_documento t (nolock) on t.codi_tipo_docu=f.codi_tipo_docu    
  where codi_act=@codi_act    
OPEN c1                     
FETCH NEXT FROM c1 INTO @f,@ff         
WHILE @@FETCH_STATUS = 0              
 BEGIN                     
 if @x=''     
  begin                    
  set @x=@x+ @f       
  set @xf=@xf+ convert(char(10),@ff,103)    
  end    
 else    
  begin                     
  set @x=@x+'; ' +@f     
  set @xf=@xf+ convert(char(10),@ff,103)    
  end     
FETCH NEXT FROM c1 INTO @f,@ff    
END                     
CLOSE c1                     
DEALLOCATE c1            
    
select right('00'+cast(day(a.fecha) as varchar(2)),2) dia_fecha,    
case month(fecha) when 1 then 'Enero'    
    when 2 then 'Febrero'    
    when 3 then 'Marzo'    
    when 4 then 'Abril'    
    when 5 then 'Mayo'    
    when 6 then 'Junio'    
    when 7 then 'Julio'    
    when 8 then 'Agosto'    
    when 9 then 'Setiembre'    
    when 10 then 'Octubre'    
    when 11 then 'Noviembre'    
    when 12 then 'Diciembre'    
end mes_fecha,    
year(a.fecha) as anio,    
SUBSTRING ( CONVERT(char(38),a.fecha,121), 12,5) AS hora_fecha,    
isnull(a.persona_responsable,' ') persona_responsable ,isnull(a.dni,'') dni,isnull(a.domicilio,'') domicilio,    
isnull(p.apel_1,'')+isnull(' '+p.apel_2,'')+isnull(' '+p.nomb_1,'')+isnull(' '+p.nomb_2,'')  representante,    
isnull(ti.nemo,'') tipo_dcto_identidad_agro,isnull(nro_docu_iden,'') nro_dcto_identidad_agro,    
nemo_alma as sucursal,    
rtrim((select  Razon_Social from Empresa)) empresa_agro,    
@x as facturas,@xf fechas_facturas,    
rtrim(al.direccion) direccion_agro,    
case when a.codi_alma='01' then 'CHIMBOTE' else nemo_alma end ciudad_sucursal,    
a.nro ,    
(select case when denominacion is null or rtrim(denominacion)='' then razo_soci else denominacion end denominacion) cliente,                    
(select nemo from tipo_docu_iden                    
 where codi_tipo_docu_iden=(select codi_tipo_docu_iden from cliente_proveedor where codi_clie_prov= cp.codi_clie_prov))+' N° '+cp.ruc dcto_cliente,                 
case when p.sexo='M' then 'del Sr.' else 'de la Sra.' end sexo_repre_agro    
from acta_entrega a (nolock) right join almacen al (nolock) on al.codi_alma=a.codi_alma    
        left join personal p (nolock) on p.codi_pers=al.representante    
           full join  tipo_docu_iden ti (nolock) on ti.codi_tipo_docu_iden=p.codi_tipo_docu_iden     
        full join  cliente_proveedor cp (nolock) on cp.codi_clie_prov=a.codi_clie_prov                    
where codi_act=@codi_act
GO
