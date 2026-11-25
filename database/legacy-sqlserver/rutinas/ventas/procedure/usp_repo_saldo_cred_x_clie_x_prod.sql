CREATE PROCEDURE [dbo].[usp_repo_saldo_cred_x_clie_x_prod]
	@almacen [char](2),
	@fecha [datetime],
	@cred [int],
	@cliente [char](5)
WITH EXECUTE AS CALLER
AS
--declare @almacen char(2) , @fecha datetime , @cred int , @cliente  char(5)
--select @almacen='19' , @fecha='31/10/2019', @cred = 729, @cliente ='37801'

set nocount on 

create table #Tx (codi_fact varchar(10) null , codi_alma char(2) null , denominacion varchar(250) null, fech_fact datetime null, desc_tipo_docu varchar(50) null,
					serie varchar(20) null, nro int null, codi_mone char(2) null, tota_fact numeric(12,2) null, tota_fact_d numeric(12,2) null,
					glosa varchar(250) null, codi_clie char(5) null, monto numeric(12,2) null, fec_fin datetime null, canc int null, codi_prod varchar(10) null,
					desc_item varchar(250) null, cant_item numeric(12,3) null, tota_costo numeric(12,2) null, tota_costo_d numeric(12,2) null)


insert #Tx
select F.codi_fact, F.codi_alma, (select denominacion from dbo.cliente_proveedor P (nolock)
		where P.codi_clie_prov=F.codi_clie_prov) Denominacion,
	 fech_fact, (select desc_tipo_docu from dbo.tipo_documento T where T.codi_tipo_docu=F.codi_tipo_docu) desc_tipo_docu,
	case when isnumeric(ser_fact)=0 then ser_fact else cast(cast(ser_fact as int) as varchar) end serie, 
	cast(nro_fact as int) nro, F.codi_mone, 
	(case when F.codi_mone='01' then C.monto else 0 end) tota_fact,
	(case when F.codi_mone='02' then C.monto else 0 end) tota_fact_d, 
	'Venta de Mercadería' glosa, f.codi_clie_prov codi_clie,
	isnull((select monto_cred from dbo.cliente_creditos A (nolock) 	where A.codi_credito=C.codi_credito),0) monto,
	isnull((select fec_fin_cred from dbo.cliente_creditos A (nolock) where A.codi_credito=C.codi_credito),'') fec_fin,
	0 Canc, D.codi_prod, desc_item, cant_item,
	(case when F.codi_mone='01' then round(cant_item*prec_costo*(case when cod_impuesto=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end),2) else 0 end) tota_costo,
	(case when F.codi_mone='02' then round(cant_item *(prec_costo* (case when cod_impuesto=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end)/F.tcambio),2) else 0 end) tota_costo_d
		
from dbo.factura f (nolock) 
join factura_detalle d (nolock)
on F.codi_fact=D.codi_fact
Join productos P(nolock)
on D.codi_prod=P.codi_prod
Join dbo.factura_credito C (nolock)
on F.codi_fact=C.codi_fact and codi_tipo_pago='4' and isnull(estado,'')<>'A' and fech_fact<DATEADD(day, 1, @fecha) and f.codi_alma=@almacen
where f.codi_clie_prov=@cliente and C.codi_credito=@cred

union all

select C.codi_fact, C.codi_alma, (select denominacion from dbo.cliente_proveedor P (nolock) where P.codi_clie_prov=C.codi_clie_prov) Denominacion,
	 fech_fact, (select desc_tipo_docu from dbo.tipo_documento T where T.codi_tipo_docu=F.codi_tipo_docu) desc_tipo_docu,
	 case when isnumeric(ser_fact)=0 then ser_fact else cast(cast(ser_fact as int) as varchar) end serie, 
	 cast(nro_fact as int) nro, C.codi_mone, 
	-1 * (case when C.codi_mone='01' then C.prec_vent else 0 end) as tota_fact,
	-1 * (case when C.codi_mone='02' then C.prec_vent else 0 end) as tota_fact_d, 
	'Nota de Crédito@ ' + rtrim(ser_nota_cred) + ' - ' + ltrim(nro_nota_cred) glosa, C.codi_clie_prov codi_clie,
	isnull((select max(monto_cred) from dbo.cliente_creditos CC(nolock) where CC.codi_credito=A.codi_credito),0) monto,
	isnull((select max(fec_fin_cred) from dbo.cliente_creditos CC(nolock) where CC.codi_credito=A.codi_credito),'') fec_fin,
	1 Canc, '', '', 0, 0,0
	
