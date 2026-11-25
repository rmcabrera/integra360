CREATE PROCEDURE [dbo].[usp_repo_letras_produc]
	@reg [varchar](11),
	@fecha [datetime],
	@clie [char](5)
WITH EXECUTE AS CALLER
AS
--declare @reg varchar(11), @fecha datetime, @clie char(5)
--select @reg='208L0025', @fecha='03/04/2024', @clie='06733'

set nocount on 

declare @Prov table (anio char(4) , mes char(2), subdia char(1) , compr varchar(5), nro_cuen char(7), codi_clie char(5))
declare @ProvC table (anio char(4) , mes char(2), subdia char(1) , compr varchar(5), nro_cuen char(7))
declare @ProvR table (anio char(4) , mes char(2), subdia char(1) , compr varchar(5), nro_cuen char(7))

declare @Letras table (idd int identity, registro varchar(10), vence datetime, soles numeric(12,2) null, dolares numeric(12,2) null, codi_mone char(2),
						codi_clie_prov char(5) null, nro_docu varchar(20) null, fecha datetime)
declare @REpo table (registro varchar(10) , totalletras int, codi_clie_prov char(5), proveedor varchar(200) null,
					vence datetime, nro_docu varchar(20) null, importe numeric(12,2) , nroletras int, codi_mone char(2))
declare @Prod table (codi_prod char(8))
declare @Compr table (registro varchar(10) , codi_clie_prov char(5), codi_docu char(4), serie varchar(10) , nro_docu varchar(20), vence datetime, fech_fact datetime null)
declare @FechProd table (codi_prod char(8), fecha datetime, compra int)
declare @DatosC table (codi_nota_ingr char(10), codi_prod char(8), cantidad int, prec_unit numeric(12,4) , prec_tota numeric(12,2), codi_mone char(2))

declare @anio int 

set @anio = year(@fecha)

--------------------------Se lista los productos del registro ----------------------
insert @Prod
select codi_prod 
from LETRAS_PRODUCTOS A (nolock) 
where registro=@reg

-----------------------Se obtiene el comprobante del registro -------------------------
insert @Prov
select anio, mes, subdia, compr, nro_cuen, codi_clie_prov
from movi_contables M (nolock)
where subdia='L' and codi_clie_prov=@clie and registro=@reg  and fecha<=@fecha

-----------------------Recuperacion de las letras -------------------------------
insert @Letras
select distinct registro, fecha_venc, importe, importe_d, codi_mone, codi_clie_prov, Nro_Docu, fecha
from movi_contables M (nolock)
join @Prov B
on M.anio=B.anio and M.mes=B.mes and M.Compr=B.compr and M.Nro_Cuen=B.nro_cuen 
	and M.subdia=B.subdia and M.codi_clie_prov=codi_clie
where cargo_Abono='A'	and importe<>0.01 and glosa not like 'Diferencia de Cambio automáti%'
order by Fecha_venc

-------------------------- Busqueda del Documento de Compra y fecha de compra--------------------------
insert @Compr
select distinct registro, codi_clie_prov, codi_tipo_docu,serie, Nro_Docu,Fecha_venc, fecha
from movi_contables M (nolock)
join @Prov B
on M.anio=B.anio and M.mes=B.mes and M.Compr=B.compr and M.Nro_Cuen<>B.nro_cuen 
	and M.subdia=B.subdia and registro<>'' 
where codi_tipo_docu='0001'
order by Fecha_venc


