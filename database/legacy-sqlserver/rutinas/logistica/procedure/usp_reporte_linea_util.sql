CREATE PROCEDURE [dbo].[usp_reporte_linea_util]
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
			and left(nro_Cuen,2) in (62, 63 ,64 ,65 ,67 )

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
(  SELECT dbo.FACTURA.CODI_ALMA,  
		(Select nemo_alma from dbo.almacen A (nolock) where a.codi_alma=dbo.factura.codi_alma) Nemo,
	(select /*(select (select (select des_lin_pro from dbo.LINEA_FAMILIA_PRO L (nolock) 
						where l.cod_lin_pro in*/ (
						select F.cod_lin_pro from dbo.familia_producto F (nolock)
					where F.codi_fami_prod in (select  S.codi_fami_prod from dbo.sub_familia_producto S (nolock)
				where codi_sub_fami_prod in (select P.codi_sub_fami_prod from dbo.Productos P (nolock) 
					where P.codi_prod =D.codi_prod) )) /*)))*/) Linea,
	sum(D.CANT_ITEM)  cantidad,
	SUM(D.CANT_ITEM *(D.PREC_ITEM * (CASE WHEN dbo.factura.codi_mone='01' THEN 1 ELSE dbo.factura.tcambio END))) venta,	
	SUM(D.CANT_ITEM* (D.PREC_COSTO * (case when cod_impuesto=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end))) prec_costo
    FROM dbo.FACTURA (nolock),   
         dbo.FACTURA_DETALLE D(nolock), 
	 dbo.productos (nolock)
   WHERE  
		( dbo.FACTURA.FECH_FACT >= @FI) and
		( dbo.FACTURA.FECH_FACT < DATEADD(DAY,1,@FF)) and 	
		D.CODI_FACT = dbo.FACTURA.CODI_FACT  and  
		D.codi_prod=dbo.productos.codi_prod and 
		( ISNULL(dbo.FACTURA.ESTADO,'')<>'A') and
		codi_tipo_pago=@tipo
	group by  dbo.factura.codi_alma, D.codi_prod
	
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
