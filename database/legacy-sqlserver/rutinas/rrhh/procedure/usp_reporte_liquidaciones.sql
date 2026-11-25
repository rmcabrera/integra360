CREATE PROCEDURE [dbo].[usp_reporte_liquidaciones]
	@mes [int],
	@anio [int]
WITH EXECUTE AS CALLER
AS
--declare @mes int ,@anio int
--select @mes=12 , @anio=2011

set nocount on 
declare @TX table (codi_pers char(5) null ) 
declare @Rx table ( idd int null, glosa varchar(100) null, codi_pers char(5) null , fech_inic datetime null,
			fech_term datetime null, valor numeric(12,2) null , codi_conc char(7) null, desc_conc varchar(100) null)
declare @Px table ( codi_pers char(5) null, nombres varchar(200) null, cargo varchar(250) null, fech_ingre datetime null,
			fech_Cese datetime null,  suel_basi numeric(12,2) null, asig_fami char(1), nro_docu varchar(12) null,
			sistpens char(2))

insert @TX
select codi_pers
from personal (nolock) 
where year(fech_cese)= @anio and month(fech_cese)= @mes

insert @PX
select codi_pers, apel_1 +isnull(' '+ apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') nombres,
	(select desc_cargo from cargos c (nolock) where c.codi_Carg= P.codi_Carg) , fech_ingre, fech_cese,
	suel_basi, asig_fami, nro_docu_iden, codi_sist_pens
from personal P (nolock) 
where P.codi_pers in (select T.codi_pers from @Tx T)-- and codi_pers='00006'

----------------------- CTS Truncas
insert @RX
select '1' idd, 'CTS Truncas' Glosa ,
	codi_pers, max(fech_inic) fech_inic, max(fech_term) fech_term, sum(valor) Valor, '999990' ,
	'' DEsc_conc
from 
	(select codi_conc, codi_pers, fech_inic, fech_term, 
--		(select desc_conc from conceptos c where c.codi_conc=d.codi_conc) desc_conc,
		case when codi_conc='999990' then valor else 0 end valor
	from planilla_cts_conceptos D (nolock) 
	join datos_cts  P (nolock)
	on D.codi_plan_cts=P.codi_plan_cts
	where anio=@anio and mes=@mes and  codi_tipo_plan='17' and codi_pers in (select codi_pers from @TX) and codi_conc='999990') SQL
group by codi_pers, codi_conc


----------------------- Vacaciones Truncas
insert @RX
select '2' idd, 'Vacaciones Truncas' Glosa ,
	codi_pers, 
	(select fech_inic from hora_plan_vaca_grat H (nolock) 
		where H.anio=@anio and H.mes=@mes and  H.codi_pers=SQL.codi_pers and H.codi_tipo_plan='11' ) fech_inic, 
	(select fech_term from hora_plan_vaca_grat H (nolock) 
		where H.anio=@anio and H.mes=@mes and  H.codi_pers=SQL.codi_pers and H.codi_tipo_plan='11' ) fech_term, 
	sum(valor) Valor,
	codi_conc, (select desc_conc from conceptos C (nolock) where c.codi_conc=SQL.codi_conc) DEsc_conc
from 
	(select codi_conc, codi_pers, fech_inic, fech_term, 
--		(select desc_conc from conceptos c where c.codi_conc=d.codi_conc) desc_conc,
		valor --case when codi_conc='199999' then valor else 0 end valor
	from planilla_empleado_conceptos D (nolock) 
	join planilla_de_empleados  P (nolock)
	on D.codi_plan_empl=P.codi_plan_empl
	where anio=@anio and mes=@mes and codi_tipo_plan='11' and codi_pers in (select codi_pers from @TX)
		and ( (left(codi_conc,1)='1' and codi_conc not in ('199998','199999','100000'))
			)
		union all
	select codi_conc, codi_pers, fech_inic, fech_term, 
	--	(select desc_conc from conceptos c where c.codi_conc=d.codi_conc) desc_conc,
		valor --case when codi_conc='199999' then valor else 0 end valor
	from planilla_obrero_conceptos D (nolock) 
	join planilla_de_obreros P (nolock)
	on D.codi_plan_obre=P.codi_plan_obre
	where anio=@anio and mes=@mes and  codi_tipo_plan='11' and codi_pers in (select codi_pers from @TX) 
		and ( (left(codi_conc,1)='1' and codi_conc not in ('199998','199999','100000')) )
			) SQL
group by codi_pers, codi_conc
order by codi_pers


----------------------- Gratificaciones Truncas
insert @RX
select '3' idd, 'Gratificaciones Truncas' Glosa ,
	codi_pers, 
	(select fech_inic from hora_plan_vaca_grat H (nolock) 
		where H.anio=@anio and H.mes=@mes and  H.codi_pers=SQL.codi_pers and H.codi_tipo_plan='12' ) fech_inic, 
	(select fech_term from hora_plan_vaca_grat H (nolock) 
		where H.anio=@anio and H.mes=@mes and  H.codi_pers=SQL.codi_pers and H.codi_tipo_plan='12' ) fech_term, 
	 sum(valor) Valor, 
	codi_conc, (select desc_conc from conceptos C (nolock) where c.codi_conc=SQL.codi_conc) DEsc_conc
from 
	(select codi_conc, codi_pers, fech_inic, fech_term, 
--		(select desc_conc from conceptos c where c.codi_conc=d.codi_conc) desc_conc,
		valor --case when codi_conc='199999' then valor else 0 end valor
	from planilla_empleado_conceptos D (nolock) 
	join planilla_de_empleados  P (nolock)
	on D.codi_plan_empl=P.codi_plan_empl
	where anio=@anio and mes=@mes and  codi_tipo_plan='12' and codi_pers in (select codi_pers from @TX) 
		and left(codi_conc,1)='1' and codi_conc not in ('199998','199999','100000')
		union all
	select codi_conc, codi_pers, fech_inic, fech_term, 
	--	(select desc_conc from conceptos c where c.codi_conc=d.codi_conc) desc_conc,
		valor -- case when codi_conc='199999' then valor else 0 end valor
	from planilla_obrero_conceptos D (nolock) 
	join planilla_de_obreros P (nolock)
	on D.codi_plan_obre=P.codi_plan_obre
	where anio=@anio and mes=@mes and codi_tipo_plan='12' and codi_pers in (select codi_pers from @TX)
			and left(codi_conc,1)='1' and codi_conc not in ('199998','199999','100000') ) SQL
group by codi_pers, codi_conc


--------------------Sistema de Pensiones
insert @RX
select 4 idd, 'Descuentos' Glosa, codi_pers, null, null, sum(valor) valor,'' ,''
from 
	(select codi_conc, codi_pers, fech_inic, fech_term, 
		--(select desc_conc from conceptos c where c.codi_conc=d.codi_conc) desc_conc,
		case when codi_conc in ('200030','200031','200032','200033' ) then valor else 0 end valor
	from planilla_empleado_conceptos D (nolock) 
	join planilla_de_empleados  P (nolock)
	on D.codi_plan_empl=P.codi_plan_empl
	where anio=@anio and mes=@mes and codi_tipo_plan in ('11','12') and codi_pers in (select codi_pers from @TX)
		and codi_conc in ('200030','200031','200032','200033' )
	union all
	select codi_conc, codi_pers, fech_inic, fech_term, 
		--(select desc_conc from conceptos c where c.codi_conc=d.codi_conc) desc_conc,
		case when codi_conc in ('200030','200031','200032','200033' ) then valor else 0 end valor
	from planilla_obrero_conceptos D (nolock) 
	join planilla_de_obreros P (nolock)
	on D.codi_plan_obre=P.codi_plan_obre
	where anio=@anio and mes=@mes and codi_tipo_plan in ('11','12') and codi_pers in (select codi_pers from @TX) 
			and codi_conc in ('200030','200031','200032','200033' )) SQL
group by codi_pers

insert @RX
select 4 idd, 'Descuentos' Glosa, codi_pers, null, null, sum(valor) valor,'200040' ,' Renta Quinta'
from 
	(select codi_conc, codi_pers, fech_inic, fech_term, 
		--(select desc_conc from conceptos c where c.codi_conc=d.codi_conc) desc_conc,
		case when codi_conc in ('200040' ) then valor else 0 end valor
	from planilla_empleado_conceptos D (nolock) 
	join planilla_de_empleados  P (nolock)
	on D.codi_plan_empl=P.codi_plan_empl
	where anio=@anio and mes=@mes and codi_tipo_plan in ('11','12') and codi_pers in (select codi_pers from @TX)
		and codi_conc in ('200040' )
	union all
	select codi_conc, codi_pers, fech_inic, fech_term, 
		--(select desc_conc from conceptos c where c.codi_conc=d.codi_conc) desc_conc,
		case when codi_conc in ('200040' ) then valor else 0 end valor
	from planilla_obrero_conceptos D (nolock) 
	join planilla_de_obreros P (nolock)
	on D.codi_plan_obre=P.codi_plan_obre
	where anio=@anio and mes=@mes and codi_tipo_plan in ('11','12') and codi_pers in (select codi_pers from @TX) 
			and codi_conc in ('200040')) SQL
group by codi_pers

--declare @val numeric(12,2 )

--set @Val = 

select idd,glosa, A.codi_pers, fech_inic, fech_term, valor,
	nombres , cargo , fech_ingre , fech_Cese ,  suel_basi , 
	isnull(dbo.f_asig_fami_pers(a.codi_pers, fech_cese),0) asig_fami,
	dbo.f_numlet(isnull((select sum(case idd when 4 then -1 else 1 end * valor)
		 from @RX X where X.codi_pers=A.codi_pers),0))
			 +upper(' Nuevos Soles') letras,
	(select razon_social from empresa (nolock) ) razo_empre,
	(select direccion from empresa (nolock) ) direccion,
	(select ruc from empresa (nolock) ) ruc, 
	nro_docu, 
	( select desc_sist_pens from sisTEMA_PENSIONES S (nolock) where S.codi_sist_pens= sistpens ) sistema,
	(select sum(valor) 
	from VALORES_SISTEMA_PENSIONES V (nolock ) 
	where anio_mes=cast(@anio as varchar)+ right('0'+cast(@mes as varchar),2) and codi_sist_pens=sistpens and codi_rubr<>'04') Porce,
	codi_conc, desc_conc
from @RX A
join @Px B
on A.codi_pers=B.codi_pers
order by A.codi_pers, idd, codi_conc
GO
