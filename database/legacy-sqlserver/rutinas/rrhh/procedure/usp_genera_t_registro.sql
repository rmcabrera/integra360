CREATE PROCEDURE [dbo].[usp_genera_t_registro]
	@anio [int],
	@mes [int],
	@TipoEstru [varchar](2)
WITH EXECUTE AS CALLER
AS
set nocount on                                           
                                          
--declare @anio int, @mes int , @TipoEstru varchar(2)                                           
--select @anio =2012, @mes =1 ,  @TipoEstru='7'                                                  
                                          
declare @Ruc varchar(11)                                              
create table #Rx ( campo nvarchar(1000) null)                                           
                                          
select @Ruc =ruc from empresa (nolock)                                          
                                           
if @TipoEstru='1'   --------------------Archivo de Establecimiento Propios                                          
 insert #Rx                                          
 select codigo_denomi+'|' + centro_riesgo  +'|'  as Campo                                          
 from EMPRESA_ESTABLECIMIENTO (nolock)                                          
                                          
set nocount on                                           
                                          
if @TipoEstru='2'   --------------------Archivo de Empleadores a quienes destaco o desplazo personal.                                          
begin                                          
 insert #Rx                                          
 SELECT  ((SELECT isnull(rtrim(RUC),'') FROM DBO.CLIENTE_PROVEEDOR (nolock)                                          
   where DESPLAZO_PERSONAL.codi_clie_prov=cliente_proveedor.codi_clie_prov) + '|' +                                           
  (select isnull(rtrim(codi_acti_sunat),'') from dbo.actividad (nolock)                                          
    where desplazo_personal.codi_acti=actividad.codi_acti) + '|' +                                           
  isnull(rtrim(convert(char(10),fecha_inicio,103)),'') + '|' +                                          
   isnull(rtrim(convert(char(10),fecha_fin,103)),'') + '|' )  as campo                                          
 FROM DESPLAZO_PERSONAL(nolock)                                           
 WHERE year(DESPLAZO_PERSONAL.fecha_inicio)=@anio and                                           
  month(DESPLAZO_PERSONAL.fecha_inicio)=@mes                                          
                                          
end                                          
                                          
if @TipoEstru='2a'--------------------Archivo de Empleadores a quienes destaco o desplazo personal SCRT                                          
begin                                          
 insert #Rx                                          
 SELECT  ((SELECT isnull(rtrim(RUC),'') FROM DBO.CLIENTE_PROVEEDOR (nolock)                                          
   where DESPLAZO_PERSONAL.codi_clie_prov=cliente_proveedor.codi_clie_prov) + '|' +                                           
  isnull(codi_estable,'') +'|'+ isnull(indicador,'0')+'|')  as campo                                           
 FROM DESPLAZO_PERSONAL(nolock)                                           
 WHERE year(DESPLAZO_PERSONAL.fecha_inicio)=@anio and                                           
  month(DESPLAZO_PERSONAL.fecha_inicio)=@mes                                          
                                          
end                                          
                                          
if @TipoEstru='3' --------------------Empleadores que me destacan o desplazan personal                                          
begin                                          
 insert #Rx                                          
 SELECT  ((SELECT ISNULL(RTRIM(RUC),'') FROM DBO.CLIENTE_PROVEEDOR(NOLOCK)                                          
   where DESPLAZAN_PERSONAL.codi_clie_prov=cliente_proveedor.codi_clie_prov) + '|' +                                           
  (select ISNULL(RTRIM(codi_Acti_Sunat),'') from dbo.actividad                                           
   where desplazan_personal.codi_acti=actividad.codi_acti) + '|' +                                           
   ISNULL(RTRIM(convert(char(10),DESPLAZAN_PERSONAL.fecha_inic,103)),'') + '|' +                                           
   ISNULL(RTRIM(convert(char(10),DESPLAZAN_PERSONAL.fecha_fin,103)),'') + '|') as campo                                          
 FROM DESPLAZAN_PERSONAL(nolock)                                           
 WHERE year(DESPLAZAN_PERSONAL.fecha_inic)=@anio and month(DESPLAZAN_PERSONAL.fecha_fin)=@mes                                          
end                                          
                           
