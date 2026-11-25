CREATE PROCEDURE [dbo].[usp_repo_resu_caja_chic]
	@f1 [datetime],
	@f2 [datetime],
	@alma [char](2),
	@Ingresos [numeric](12, 2)
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime , @f2 datetime , @alma char(2), @Ingresos  numeric(12,2) 
---select @f1 ='01/01/2019', @f2='31/05/2019', @alma='21', @Ingresos=1000

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

declare @UtilCobranza numeric(12,2)


select @UtilCobranza = 	cast( sum(venta - prec_costo)  as numeric(12,2)) 
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


if @UtilCobranza is null set @UtilCobranza=0

select 1 as tipo, 2, 'INGRESOS POR COBRANZAS DE CREDITOS', @UtilCobranza as monto, @Ingresos as Ingresos
union all
select 0 as tipo, 98, 'GASTOS DE ALQUILER', 
		case @alma when '20' then 360 * dbo.F_TC(@f2,'V','01','02')
					when '15' then 1350
					when '21' then 3500
					when '09' then 2300 * dbo.F_TC(@f2,'V','01','02')
					when '04' then 2700 else 0 end as monto ,  @Ingresos as Ingresos
union all
select tipo ,id_rubro, Rubro, sum(monto) as monto, @Ingresos as Ingresos
from 
(select cc.tipo_io tipo , tipo_contab,
		(select a.id_rubro from rubros_Caja A
				join rubros_Caja_detalle B
				on A.id_rubro=B.id_rubro
					where B.tipo_reemb=cc.tipo_contab and b.i_o=cc.tipo_io) as id_rubro,
		(select a.desc_rubro from rubros_Caja A
				join rubros_Caja_detalle B
				on A.id_rubro=B.id_rubro
					where B.tipo_reemb=cc.tipo_contab and b.i_o=cc.tipo_io) as Rubro, 
		sum(importe*case when tipo_io=0 then 1 else case when tipo_contab in (036,037) then 1 else 0 end end ) as monto
from dbo.caja_chica cc (nolock)
where cc.fecha>=@f1 and cc.fecha<=@f2 and cc.codi_alma=@alma AND isnull(dscto_adm,'0')<>'1'
				and tipo_contab not in ('016' ,'036','037')
group by cc.tipo_io,tipo_contab) as SQ
where not id_rubro is null
group by tipo, id_rubro, rubro
union all
select 0, 99, 'PLANILLA REMUNERACIONES', sum(valor), @Ingresos as Ingresos
from planilla_de_empleados A (nolock)
join planilla_empleado_conceptos B (nolock)
on A.codi_plan_empl=B.codi_plan_empl
where anio=year(@f2) and mes=month(@f2)  and indi_tiem='M' and codi_Tipo_plan in ('01','02','03','11','12')
	and codi_conc in ('199998', '399999')
	and codi_unid_oper in (select  x.codi_unid_oper from almacen x (nolock) where x.codi_alma=@alma  )
GO
