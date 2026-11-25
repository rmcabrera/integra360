CREATE PROCEDURE [dbo].[usp_kardex_sunat_resu_alma]
	@per [int],
	@fec1 [datetime],
	@fec2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @per int, @fec1 datetime, @fec2 datetime, @alma char(2)   
--select @per=2017, @fec1='01/01/2017', @fec2='12/10/2017', @alma ='01'  
  
set nocount on   
  
declare @Esta varchar(200)  
set @Esta=''  
if (select ruc from empresa)='20523088361'  set @Esta='AV. VILLA DEL MAR NRO. 796 ANCASH SANTA COISHCO'  
  
create table #Tx (codi_prod char(8) null, existencia varchar(50) null, unidad char(2) null, descripcion varchar(200) null,  
     fech_tran datetime null, tipo varchar(10) null, serie varchar(10) null, numero varchar(100) null, tipooper varchar(10) null,  
     cant_ingr numeric(12,4) null, prec_unit numeric(12,2) null, valo_ingr numeric(12,4) null, cant_sali numeric(12,2) null,  
     costo_salida numeric(12,4) null, valo_sali numeric(12,4) null, cant_saldo numeric(12,4) null, prec_prom numeric(12,4) null,  
     valo_saldo numeric(12,4) null, razon_social varchar(150) null, ruc varchar(15) null, establecimiento varchar(100) null,  
     i_o int null, codi_docu_io varchar(10) null, codi_kard varchar(20) null )  
       
insert #Tx       
SELECT codi_prod,  
  (select (select desc_tipo_exis from tipo_existencia T (nolock) where t.codi_tipo_exis=P.codi_tipo_exis)  
   from productos P (nolock) where P.codi_prod=k.codi_prod) Existencia,  
     
  (select (select codi_sunat from unidad_medida U (nolock) where u.codi_unid_medi=p.codi_unid_medi)  
    from productos P (nolock) where p.codi_prod=k.codi_prod) Unidad,  
      
  (select desc_prod from productos P (nolock) where p.codi_prod=k.codi_prod) descripcion,  
    
  fech_tran,   
    
/*  case when i_o=1 then   
  (Select (select tipo_sunat from tipo_documento t (nolock)   
   where t.codi_tipo_docu=codi_tipo_docu_cont ) from nota_ingreso N (nolock)   
   where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)    
  else (Select (select tipo_sunat from tipo_documento t (nolock)   
   where codi_tipo_docu = codi_tipo_docu_sali) from docu_sali_mate D (nolock)   
   where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end Tipo,  
  
  
  case when i_o=1 then   
  (Select nro_seri_docu_cont  from nota_ingreso N (nolock)   
   where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)    
  else (Select nro_seri_docu_sali from docu_sali_mate D (nolock)   
   where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end Serie,  
  
  case when i_o=1 then   
  (Select nro_docu_cont  from nota_ingreso N (nolock)   
   where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)    
  else (Select nro_docu_sali from docu_sali_mate D (nolock)   
   where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end Numero,  
  
  case when i_o=1 then   
  (Select (select codi_sunat_moti_tras from tipo_ingr_sali T (nolock)  
    where codi_tipo_is=tipo_nota_ingr )  from nota_ingreso N (nolock)   
   where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)    
  else (Select (select codi_sunat_moti_tras from tipo_ingr_sali T (nolock)  
    where codi_tipo_is=tipo_sali )  from docu_sali_mate D (nolock)   
   where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end TipoOper,  
   */  
  '' as Tipo ,  
  '' as Serie,  
  '' as Numero,  
  '' as TipoOper,  
 cant_ingr, prec_unit, valo_ingr,   
 cant_sali, case when cant_sali<>0 then prec_prom else 0 end costo_salida, valo_sali,   
 cant_saldo, prec_prom, valo_saldo,  
 (select razon_social from empresa E (nolock)) Razon_social,  
 (select ruc from empresa E (nolock)) Ruc,  
 @ESTa Establecimiento ,  I_O,   Codi_Docu_I_O, codi_kard  
    FROM KARDEX K (nolock)  
   WHERE  codi_alma=@alma and cast(convert(char(10),fech_tran,103) as datetime) between @fec1 and @fec2   
     