if @TipoEstru='5'   --------------------Archivo Datos del Trabajador                                          
begin                                     
 declare @mes_aux int                                          
 declare @anio_aux int                                          
 set @mes_aux=@mes  + 1                                   
 set @anio_aux=@anio                                          
 if @mes=12                                          
 begin                                          
  set @mes_aux=1                                           
  set @anio_aux=@anio + 1                                          
 end                                          
                                           
 declare @Tra table ( codi_pers char(5) null, tipo_situ char(2) null)                                          
                                          
 insert @Tra                                          
/* select distinct codi_pers ,                                          
  (select (select codi_situ_trab_pens_sunat from                                           
    SITU_TRAB_PENS S (nolock) where S.Codi_Situ_Trab_Pens=X.Codi_Situ_Trab_Pens)                                          
    from personal_categoria X where X.codi_pers=p.codi_pers)                                          
 from planilla_de_empleados P (nolock) where anio=@anio and mes=@mes and codi_tipo_pers<>'04'                                          
 union all                                          
 select distinct codi_pers ,                                           
  (select (select codi_situ_trab_pens_sunat from                                           
    SITU_TRAB_PENS S (nolock) where S.Codi_Situ_Trab_Pens=X.Codi_Situ_Trab_Pens)                                          
    from personal_categoria X where X.codi_pers=p.codi_pers)                                          
 from planilla_de_obreros P (nolock) where anio=@anio and mes=@mes and codi_tipo_pers<>'04'     */                                    
select distinct codi_pers ,                                         
 (select codi_situ_trab_pens_sunat from SITU_TRAB_PENS S (nolock) where S.Codi_Situ_Trab_Pens IN                                    
  (SELECT X.Codi_Situ_Trab_Pens from personal_categoria X where X.codi_pers=p.codi_pers) )                                    
 from planilla_de_empleados P (nolock) where anio=@anio and mes=@mes and codi_tipo_pers<>'04'                                          
union all                                          
 select distinct codi_pers ,                                           
 (select codi_situ_trab_pens_sunat from SITU_TRAB_PENS S (nolock) where S.Codi_Situ_Trab_Pens IN                                    
  (SELECT X.Codi_Situ_Trab_Pens from personal_categoria X where X.codi_pers=p.codi_pers) )                                         
 from planilla_de_obreros P (nolock) where anio=@anio and mes=@mes and codi_tipo_pers<>'04'                                       
