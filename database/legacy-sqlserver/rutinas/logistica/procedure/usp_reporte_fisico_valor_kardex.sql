CREATE PROCEDURE [dbo].[usp_reporte_fisico_valor_kardex]
	@anio [char](4),
	@F1 [datetime],
	@F2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @F1 datetime, @F2 datetime
--select @anio='2019', @F1='01/12/2019', @F2='31/12/2019'

declare @Tx table (codi_prod char(8), tipo char(2) , i_o int, ingreso numeric(12,2) null, salida numeric(12,2) , 
					valor_ingr numeric(12,2) , valor_sali numeric(12,2))

set nocount on

insert @Tx					
select codi_prod, Tipo, i_o, 
		sum(cant_ingr) Ingreso, 
		sum(cant_sali) Salida,
		sum(valo_ingr) ValorIngre, 
		sum(valo_sali) ValorSali
from (select codi_prod, month(fech_tran) as mes, cant_ingr , cant_sali, valo_ingr, valo_sali,
       case when convert(char(10),fech_tran,103) < @F1 then '04' else
		case when i_o=1 
			then 
			/*	case when 
					(select tipo_nota_ingr from nota_ingreso N (nolock) where N.codi_nota_ingr=K.codi_docu_i_o) ='04' 
						and fech_tran='01/01/2013' then '00' else*/ (select tipo_nota_ingr from nota_ingreso N (nolock) where N.codi_nota_ingr=K.codi_docu_i_o)/* end */
			
			else (select tipo_sali from docu_sali_mate S (nolock) where S.codi_docu_sali=K.codi_docu_i_o)
			end end as Tipo, i_o
	from kardex K (nolock) 
	where periodo=@anio and convert(char(10),fech_tran,103) <= @F2 ) SQ --where tipo='04'
group by codi_prod, i_o, tipo
order by codi_prod, i_o, tipo

/*
select X.codi_prod , (select desc_prod from productos P (nolock) where P.codi_prod=X.codi_prod), ingreso,valor_ingr 
from @Tx X where tipo='00'
order by 2
*/


--------------------------- Productos Sin Movimiento
declare @ProdSinMovi table (codi_prod char(8), descr varchar(200), inicial numeric(12,2), valor numeric(12,2) )

insert @ProdSinMovi 
select X.codi_prod , (select desc_prod from productos P (nolock) where P.codi_prod=X.codi_prod), ingreso,valor_ingr
from @Tx X 
where tipo='04' and 
		x.codi_prod not in (select T.codi_prod from @Tx T where tipo not in ('04','02','37','23','27','28','30','07','10','17'))

--select * from @ProdSinMovi order by 2
--select sum(valor) from @ProdSinMovi 


---------------- producto en mal estado que no estan en inventario

--select * from @Mal
--where codi_prod in (select codi_prod from @ProdSinMovi )

--return

-----------------------------------------------------------------------------------------
/*
select B.codi_prod,B.descr, inicial, vencidos , precio, valor, round(precio*vencidos,2) as Valorizado
from @Mal A
join @ProdSinMovi B
on A.codi_prod=B.codi_prod
--where inicial-vencidos>=0
order by 2 
*/
/*
select X.codi_prod , (select desc_prod from productos P (nolock) where P.codi_prod=X.codi_prod), ingreso,valor_ingr 
from @Tx X where tipo='00'
order by 2

select A.codi_prod, A.descr, inicial, isnull(vencidos,0) as vencidos , isnull(precio,0) as precio , 
		valor as valor_inicial, isnull(round(precio*vencidos,2),0) as Valorizado
from @ProdSinMovi A
left join @Mal B
on A.codi_prod=B.codi_prod
order by 2 
*/

--select * from @MaL where codi_prod not in (select X.codi_prod from @Tx X where tipo='00')

/*
select C.codi_prod, C.descr, ingreso, isnull(vencidos,0) as vencidos , isnull(precio,0) as precio , 
		valor_ingr as valor_inicial, isnull(round(precio*vencidos,2),0) as Valorizado, isnull(inicial,0) as SinMovi,
		isnull((select sum(ingreso) from @Tx T where T.tipo in ('01','26') and T.codi_prod=C.codi_prod),0) as Compra,
		isnull((select sum(salida) from @Tx T where T.tipo='08' and T.codi_prod=C.codi_prod),0) as Venta
from
(select x.codi_prod, (select desc_prod from productos P (nolock) where P.codi_prod=X.codi_prod) as descr,
		ingreso,valor_ingr 
	from @Tx X /*where tipo='00'*/) C
