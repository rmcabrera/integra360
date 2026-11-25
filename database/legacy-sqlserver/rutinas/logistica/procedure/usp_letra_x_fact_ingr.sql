CREATE PROCEDURE [dbo].[usp_letra_x_fact_ingr]
	@anio [char](4),
	@fech [datetime],
	@tipo [char](1)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4) , @fech datetime, @tipo char(1)
--select @anio='2009' , @fech='31/01/2009', @tipo='C'

set nocount on 
declare @ls_c43 char(7)

declare @Tx table ( anio int null, mes int null, subdia char(1) null, compr int null,
			codi_mone char(2) null, importe numeric(12,2) null, importe_d numeric(12,2) null,
			cargo_abono char(1) null, registro varchar(11) null ,
			codi_tipo_docu char(4) null, serie varchar(5) null, nro_docu varchar(15) null, 
			codi_clie_prov char(5) null , fecha datetime null)

declare @TN table (codi_nota_ingr int null , registro varchar(11) null)

select @ls_c43= cuenta  from cuentas_provision (nolock) where codigo='13'

if @tipo='T'
	insert @Tx
	select  anio, mes ,subdia, compr, codi_mone, importe, importe_D, cargo_abono, registro,
		codi_tipo_docu, serie, nro_docu, codi_clie_prov, fecha
	from movi_contables M (nolock) 
	where anio=@anio and fecha < DATEADD ( day , 1, @fech)  and subdia='L' and PATINDEX ('%C%',registro )<>0
	order by anio, mes , cast(compr as int)

--declare @TP  table ( codi_clie_prov char(5) null, nro_cuen char(7) null, registro varchar(11) null, imp numeric(12,2) null, impd numeric(12,2) null )

if @tipo='P'
	insert @Tx
	select  Ax.anio, Ax.mes , Ax.subdia, Ax.compr, codi_mone, importe, importe_D, cargo_abono, registro,
		codi_tipo_docu, serie, nro_docu, codi_clie_prov, fecha
	from movi_contables AX (nolock) 
	join 
	(select DISTINCT anio,mes, compr, subdia from movi_contables M (nolock)
		join (
			select codi_clie_prov,nro_cuen,registro ,isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0) Imp,
					isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0) ImpD
			from movi_contables  (nolock) 
			where  anio =@anio and nro_cuen = @ls_c43 and fecha < DATEADD ( day , 1, @fech)  
						and not (registro is null or ltrim(registro)='') 
			group by codi_clie_prov,nro_cuen,registro 
			having not (isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0)=0
					and isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0)=0) ) SQL
		on M.codi_clie_prov=SQL.codi_clie_prov and M.registro=SQL.registro
			where M.anio=@anio and M.fecha < DATEADD ( day , 1, @fech)  and M.subdia='L'  
					)  RES
	on AX.anio=RES.anio and AX.mes=RES.mes and Ax.compr=RES.compr and Ax.subdia=RES.subdia 
	where AX.anio=@anio and Ax.fecha < DATEADD ( day , 1, @fech)  and AX.subdia='L'  and PATINDEX ('%C%', AX.registro )<>0
	order by Ax.anio, Ax.mes , cast(Ax.compr as int)

/*	insert @TP
	select codi_clie_prov,nro_cuen,registro ,isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0) Imp,
					isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0) ImpD
			from movi_contables  (nolock) 
			where  anio =@anio and nro_cuen = @ls_c43 and fecha < DATEADD ( day , 1, @fecha)  
						and not (registro is null or ltrim(registro)='') 
			group by codi_clie_prov,nro_cuen,registro 
			having not (isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0)=0
					and isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0)=0) 

	select SQL.* , M.* from movi_contables M (nolock)
	join @TP as SQL
	on M.codi_clie_prov =SQL.codi_clie_prov and M.registro=SQL.registro
		where M.anio=@anio and M.fecha < DATEADD ( day , 1, @fecha)  and M.subdia='L' 

*/

if @tipo='C'
	insert @Tx
	select  Ax.anio, Ax.mes , Ax.subdia, Ax.compr, codi_mone, importe, importe_D, cargo_abono, registro,
		codi_tipo_docu, serie, nro_docu, codi_clie_prov, fecha
	from movi_contables AX (nolock) 
	join 
	(select DISTINCT anio,mes, compr, subdia from movi_contables M (nolock)
		join (
			select codi_clie_prov,nro_cuen,registro from movi_contables  (nolock) 
			where  anio =@anio and nro_cuen = @ls_c43 and fecha < DATEADD ( day , 1, @fech)  
						and not (registro is null or ltrim(registro)='') 
			group by codi_clie_prov,nro_cuen,registro 
			having (isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0)=0
					and isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0)=0) ) SQL
		on M.codi_clie_prov=SQL.codi_clie_prov and M.registro=SQL.registro
			where M.anio=@anio and M.fecha < DATEADD ( day , 1, @fech)  and M.subdia='L'  )  RES
	on AX.anio=RES.anio and AX.mes=RES.mes and Ax.compr=RES.compr and Ax.subdia=RES.subdia
	where AX.anio=@anio and Ax.fecha < DATEADD ( day , 1, @fech)  and AX.subdia='L'  and PATINDEX ('%C%', AX.registro )<>0
	order by Ax.anio, Ax.mes , cast(Ax.compr as int)


insert @TN
select codi_nota_ingr, registro from movi_contables N (nolock)
where N.anio=@anio and N.subdia='C' and left(nro_cuen,2)='42'  
	and not (codi_nota_ingr is null or rtrim(codi_nota_ingr)='') 
	and isnumeric(codi_nota_ingr)=1

select anio, mes, subdia, compr, A.codi_mone, importe, importe_d, cargo_abono, A.registro, B.codi_nota_ingr, fecha,
	codi_tipo_docu, serie, nro_docu, codi_clie_prov, 
	codi_prod, cantidad, prec_unit, codi_alma,
	(select desc_tipo_docu from tipo_documento T (nolock) where T.codi_tipo_docu=A.codi_tipo_docu  collate sql_latin1_general_cp1_ci_as ) docu,
	(select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end
		from cliente_proveedor CX ( nolock) Where Cx.codi_clie_prov=A.codi_clie_prov  collate sql_latin1_general_cp1_ci_as ) cliente,
	(select desc_prod from productos P (nolock) where P.codi_prod=C.codi_prod  collate sql_latin1_general_cp1_ci_as ) Producto,
	(select desc_alma from almacen Ax (nolock) where Ax.codi_alma=C.codi_alma  collate sql_latin1_general_cp1_ci_as ) Almacen,
	(select razon_social from empresa (nolock) ) empresa
from @Tx A
join @TN B
	on A.registro=B.registro
join detalle_nota_ingreso C (nolock)
	on B.codi_nota_ingr = C.codi_nota_ingr  collate sql_latin1_general_cp1_ci_as 
order by anio, mes, compr
GO