/*                                          
 insert @Tra                                          
 SELECT DISTINCT p.CODI_PERS , (select (select codi_situ_trab_pens_sunat from                                      
    SITU_TRAB_PENS S (nolock) where S.Codi_Situ_Trab_Pens=X.Codi_Situ_Trab_Pens)                                          
    from personal_categoria X where X.codi_pers=p.codi_pers)                                          
 FROM PERSONAL P (nolock),  PERSONAL_POR_TIPO_TRABAJADOR PP (nolock)                                          
 WHERE ( PP.CODI_PERS = P.CODI_PERS ) and isnull(pp.codi_tipo_pers,'')<>'04'                                           
   and p.esta_acti=1                                          
  and p.codi_pers  not in (select codi_pers from personal  (nolock)                                          
                   where esta_acti=1 and year(fech_ingre)=@anio_aux and month(fech_ingre)=@mes_aux)                                           
  and p.codi_pers  not in (select T.codi_pers FROM @Tra T )                                          
  and p.codi_pers not in (select codi_pers from LICENCIAS_POR_PERSONAL L (nolock)                                          
        where month(L.fech_inic)=@mes  and year(L.fech_inic)=@anio )                                  
                                
*/                                
 insert @Tra                                          
 SELECT DISTINCT p.CODI_PERS ,                                 
    (select codi_situ_trab_pens_sunat from SITU_TRAB_PENS S (nolock) where S.Codi_Situ_Trab_Pens in                                
    (select X.Codi_Situ_Trab_Pens from personal_categoria X where X.codi_pers=p.codi_pers))                     
 FROM PERSONAL P (nolock),  PERSONAL_POR_TIPO_TRABAJADOR PP (nolock)                                          
 WHERE ( PP.CODI_PERS = P.CODI_PERS ) and isnull(pp.codi_tipo_pers,'')<>'04'                                           
   and p.esta_acti=1                                          
  and p.codi_pers  not in (select codi_pers from personal  (nolock)                                          
                   where esta_acti=1 and year(fech_ingre)=@anio_aux and month(fech_ingre)=@mes_aux)                               
  and p.codi_pers  not in (select T.codi_pers FROM @Tra T )                                          
  and p.codi_pers not in (select codi_pers from LICENCIAS_POR_PERSONAL L (nolock)                                          
        where month(L.fech_inic)=@mes  and year(L.fech_inic)=@anio )                                         
                        
  insert #Rx                                  
  select isnull(right('00'+cast(TDI.Codi_Sunat as varchar(2)),2),'') + '|' +                                           
  isnull(cast(nro_docu_iden as varchar(15)),'')+'|'+                                          
  isnull(case when TDI.Codi_Sunat=7 then codi_pais_emi else '' end ,'')+'|'+                                           
  isnull(codi_regi_labo,'')+'|' +                                           
  isnull(codi_nivel_sunat,'') + '|'+                                          
  isnull(codi_ocu_sunat,'') + '|'+ cast(isnull(discapacidad,0) as varchar)+'|'+                                           
  isnull(cast(T.nro_cupss as varchar(12)),'')+'|'+ isnull(cast(sctr_pension as varchar),'0') +'|'+                                          
  isnull(codi_tipo_cont_sunat,'')+'|'+ cast(isnull(sujeto_reg_alter,0) as varchar) +'|'+                                    
  cast(isnull(sujeto_jornada_max,0) as  varchar)+'|'+ cast( isnull(horario_noctur,0) as varchar) +'|'+                                          
  cast( isnull(sindicalizado,0) as varchar)+'|'+ cast(codi_periodo as varchar)+'|'+                                        
  cast(isnull(suel_basi,0)as varchar)+'|'+                                    
  cast(isnull(ST.Codi_Situ_Trab_Pens_plame,'')as varchar)+'|'+                                        
  cast(isnull(renta_qta_cat_exo_inaf,0)as varchar)+'|'+                                        
  cast(isnull(ct.codi_sunat,0)as varchar)+'|'+                                        
  cast(isnull(tp.codi_sunat,0)as varchar)+'|' +                                      
  CASE                                   
         WHEN t.cod_categ_ocup is null THEN (select isnull(right('00'+cast(c.codigo_sunat as varchar(2)),2),'') from categoria_ocupacional c where c.cod_categ_ocup=t.codi_tipo_pers)                                      
         WHEN t.cod_categ_ocup is not null THEN (select isnull(right('00'+cast(c.codigo_sunat  as varchar(2)),2),'') from categoria_ocupacional c where c.cod_categ_ocup=t.cod_categ_ocup)                                      
  END +'|'+                                    
  +'0|'+                                    
  cast(isnull(t.ruc,'')as varchar)+'|'                                    
                                        
 from @Tra A                                          
 join Personal P  (nolock)                                          
on A.codi_pers=P.codi_pers                                          
 join PERSONAL_CATEGORIA T (nolock) on P.codi_pers=T.codi_pers and tipo_cat_trab='T'                                          
 left join Tipo_Docu_Iden TDI (nolock)on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden                
 left join via v (nolock) on v.codi_via=p.codi_via                                          
 left join zona z (nolock) on z.codi_zona=p.codi_zona                                          
 left join ocupacion O (nolock) on O.codi_ocu=T.codi_ocu                                          
 left join nivel N (nolock) on N.codi_nivel=T.codi_nivel                                          
 left join tipo_contrato C (nolock) on C.codi_tipo_cont=T.codi_tipo_cont                                          
 left join SITU_TRAB_PENS ST (nolock) on st.codi_situ_trab_pens=T.codi_situ_trab_pens                                        
 left join categoria_trabajador ct (nolock) on ct.codi_cate_trab=T.codi_cate_trab                                        
 left join tipo_pago tp(nolock) on tp.Codi_Tipo_Medio_Pago=T.Codi_Tipo_Medio_Pago                                        
end                                           
                            
