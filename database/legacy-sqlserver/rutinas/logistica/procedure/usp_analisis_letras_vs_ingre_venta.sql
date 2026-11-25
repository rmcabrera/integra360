CREATE PROCEDURE [dbo].[usp_analisis_letras_vs_ingre_venta]
	@anio [char](4),
	@mes [char](2),
	@compr [varchar](10),
	@prov [char](5),
	@registro [char](11)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2), @compr varchar(10) , @prov char(5), @registro char(11)
--select @anio ='2017', @mes ='01', @compr ='1', @prov='04563', @registro = '611L0108'

set nocount on 

create table #Tx (registro char(11) null, codi_tipo_docu char(4) null, serie char(5) null, nro_docu varchar(10) null,
					importe numeric(12,2) null, importe_d numeric(12,2) null, fecha_vence datetime null, c_a char(1), sd char(1))
create table #Sx (registro char(11) null, codi_tipo_docu char(4) null, serie char(5) null, nro_docu varchar(10) null,
					importe numeric(12,2) null, importe_d numeric(12,2) null, fecha_vence datetime null, c_a char(1), sd char(1))
create table #Nx (codi_nota_ingr char(10) )
declare @Lx table (idd int identity, registro char(11), porcen numeric(12,6) null, soles numeric(12,2) null, dolar numeric(12,2) null)

insert #Tx					
select registro ,codi_tipo_docu, serie , nro_docu, importe, importe_d, fecha_venc, cargo_abono, subdia
from movi_contables M (nolock)
where M.anio=@anio and M.mes=@mes and M.subdia in ('L') and M.compr=@compr and  codi_clie_prov=@prov
			and glosa not like '%Diferencia de Cambio%'
--		and left(nro_cuen,1) not in ('6','7')

insert #Sx					
select registro ,codi_tipo_docu, serie , nro_docu, importe, importe_d, fecha_venc, cargo_abono, subdia
from movi_contables M (nolock)
where M.anio=@anio and M.mes=@mes and M.subdia in ('S') and M.compr=@compr and  codi_clie_prov=@prov
		and Registro=@registro
			and glosa not like '%Diferencia de Cambio%'

insert #Tx					
select A.registro , codi_tipo_docu, serie , nro_docu, importe, importe_d, fecha_venc, cargo_abono, A.subdia
from Movi_Contables A (nolock)
join
	(select distinct anio, mes, Subdia, compr
	from Movi_Contables M (nolock)
	join #Sx S
	on M.Registro=S.registro
	where subdia ='L' and 
		exists(select * from Movi_Contables E (nolock) 
					where E.anio =M.anio and E.mes=M.mes and E.Subdia=M.Subdia and E.Compr=M.Compr 
							and SUBSTRING(registro,4,1)='C')) B
on A.anio=B.anio and A.mes=B.mes and A.Subdia=B.Subdia and A.Compr=B.Compr
where registro<>''


declare @Fec_vence datetime, @fec_ini datetime

set @fec_ini=cast('01/01/'+@anio as datetime)