left join @ProdSinMovi A
on A.codi_prod=C.codi_prod
left join @Mal B
on c.codi_prod=B.codi_prod
order by 2 
 */

select codi_prod, 
		(select desc_prod from productos P (nolock) where P.codi_prod=T.codi_prod) desc_prod,
		sum(case when tipo='04' then ingreso else 0 end) Inventario,
		sum(case when tipo='01' then ingreso else 0 end) Compras,
		sum(case when tipo='39' then ingreso else 0 end) DevolucionIngr,
		sum(case when tipo='37' then ingreso else 0 end) Ajuste,
		sum(case when tipo='02' then ingreso else 0 end) Reposicion,
		sum(case when tipo='23' then ingreso else 0 end) Transferencia,		
		sum(case when tipo='26' then ingreso else 0 end) Bonifi,	
		--sum(case when tipo='27' then ingreso else 0 end) Organizacion,			
		--sum(case when tipo='35' then ingreso else 0 end) Muestra,		
		sum(case when tipo='40' then ingreso else 0 end) Periodo_Anterior,		
		sum(case when tipo='08' then salida else 0 end) Venta,
		sum(case when tipo='28' then salida else 0 end) AjusteSAlida,
		sum(case when tipo in ('38','22') then salida else 0 end) Prestamo,
		sum(case when tipo='07' then salida else 0 end) Devolucion,
		--sum(case when tipo='10' then salida else 0 end) Produccion,
		sum(case when tipo='17' then salida else 0 end) TRansferencia,
		sum(ingreso - salida) Stock,
		sum(case when tipo='04' then valor_ingr else 0 end) Inventario,
		sum(case when tipo='01' then valor_ingr else 0 end) Compras,
		sum(case when tipo='39' then valor_ingr else 0 end) DevolucionIngr,
		sum(case when tipo='37' then valor_ingr else 0 end) Ajuste,
		sum(case when tipo='02' then valor_ingr else 0 end) Reposicion,
		sum(case when tipo='23' then valor_ingr else 0 end) Transferencia,		
		sum(case when tipo='26' then valor_ingr else 0 end) Bonifi,	
		--sum(case when tipo='27' then valor_ingr else 0 end) Organizacion,			
		--sum(case when tipo='35' then valor_ingr else 0 end) Muestra,		
		sum(case when tipo='40' then valor_ingr else 0 end) Periodo_Anterior,		
		sum(case when tipo='08' then valor_sali else 0 end) Venta,
		sum(case when tipo='28' then valor_sali else 0 end) AjusteSAlida,
		sum(case when tipo in ('38','22') then valor_sali else 0 end) Prestamo,
		sum(case when tipo='07' then valor_sali else 0 end) Devolucion,
		--sum(case when tipo='10' then valor_sali else 0 end) Produccion,
		sum(case when tipo='17' then valor_sali else 0 end) TRansferencia,
		sum(valor_ingr - valor_sali) SAldo,
		isnull((select max(inicial) from @ProdSinMovi P where P.codi_prod=T.codi_prod),0) as SinMovi,
		
		(select top 1 prec_unit * (case when A.codi_mone='01' then 1 else 
		case when isnull(tipo_camb,0)=0 then dbo.f_tc(convert(char(10),fech_nota_ingr,103),'V','01','02') else tipo_camb end end) 
		from nota_ingreso A(nolock) join detalle_nota_ingreso B(nolock) on A.codi_nota_ingr=B.codi_nota_ingr
		where convert(char(10),fech_nota_ingr,103)<=@F2 and B.codi_prod=T.codi_prod and tipo_nota_ingr='01' and A.codi_alma='01'
		order by fech_nota_ingr desc) precio,
		sum(case when tipo='34' then salida else 0 end) robo,
		sum(case when tipo='34' then valor_sali else 0 end) robo,
		sum(case when tipo='19' then salida else 0 end) consigna,
		sum(case when tipo='19' then valor_sali else 0 end) consigna,
		sum(case when tipo='18' then ingreso else 0 end) consigna_reci,
		sum(case when tipo='18' then valor_ingr else 0 end) consigna_reci
		
from @Tx T
--where codi_prod in (11023)
group by codi_prod
order by 2

--select * from @Tx T
--where codi_prod=11582
/*
select * from tipo_ingr_sali where codi_tipo_is in (01,02,04,07,08,10,17,23,26,27,28,30,35)
order by I_S
*/
GO
