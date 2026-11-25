CREATE PROCEDURE [dbo].[PA_Registro_Compras]
	@TIPO [tinyint],
	@mes [char](2),
	@anio [char](4),
	@codi_clie [char](5)
WITH EXECUTE AS CALLER
AS
--declare @TIPO TINYINT, @mes  char(2), @anio char(4),@codi_clie char (5)     
--select @TIPO =1, @mes  ='01',@anio ='2023' ,@codi_clie=null
    
set nocount on    
IF @TIPO= 1     
   begin    
 SELECT    
  Compr, fecha, isnull(fecha_venc,fecha+30),     
  --right(codi_tipo_docu,2), 
  (select codi_sunat from tipo_documento t (nolock) where t.codi_tipo_docu = MOVI_CONTABLES.codi_tipo_docu) codi_tipo_docu,
  CODI_ADUANA , ANIO_DUA_DSI,     
  isnull(ltrim(rtrim(serie))+'-','') + isnull(ltrim(rtrim(nro_docu)),'') as NRO_COMPR,    
    
          /*case when  (left(nro_cuen,2) not in ('42','43','40')) and (otros=0 or isnull(otros,0)=0)     
   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as BASE_IMPO,*/    
    
    case when  (left(nro_cuen,2) not in ('42','43','40','46') or left(nro_cuen,4)='4211') and (otros=0 or isnull(otros,0)=0)
   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as BASE_IMPO,       
    
          case when (left(nro_cuen,2) in ('40'))     
     then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as IGV,    
      0.0 AS ISC,       
          case when (left(nro_cuen,2) not in ('42','43','40','46') ) and otros<>0     
   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as Otros,       
    
  case when (left(nro_cuen,2) in ('42','43','46') and left(nro_cuen,4)<>'4211' )    
   then (case when cargo_abono='A' then Importe else -1*Importe end) else 0 end as TOTAL,       
    
          /*case when (left(nro_cuen,2) in ('42','43'))     
   then (case when cargo_abono='A' then Importe else -1*Importe end) else 0 end as TOTAL,   */    
    
   ' ' AS NRO_COMPR_NO_DOMIC, num_spot nro_detrac, FECHA_spot fecha_detrac, Tipo_Cambio,      
  FECHA_ND_NC, right(TIPO_DOCU_ND_NC,2) , SERIE_ND_NC  , NRO_DOCU_ND_NC,    
  Codi_Contable, Nro_Cuen,  --CAMPOS DE MAS     
   Registro, Glosa,  num_spot, fecha_spot,--CAMPOS DE MAS     
          Cargo_Abono, Mes, Subdia, Codi_Vouc, codi_nota_ingr, importe, nro_fact, codi_unid_oper ,     --CAMPOS DE MAS     
      
  TIPO_DOCU_IDEN.CODI_SUNAT, CLIENTE_PROVEEDOR.RUC,    
    
  denominacion  clie_Prov, isnull(TIPO_VENTA,1) tipo_venta,    
    
         case when left(nro_cuen,2) in ('42','43','46') and left(nro_cuen,4)<>'4211'   
   then (case when cargo_abono='A' then Importe_d else -1*Importe_d end) else 0 end as Dolares,
   (select top 1 nro_cuen from movi_contables x(nolock) 
   where x.anio=MOVI_CONTABLES.anio and x.mes=MOVI_CONTABLES.mes and x.subdia=MOVI_CONTABLES.subdia and x.compr=MOVI_CONTABLES.compr) cuenta
 FROM dbo.MOVI_CONTABLES (nolock) INNER JOIN CLIENTE_PROVEEDOR (nolock) ON MOVI_CONTABLES.CODI_CLIE_PROV= CLIENTE_PROVEEDOR.CODI_CLIE_PROV    
 INNER JOIN TIPO_DOCU_IDEN (nolock) ON  TIPO_DOCU_IDEN.CODI_TIPO_DOCU_IDEN=CLIENTE_PROVEEDOR.CODI_TIPO_DOCU_IDEN    
    
 WHERE Subdia = 'C' AND  Mes  = @mes AND  Anio = @anio and (@codi_clie is null or CLIENTE_PROVEEDOR.codi_clie_prov=@codi_clie) 
 and isnull(MOVI_CONTABLES.codi_tipo_docu,'') not in (select T.codi_tipo_docu from tipo_documento T(nolock) where upper(desc_tipo_docu) like '%NO DOMICILIADO%') 
 --and compr=130    