if (select count(*) from @Compr)<=0 
begin
	----Se busca en Primer Canje
	insert @ProvC
	select anio, mes, subdia, compr, nro_cuen  
	from movi_contables A (nolock) where registro in (
		select distinct registro
		from movi_contables M (nolock)
		join @Prov B
		on M.anio=B.anio and M.mes=B.mes and M.Compr=B.compr and M.subdia=B.subdia and registro<>''
		where cargo_abono='C') 
	and	subdia='L' 	and not exists (select * from @Prov X where X.anio=A.anio and X.mes=A.mes and X.subdia=A.subdia and X.compr=A.compr)

	insert @Compr
	select distinct registro, codi_clie_prov, codi_tipo_docu,serie, Nro_Docu,Fecha_venc, fecha
	from movi_contables M (nolock)
	join @ProvC B
	on M.anio=B.anio and M.mes=B.mes and M.Compr=B.compr and M.Nro_Cuen<>B.nro_cuen 
		and M.subdia=B.subdia and registro<>'' and codi_tipo_docu<>'0008'
	order by Fecha_venc	
	
	if (select count(*) from @Compr)<=0 
	begin
		---- Se busca en segundo Canje
		insert @ProvR
		select anio, mes, subdia, compr, nro_cuen  
		from movi_contables A (nolock) where registro in (
			select distinct registro
			from movi_contables M (nolock)
			join @ProvC B
			on M.anio=B.anio and M.mes=B.mes and M.Compr=B.compr and M.subdia=B.subdia and registro<>''
			where cargo_abono='C') 
		and	subdia='L' 	and 
			not exists (select * from @ProvC X where X.anio=A.anio and X.mes=A.mes and X.subdia=A.subdia and X.compr=A.compr) 


		insert @Compr
		select distinct registro, codi_clie_prov, codi_tipo_docu,serie, Nro_Docu,Fecha_venc, fecha
		from movi_contables M (nolock)
		join @ProvR B
		on M.anio=B.anio and M.mes=B.mes and M.Compr=B.compr and M.Nro_Cuen<>B.nro_cuen 
			and M.subdia=B.subdia and registro<>''
		order by Fecha_venc					

		if (select count(*) from @Compr)<=0 
		begin
			---- Se busca en segundo Canje
			delete @ProvC
			
			insert @ProvC
			select anio, mes, subdia, compr, nro_cuen  
			from movi_contables A (nolock) where registro in (
				select distinct registro
				from movi_contables M (nolock)
				join @ProvR B
				on M.anio=B.anio and M.mes=B.mes and M.Compr=B.compr and M.subdia=B.subdia and registro<>''
				where cargo_abono='C') 
			and	subdia='L' 	and 
				not exists (select * from @ProvR X where X.anio=A.anio and X.mes=A.mes and X.subdia=A.subdia and X.compr=A.compr) 

			insert @Compr
			select distinct registro, codi_clie_prov, codi_tipo_docu,serie, Nro_Docu,Fecha_venc, fecha
			from movi_contables M (nolock)
			join @ProvC B
			on M.anio=B.anio and M.mes=B.mes and M.Compr=B.compr and M.Nro_Cuen<>B.nro_cuen 
				and M.subdia=B.subdia and registro<>''
			order by Fecha_venc					
		end

	end
	
	
end


--select * from @compr
------------------ Se obtiene cantidad comprada ----------------
insert @FechProd 
select codi_prod, max(FECH_NOTA_INGR), isnull(sum(cantidad),0)
from NOTA_INGRESO A(nolock)
join DETALLE_NOTA_INGRESO B (nolock)
on A.CODI_NOTA_INGR = B.CODI_NOTA_INGR
join @Compr C
on A.CODI_TIPO_DOCU_CONT=C.codi_docu and 
		case when isnumeric(NRO_SERI_DOCU_CONT)=1 then 	cast(cast(NRO_SERI_DOCU_CONT as numeric) as varchar) else NRO_SERI_DOCU_CONT end =C.serie and
		case when isnumeric(NRO_DOCU_CONT)=1 then 	cast(cast(NRO_DOCU_CONT as numeric) as varchar) else NRO_DOCU_CONT end =c.nro_docu	and 
		A.codi_clie_prov=C.codi_clie_prov
--where a.CODI_NOTA_INGR=0000058373
group by CODI_PROD
--order by 6