select @Fec_Vence = (select max(fecha_vence) from #Tx where registro=@registro)

insert @Lx
select registro,1, importe, importe_d
from #Tx where substring(registro,4,1)='L' and c_a='A' and registro=@registro

update @Lx set porcen = 100.00000/(select count(*) from @LX)

--select * from @Lx
declare @Ning table ( docu char(4) null, serie varchar(5) null, nro varchar(10) null, fecha datetime, codi_clie_prov char(5))
declare @Notax table ( codi_nota_ingr char(10), docu char(4) null, serie varchar(5) null, nro varchar(10) null, fecha datetime, codi_clie_prov char(5), ser_nota varchar(5))

declare @LxL table (registro char(11))
declare @RxL table (registro char(11))

insert @LxL
select distinct registro from #Tx where c_a='C' and SUBSTRING(registro,4,1)='L'

if (select COUNT(*) from @LxL) >0
begin
	insert @RxL
	select registro
	from movi_contables X (nolock)
	join (
			select distinct anio, mes , subdia, compr from movi_contables M (nolock)
				where M.registro in (select a.registro from @LxL A) and cargo_abono='A') SQ
	on X.anio=SQ.anio and X.mes=SQ.mes and X.subdia=SQ.subdia and X.compr=SQ.compr
	where substring(X.registro,4,1)='C'
 	
 	insert @Ning
	select A.codi_tipo_docu, A.serie, A.nro_docu, A.fecha, codi_clie_prov
	from movi_contables A (nolock) 
	join @RxL B
	on A.registro=B.registro
	where subdia='C' and substring(B.registro,4,1)='C'

end

insert @Ning
select distinct A.codi_tipo_docu, A.serie, A.nro_docu, A.fecha, codi_clie_prov
		--right('00000000'+ rtrim(cast(codi_nota_ingr  as varchar)),10)
from movi_contables A (nolock) 
join #Tx B
on A.registro=B.registro
where subdia='C' and substring(B.registro,4,1)='C'

--select NRO_DOCU_CONT, * from NOTA_INGRESO (nolock)where NRO_DOCU_CONT ='7525'

insert @Notax
select codi_nota_ingr, a.docu, a.serie, a.nro, a.fecha ,a.codi_clie_prov, nro_Seri_docu_cont
from @Ning A
join Nota_ingreso B (nolock)
on A.codi_clie_prov=B.codi_clie_prov and A.docu=B.codi_tipo_docu_cont 
	 and A.nro=B.nro_docu_cont --and convert(char(10),A.FEcha,103)=convert(char(10),B.FECH_REG_FACT,103)
	 
--select * from @notax where isnumeric(serie)=1

insert #Nx
select codi_nota_ingr from @notax 
where case when ISNUMERIC(serie)=1 then CAST(cast(serie as int) AS varchar) else serie end 
			= case when ISNUMERIC(ser_nota )=1 then CAST(cast(ser_nota  as int) AS varchar) else ser_nota end 
/*select distinct codi_nota_ingr from @notax
where isnumeric(serie)=0 and serie=ser_nota
union all
select distinct codi_nota_ingr from @notax
where isnumeric(serie)=1 and (cast(serie as numeric)=cast(ser_nota as numeric))*/

declare @Meses int

set @Meses = MONTH(@Fec_vence)

select nota_ingreso.fech_nota_ingr, 
      nota_ingreso.nro_nota_ingr, 
     detalle_nota_ingreso.codi_prod, 
     productos.desc_prod,
     detalle_nota_ingreso.cantidad, 
     
     round(detalle_nota_ingreso.prec_unit*case when NOTA_INGRESO.afecto='1' then 1 + dbo.f_igv(NOTA_INGRESO.fech_nota_ingr) /100.00 else 1 end, 4) as prec_unit,
     
     round( round(  detalle_nota_ingreso.prec_unit , 4 ) * round( detalle_nota_ingreso.cantidad , 4 )* 
				case when NOTA_INGRESO.afecto='1' then 1 + dbo.f_igv(NOTA_INGRESO.fech_nota_ingr) /100.00 else 1 end , 2 )  Subtotal,
     
	( select cast( cast( nro_orde_comp as numeric ) as varchar) from orden_de_compra (nolock) where codi_orde_comp = left( detalle_nota_ingreso.codi_deta_orde_comp , 10 ) ) as nro_orde_comp,
	( select simbolo from monedas (nolock)where codi_mone = nota_ingreso.codi_mone) as mone_ni,
	(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu=codi_tipo_docu_cont) DocuFact, nro_seri_docu_cont, nro_docu_cont,
	
	isnull((select sum(cant_ingr - cant_sali) from kardex k (nolock)            
		where periodo=year(fech_nota_ingr) and  fech_tran < fech_nota_ingr and            
				K.codi_prod =detalle_nota_ingreso.codi_prod),0) Inicial,
	
	isnull((select sum(cant_ingr) from kardex k (nolock)            
		where periodo=year(fech_nota_ingr) and  fech_tran > fech_nota_ingr  and cast(convert(char(10),fech_tran,103)as datetime )<=@Fec_vence and i_o=1 and
				K.codi_prod =detalle_nota_ingreso.codi_prod and left(k.concepto,6)='COMPRA' ),0) Otras,
				
	isnull((select sum(cant_sali) from kardex k (nolock)            
		where periodo=year(fech_nota_ingr) and  
				cast(convert(char(10),fech_tran,103)as datetime ) between cast(convert(char(10),fech_nota_ingr,103)as datetime ) and 
						cast(cast(@Fec_vence as varchar) as datetime)
				and i_o=2 and
				K.codi_prod =detalle_nota_ingreso.codi_prod and left(k.concepto,5)='VENTA' ),0) Venta,
	
	isnull((select sum(cant_ingr - cant_sali) from kardex k (nolock)            
		where periodo=year(@Fec_vence) and  cast(convert(char(10),fech_tran,103)as datetime )< dateadd(d,1,@Fec_vence) and 
				K.codi_prod =detalle_nota_ingreso.codi_prod),0) Saldo,
		(select sum(porcen) from @Lx where registro<=@registro) Porc,
		cantidad*(select sum(porcen) from @Lx where registro<=@registro)/100.000 Meta, 
		dbo.f_cliente_proveedor(nota_ingreso.codi_clie_prov) Razon_social,
		(select razon_social from empresa (nolock)) empresa,
		cast((select count(*) from @Lx where registro<=@registro)  as varchar) + ' DE ' +
		cast((select count(*) from @Lx)  as varchar) NroLetra, @Fec_vence as Vecimiento,
		
		(select soles from @Lx where registro=@registro) LetraSoles,
		isnull((select dolar from @Lx where registro=@registro),0) LetraDolar,
		
		isnull((select round(sum(FACTURA_DETALLE.CANT_ITEM)/@Meses,0)
				FROM FACTURA (nolock),FACTURA_DETALLE (nolock)
			WHERE ( FACTURA_DETALLE.CODI_FACT = FACTURA.CODI_FACT ) and  
				( FACTURA_DETALLE.CODI_PROD = DETALLE_NOTA_INGRESO.CODI_PROD) and
					( FACTURA.FECH_FACT >= @fec_ini) and
				( FACTURA.FECH_FACT < DATEADD(DAY,1,@Fec_vence)) and 
				( ISNULL(FACTURA.ESTADO,'')<>'A') ),0) Reserva,

		(select count(*) from @Lx where registro<=@registro)  NroLetra,
		(select count(*) from @Lx)  TotalLetras
				

from detalle_nota_ingreso (nolock),  productos(nolock), nota_ingreso(nolock), TIPO_DOCUMENTO TD(nolock)
where nota_ingreso.codi_nota_ingr in (select N.codi_nota_ingr from #Nx N)
		and ( productos.codi_prod = detalle_nota_ingreso.codi_prod ) 
		and ( nota_ingreso.codi_nota_ingr = detalle_nota_ingreso.codi_nota_ingr )
		and td.codi_tipo_docu =* nota_ingreso.codi_tipo_docu
order by DESC_PROD

drop table #Tx
drop table #Nx
drop table #Sx
GO
