CREATE PROCEDURE [dbo].[usp_lista_nota_ingreso_alma]
	@alma [char](2),
	@prod [char](8),
	@tipo [char](2)
WITH EXECUTE AS CALLER
AS
--declare @alma char(2), @prod char(8) , @tipo char(2)
--select @alma='07', @prod='00082211', @tipo='23'

set nocount on
declare @Tx table (codi_nota_ingr char(10), codi_docu_sali char(10), codi_alma char(2) null, 
		   fech_nota_ingr datetime null, tipo_nota_ingr char(2) null, canti_ni numeric(12,4) null,
		   prec_unit numeric(12,4) null, prec_compra numeric(12,4) null, nro_nota_ingr char(10) null,
		   peso numeric(12,3) null, prod char(8) null)

insert @Tx
select distinct A.codi_nota_ingr, A.codi_docu_sali, codi_alma_dest as codi_alma,
	fech_nota_ingr, /*C.cantidad, C.prec_costo, C.prec_prom,*/ A.tipo_nota_ingr,
	B.cantidad canti_ni, B.prec_unit, isnull(B.prec_compra,0) prec_compra, A.nro_nota_ingr,
	(select peso from productos p(nolock) where p.codi_prod=b.codi_prod) peso, b.codi_prod
	
from nota_ingreso A(nolock)
join detalle_nota_ingreso B(nolock) 
on A.codi_nota_ingr = B.codi_nota_ingr
left join detalle_docu_sali C (nolock)
on A.codi_docu_sali = C.codi_docu_sali
where A.codi_alma=@alma and B.codi_prod=@prod --and nro_nota_ingr='52421' --and A.tipo_nota_ingr=@tipo

order by A.codi_nota_ingr desc

select codi_docu_sali, codi_nota_ingr, codi_alma, fech_nota_ingr, 
       (select cantidad from detalle_docu_sali D(nolock) where D.codi_docu_sali = T.codi_docu_sali and D.codi_prod =@prod) cantidad,
       (select prec_costo from detalle_docu_sali D(nolock) where D.codi_docu_sali = T.codi_docu_sali and D.codi_prod =@prod) prec_costo,
       (select prec_prom from detalle_docu_sali D(nolock) where D.codi_docu_sali = T.codi_docu_sali and D.codi_prod =@prod) prec_prom,
	    tipo_nota_ingr,	canti_ni, prec_unit, prec_compra, nro_nota_ingr,
        --(case when isnull(peso,0)<>0 then (prec_compra_PRI / peso) * 1000.00 else 0 end) precio_TN
        
	isnull((case when isnull(peso,0)<>0 then ((select top 1 precio from orden_de_compra g(nolock)
			join detalle_orden_compra gd(nolock)on g.codi_orde_comp = gd.codi_orde_comp
				where cast(convert(char(10),fecha,103) as datetime) <= cast(convert(char(10),fech_nota_ingr ,103) as datetime)
				and T.prod = GD.codi_prod order by fecha desc)/ peso ) * 1000.00 else 0 end),0) precio_TN,
				--(case when isnull(peso,0)<>0 then (prec_unit / peso) * 1000.00 else prec_unit end) precio_TN,
				
				/*case when dbo.f_tc(convert(char(10),fech_nota_ingr,103),'V','01','02')=0 then 0 else
					round((case when isnull(peso,0)<>0 then (prec_unit / peso) * 1000.00 else prec_unit end) /
						dbo.f_tc(convert(char(10),fech_nota_ingr,103),'V','01','02'),0) end*/ 0.00 precio_TN_d 
				
from @Tx T
GO