end    
    
    
ELSE    
    
    
    begin    
 Declare @imes  tinyint,    
  @ianio smallint    
    
 Set @imes  = cast(@mes  as tinyint)    
 Set @ianio = cast(@anio as smallint)    
     
 SELECT Compr , fecha,  isnull(fecha_venc,fecha+30),     
  --right(codi_tipo_docu,2), 
  (select codi_sunat from tipo_documento t (nolock) where t.codi_tipo_docu = MOVI_CONTABLES.codi_tipo_docu)codi_tipo_docu,
  CODI_ADUANA , ANIO_DUA_DSI,     
  isnull(serie,' ') + ' ' + nro_docu as NRO_COMPR ,    
    
          /*case when  (left(nro_cuen,2) not in ('42','43','40')) and (otros=0 or isnull(otros,0)=0)     
   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as BASE_IMPO,*/    
  case when  (left(nro_cuen,2) not in ('42','43','40','46') or left(nro_cuen,4)='4211')  and (otros=0 or isnull(otros,0)=0)     
   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as BASE_IMPO,          
          case when (left(nro_cuen,2) in ('40'))     
     then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as IGV,    
   0.0 AS BASE_IMPO_GV_NGV,    
   0.0 AS IGV_GV_NGV,    
   0.0 AS BASE_IMPO_AGV_NG,    
   0.0 AS IGV__AGV_NG,    
  0.0 AS ISC,       
          case when (left(nro_cuen,2) not in ('42','43','40','46')) and otros<>0     
   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as Otros,       
    
  case when (left(nro_cuen,2) in ('42','43','46') and left(nro_cuen,4)<>'4211')    
   then (case when cargo_abono='A' then Importe else -1*Importe end) else 0 end as TOTAL,       
    
          /*case when (left(nro_cuen,2) in ('42','43'))     
   then (case when cargo_abono='A' then Importe else -1*Importe end) else 0 end as TOTAL,   */    
    
   ' ' AS NRO_COMPR_NO_DOMIC, NRO_DETRAC ,   FECHA_DETRAC ,  Tipo_Cambio,      
  FECHA_ND_NC  ,  right(TIPO_DOCU_ND_NC,2) ,  SERIE_ND_NC  , NRO_DOCU_ND_NC  ,    
  Codi_Contable, Nro_Cuen,  --CAMPOS DE MAS     
   Registro, Glosa, num_spot, fecha_spot, --CAMPOS DE MAS     
         Cargo_Abono, Mes, Subdia, Codi_Vouc, codi_nota_ingr, importe, nro_fact, codi_unid_oper , --CAMPOS DE MAS     
    
         TIPO_DOCU_IDEN.CODI_SUNAT  , CLIENTE_PROVEEDOR.RUC ,      
  denominacion  clie_Prov, isnull(TIPO_VENTA,1) tipo_venta,    
    
         case when left(nro_cuen,2) in ('42','43','46') and left(nro_cuen,4)<>'4211'    
   then (case when cargo_abono='A' then Importe_d else -1*Importe_d end) else 0 end as Dolares,
   
   (select top 1 nro_cuen from movi_contables x(nolock) 
   where x.anio=MOVI_CONTABLES.anio and x.mes=MOVI_CONTABLES.mes and x.subdia=MOVI_CONTABLES.subdia and x.compr=MOVI_CONTABLES.compr) cuenta
       
 FROM dbo.MOVI_CONTABLES (nolock) INNER JOIN CLIENTE_PROVEEDOR (nolock) ON MOVI_CONTABLES.CODI_CLIE_PROV= CLIENTE_PROVEEDOR.CODI_CLIE_PROV    
 INNER JOIN TIPO_DOCU_IDEN (nolock) ON  TIPO_DOCU_IDEN.CODI_TIPO_DOCU_IDEN=CLIENTE_PROVEEDOR.CODI_TIPO_DOCU_IDEN    
  WHERE Subdia = 'C' AND year(fecha_venc) = @ianio AND month(fecha_venc) = @imes    
  and isnull(MOVI_CONTABLES.codi_tipo_docu,'') not in (select T.codi_tipo_docu from tipo_documento T(nolock) where upper(desc_tipo_docu) like '%NO DOMICILIADO%') 
    end
GO