------------------ se obtiene precio compra y prec unitario ----------------------
insert @DatosC
select A.codi_nota_ingr,codi_prod, CANTIDAD, PREC_UNIT, PREC_TOTA, A.codi_mone
from NOTA_INGRESO A(nolock)
join DETALLE_NOTA_INGRESO B (nolock)
on A.CODI_NOTA_INGR = B.CODI_NOTA_INGR
join @Compr C
on A.CODI_TIPO_DOCU_CONT=C.codi_docu and 
		case when isnumeric(NRO_SERI_DOCU_CONT)=1 then 	cast(cast(NRO_SERI_DOCU_CONT as numeric) as varchar) else NRO_SERI_DOCU_CONT end =C.serie and
		case when isnumeric(NRO_DOCU_CONT)=1 then 	cast(cast(NRO_DOCU_CONT as numeric) as varchar) else NRO_DOCU_CONT end =c.nro_docu	and 
		A.codi_clie_prov=C.codi_clie_prov
where PREC_UNIT<>0
order by A.CODI_NOTA_INGR


-----------------Se Obtiene Informacion de la Letra, Total, y Nro--------------------------
insert @REpo
select 	@reg as registro, 
		count(registro) as NroLetras,
		codi_clie_prov,
		dbo.F_Cliente_Proveedor(codi_Clie_prov) as Proveedor,
		max(case when registro=@reg then vence else null end) Vence,
		max(case when registro=@reg then nro_docu else null end) Nro_docu,
		max(case when registro=@reg then 
				case when codi_mone='01' then soles else dolares end 
				else 0 end ) Importe,
		max(case when registro=@reg then idd else 0 end) as NroLetra,
		codi_mone	
from @Letras 
group by codi_clie_prov, codi_mone


-------------------- Se obtiene informacion detalle de los productos --------------------
declare @Posi int
set @Posi = isnull((select top 1 idd from @Letras X where X.registro=@reg),0)


declare @Det table (registro varchar(10) , codi_prod char(8), compra int, posterior int, stock int, esperado numeric(12,2) , fechacompra datetime)

insert @Det
select  @reg as Registro,
		codi_prod, 
		--cast(sum(cantidad) as numeric(12)) as Compra,
		(select compra from @FechProd F where F.codi_prod=A.codi_prod) as Compra,

		isnull((select sum(y.CANTIDAD)
			from nota_ingreso X (nolock)
			join DETALLE_NOTA_INGRESO y (nolock)
			on X.CODI_NOTA_INGR=Y.CODI_NOTA_INGR
			where X.TIPO_NOTA_INGR='01' and FECH_NOTA_INGR>(select fecha from @FechProd F where F.codi_prod=A.codi_prod) 
					and Y.codi_prod=A.codi_prod),0 )  as Posterior,

		isnull((select sum(cant_ingr - cant_sali) 
			from kardex  K (nolock)
				where periodo=@anio and K.codi_prod =A.codi_prod and k.fech_tran<@fecha),0) as StockActual,

		sum(case when idd<=@posi then cantidad else  0 end ) as Esperada,
		
		(select f.fecha from @FechProd F where F.codi_prod=A.codi_prod) as fechaCompra

from LETRAS_PRODUCTOS A (nolock) 
join @Letras B
on A.registro=B.registro
group by codi_prod
order by codi_prod

--------------------------- se obtiene el precio venta ---------------
declare @alma char(2)
select @alma='19'			------------Galvez 885

set nocount on 

declare @Pventa table (codi_prod char(8),  precio_venta numeric(12,2))

insert @Pventa
SELECT  p.codi_prod , 
		isnull(round( case when codi_mone='01' then prec_costo * 
			( 1 +  prec_porc_uti_esp / 100) * case when cod_impuesto=3 then 1 else (1 + (SELECT valor FROM valores_unitarios_anuales (nolock) where codi_valo_unit=2 and esta_acti=1)/100) end 
		 else  prec_costo * ( 1 +  prec_porc_uti_esp / 100) * 
				case when cod_impuesto=3 then 1 
						else (1 + (SELECT valor FROM valores_unitarios_anuales (nolock) 
						where codi_valo_unit=2 and esta_acti=1)/100)   end * tcambio
			 end , nro_decim_precio ),0)
FROM PRODUCTOS P (nolock) 
INNER JOIN ALMACEN_PRODUCTO AP (nolock) 
	ON AP.CODI_ALMA=@alma and P.CODI_PROD=AP.CODI_PROD
where P.codi_prod in (select d.codi_prod from @Det D)
order by 2


------------------------------ Se muestra cuadro reporte-----------------------