from dbo.nota_credito C(nolock) 
join dbo.factura F(nolock)
on C.codi_fact=F.codi_fact and codi_tipo_pago='4' and isnull(F.estado,'')<>'A' and fech_nota_cred<DATEADD(day, 1, '17/06/2019') and C.codi_alma=@almacen
join dbo.factura_credito A(nolock)
on F.codi_fact=A.codi_fact
where f.codi_clie_prov=@cliente and A.codi_credito=@cred

union all

select Ax.nro_recibo, codi_alma , (select denominacion from dbo.cliente_proveedor P (nolock)
			where P.codi_clie_prov=Ax.codi_clie_prov) Denominacion,
	 fecha,  (select desc_tipo_docu from dbo.tipo_documento T where T.codi_tipo_docu=Ax.codi_tipo_docu) desc_tipo_docu,
	 case when isnumeric(serie)=0 then serie else cast(cast(serie as int) as varchar) end serie, 
	cast(nro_docu as int), codi_mone,
	((case when tipo_io=1 then -1 else 1 end) * (case when codi_mone='01' then importe else 0 end))*cast(round(monto/tota_fact,2) as numeric(12,2)) imp,
	((case when tipo_io=1 then -1 else 1 end) * (case when codi_mone='02' then importe else 0 end))*cast(round(monto/tota_fact,2) as numeric(12,2)) impd ,
	glosa , Ax.codi_clie_prov codi_clie,
	isnull((select monto_cred from dbo.cliente_creditos X (nolock) where x.codi_credito=Fc.codi_credito),0) monto,
	isnull((select fec_fin_cred from dbo.cliente_creditos X (nolock) where x.codi_credito=Fc.codi_credito),'') fec_fin,
	tipo_io canc,'','',0, 0,0
	
from dbo.caja_chica Ax (nolock)
Join (select nro_recibo, codi_fact,tota_fact from dbo.caja_chica C(nolock) 
	Join dbo.factura f (nolock)
	On isnumeric(serie)=1 and 
		case when isnumeric(ser_fact)=0 then ser_fact else cast(cast(ser_fact as numeric) as varchar) end =
		case when isnumeric(serie)=0 then serie else cast(cast(serie as numeric) as varchar) end  and 
		case when isnumeric(nro_fact)=0 then nro_fact else cast(cast(nro_fact as numeric) as varchar) end =
		case when isnumeric(nro_docu)=0 then nro_docu else cast(cast(nro_docu as numeric) as varchar) end and 
		F.codi_tipo_docu=c.codi_tipo_docu  and ((tipo_io=1 and tipo_contab in ('005','036','037','130')) or (tipo_io=0 and tipo_contab in ('026')))
		
		union all
		select nro_recibo, codi_fact,tota_fact from dbo.caja_chica C(nolock) 
		Join dbo.factura f (nolock)
		On isnumeric(serie)=0 and ser_fact=serie and case when isnumeric(nro_fact)=1 then cast(cast(nro_fact as numeric) as varchar) else nro_fact end = 
		case when isnumeric(nro_docu)=1 then cast(cast(nro_docu as numeric) as varchar) else nro_docu end and 
		F.codi_tipo_docu=c.codi_tipo_docu  and ((tipo_io=1 and tipo_contab in ('005','036','037','130')) or (tipo_io=0 and tipo_contab in ('026')))		

)  S

on Ax.nro_recibo=S.nro_recibo
    and ((tipo_io=1 and tipo_contab in ('005','036','037','130','020')) or (tipo_io=0 and tipo_contab in ('026')))
	and Ax.fecha<DATEADD(day, 1, @fecha) and Ax.codi_alma=@almacen
Join dbo.factura_Credito FC (nolock)
on Fc.codi_fact=S.codi_Fact 
where  Ax.codi_clie_prov=@cliente and FC.codi_credito=@cred

union all

select cast(F.codi_Vale as varchar), codi_alma, 
	(select denominacion from dbo.cliente_proveedor P (nolock)
		where P.codi_clie_prov=F.codi_clie_prov) Denominacion,
	 fecha, 
	 'Vale Crédito'  as desc_tipo_docu,
	 '0' as  serie, nro_vale as  nro, codi_mone, 
	(case when codi_mone='01' then C.monto else 0 end) tota_fact,
	(case when codi_mone='02' then C.monto else 0 end) tota_fact_d,
	'Venta de Mercadería' glosa, f.codi_clie_prov codi_clie,
	isnull((select monto_cred from dbo.cliente_creditos A (nolock) 	where A.codi_credito=C.codi_credito),0) monto,
	isnull((select fec_fin_cred from dbo.cliente_creditos A (nolock) where A.codi_credito=C.codi_credito),'') fec_fin,
	0 Canc, null codi_depo, 'VALE ' + ltrim(cast(nro_vale as varchar)), 0.00 importe, 0,0
	