if @TipoEstru='7'   --------------------Prestador de Servicios con Rentas de Cuarta categoría                                    
begin                        
                  
 create table #recibos_x_honorarios   (codi_clie_prov char(5) COLLATE SQL_Latin1_General_CP1_CI_AS  )                    
   declare @codi_vouc varchar(10)                    
 declare @codi_clie_prov char(5)                    
                    
 declare C1 cursor                     
 for select distinct mov.codi_clie_prov                    
 from cliente_proveedor cp                    
  inner join movi_contables mov on cp.codi_clie_prov=mov.codi_clie_prov                     
 where mov.anio=@ANIO and mov.mes=@MES and mov.subdia='H' and left(nro_cuen,2) ='42' and isnull(ltrim(registro),'')<>''                    
                    
 open C1                    
 fetch C1 into @codi_clie_prov                     
                    
 WHILE @@FETCH_STATUS = 0                    
  begin                    
   insert into #recibos_x_honorarios                    
   (codi_clie_prov)                    
   values(@codi_clie_prov)                    
                    
   fetch C1 into  @codi_clie_prov                     
  end                    
                    
 close C1                    
 deallocate C1                    
    insert #Rx                     
 select  distinct ( '06|' + isnull(cp.ruc,'') +  '|' + cast( isnull(cp.apel_1,'')  as varchar(40) )+ '|' +cast( isnull(cp.apel_2,'') as varchar(40)) + '|'                     
 + cast(isnull(cp.nomb_1,'') as varchar(40))  + ' ' +  cast(isnull(cp.nomb_2,'') as varchar(40) )+ '|' + isnull(cp.domiciliado,1) + '|' +  '0|'   )                    
 from  cliente_proveedor cp inner join (select distinct codi_clie_prov from #recibos_x_honorarios) h on cp.codi_clie_prov=h.codi_clie_prov                    
 left join nacion n on n.codi_nacion=cp.codi_nacion                    
                    
 drop table #recibos_x_honorarios                             
end                   
                               
if @TipoEstru='13'   --------------------Derecho Habiente ALtas                                    
begin                                 
insert #Rx                                
select                                
 cast( (select right('00'+cast(td.Codi_Sunat as varchar),2) from TIPO_DOCU_IDEN td(nolock)                                     
  where td.Codi_Tipo_Docu_Iden=PERSONAL.Codi_Tipo_Docu_Iden                                    
   and personal.codi_pers not in ('00000') ) as varchar(2)) + '|'  +---dcto                              
                                
 PERSONAL.NRO_DOCU_IDEN + '|'+                                      
                            
 cast( (select right('00'+cast(td.Codi_Sunat as varchar),2) from TIPO_DOCU_IDEN td (nolock)                                    
  where td.Codi_Tipo_Docu_Iden= DERECHO_HABIENTE.Codi_Tipo_Docu_Iden) as varchar(2))+ '|'+                                       
                                
 DERECHO_HABIENTE.NRO_DOCU_IDEN  + '|'+ isnull(codi_pais,'')+'|' +                                       
 isnull(convert(varchar(10), DERECHO_HABIENTE.fech_naci,103),'') + '|'+                        
 isnull(DERECHO_HABIENTE.APEL_1,'') + '|'+                                    
 isnull(DERECHO_HABIENTE.APEL_2,'') + '|'+                                       
 isnull(DERECHO_HABIENTE.NOMB_1,'') +' '+isnull(DERECHO_HABIENTE.NOMB_2,2)+ '|' +                                      
 isnull(Case when  DERECHO_HABIENTE.SEXO='F' then '2' else '1' end ,'') + '|'+                                   
 isnull(right('00'+CAST(VINCULO_FAMILIAR.Codi_Vinc_Fami_Sunat AS VARCHAR(2)),2),'')+ '|' +                                   
 --isnull(VINCULO_FAMILIAR.codi_tregistro  ,'')+ '|' +                                    
 isnull(right('00'+cast(DERECHO_HABIENTE.tipo_doc_acred_pater as varchar(2)),2),'') + '|'+                                    
 isnull(DERECHO_HABIENTE.nro_doc_acred_pater ,'') + '|'+                                    
 isnull(rtrim(mesconcep),'')+'|'+                                    
                                
 case                                  
 when cast( (select right('00'+cast(td.Codi_Sunat as varchar),2) from TIPO_DOCU_IDEN td (nolock)                                    
       where td.Codi_Tipo_Docu_Iden= DERECHO_HABIENTE.Codi_Tipo_Docu_Iden) as varchar(2)) in('07','04') then                                 
     (case derecho_habiente.domicilio                                
      when '0' then + isnull((select via.codi_via_sunat from via where via.codi_via=PERSONAL.Codi_Via),'') + '|'+                                
                      isnull(PERSONAL.Nomb_via,'') + '|'+                                
                        isnull(PERSONAL.Num_via,'' )+ '|'+                                
                        '|'+  ---departamento                                  
                        isnull(PERSONAL.Interior_via,'') + '|'+                                
        '|'+  ---manzana                                    
                        '|'+  ---lote                                 
                        '|'+  ---kilometro                                    
                        '|'+  ---block                                    
                        '|'+  ---etapa                                   
                        isnull(cast((select ZONA.Codi_Zona_Sunat from zona where ZONA.Codi_Zona=PERSONAL.Codi_Zona) as varchar(2)),'')+ '|'+                                
 isnull(cast(PERSONAL.Nomb_Zona as varchar(20)),'')+ '|'+                                
                        isnull(cast(PERSONAL.refe_zona as varchar(40)),'' )+ '|'+                                
                        isnull (cast((select UBIGEO_DISTRITO.Codi_Ubi_Dist_Sunat from UBIGEO_DISTRITO where  UBIGEO_DISTRITO.codi_ubi_dist=PERSONAL.Codi_Ubi_Dist)as varchar(6)),'')+'|'                                
                                
      when '1' then + isnull(VIA.Codi_Via_Sunat,'') + '|'+                                    
               isnull(DERECHO_HABIENTE.Nomb_via,'') + '|'+                                       
       isnull(DERECHO_HABIENTE.Num_via,'') + '|'+                                       
        '|'+  ---departamento                                    
              isnull(DERECHO_HABIENTE.Interior_via,'') + '|'+                                       
        '|'+  ---manzana                                    
        '|'+  ---lote                                    
        '|'+  ---kilometro                                    
        '|'+  ---block                                    
        '|'+  ---etapa                                    
        isnull(cast(ZONA.Codi_Zona_Sunat as varchar(2)),'') + '|'+                                    
        isnull(cast(DERECHO_HABIENTE.Nomb_Zona as varchar(20)),'') + '|'+                                       
       isnull(cast(DERECHO_HABIENTE.referencia as varchar(40)),'') + '|'+                                    
        isnull(cast(UBIGEO_DISTRITO.Codi_Ubi_Dist_Sunat as varchar(6)),'') + '|'                                     
                                     
      end)                                
 when (cast( (select right('00'+cast(td.Codi_Sunat as varchar),2) from TIPO_DOCU_IDEN td (nolock)                                    
       where td.Codi_Tipo_Docu_Iden= DERECHO_HABIENTE.Codi_Tipo_Docu_Iden) as varchar(2))='01') and                                 
      (right('00'+VINCULO_FAMILIAR.Codi_Vinc_Fami_Sunat,3)= '05') then --+'aca falta2'                         
                    
     (case derecho_habiente.domicilio                                
      when '0' then + isnull((select via.codi_via_sunat from via where via.codi_via=PERSONAL.Codi_Via),'') + '|'+                                
          isnull(PERSONAL.Nomb_via,'') + '|'+                                
          isnull(PERSONAL.Num_via,'' )+ '|'+                                
         '|'+  ---departamento                                  
        isnull(PERSONAL.Interior_via,'') + '|'+                                
        '|'+  ---manzana                                    
        '|'+  ---lote                                 
        '|'+  ---kilometro                                    
        '|'+  ---block                                    
        '|'+  ---etapa                                   
        isnull(cast((select ZONA.Codi_Zona_Sunat from zona where ZONA.Codi_Zona=PERSONAL.Codi_Zona) as varchar(2)),'')+ '|'+                                
        isnull(cast(PERSONAL.Nomb_Zona as varchar(20)),'')+ '|'+                                
        isnull(cast(PERSONAL.refe_zona as varchar(40)),'' )+ '|'+                                
        isnull (cast((select UBIGEO_DISTRITO.Codi_Ubi_Dist_Sunat from UBIGEO_DISTRITO where  UBIGEO_DISTRITO.codi_ubi_dist=PERSONAL.Codi_Ubi_Dist)as varchar(6)),'')+'|'                                
                                
     when '1' then + isnull(VIA.Codi_Via_Sunat,'') + '|'+                                    
        isnull(DERECHO_HABIENTE.Nomb_via,'') + '|'+                                       
       isnull(DERECHO_HABIENTE.Num_via,'') + '|'+                                       
        '|'+  ---departamento                                    
              isnull(DERECHO_HABIENTE.Interior_via,'') + '|'+                                       
        '|'+  ---manzana                                    
        '|'+  ---lote                                    
        '|'+  ---kilometro                                    
        '|'+  ---block                                    
        '|'+  ---etapa                                    
        isnull(cast(ZONA.Codi_Zona_Sunat as varchar(2)),'') + '|'+                                    
        isnull(cast(DERECHO_HABIENTE.Nomb_Zona as varchar(20)),'') + '|'+                                       
       isnull(cast(DERECHO_HABIENTE.referencia as varchar(40)),'') + '|'+                                    
        isnull(cast(UBIGEO_DISTRITO.Codi_Ubi_Dist_Sunat as varchar(6)),'') + '|'                                     
                                     
   end)                    
                           
  else  +'|'+ --tipo via                                
    '|'+ --nombre via                                
         '|'+ --# via                                
         '|'+ --departamento                                
   '|'+ --interior                                
         '|'+ --manzana                                
         '|'+ --lote                                
         '|'+ --kilometro                                
         '|'+ --block                                
         '|'+ --etapa                                
         '|'+ --tipo zona                                
         '|'+ --nombre zona                                
         '|'+ --referencia                                
         '|'--ubigeo                                
                                    
 end + --'|'+                                 
       case derecho_habiente.domicilio                                
       when '0' then  isnull((select via.codi_via_sunat from via where via.codi_via=PERSONAL.Codi_Via),'') + '|'+ --via 2                                
      isnull(PERSONAL.Nomb_via,'') + '|'+ --nombre via 2                                
      isnull(PERSONAL.Num_via,'' )+ '|'+ --num via 2                                
      '|'+  ---departamento 2                                 
      isnull(PERSONAL.Interior_via,'') + '|'+ --interior 2                                
      '|'+  ---manzana 2                                   
      '|'+  ---lote 2                                  
      '|'+  ---kilometro 2                                   
     '|'+  ---block 2                                   
     '|'+  ---etapa 2                                  
      isnull(cast((select ZONA.Codi_Zona_Sunat from zona where ZONA.Codi_Zona=PERSONAL.Codi_Zona) as varchar(2)),'')+ '|'+                                
        isnull(cast(PERSONAL.Nomb_Zona as varchar(20)),'')+ '|'+                                
       isnull(cast(PERSONAL.refe_zona as varchar(40)),'' )+ '|'+                                
        isnull (cast((select UBIGEO_DISTRITO.Codi_Ubi_Dist_Sunat from UBIGEO_DISTRITO where  UBIGEO_DISTRITO.codi_ubi_dist=PERSONAL.Codi_Ubi_Dist)as varchar(6)),'')+'|'                                
                                
  when '1' then + isnull(VIA.Codi_Via_Sunat,'') + '|'+  --via 2                                
      isnull(DERECHO_HABIENTE.Nomb_via,'') + '|'+  --nomb via 2                                     
      isnull(DERECHO_HABIENTE.Num_via,'') + '|'+  --num via 2                                     
      '|'+  ---departamento 2                                   
            isnull(DERECHO_HABIENTE.Interior_via,'') + '|'+  --interior 2                                     
      '|'+  ---manzana 2                                
      '|'+  ---lote 2                                   
      '|'+  ---kilometro 2                           
     '|'+  ---block 2                                   
      '|'+  ---etapa 2                                   
      isnull(cast(ZONA.Codi_Zona_Sunat as varchar(2)),'') + '|'+ --zona 2                                   
      isnull(cast(DERECHO_HABIENTE.Nomb_Zona as varchar(20)),'') + '|'+   --nomb zona 2                                     
     isnull(cast(DERECHO_HABIENTE.referencia as varchar(40)),'') + '|'+ --referencia 2                                   
      isnull(cast(UBIGEO_DISTRITO.Codi_Ubi_Dist_Sunat as varchar(6)),'') + '|' --cod_ubigeo 2                                    
                                   
  end +                                
/*isnull(VIA.Codi_Via_Sunat,'') + '|'+                                    
 isnull(DERECHO_HABIENTE.Nomb_via,'') + '|'+                                       
 isnull(DERECHO_HABIENTE.Num_via,'') + '|'+                                       
 '|'+  ---departamento                                    
        isnull(DERECHO_HABIENTE.Interior_via,'') + '|'+                                       
 '|'+  ---manzana                                    
 '|'+  ---lote                                    
 '|'+  ---kilometro                                    
 '|'+  ---block                                    
 '|'+  ---etapa                                    
 isnull(cast(ZONA.Codi_Zona_Sunat as varchar(2)),'') + '|'+                
  isnull(cast(DERECHO_HABIENTE.Nomb_Zona as varchar(20)),'') + '|'+                                       
 isnull(cast(DERECHO_HABIENTE.referencia as varchar(40)),'') + '|'+                                    
 isnull(cast(UBIGEO_DISTRITO.Codi_Ubi_Dist_Sunat as varchar(6)),'') + '|'  +                                    
 '|'+  --- tipo via 2                                    
 '|'+  --- nom via 2                                    
 '|'+  --- num via 2                                    
 '|'+  --- departamento                                    
 '|'+  --- interior                                    
 '|'+  --- manzana                                    
 '|'+  --- lote                                    
 '|'+  --- kilometro                                    
 '|'+  --- block                                    
 '|'+  --- etapa                                    
 '|'+  --- tipo de zona                                    
 '|'+  --- nombre de la zona 2                                    
 '|'+  --- referencia                            
 '|'+ --- ubigeo 2                                     
*/                                
 '2|'+  --- indicador centro salud                                    
 isnull(cast(DERECHO_HABIENTE.codi_ldistanci as varchar(2)),'')+'|'+  ---telefono codigo                                    
 isnull(cast(DERECHO_HABIENTE.telefono as varchar(10)),'')+'|'+  ---telefono nro                                    
 isnull(cast(DERECHO_HABIENTE.correo as varchar(50)),'')+'|' --- correo                                    
                                 
 FROM DERECHO_HABIENTE (nolock)inner join  PERSONAL(nolock) on  PERSONAL.CODI_PERS = DERECHO_HABIENTE.CODI_PERS                                       
         left join VINCULO_FAMILIAR (nolock)on DERECHO_HABIENTE.Codi_Vinc_Fami = VINCULO_FAMILIAR.Codi_Vinc_Fami                                    
         left join MOTI_BAJA_DH (nolock)on DERECHO_HABIENTE.Codi_Moti_Baja_DH = MOTI_BAJA_DH.Codi_Moti_Baja_DH                                     
         left join VIA (nolock)on via.codi_via=DERECHO_HABIENTE.codi_via                                       
         left join ZONA (nolock) on zona.codi_zona=   DERECHO_HABIENTE.codi_zona                                    
         left join UBIGEO_DISTRITO(nolock) on UBIGEO_DISTRITO.Codi_Ubi_Dist= DERECHO_HABIENTE.Codi_Ubi_Dist                                     
     where year(fech_alta)=@anio and month(fech_alta)=@mes                                   
                                  
 end                                  
                                  
if @TipoEstru='12'---------------    Trabajador - Otras Rentas de 5ta. categoría                            
 begin                              
 INSERT #Rx                            
  select                             
       isnull(cast((select right('00'+cast(td.codi_sunat as varchar),2) from personal p left join tipo_docu_iden td on p.codi_tipo_docu_iden=td.codi_tipo_docu_iden where p.codi_pers=q.codi_pers)as varchar(2)),'')+ '|'                            
       +isnull(cast(s.nro_docu_iden as varchar(15)),'')+'|'                            
       +isnull( cast(cp.ruc as varchar(11)),'')+'|'                                 
       +isnull(cast(q.monto as varchar),'')+'|'        
  from ingresos_quinta_categ q left join personal s on q.codi_pers=s.codi_pers                             left join CLIENTE_PROVEEDOR cp on q.codi_clie_prov=cp.codi_clie_prov                            
  where q.año=@anio and mes=@mes                            
 end                            
                            
                            
if @TipoEstru='14'---------------   Trabajador - Datos de la Jornada Laboral                            
  INSERT #Rx                            
  EXEC PA_Personal_Jornada_laboral_por_trabajador_Exporta_plame @anio=@anio, @mes=@mes , @codi_plan ='01'                             
                             
if @TipoEstru='15'---------------  PERSONAL DIAS NO SUBSIDIADOS NO TRABJADOS                            
  insert #Rx                        
  exec PA_PERSONAL_DIAS_NO_SUBSIDIADOS_NO_TRABAJADOS_tregistro @anio =@anio,@mes =@mes                              
                              
                              
if @TipoEstru='18'   --------------------Archivo Datos del Trabajador                            
 insert #Rx                                          
 exec PA_Datos_Detalle_Remuneración_Trabajador_exporta_plame @anio =@anio , @mes =@mes, @tipo_plan ='01'                                          
                  
if @TipoEstru='20'   --------------------Prestador de Servicios con Rentas de Cuarta categoría: Detalle de comprobantes.                      
 begin                  
  insert #Rx                   
 exec PA_CUARTA_CATEGORIA_COMPROBANTES_EXPORTA_plame @ANIO=@anio,@MES=@mes                  
end                   
                              
if @TipoEstru='24'   --------------------Derecho Habiente Bajas                                    
 begin                                
 insert #Rx                               
 SELECT                                 
 cast( (select right('00'+cast(td.Codi_Sunat as varchar),2) from TIPO_DOCU_IDEN td(nolock)                                 
  where td.Codi_Tipo_Docu_Iden=PERSONAL.Codi_Tipo_Docu_Iden                                
   and personal.codi_pers not in ('00000') ) as varchar(2)) + '|'+                                   
 PERSONAL.NRO_DOCU_IDEN + '|'+                                  
                                
 cast( (select right('00'+cast(td.Codi_Sunat as varchar),2) from TIPO_DOCU_IDEN td (nolock)                                
  where td.Codi_Tipo_Docu_Iden= DERECHO_HABIENTE.Codi_Tipo_Docu_Iden) as varchar(2))+ '|'+                                   
 DERECHO_HABIENTE.NRO_DOCU_IDEN  + '|'+ isnull(codi_pais,'')+'|' +                                   
 isnull(convert(varchar(10), DERECHO_HABIENTE.fech_naci,103),'') + '|'+                                
 isnull(cast(DERECHO_HABIENTE.APEL_1 as varchar(40)),'') + '|'+                                
 isnull(cast(DERECHO_HABIENTE.APEL_2 as varchar(40)),'') + '|'+                                   
 cast(isnull(DERECHO_HABIENTE.NOMB_1,'') +' '+isnull(DERECHO_HABIENTE.NOMB_2,'') as varchar(40))+ '|' +                                  
 isnull(right('00'+CAST(VINCULO_FAMILIAR.Codi_Vinc_Fami_Sunat AS VARCHAR(2)),2),'')+ '|' +                              
 --isnull(VINCULO_FAMILIAR.codi_tregistro  ,'')+ '|' +                                
 isnull(convert(varchar(10), DERECHO_HABIENTE.fech_baja,103),'') + '|'+                                
 isnull(right('00' +cast(MOTI_BAJA_DH.Codi_Moti_Baja_DH_Sunat as varchar),2),'') + '|'                                 
                               
  FROM DERECHO_HABIENTE (nolock)inner join  PERSONAL(nolock) on  PERSONAL.CODI_PERS = DERECHO_HABIENTE.CODI_PERS                                   
         left join VINCULO_FAMILIAR (nolock)on DERECHO_HABIENTE.Codi_Vinc_Fami = VINCULO_FAMILIAR.Codi_Vinc_Fami                                
         left join MOTI_BAJA_DH (nolock)on DERECHO_HABIENTE.Codi_Moti_Baja_DH = MOTI_BAJA_DH.Codi_Moti_Baja_DH                                 
         left join VIA (nolock)on via.codi_via=DERECHO_HABIENTE.codi_via                                   
  left join ZONA (nolock) on zona.codi_zona=   DERECHO_HABIENTE.codi_zona                                
         left join UBIGEO_DISTRITO(nolock) on UBIGEO_DISTRITO.Codi_Ubi_Dist= DERECHO_HABIENTE.Codi_Ubi_Dist                                 
     where year(fech_baja)=@anio and month(fech_baja)=@mes                              
                       
end                                
                                  
select campo from #Rx                                          
                                          
drop table #Rx
GO
