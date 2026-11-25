CREATE PROCEDURE [dbo].[usp_reporte_linea_util_igv_all]
	@FI [datetime],
	@FF [datetime],
	@tipo [int]
WITH EXECUTE AS CALLER
AS
--declare @FI datetime , @FF datetime, @tipo int
--select @FI='01/05/2015' , @FF ='18/05/2015' , @tipo=1

/*
04	Fertilizantes Compuestos
06	Fertilizantes Genericos
03	Herramientas
05	Nutricional
01	Pesticidas
02	Semillas
*/
create table #Tx (codi_alma char(2), nemo varchar(30) , fertcosto numeric(12,2) null, fertventa numeric(12,2) null, 
					fertgencosto numeric(12,2) null, fertgenventa numeric(12,2) null, herrcosto numeric(12,2) null, herrventa numeric(12,2) null, 
					nutrcosto numeric(12,2) null, nutrventa numeric(12,2) null, pestcosto numeric(12,2) null, pestventa numeric(12,2) null, 
					semicosto numeric(12,2) null, semiventa numeric(12,2) null, costo numeric(12,2) null, venta numeric(12,2) null, empresa varchar(200) null)

create table #MX (codi_alma char(2), importe numeric(12,2) )

insert #MX
select (select X.codi_alma from almacen X (nolock) where X.codi_unid_oper=M.codi_unid_oper) codi_alma,
			importe*case when cargo_abono='C' then 1 else -1 end as importe	
	from movi_contables M (nolock) 
	where cast(convert(char(10),fecha,103) as datetime) between @FI and @FF
			and codi_unid_oper in (select A.codi_unid_oper from almacen A (nolock) )
			and left(nro_Cuen,2) in (62 ,63 ,64 ,65 ,67 )

insert #TX
select codi_alma,  Nemo,
	--linea, 
	--sum(cantidad) cantidad, 
	sum(case when linea='04' then prec_costo else 0 end) FertCosto,
	sum(case when linea='04' then venta else 0 end) FertVenta,
	
	sum(case when linea='06' then prec_costo else 0 end) FertGenCosto,
	sum(case when linea='06' then venta else 0 end) FertGenVenta,
	
	sum(case when linea='03' then prec_costo else 0 end) HerrCosto,
	sum(case when linea='03' then venta else 0 end ) HerrVenta,
	
	sum(case when linea='05' then prec_costo else 0 end) NutrCosto,
	sum(case when linea='05' then venta else 0 end) NutrVenta,
	
	sum(case when linea='01' then prec_costo else 0 end) PestCosto,
	sum(case when linea='01' then venta else 0 end) PestVenta,

	sum(case when linea='02' then prec_costo else 0 end) SemiCosto,
	sum(case when linea='02' then venta else 0 end) SemiVenta,
	
	sum(prec_costo) as Costo,
	sum(venta) as venta,
	
	(select razon_social from empresa ) Empresa
