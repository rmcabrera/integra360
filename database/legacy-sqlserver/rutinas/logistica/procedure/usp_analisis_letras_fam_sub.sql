CREATE PROCEDURE [dbo].[usp_analisis_letras_fam_sub]
	@anio [char](4),
	@mes [char](2),
	@compr [varchar](10),
	@prov [char](5),
	@registro [char](11)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2), @compr varchar(10) , @prov char(5), @registro char(11)
--select @anio ='2014', @mes ='11', @compr ='12', @prov='25718', @registro = '411L0097'

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
select A.registro ,codi_tipo_docu, serie , nro_docu, importe, importe_d, fecha_venc, cargo_abono, A.subdia
from Movi_Contables A (nolock)
join
	(select anio, mes, Subdia, compr
	from Movi_Contables M (nolock)
	join #Sx S
	on M.Registro=S.registro
	where subdia<>'S' and 
		exists(select * from Movi_Contables E (nolock) 
					where E.anio =M.anio and E.mes=M.mes and E.Subdia=M.Subdia and E.Compr=M.Compr 
							and SUBSTRING(registro,4,1)='C')) B
on A.anio=B.anio and A.mes=B.mes and A.Subdia=B.Subdia and A.Compr=B.Compr

declare @Fec_vence datetime, @fec_ini datetime

set @fec_ini=cast('01/01/'+@anio as datetime)

select @Fec_Vence = (select fecha_vence from #Tx where registro=@registro)

insert @Lx
select registro,1, importe, importe_d
from #Tx where substring(registro,4,1)='L' and c_a='A'

update @Lx set porcen = 100.00000/(select count(*) from @LX)

--select * from @Lx
declare @Ning table ( docu char(4) null, serie varchar(5) null, nro varchar(10) null, fecha datetime, codi_clie_prov char(5))
declare @Notax table ( codi_nota_ingr char(10), docu char(4) null, serie varchar(5) null, nro varchar(10) null, fecha datetime, codi_clie_prov char(5), ser_nota varchar(5))

declare @LxL table (registro char(11))
declare @RxL table (registro char(11))

insert @LxL
select registro from #Tx where c_a='C' and SUBSTRING(registro,4,1)='L'

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
select A.codi_tipo_docu, A.serie, A.nro_docu, A.fecha, codi_clie_prov
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

insert #Nx
select codi_nota_ingr from @notax
where serie=cast(ser_nota as int)

declare @Meses int

set @Meses = MONTH(@Fec_vence)

create table #Rx (nro_nota_ingr char(10) ,  familia varchar(150) null, subfamilia varchar(250) null,
					codi_prod char(8) null, subtotal numeric(12,2) null, nro_orde_comp varchar(30) null, mone_ni varchar(10) null, docufact varchar(3) null, nro_seri_docu_cont varchar(5) null,
					nro_docu_cont varchar(15) null, razon_social varchar(250) null,  empresa varchar(250) null, nroletra varchar(20) null, fecha_vence datetime null, letrasoles numeric(12,2) null, letradolar numeric(12,2) null,
					letra_actual int null, total_letra int null)

					
insert #Rx (nro_nota_ingr  ,familia, subfamilia, codi_prod , subtotal , nro_orde_comp , mone_ni , docufact , nro_seri_docu_cont ,
					nro_docu_cont , razon_social ,  empresa , nroletra , fecha_vence , letrasoles , letradolar ,letra_actual , total_letra )									
select nota_ingreso.nro_nota_ingr, 
     (select (select desc_fami_prod from familia_producto f (nolock) where F.codi_fami_prod=S.codi_fami_prod)
		 from sub_familia_producto S (nolock) where S.codi_sub_Fami_prod
			in (select codi_sub_fami_prod from productos P (nolock) 
					where P.codi_prod=detalle_nota_ingreso.codi_prod) ) Familia,     
     (select desc_sub_fami_prod from sub_familia_producto S (nolock) where S.codi_sub_Fami_prod
		in (select codi_sub_fami_prod from productos P (nolock) 
			where P.codi_prod=detalle_nota_ingreso.codi_prod) ) SubFamilia,     

	detalle_nota_ingreso.codi_prod,
     round( round(  detalle_nota_ingreso.prec_unit , 4 ) * round( detalle_nota_ingreso.cantidad , 4 ) , 2 )  Subtotal,
	( select cast( cast( nro_orde_comp as numeric ) as varchar) from orden_de_compra (nolock) where codi_orde_comp = left( detalle_nota_ingreso.codi_deta_orde_comp , 10 ) ) as nro_orde_comp,
	( select simbolo from monedas (nolock)where codi_mone = nota_ingreso.codi_mone) as mone_ni,
	(select nemo from tipo_documento T (nolock) where t.codi_tipo_docu=codi_tipo_docu_cont) DocuFact, nro_seri_docu_cont, nro_docu_cont,

	/*isnull((select sum(cant_ingr) from kardex k (nolock)            
		where periodo=year(fech_nota_ingr) and  fech_tran > fech_nota_ingr  and cast(convert(char(10),fech_tran,103)as datetime )<=@Fec_vence and i_o=1 and
				K.codi_prod =detalle_nota_ingreso.codi_prod and left(k.concepto,6)='COMPRA' ),0) Otras,
				
	isnull((select sum(cant_sali) from kardex k (nolock)            
		where periodo=year(fech_nota_ingr) and  
				cast(convert(char(10),fech_tran,103)as datetime ) between cast(convert(char(10),fech_nota_ingr,103)as datetime ) and 
						cast(cast(@Fec_vence as varchar) as datetime)
				and i_o=2 and
				K.codi_prod =detalle_nota_ingreso.codi_prod and left(k.concepto,5)='VENTA' ),0) Venta,
	*/
		dbo.f_cliente_proveedor(nota_ingreso.codi_clie_prov) Razon_social,
		(select razon_social from empresa (nolock)) empresa,
		cast((select count(*) from @Lx where registro<=@registro)  as varchar) + ' DE ' +
		cast((select count(*) from @Lx)  as varchar) NroLetra, @Fec_vence as Vecimiento,
		(select soles from @Lx where registro=@registro) LetraSoles,
		isnull((select dolar from @Lx where registro=@registro),0) LetraDolar,
		
		(select count(*) from @Lx where registro<=@registro)  NroLetra,
		(select count(*) from @Lx)  TotalLetras
			
from detalle_nota_ingreso (nolock),  productos(nolock), nota_ingreso(nolock), TIPO_DOCUMENTO TD(nolock)
where nota_ingreso.codi_nota_ingr in (select N.codi_nota_ingr from #Nx N)
		and ( productos.codi_prod = detalle_nota_ingreso.codi_prod ) 
		and ( nota_ingreso.codi_nota_ingr = detalle_nota_ingreso.codi_nota_ingr )
		and td.codi_tipo_docu =* nota_ingreso.codi_tipo_docu
order by DESC_PROD

select ---nro_nota_ingr  ,   
		Familia,     
		SubFamilia,     
		 sum(subtotal) as subtotal , 
		-- max(nro_orde_comp) , mone_ni , docufact , nro_seri_docu_cont ,	nro_docu_cont , 
		max(razon_social) as razon_social , max( empresa) as empresa  , 
		max(nroletra) as nroletra , max(fecha_vence ) as fecha_vence , 
		max(letrasoles ) as letrasoles , 
		max(letradolar ) as letradolar ,
		max(letra_actual ) as letra_actual , 
		max(total_letra ) as total_letra 
from #Rx R
group by familia, subfamilia
order by 2

drop table #Tx
drop table #Nx
drop table #Sx
drop table #Rx
GO
