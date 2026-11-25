CREATE PROCEDURE [dbo].[usp_provi_util]
	@anio [int],
	@mes [char](2),
	@anio_prov [char](4),
	@mes_prov [char](2)
WITH EXECUTE AS CALLER
AS
--declare @anio int, @mes char(2), @anio_prov char(4), @mes_prov char(2)   
--select @anio=2016 , @mes ='03', @anio_prov ='2017', @mes_prov ='07'  
set nocount on   
  
declare @con1 char(6), @con2 char(6), @nro char(7), @ca char(1), @tip char(2) , @prov char(2)  
declare @errno  int,@errmsg varchar(255), @error varchar(10)  
declare @ulti int, @fec datetime  
declare @TX table (codi_pers char(5), codi_conc char(6), valor numeric(12,2) null, tipo char(2), codi_clie_prov char(5) null )  
  
declare @MOV table (Codi_Contable int identity, Subdia char(1) null, Compr char(10) null,  Codi_Mone char(2) null,   
   Fecha datetime null , Nro_Cuen char(7) null, Nro_Sub_Cuen char(7) null ,   
   Serie char(5) null, Nro_Docu char(10) null, Importe numeric(12,2) null ,igv numeric(12,2) null ,   
   otros numeric(12,2) null , total numeric(12,2) null , importe_d numeric(12,2) null , igv_d numeric(12,2) null ,   
   otros_d numeric(12,2) null , total_d numeric(12,2) null ,   
   registro char(10) null, codi_unid_oper char(5) null, glosa varchar(200) null,   
   cargo_abono char(1) null, mes char(2) null, anio char(4)  null,   
   tipo_cambio numeric(18,4) null , codi_vouc char(10) null, codi_sema char(8) null, codi_clie_prov char(5) null)  
  
set @ulti = dbo.f_ulti_dia( @anio, cast(@mes as int))  
set @fec = cast(cast(@ulti as varchar)+'/'+@mes+'/'+cast(@anio as varchar) as datetime)  
  
insert @Tx  
select A.codi_pers, codi_conc, valor,   
  (select codi_tipo_pers from personal_por_tipo_trabajador T (nolock) where t.codi_pers=A.codi_pers) tipo,  
 (select codi_rela from personal P (nolock) where P.codi_pers=A.codi_pers)  
from calc_util_deta A (nolock)   
join calc_util_pers B (nolock)  
on a.codi_pers=B.codi_pers and A.anio=B.anio  
where A.anio=@anio --and mes=@mes  
  
  
declare C1 cursor for select codi_conc, codi_conc_fina, nro_cuen , carg_abon, codi_tipo_pers, codi_tipo_prov  
 from conceptos_contables (nolock)   
 where  codi_tipo_plan='07' order by nro_cuen  
open c1  
fetch c1 into @con1, @con2 , @nro, @ca, @tip , @prov  
while @@fetch_status=0  
begin  
 if @prov='01'  
  insert @MOV (nro_cuen, cargo_abono, importe, subdia, nro_sub_cuen, igv, otros, total, importe_d, igv_d, otros_d, total_d,  
   mes, anio, tipo_cambio, glosa,CODI_MONE, codi_clie_prov)  
  select @nro, @ca, valor , 'P' , (select nro_sub_cuen from cuentas_contable C (nolock) where C.nro_cuen=@nro),  
   0 , 0 , 0 ,0 , 0 , 0 , 0, @mes_prov, @anio_prov, 1 ,'PROVISIÓN AUTOMATICA UTILIDADES','01', codi_clie_prov  
   from @tx where codi_conc between @con1 and @con2 and tipo=@tip  
  
 if @prov='03'  
  insert @MOV (nro_cuen, cargo_abono, importe, subdia, nro_sub_cuen, igv, otros, total, importe_d, igv_d, otros_d, total_d,  
   mes, anio, tipo_cambio, glosa, codi_mone, codi_clie_prov)  
  select @nro, @ca, sum(valor), 'P' , (select nro_sub_cuen from cuentas_contable C (nolock) where C.nro_cuen=@nro),  
   0 , 0 , 0 ,0 , 0 , 0 , 0 , @mes_prov, @anio_prov , 1 ,'PROVISIÓN AUTOMATICA UTILIDADES','01', null codi_clie_prov  
   from @tx where codi_conc between @con1 and @con2  
    and tipo=@tip  
  
 fetch c1 into @con1, @con2 , @nro, @ca, @tip , @prov  
end  
close c1  
deallocate c1  
  
declare @registro varchar(10), @cuen char(7), @ct int  
set @ct=0  
declare c2 cursor for select distinct nro_cuen from @Mov where left(nro_cuen,2) in ('41','46') order by nro_cuen  
open c2  
fetch c2 into @cuen  
while @@fetch_status=0  
begin  
 set @ct = @ct + 1   
 set @registro= right(cast(@anio_prov as varchar),1)+ @mes_prov+'Pu'+ right('000'+cast(@ct as varchar),3)  
  
 update @mov set registro=@registro where nro_cuen =@cuen  
  
 fetch c2 into @cuen  
end  
close c2  
deallocate c2  
  
begin transaction x1  
   
 declare @MX numeric(18), @Compr int, @codi_vouc char(10), @sema char(8)  
 select @MX = max(codi_contable) from movi_contables (nolock)  
  
 set @sema = @mes_prov+'PU'+cast(@anio_prov as varchar)  
  
 delete from movi_contables where anio=@anio_prov and mes= @mes_prov and  subdia= 'P' and codi_sema=@sema  
  
 if @@error <> 0   
 begin  
  select @errno = 30002, @errmsg = 'No se puede eliminar asientos de consumo'  
  goto error  
 end   
  
 select @Compr = isnull(max(cast(compr as int)),0)  from movi_contables (nolock) where anio=@anio_prov and mes=@mes_prov and subdia='P'  
  
 select @codi_vouc= right('0000000000' + cast(isnull((Select max(codi_vouc)   
   from movi_contables (nolock) where left(codi_vouc , 1) = '0' ) ,0) +1 as varchar),10)   
  
  
 insert movi_contables(codi_contable, Subdia, Compr, Codi_Mone, Fecha, Nro_Cuen, Nro_Sub_Cuen,   
  Serie, Nro_Docu, Importe,igv, otros, total, importe_d, igv_d , otros_d, total_d,   
  registro, codi_unid_oper, glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, codi_clie_prov)  
 select right('0000000000'+cast(@MX + codi_contable as varchar(10)),10) codi,   
  Subdia, @Compr + 1 Compr, Codi_Mone, @fec Fecha, Nro_Cuen, Nro_Sub_Cuen,   
  Serie, Nro_Docu, Importe,igv, otros, total, importe_d, igv_d , otros_d, total_d,   
  registro, codi_unid_oper, glosa, cargo_abono, mes, anio, tipo_cambio,   
  @codi_vouc, @Sema codi_sema, codi_clie_prov  
 from @Mov  
   
 if @@error <> 0   
 begin  
  select @errno = 30002, @errmsg = 'No se puede generar asientos de consumo'  
  goto error  
 end   
  
 commit transaction x1   
  
return  
error:  
 --raiserror @errno @errmsg  
 rollback transaction x1
GO