from
(  SELECT si_agrog.dbo.FACTURA.CODI_ALMA,  
		(Select nemo_alma from si_agrog.dbo.almacen A (nolock) where a.codi_alma=si_agrog.dbo.factura.codi_alma) Nemo,
	(select /*(select (select (select des_lin_pro from si_agrog.dbo.LINEA_FAMILIA_PRO L (nolock) 
						where l.cod_lin_pro in*/ (
						select F.cod_lin_pro from si_agrog.dbo.familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from si_agrog.dbo.sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from si_agrog.dbo.Productos P (nolock) 
					where P.codi_prod =D.codi_prod) )) /*)))*/) Linea,
	sum(D.CANT_ITEM)  cantidad,
	--SUM(D.CANT_ITEM *(D.PREC_ITEM * (CASE WHEN si_agrog.dbo.factura.codi_mone='01' THEN 1 ELSE si_agrog.dbo.factura.tcambio END))) venta,
	
	SUM(D.CANT_ITEM *( case when  si_agrog.dbo.productos.cod_impuesto=1 then 	D.PREC_ITEM/(1+d.igv/100) else 0 end  +  
						 case when  si_agrog.dbo.productos.cod_impuesto=3 then 	D.PREC_ITEM else 0 end)  *
                                        (CASE WHEN  si_agrog.dbo.factura.codi_mone='01' THEN 1 ELSE  si_agrog.dbo.factura.tcambio END)   ) venta,
	
	SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + si_agrog.dbo.f_igv(fech_fact)/100 end))) prec_costo
    FROM si_agrog.dbo.FACTURA (nolock),   
         si_agrog.dbo.FACTURA_DETALLE D(nolock), 
	 si_agrog.dbo.productos (nolock)
   WHERE  
		( si_agrog.dbo.FACTURA.FECH_FACT >= @FI) and
		( si_agrog.dbo.FACTURA.FECH_FACT < DATEADD(DAY,1,@FF)) and 	
		D.CODI_FACT = si_agrog.dbo.FACTURA.CODI_FACT  and  
		D.codi_prod=si_agrog.dbo.productos.codi_prod and 
		( ISNULL(si_agrog.dbo.FACTURA.ESTADO,'')<>'A') and
		codi_tipo_pago=@tipo
	group by  si_agrog.dbo.factura.codi_alma, D.codi_prod
	
	union all

	SELECT si_agrom.dbo.FACTURA.CODI_ALMA,  
		(Select nemo_alma from si_agrom.dbo.almacen A (nolock) where a.codi_alma=si_agrom.dbo.factura.codi_alma) Nemo,
	(select /*(select (select (select des_lin_pro from si_agrom.dbo.LINEA_FAMILIA_PRO L (nolock) 
						where l.cod_lin_pro in */(select F.cod_lin_pro from si_agrom.dbo.familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from si_agrom.dbo.sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from si_agrom.dbo.Productos P (nolock) 
					where P.codi_prod =D.codi_prod) ))/*)))*/) Linea,
	sum(D.CANT_ITEM)  cantidad,
--	SUM(D.CANT_ITEM *(D.PREC_ITEM * (CASE WHEN si_agrom.dbo.factura.codi_mone='01' THEN 1 ELSE si_agrom.dbo.factura.tcambio END))) venta,
	SUM(D.CANT_ITEM *( case when  si_agrom.dbo.productos.cod_impuesto=1 then 	D.PREC_ITEM/(1+d.igv/100) else 0 end  +  
						 case when si_agrom.dbo.productos.cod_impuesto=3 then 	D.PREC_ITEM else 0 end)  *
                                        (CASE WHEN  si_agrom.dbo.factura.codi_mone='01' THEN 1 ELSE  si_agrom.dbo.factura.tcambio END)   ) venta,

	SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + si_agrom.dbo.f_igv(fech_fact)/100 end))) prec_costo
    FROM si_agrom.dbo.FACTURA (nolock),   
         si_agrom.dbo.FACTURA_DETALLE D(nolock), 
		 si_agrom.dbo.productos (nolock)
   WHERE  
   		( si_agrom.dbo.FACTURA.FECH_FACT >= @FI) and
		( si_agrom.dbo.FACTURA.FECH_FACT < DATEADD(DAY,1,@FF)) and 
		D.CODI_FACT = si_agrom.dbo.FACTURA.CODI_FACT  and  
		D.codi_prod=si_agrom.dbo.productos.codi_prod and 
		( ISNULL(si_agrom.dbo.FACTURA.ESTADO,'')<>'A') and codi_tipo_pago=@tipo
	group by  si_agrom.dbo.factura.codi_alma, D.codi_prod
	) SQL
group by codi_alma, nemo
order by nemo


select codi_alma , nemo , fertcosto , fertventa , fertgencosto , fertgenventa , herrcosto , herrventa , 
		nutrcosto , nutrventa , pestcosto , pestventa , semicosto , semiventa , costo , venta , empresa,
		isnull((select sum(importe) from #MX X where X.codi_alma=T.codi_alma
					group by codi_alma),0) as Otros_Gasto
from #tx T
		
drop table #tx
drop table #Mx
GO
