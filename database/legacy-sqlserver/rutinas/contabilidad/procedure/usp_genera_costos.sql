CREATE PROCEDURE [dbo].[usp_genera_costos]
	@anio [char](4),
	@fi [datetime],
	@ff [datetime]
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @fi datetime, @ff datetime 
--select @anio='2019' ,@fi='01/10/2019',@ff='31/12/2019'

set nocount on 

declare @t1 table (codi_contable char(10),nro_cuen char(7) null, fecha datetime , venta numeric(12,2) null,igv numeric(12,2) null,total numeric(12,2) null, otros numeric(12,2) null,
		 Codi_Clie_Prov char(5) null, dolares numeric(12,2) null, ruc varchar(15) null,denominacion varchar(250) null,tipo_pers varchar(12) null,apel_1 varchar(300) null,
		apel_2 varchar(300) null,nomb_1 varchar(300) null,nomb_2 varchar(300) null,
		cargo_abono char(1) null,mes char(2)null,compr varchar(10) null,Razon_Social char(50)null,rucx char(15)null,Codi_Vouc char(10)null, Codi_Tipo_Docu_Iden tinyint null,Codi_Tipo_Docu_Idenx tinyint null)


declare @Sx table (clie char(5) null)

insert @Sx
select codi_clie_prov from cliente_proveedor (nolock) where denominacion like '%sunat%'

--select * from @Sx

insert @t1

SELECT Movi_Contables.Codi_Contable,   
         Movi_Contables.Nro_Cuen, 
	movi_contables.fecha,  
	
         case when  (left(nro_cuen,2) not in ('42','43','40') or left(nro_cuen,4)='4211') and (otros=0 or isnull(otros,0)=0)
			then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as Venta,   
			
         case when (left(nro_cuen,2) in ('40'))     
			then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as IGV,   
     
         case when (left(nro_cuen,2) in ('42','43') and left(nro_cuen,4)<>'4211' )    
			then (case when cargo_abono='A' then Importe else -1*Importe end) else 0 end as TOTAL,   
   
         case when (left(nro_cuen,2) not in ('42','43','40') ) and otros<>0     
			then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end as Otros,   
   
         Movi_Contables.Codi_Clie_Prov,   
         
	     case when left(nro_cuen,2) in ('42','43') and left(nro_cuen,4)<>'4211'   
			then (case when cargo_abono='A' then Importe_d else -1*Importe_d end) else 0 end as Dolares,   
   
         CLIENTE_PROVEEDOR.RUC,   
         isnull(rtrim(CLIENTE_PROVEEDOR.razo_soci),'') as denominacion, 
	  case when tipo_pers='Natural' then '01' else '02'end as tipo_pers,  
		   --CLIENTE_PROVEEDOR.tipo_pers,   
	isnull(cliente_proveedor.apel_1, '')as apel_1,
	isnull(cliente_proveedor.apel_2, '')as apel_2,
	isnull(cliente_proveedor.nomb_1, '')as nomb_1,
 	isnull(cliente_proveedor.nomb_2, '')as nomb_2,
         Movi_Contables.Cargo_Abono,   
         Movi_Contables.Mes,   
         Movi_Contables.Compr,   
         Empresa.Razon_Social,   
         Empresa.Ruc,   
         Movi_Contables.Codi_Vouc,

	(select codi_sunat from tipo_docu_iden t (nolock) where t.Codi_Tipo_Docu_Iden in (select Codi_Tipo_Docu_Iden from cliente_proveedor c (nolock)
			where ruc in (select ruc from empresa))) as  Codi_Tipo_Docu_Iden ,

	tipo_docu_iden.codi_sunat as Codi_Tipo_Docu_Idenx

		
    FROM Movi_Contables (nolock),   
         CLIENTE_PROVEEDOR (nolock),   
         Empresa,
	 tipo_docu_iden 
   WHERE ( cast(convert(char(10),Movi_Contables.fecha,103) as smalldatetime) between @fi and @ff  ) 
   AND   ( Movi_Contables.anio = @anio )  
	
   and( CLIENTE_PROVEEDOR.CODI_CLIE_PROV = Movi_Contables.Codi_Clie_Prov ) 
   and ( tipo_docu_iden.codi_tipo_docu_iden = cliente_proveedor.codi_tipo_docu_iden ) 
   And   ( Movi_Contables.Subdia = 'C' )
   And  ( MOVI_CONTABLES.CODI_CLIE_PROV not in (select clie from @Sx) ) 
 

declare @tx2 table (Codi_Tipo_Docu_Iden tinyint null,rucx char(15)null, fecha datetime null, tipo_pers varchar(12) null, Codi_Tipo_Docu_Idenx tinyint null, ruc varchar(15) null,venta numeric(12,2) null,apel_1 varchar(300) null,
		apel_2 varchar(300) null,nomb_1 varchar(300) null,nomb_2 varchar(300) null,denominacion varchar(250)null)

declare @uit numeric(18,2)

select @uit= isnull(valor,0) from valores_unitarios_anuales 
where codi_valo_unit=1 and @fi between fech_asig and fech_asig_fin 
--select 2*@uit


insert @tx2
select max(Codi_Tipo_Docu_Iden)as Codi_Tipo_Docu_Iden,max(rucx)as rucx,max(fecha)as fecha,max(tipo_pers)as tipo_pers,max(Codi_Tipo_Docu_Idenx)as Codi_Tipo_Docu_Idenx,
	max(ruc)as ruc,sum(venta)as venta,max(apel_1)as apel_1,max(apel_2)as apel_2,max(nomb_1)as nomb_1,max(nomb_2)as nomb_2,max(denominacion)as denominacion
from @t1
group by ruc
having  sum(venta)> 2*@uit

--return
declare @tx table( idd numeric(18,0) IDENTITY (1,1) not null, data varchar(255) null)

insert @tx
select  cast(cast(Codi_Tipo_Docu_Iden as tinyint) as varchar)+'|'+rtrim(isnull(rucx,''))+'|'+cast(year(fecha)as varchar)+'|'+cast(cast(tipo_pers as varchar) as varchar) +'|'
	+cast(cast(Codi_Tipo_Docu_Idenx as tinyint) as varchar) +'|'+rtrim(isnull(ruc,''))+'|'+cast(cast( venta as numeric)as varchar)+'|'+cast(cast(apel_1 as varchar)as varchar)+'|'
	+cast(cast(apel_2 as varchar)as varchar)+'|'+cast(cast(nomb_1 as varchar)as varchar)+'|'+cast(cast(nomb_2 as varchar)as varchar) +'|'+cast(cast(rtrim(denominacion) as varchar(300))as varchar(300))+'|'
from @tx2   

select cast(idd as varchar)+'|'+data from @tx
GO
