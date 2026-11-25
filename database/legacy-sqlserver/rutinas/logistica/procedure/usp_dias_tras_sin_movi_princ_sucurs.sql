CREATE PROCEDURE [dbo].[usp_dias_tras_sin_movi_princ_sucurs]
	@f1 [datetime],
	@f2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime, @f2 datetime , @alma  char(2)
--select @f1 ='01/01/2018', @f2='21/05/2018' , @alma ='01'

set nocount on

declare @Tx table (codi_alma char(2), origen varchar(100) , codi_alma_desti char(2), destino varchar(100), fecha_emis datetime, codi_prod char(8),
					producto varchar(200), presen varchar(50) , cantidad int, linea varchar(50) , subfamilia varchar(200) , laboratorio varchar(200) ,
					moti char(2) , desc_moti varchar(250) , observa varchar(200) , fechaingreso datetime, cantingr numeric(12,2) null)

declare @Ax table (codi_alma char(2))

if @alma='00' 
	insert @Ax
	select codi_alma from almacen (nolock)	
else
	insert @Ax
	select @alma


insert @tx
select D.codi_alma, 
		(select NEMO_ALMA from almacen A (nolock) where a.CODI_ALMA=D.codi_alma) as Origen,
		D.CODI_ALMA_DESTI, 
		(select NEMO_ALMA from almacen A (nolock) where a.CODI_ALMA=D.CODI_ALMA_DESTI) as Destino,
		max(fech_emis)  FECH_EMIS ,
		codi_prod,
		(select desc_prod from productos P (nolock) where P.codi_prod=B.codi_prod) as Producto,
		(select (select desc_pres from presentacion X (nolock) where x.cod_pres=p.cod_pres)
				 from productos P (nolock) where P.codi_prod=B.codi_prod) as Presen,	
		0 cantidad,

		(select (select (select (select l.des_lin_pro from LINEA_FAMILIA_PRO L (nolock) where L.cod_lin_pro=f.cod_lin_pro)
			from familia_producto F (nolock) where F.CODI_FAMI_PROD= S.CODI_FAMI_PROD)
				 from sub_familia_producto S (nolock)
					where S.codi_sub_fami_prod=p.codi_sub_fami_prod) from productos P (nolock) where P.codi_prod=B.codi_prod) as Linea,

		(select (select desc_sub_fami_prod from sub_familia_producto S (nolock)
					where S.codi_sub_fami_prod=p.codi_sub_fami_prod) from productos P (nolock) where P.codi_prod=B.codi_prod) as SubFamilia,		

		(select dbo.F_Cliente_Proveedor(P.codi_clie_prov) from productos P (nolock) where P.codi_prod=B.codi_prod) as Laboratorio,

		'' ,--(select CODI_MOTI_TRAS from guia g (nolock) where g.codi_docu_sali=D.codi_docu_sali) Moti,
	
		'', /* (select (select x.DESC_MOTI_TRAS from MOTIVO_TRASLADO x (nolock) where x.CODI_MOTI_TRAS=g.CODI_MOTI_TRAS)
			 from guia g (nolock) where g.codi_docu_sali=D.codi_docu_sali) DesMoti,*/

		'' , --(select observaciones from guia g (nolock) where g.codi_docu_sali=D.codi_docu_sali) Observa,

		null FechaIngreso,
		/*
		isnull((select sum(y.cantidad) from nota_ingreso X (nolock)
			join detalle_nota_ingreso y (nolock)
			on x.codi_nota_ingr=Y.codi_nota_ingr
			where Y.codi_prod=B.codi_prod and x.tipo_nota_ingr='23' and 
					x.codi_alma=D.codi_alma and 
					X.fech_nota_ingr in (
				(select max(a.FECH_NOTA_INGR) from nota_ingreso A (nolock)
					join DETALLE_NOTA_INGRESO C (nolock)
					on A.CODI_NOTA_INGR=C.CODI_NOTA_INGR
						where a.TIPO_NOTA_INGR='23' and C.codi_prod=B.codi_prod 
						and A.codi_alma=D.codi_alma and a.FECH_NOTA_INGR<@f1 ))), 0 ) 	*/0 cantidadIngr
						