union all  
select codi_prod,  
  (select (select desc_tipo_exis from tipo_existencia T (nolock) where t.codi_tipo_exis=P.codi_tipo_exis)  
   from productos P (nolock) where P.codi_prod=k.codi_prod) Existencia,  
  (select (select codi_sunat from unidad_medida U (nolock) where u.codi_unid_medi=p.codi_unid_medi)  
    from productos P (nolock) where p.codi_prod=k.codi_prod) Unidad,  
  (select desc_prod from productos P (nolock) where p.codi_prod=k.codi_prod) descripcion,  
 fech_tran,   
 '99' tipo, '' Serie, '' Nro, '' tipooper, 0 as cant_ingr, 0, 0 as valo_ingr,0 as  cant_sali, 0, 0 as valo_sali,  
  cant_saldo, cc , valo_saldo,  
 (select razon_social from empresa E (nolock)) Razon_social,  
 (select ruc from empresa E (nolock)) Ruc,  
 @ESta Establecimiento, 1 as I_O,  '0' as codi_docu_I_O , '0' codi_karx  
from (  
select '0' as C, pk.codi_prod,'' as C1, '' as C2,'' as C3, '' as C4,'' as C5,'' as C6,  
   @fec1 as Fech_tran,  
   isnull(sum(cant_ingr),0) as Cant_ingr, isnull( sum(cant_sali),0) as cant_sali,  
   isnull(sum(cant_ingr) - sum(cant_sali),0) as cant_saldo, 0 as C10,   
  (SELECT PREC_PROM FROM KARDEX as PP (nolock) WHERE CODI_KARD IN   
   (SELECT MAX(CODI_KARD) FROM KARDEX  as P1 (nolock)   
    WHERE p1.CODI_PROD =PK.CODI_PROD AND p1.FECH_TRAN in   
    (select max(fech_tran)   
    from kardex as P2  (nolock)   
    where periodo=@per and p2.codi_prod = PK.CODI_PROD and  
     p2.fech_tran < @fec1 ))) as CC,  
   isnull( sum(valo_ingr),0) as valo_ingr, isnull(sum(valo_sali),0) as valo_sali,  
  isnull(sum(valo_ingr) - sum(valo_sali),0) as valo_saldo ,  
  '01' as C7,  
  0 as C8, 1 as I_O,  '0' as codi_docu_I_O ,  
  'SALDO ANTERIOR' as C9  
  from kardex  (nolock),   
   (select distinct codi_prod from kardex (nolock)   
    where periodo=@per and codi_alma=@alma and fech_tran<=@fec2) as PK  
  where periodo=@per and codi_alma=@alma and fech_tran<@fec1 and pk.codi_prod = Kardex.codi_prod    
  group by pk.codi_prod) as K  
  where cant_saldo<>0  
order by codi_prod, fech_tran  
  
/*  
select codi_prod, existencia, unidad, descripcion, fech_tran , tipo , serie ,numero ,tipooper , cant_ingr , prec_unit , valo_ingr,  
   cant_sali , costo_salida , valo_sali ,cant_saldo , prec_prom , valo_saldo , razon_social , ruc,  establecimiento ,i_o ,  
   codi_docu_io , codi_kard  
from #Tx  
*/  
select codi_prod, max(existencia) as existencia, max(unidad) as unidad ,   
  max(descripcion) as descripcion ,   
  max(fech_tran) as fech_Tran,  

  dbo.uf_dato_max_kardex(t.codi_prod, max(fech_tran), 1 ,@alma ) as Tipo,
  dbo.uf_dato_max_kardex(t.codi_prod, max(fech_tran), 2 ,@alma ) as serie, 
  dbo.uf_dato_max_kardex(t.codi_prod, max(fech_tran), 3 ,@alma ) as numero, 
  dbo.uf_dato_max_kardex(t.codi_prod, max(fech_tran), 4 ,@alma ) as tipooper,  

  sum(cant_ingr) as cant_ingr,   
  case when sum(cant_ingr)<>0 then sum(valo_ingr) / sum(cant_ingr) else 0 end as prec_unit,  
  sum(valo_ingr) as valo_ingr,  
  sum(cant_sali) as cant_sali,  
  case when sum(cant_sali)<>0 then sum(valo_sali) / sum(cant_sali) else 0 end as costo_salida,  
  sum(valo_sali) as valo_sali,    
  sum(cant_ingr - cant_sali) as cant_saldo,  
  case when sum(cant_ingr - cant_sali)<>0 then sum(valo_ingr - valo_sali) / sum(cant_ingr - cant_sali) else 0 end as prec_prom,    
  sum(valo_ingr - valo_sali) as valo_saldo,  
  max(razon_social) as razon_social,  
  max(ruc) as ruc,  
  max(establecimiento) as establecimiento,  
  max(i_o) as i_o,  
  max(codi_docu_io) as  codi_docu_io,  
  max(codi_kard) as codi_kard,  
  (select nemo_alma from almacen (nolock) where codi_alma=@alma) almacen,  
  month(fech_tran) as mes  
from #Tx T
group by month(fech_tran), codi_prod  
order by mes, descripcion  
  
drop table #Tx
GO