from dbo.registro_vale f (nolock) 
Join dbo.vale_CREDITO C (nolock)
on F.codi_Vale=C.codi_vale and codi_tipo_pago='4' and isnull(codi_Fact,'')='' and isnull(estado,'')<>'N' and fecha<DATEADD(day, 1, @fecha) and f.codi_alma=@almacen
where f.codi_clie_prov=@cliente and C.codi_credito=@cred /*and f.codi_vale not in (select codi_docu from caja_chica_depo (nolock) where tipo_rela='S')*/

union all

select cast(F.codi_Vale as varchar), codi_alma, 
	(select denominacion from dbo.cliente_proveedor P (nolock)
		where P.codi_clie_prov=F.codi_clie_prov) Denominacion,
	 fecha, 
	 'Vale Crédito'  as desc_tipo_docu,
	'0' as  serie, nro_vale as  nro, codi_mone, 
	-1*(case when codi_mone='01' then /*C.monto -*/ isnull((select sum(importe) from caja_chica_depo ccd(nolock) where tipo_rela='S' and ccd.codi_docu=C.codi_vale),0)  else 0 end) tota_fact,
	-1*(case when codi_mone='02' then /*C.monto -*/ isnull((select sum(importe) from caja_chica_depo ccd(nolock) where tipo_rela='S' and ccd.codi_docu=C.codi_vale),0)  else 0 end) tota_fact_d, 
	'Venta de Mercadería' glosa, f.codi_clie_prov codi_clie,
	isnull((select monto_cred from dbo.cliente_creditos A (nolock) 	where A.codi_credito=C.codi_credito),0) monto,
	isnull((select fec_fin_cred from dbo.cliente_creditos A (nolock) where A.codi_credito=C.codi_credito),'') fec_fin,
	1 Canc, codi_depo, 'VALE ' + ltrim(cast(nro_vale as varchar)), importe, 0,0
	
from dbo.registro_vale f (nolock) 
Join dbo.vale_CREDITO C (nolock)
on F.codi_Vale=C.codi_vale and codi_tipo_pago='4' and isnull(codi_Fact,'')='' and isnull(estado,'')<>'N' and fecha<DATEADD(day, 1, @fecha) and f.codi_alma=@almacen
left join dbo.caja_chica_depo cc(nolock)
on f.codi_vale=cc.codi_docu
where f.codi_clie_prov=@cliente and C.codi_credito=@cred and cc.tipo_rela='S' /*and f.codi_vale not in (select codi_docu from caja_chica_depo (nolock) where tipo_rela='S')*/

create table #Rx (desc_tipo_docu varchar(50) null, serie varchar(20) null, nro int null, tota_fact numeric(12,2) null, tota_fact_d numeric(12,2) null,
                  tota_costo numeric(12,2) null, tota_costo_d numeric(12,2) null)

--select distinct codi_Fact,desc_tipo_docu ,serie, nro ,tota_fact , tota_fact_d 	from #Tx
--where nro=2252

insert #Rx
select desc_tipo_docu ,serie, nro , sum(tota_fact) tota_fact , sum(tota_fact_d) tota_fact_d, sum(tota_costo) , sum(tota_costo_d) 
from 
	(select distinct codi_Fact,desc_tipo_docu ,serie, nro ,max(tota_fact) tota_fact, max(tota_fact_d) tota_fact_d, 
			sum(tota_costo) tota_costo, sum(tota_costo_d) tota_costo_d
		from #Tx
		group by codi_Fact, desc_tipo_docu, serie, nro 
			--where nro=8877
			) as SQ
group by desc_tipo_docu, serie, nro
having sum(tota_fact)<>0 or sum(tota_fact_d)<>0


select codi_fact , codi_alma , denominacion ,fech_fact ,a.desc_tipo_docu, A.serie , A.nro ,
	   codi_mone, B.tota_fact, B.tota_fact_d, glosa, codi_clie, monto, fec_fin, canc, 
	   codi_prod, desc_item, cant_item,
		(select desc_sub_fami_prod from sub_familia_producto SF(nolock) where SF.codi_sub_fami_prod in
			(select codi_sub_fami_prod from productos P(nolock) where P.codi_prod=B.codi_prod)) as sub_familia,
	   dbo.f_cliente_proveedor((select codi_clie_prov from productos P(nolock) where P.codi_prod=B.codi_prod)) as laboratorio,
	   A.tota_costo, A.tota_costo_d
	   
from #Rx A
join #Tx B
on A.desc_tipo_docu=B.desc_tipo_docu and A.serie=B.serie and A.nro=B.nro
--where B.serie='B018' and B.nro=2252
--order by tota_fact

drop table #Tx
drop table #Rx
GO