select A.registro, 
		totalletras, 
		codi_clie_prov, 
		proveedor, 
		vence, 
		nro_docu, 
		importe,
		nroletras, 
		codi_mone,
		codi_prod,
		(select P.desc_prod from productos P (nolock) where P.codi_prod=B.codi_prod) as DEscProd,
		isnull(compra,0) as compra,
		posterior,
		stock,
		esperado ,
		posterior - stock + isnull(compra,0)  as CantVend,
		
	/*	isnull((select sum(y.CANTIDAD)
			from DOCU_SALI_MATE X (nolock)
			join detalle_docu_sali y (nolock)
			on X.CODI_DOCU_SALI=Y.CODI_DOCU_SALI
			where X.TIPO_SALI='08' and FECH_EMIS>(select fecha from @FechProd F where F.codi_prod=B.codi_prod) 
					and Y.codi_prod=B.codi_prod),0 )  as CantVend,
*/
		(posterior - stock + isnull(compra,0) )*100/case when esperado<>0 then esperado else 1 end as PorcAvan,

/*		isnull((select sum(y.CANTIDAD)
			from DOCU_SALI_MATE X (nolock)
			join detalle_docu_sali y (nolock)
			on X.CODI_DOCU_SALI=Y.CODI_DOCU_SALI
			where X.TIPO_SALI='08' and FECH_EMIS>(select fecha from @FechProd F where F.codi_prod=B.codi_prod) 
					and Y.codi_prod=B.codi_prod),0 ) *100/esperado as PorcAvan,

*/
		case when (posterior - stock + isnull(compra,0) )>=esperado then 'PAGAR 100%' else 'RENOVAR' end as Estado,
		case when (posterior - stock + isnull(compra,0) )<0 then 'LA CANTIDAD VENDIDA PERTENECE A UNA COMPA ANTERIOR' else '' end as Observa,
/*
		case when isnull((select sum(y.CANTIDAD)
			from DOCU_SALI_MATE X (nolock)
			join detalle_docu_sali y (nolock)
			on X.CODI_DOCU_SALI=Y.CODI_DOCU_SALI
			where X.TIPO_SALI='08' and FECH_EMIS>(select fecha from @FechProd F where F.codi_prod=B.codi_prod) 
					and Y.codi_prod=B.codi_prod),0 ) >=esperado then 'PAGAR 100%' else 'RENOVAR' end as Estado,

		case when isnull((select sum(y.CANTIDAD)
			from DOCU_SALI_MATE X (nolock)
			join detalle_docu_sali y (nolock)
			on X.CODI_DOCU_SALI=Y.CODI_DOCU_SALI
			where X.TIPO_SALI='08' and FECH_EMIS>(select fecha from @FechProd F where F.codi_prod=B.codi_prod) 
					and Y.codi_prod=B.codi_prod),0 ) <0 then 'LA CANTIDAD VENDIDA PERTENECE A UNA COMPA ANTERIOR' else '' end as Observa,
*/			
		(select razon_social from empresa (nolock)) Empresa,
		
		(select sum(prec_tota) from 
				(select distinct codi_nota_ingr,prec_tota from @DatosC) SQ) as TotalCompra,

		(select top 1 codi_mone from @datosC ) as MoneCompra,

		isnull((select max(prec_unit) from @DatosC x where X.codi_prod=B.codi_prod),0)  as PrecUnit,

		(SELECT  X.cantidad FROM LETRAS_PRODUCTOS X (NOLOCK) where x.registro=A.registro and x.codi_prod=B.codi_prod) as CantiLetra,

		0 as ValorCantV,

		(SELECT  X.cantidad FROM LETRAS_PRODUCTOS X (NOLOCK) where x.registro=A.registro and x.codi_prod=B.codi_prod) *	
				isnull((select max(prec_unit) from @DatosC x where X.codi_prod=B.codi_prod),0) as CantLetraV,

		(select p.precio_venta from @Pventa P  where p.codi_prod=B.codi_prod) as PrecVenta,
		fechacompra
from @REpo A 
join @Det B
on A.registro=B.registro
order by codi_prod
GO