from DOCU_SALI_MATE D (nolock)
join DETALLE_DOCU_SALI B (nolock)
on D.CODI_DOCU_SALI = B.CODI_DOCU_SALI
where cast(convert(char(10),FECH_EMIS,103) as datetime) between @f1 and @f2 
		and TIPO_SALI='17' and D.codi_alma='01' and D.codi_alma in (select X.codi_alma from @Ax x)
group by D.codi_alma,D.codi_alma_desti, codi_prod
--order by 1, 2,3

declare @StockAlma table (codi_prod char(8), codi_alma char(2) , stock numeric(12,2) null)

insert @StockAlma 
select distinct x.codi_prod,	x.codi_alma,
		sum(cant_ingr - cant_sali) from kardex k (nolock)
join (select distinct codi_prod, codi_alma from @Tx) x
on k.codi_alma=X.codi_alma and k.codi_prod=X.codi_prod
where k.periodo=year(@f2) and 
					convert(char(10),k.fech_tran,103)<=@f2
					--and X.codi_prod=00010005
group by x.codi_alma, x.codi_prod						

insert @StockAlma 
select x.codi_prod,	x.codi_alma_desti,
		sum(cant_ingr - cant_sali) from kardex k (nolock)
join @Tx x
on k.codi_alma=X.codi_alma_desti and k.codi_prod=X.codi_prod
where k.periodo=year(@f2) and 
					convert(char(10),k.fech_tran,103)<=@f2
group by x.codi_alma_desti, x.codi_prod						

declare @Cx table (codi_prod char(8) , cantidad numeric(12,2) null, codi_alma char(2), codi_desti char(2))

insert @Cx
select x.codi_prod, c.cantidad , x.codi_alma , x.codi_alma_desti
from docu_sali_mate A (nolock)
			join detalle_docu_sali C (nolock)
				on A.codi_docu_sali=C.codi_docu_sali
join @Tx X 
on X.codi_prod=C.codi_prod and X.codi_alma=A.codi_alma 				
				and a.codi_alma_desti=X.codi_alma_desti
where a.tipo_Sali='17' 	and A.fech_emis=X.fecha_emis
					

select	codi_alma , 
		origen , 
		codi_alma_desti , 
		destino , 
		fecha_emis , 
		codi_prod ,
		producto , 
		presen , 
		(select cantidad from @Cx C 
				where c.codi_prod=X.codi_prod and c.codi_alma=X.codi_alma and c.codi_desti=X.codi_alma_desti) cantidad , 
		linea , 
		subfamilia , 
		laboratorio ,
		moti , 
		desc_moti , 
		observa , 
		(select max(a.fech_emis) from docu_sali_mate A (nolock)
			join detalle_docu_sali C (nolock)
				on A.codi_docu_sali=C.codi_docu_sali
					where a.tipo_Sali='17' and C.codi_prod=X.codi_prod 
					and A.codi_alma=X.codi_alma 
					and a.codi_alma_desti=X.codi_alma_desti
					and A.fech_emis<X.fecha_emis )  fechaingreso,
					
		isnull(DATEDIFF(d,fecha_emis, @f2) + 1,0) Diff,
		(select razon_social from empresa (nolock)) as Empresa, 
		
		
		(select top 1 c.cantidad from docu_sali_mate A (nolock)
			join detalle_docu_sali C (nolock)
				on A.codi_docu_sali=C.codi_docu_sali
					where a.tipo_Sali='17' and C.codi_prod=X.codi_prod 
					and A.codi_alma=X.codi_alma 
					and a.codi_alma_desti=X.codi_alma_desti
					and A.fech_emis<X.fecha_emis order by a.fech_emis desc )cantingr,
		
		(select stock  from @stockalma k 
				where k.codi_alma=X.codi_alma and k.codi_prod=X.codi_prod )	stock,

		(select stock  from @stockalma k 
				where k.codi_alma=X.codi_alma_desti and k.codi_prod=X.codi_prod )	stock_sucurs
						
from @Tx X
--where codi_prod=00010005
order by producto
GO
