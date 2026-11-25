CREATE PROCEDURE [dbo].[usp_reporte_pagos_efec_vs_produc]
	@fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime , @fec2 datetime
--select @fec1 ='01/01/2017', @fec2='31/01/2017'

set nocount on 

create table #Mx (registro varchar(11) null, codi_clie_prov char(5) null, serie varchar(10) null, nro_docu varchar(20)null, importe numeric(12,2) null,
					importe_d numeric(12,2) null, glosa varchar(250) null, nro_cuen char(7) null, fecha datetime null, codi_mone char(2))

create table #Dx (registro varchar(11) null, codi_clie_prov char(5) null, serie varchar(10) null, nro_docu varchar(20)null, importe numeric(12,2) null,
					importe_d numeric(12,2) null, glosa varchar(250) null, nro_cuen char(7) null, fecha datetime null, codi_mone char(2))

create table #Rx (registro varchar(11) null, fecha datetime null, codi_mone char(2),
					codi_clie_prov char(5) null, serie varchar(10) null, nro_docu varchar(20)null, importe numeric(12,2) null,
					importe_d numeric(12,2) null, glosa varchar(250) null, codi_prod char(8) null, cantidad int null,
					proporcanti int, original numeric(12,2) null, original_d numeric(12,2) null)
					
					
insert #Mx					
select registro, Codi_Clie_Prov, serie, nro_docu, Importe, Importe_d, glosa, nro_cuen, fecha, codi_mone
from Movi_Contables M (nolock)
where Subdia='E' and M.fecha between @fec1 and @fec2 
		and LEFT(Nro_Cuen,2 ) ='42'
		

insert #Dx					
select registro, Codi_Clie_Prov, serie, nro_docu, Importe, Importe_d, glosa, nro_cuen, fecha, codi_mone
from #Mx
where glosa not like 'Diferencia de Cambio automático'
		and ( patindex('%C%', registro)>0 or patindex('%L%', registro)>0 )

insert #Rx
select D.registro, D.fecha, D.codi_mone,codi_clie_prov, serie, nro_docu, importe, importe_d, glosa, l.codi_prod, l.cantidad, 
		l.cantidad as proporcanti, 0.0 as Original_D, 0.00 as Original_D
from #Dx D
join letras_productos L (nolock)
on D.registro = L.registro

insert #Rx
select D.registro, D.fecha, D.codi_mone, D.codi_clie_prov, D.serie, D.nro_docu, D.importe, d.importe_D, 
		D.glosa, I.codi_prod, I.cantidad,
		cast(round(I.cantidad*case when D.codi_mone='01' 
						then D.importe/M.importe else D.importe_D/M.importe_D end ,0) as numeric(12,0)) as ProporCanti,
		M.importe as Original , M.importe_d as Original_D
from #Dx D
join movi_contables M (nolock)
on D.registro=M.registro
join nota_ingreso N (nolock)
On M.codi_clie_prov=N.codi_clie_prov and M.codi_tipo_docu=N.codi_tipo_docu_cont and 
		M.serie=N.nro_Seri_docu_cont and M.nro_docu=N.nro_Docu_cont
join detalle_nota_ingreso I (nolock)		
on N.codi_nota_ingr=I.codi_nota_ingr
where D.registro not in (select L.registro from letras_productos L (nolock))
		and M.subdia='C' and N.tipo_nota_ingr='01'
	---and  patindex('%L%', registro)>0


select registro , fecha , R.codi_mone , R.codi_clie_prov , serie , nro_docu , importe ,
					importe_d , glosa , R.codi_prod , cantidad ,	proporcanti , original , original_d ,
			dbo.f_cliente_proveedor(R.codi_clie_prov) as Laboratorio,
			(select razon_Social from empresa (nolock)) as Empresa,
			(select Ruc from empresa (nolock)) as EmpresaRuc,
			S.desc_sub_fami_prod,
			L.des_lin_pro,
			P.DESC_PROD
from #RX R
join productos P (nolock)
on R.codi_prod=P.codi_prod
join sub_familia_producto S (nolock)
on P.codi_sub_fami_prod=S.codi_sub_fami_prod
join familia_producto F (nolock)
on F.codi_fami_prod=S.codi_fami_prod
join LINEA_FAMILIA_PRO L (nolock)
on L.cod_lin_pro=F.cod_lin_pro
order by registro, fecha

drop table #Mx
drop table #DX
drop table #Rx
GO
