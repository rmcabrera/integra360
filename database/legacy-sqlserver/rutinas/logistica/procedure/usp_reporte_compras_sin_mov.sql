CREATE PROCEDURE [dbo].[usp_reporte_compras_sin_mov]
	@anio [int]
WITH EXECUTE AS CALLER
AS
--declare @anio int   
--select @anio=2018  
  
set nocount on  
  
declare @Tx table (codi_prod char(8), fecha datetime)  
declare @Rx table (codi_prod char(8), fecha datetime, dias int)  
  
insert @Tx  
select codi_prod,   
  convert(char(10),max(fech_nota_ingr),103) fecha  
from nota_ingreso A (nolock)  
join detalle_nota_ingreso B (nolock)  
on A.codi_nota_ingr=B.codi_nota_ingr  
where year(fech_nota_ingr)=@anio and tipo_nota_ingr='01'  
group by codi_prod  
  
insert @Rx  
select codi_prod, fecha, datediff(d,fecha,  
  (select max(fech_emis) from docu_sali_mate A (nolock)  
    join detalle_docu_sali B (nolock)  
    on A.codi_docu_sali=B.codi_docu_sali  
    where A.codi_alma='01' and A.tipo_sali='17' and B.codi_prod=T.codi_prod  and A.fech_emis>=T.fecha))  
 from @Tx T  
  
  
declare @Repo table (codi_prod char(8) null, desc_prod varchar(200) null, fecha datetime, dias int null, empresa varchar(200) null,  
    compra int null, stock int null)  
  
insert @Repo      
select codi_prod,   
  (select desc_prod from productos P (nolock) where p.codi_prod=R.codi_prod) Desc_prod,  
  fecha,   
  datediff(d,fecha,getdate()) as Dias,  
  (select razon_social from empresa (nolock)) Empresa,  
  isnull((select sum(b.cantidad) from nota_ingreso A (nolock)  
     join detalle_nota_ingreso b (nolock)  
   on A.codi_nota_ingr=B.codi_nota_ingr  
   where A.tipo_nota_ingr='01' and   
      B.codi_prod=R.codi_prod and convert(char(10),fech_nota_ingr,103)=R.fecha),0) as Compra,  
  (select sum(cant_ingr - cant_sali) from kardex k (nolock)  
    where k.periodo=@anio and k.codi_prod=R.codi_prod and k.codi_alma='01')    
from @Rx R  
where dias is null  
order by desc_prod  
  
select codi_prod, desc_prod, fecha, dias, empresa,  
  (select (select (select (select l.des_lin_pro from LINEA_FAMILIA_PRO L where L.cod_lin_pro=f.cod_lin_pro)  
   from familia_producto F (nolock) where F.CODI_FAMI_PROD= S.CODI_FAMI_PROD)  
     from sub_familia_producto S (nolock)  
     where S.codi_sub_fami_prod=p.codi_sub_fami_prod) from productos P (nolock) where P.codi_prod=B.codi_prod) as Linea,  
  
  (select (select desc_sub_fami_prod from sub_familia_producto S (nolock)  
     where S.codi_sub_fami_prod=p.codi_sub_fami_prod) from productos P (nolock) where P.codi_prod=B.codi_prod) as SubFamilia,    
  
  (select dbo.F_Cliente_Proveedor(P.codi_clie_prov) from productos P (nolock) where P.codi_prod=B.codi_prod) as Laboratorio , 
       compra
from @Repo as B  
where stock>=compra
GO
