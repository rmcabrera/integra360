CREATE PROCEDURE [dbo].[usp_utilidad_cobranza_credi]
	@f1 [datetime],
	@f2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime , @f2 datetime , @alma char(2)
--select @f1 ='01/06/2019', @f2='13/06/2019', @alma='03'

set nocount on

create Table #Cx (codi_docu char(4), serie varchar(5) null, nro_docu int, importe numeric(12,2) null)

create Table #Fx (codi_docu char(4), serie varchar(5) null, nro_docu int, importe numeric(12,2) null, total numeric(12,2) null, porcentaje numeric(12,4) null,
					codi_Fact char(10) null, codi_mone char(2) null, tpc numeric(12,2) null, fech_fact datetime null)


insert #Cx
select codi_tipo_docu, serie, nro_docu,
			sum(importe) as importe
from dbo.caja_chica cc (nolock)
where cc.fecha>=@f1 and cc.fecha<=@f2 and cc.codi_alma=@alma AND isnull(dscto_adm,'0')<>'1'
				and tipo_contab<>'016'  and tipo_contab in (036,037)
group by codi_tipo_docu,serie, nro_docu


insert #Fx
select codi_docu, serie, nro_docu, importe, TOTA_FACT,  importe/TOTA_FACT*1.0000 as porc , CODI_FACT, codi_mone, tcambio, fech_fact
from #Cx A
join factura B (nolock)
on A.codi_docu=B.CODI_TIPO_DOCU and 
			right(ltrim(rtrim(B.SER_FACT)), len(A.serie))=A.serie and 
			A.nro_docu=B.NRO_FACT


select 
	sum(case when linea='01' then prec_costo else 0 end ) costo01,
	sum(case when linea='01' then venta else 0 end) venta01,

	sum(case when linea='02' then prec_costo else 0 end ) costo02,
	sum(case when linea='02' then venta else 0 end) venta02,
	
	sum(case when linea='03' then prec_costo else 0 end ) costo03,
	sum(case when linea='03' then venta else 0 end) venta03,

	sum(case when linea='04' then prec_costo else 0 end ) costo04,
	sum(case when linea='04' then venta else 0 end) venta04,

	sum(case when linea='05' then prec_costo else 0 end ) costo05,
	sum(case when linea='05' then venta else 0 end) venta05,

	sum(case when linea='06' then prec_costo else 0 end ) costo06,
	sum(case when linea='06' then venta else 0 end) venta06,

	sum(case when linea='07' then prec_costo else 0 end ) costo07,
	sum(case when linea='07' then venta else 0 end) venta07,

	sum(case when linea='08' then prec_costo else 0 end ) costo08,
	sum(case when linea='08' then venta else 0 end) venta08,

	sum(prec_costo ) costo,
	sum(venta ) venta

from
(  SELECT 
	(select (select (select (select F.cod_lin_pro from familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from Productos P (nolock) 
					where P.codi_prod =D.codi_prod) ))))) Linea,

					
	sum(D.CANT_ITEM)  cantidad,
	SUM(f.porcentaje*D.CANT_ITEM *(D.PREC_ITEM * (CASE WHEN f.codi_mone='01' THEN 1 ELSE f.tpc END))) as  venta,
	SUM(f.porcentaje*D.CANT_ITEM* (D.PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end))) as prec_costo

    FROM #Fx F (nolock),   
        FACTURA_DETALLE D(nolock), 
		productos (nolock)
   WHERE  D.CODI_FACT = F.CODI_FACT  and  
		  D.codi_prod=productos.codi_prod 
	group by  D.codi_prod) SQL


drop table #Cx
drop table #Fx
GO
