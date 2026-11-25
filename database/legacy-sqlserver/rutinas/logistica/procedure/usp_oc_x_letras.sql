CREATE PROCEDURE [dbo].[usp_oc_x_letras]
	@f1 [datetime],
	@F2 [datetime],
	@codi_prod [char](8),
	@registro [char](11)
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime , @F2 datetime , @codi_prod char(8),@registro char(11)
--select @f1='01/01/2014', @f2='31/10/2014', @codi_prod='00081216',@registro ='403L0050'

set nocount on

declare @Ox table (codi char(10) , cliente char(5), fecha datetime, cantidad numeric(12,2) null, precio numeric(12,4) null, total numeric(12,2) null, nro_oc char(10))
declare @TOxN table (codi_orde_comp char(10), codi_nota_ingr char(10))
declare @Doc table (codi_clie_prov char(5) null, codi_tipo_docu char(4) null, serie char(5) null, nro_docu char(10) null, fecha datetime null, codi_orde_comp char(10) null)
declare @Rx table (registro char(11) null, fecha_venc datetime, codi_orde_comp char(10) null)
declare @LX table (anio char(4), mes char(2), subdia char(1) , compr char(5), registro char(11), codi_orde_comp char(10) null)
declare @clie char(5), @ser char(5),@nro char(5)

insert @Ox
select A.codi_orde_comp,codi_clie_prov, fecha, cantidad, precio ,  cantidad*precio, nro_orde_comp
from orden_de_compra A(nolock)
join detalle_orden_compra B (nolock)
on A.codi_orde_comp= B.codi_orde_comp
where cast(convert(char(10),fecha,103) as datetime) between @f1 and @F2 and pedi_trab='P'
	and codi_prod=@codi_prod


insert @TOxN 
select codi_orde_comp, codi_nota_ingr 
from NOTA_INGR_POR_ORDE_COMP (nolock) where codi_orde_comp in (select codi from @Ox)

insert @Doc
select distinct codi_clie_prov, codi_tipo_docu_cont, 
	case when isnumeric(nro_seri_docu_cont)=1 then cast(cast(nro_seri_docu_cont as int)as varchar) else nro_seri_docu_cont end , 
	case when isnumeric(nro_docu_cont)=1 then cast(cast(nro_docu_cont as int) as varchar) else nro_docu_cont end , fech_reg_fact,
	codi_orde_comp
from nota_ingreso A (nolock) 
join @TOxN B 
on A.codi_nota_ingr=B.codi_nota_ingr

insert @Rx
select registro, fecha_Venc , B.codi_orde_comp 
from movi_contables A (nolock)
join @Doc B
on A.codi_clie_prov = B.codi_clie_prov and A.codi_tipo_docu=B.codi_tipo_docu and 
	A.serie=B.serie and 
	A.nro_docu=B.nro_docu and A.fecha=B.fecha
where subdia='C' and left(nro_cuen,2) in ('42','43')

insert @LX
select distinct anio, mes, subdia, compr , '' registro, R.codi_orde_comp 
from movi_contables M (nolock) 
join @Rx R 
on M.registro = R.registro and subdia='L'

declare @Letra table (anio char(4) , mes char(2) ,subdia char(1), compr char(10), registro varchar(11) null, fecha_venc datetime null, serie char(5) null, 
				nro_docu varchar(20) null, codi_orde_comp char(10) null, filas int, incre int)


insert @Letra
select L.anio,L.mes, L.subdia, L.compr, M.registro, fecha_venc , serie , nro_docu, L.codi_orde_comp ,0,0
		from movi_contables M (nolock)
		join @Lx L
	on M.anio=L.anio and M.mes=L.mes and M.subdia=L.subdia and M.compr=L.compr
	where substring(M.registro,4,1)='L'

update @letra set filas= (select count(*) from @letra X where x.codi_orde_comp=L.codi_orde_comp ), 
		  incre= (select count(*) from @letra X where x.codi_orde_comp=L.codi_orde_comp and X.registro<=L.registro)
from @letra as L

declare @Reg table (anio char(4) , mes char(2) , subdia char(1), compr char(10))

insert @Reg
select anio, mes, subdia, compr 
from @letra X where registro=@registro

--select * from @Reg 
--select * from @letra

select dbo.f_cliente_proveedor(cliente) proveedor, fecha, cantidad,
		anio+'/' + mes + ': '+subdia +'-'+ compr as Compr, 
		registro, fecha_venc, rtrim(serie)+'-'+rtrim(nro_docu) as Docu, codi, nro_oc,
		(select sum(cant_ingr - cant_sali) from kardex k (nolock)
			where k.periodo=year(SQ.fecha_venc) and k.codi_prod=@codi_prod and k.fech_tran<=SQ.fecha_venc) Saldo,
		cast(round(cantidad/filas,0)as numeric(12,0))  + 
			case when filas=incre and cantidad - cast(round(cantidad/filas,0) as numeric(12,0)) * incre<>0 then (cantidad - cast(round(cantidad/filas,0) as numeric(12,0)) * incre) else 0 end Vender, 	
		cantidad - cast(round(cantidad/filas,0)as numeric(12,0)) * incre +  
				case when filas=incre and cantidad - cast(round(cantidad/filas,0)as numeric(12,0)) * incre<>0 then -1*(cantidad - cast(round(cantidad/filas,0)as numeric(12,0)) * incre) else 0 end SaldoVence	
from @Ox A 
join @Letra SQ
on A.codi = SQ.codi_orde_comp
where exists (select * from @Reg R where R.anio=SQ.anio and R.mes=SQ.mes and R.subdia=SQ.subdia and R.compr=SQ.compr)
		or (select count(*) from @Reg R)=0
GO
