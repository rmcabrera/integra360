CREATE PROCEDURE [dbo].[usp_repo_compr_letras]
	@anio [char](4),
	@mes [char](2),
	@compr [varchar](10),
	@prov [char](5),
	@cance [char](1)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2), @compr varchar(10) , @prov char(5), @cance char(1)
--select @anio ='2024', @mes ='10', @compr ='1', @prov='00753', @cance ='1'

set nocount on 

declare @ld_Fecha datetime, @ls_c43 char(7)

set @ld_fecha = cast(convert(char(10),getdate(),103) as datetime)
--select @ld_fecha

set @ls_c43 = (select cuenta from cuentas_provision (nolock) where codigo='13')
--select @ls_c43

create table #Px (FS datetime null, clie char(5) null, regis varchar(12) null, cta char(7) null)


if @cance ='1'
begin
	insert #Px
	select max(fecha_venc) as FS, codi_clie_prov, registro, nro_cuen
		from movi_contables (nolock) 
		where anio =@anio and left(nro_cuen,len(@ls_c43))= @ls_c43 and fecha < DATEADD ( day , 1, @ld_fecha) 
		and not (registro is null or ltrim(registro)='') and codi_clie_prov=@prov 
		--and registro='410L0004'
		and registro in
			(select distinct M.registro from movi_contables M (nolock)
			where M.anio=@anio and M.mes=@mes and M.subdia in ('L','S') and M.compr=@compr and codi_clie_prov=@prov)
									
		group by codi_clie_prov,nro_cuen,registro 
		having (isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0)=0
				and isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0)=0)
end
else
begin
	insert #Px
	select max(fecha_venc) as FS, codi_clie_prov, registro, nro_cuen
		from movi_contables (nolock) 
		where anio =@anio and left(nro_cuen,len(@ls_c43))= @ls_c43 and fecha < DATEADD ( day , 1, @ld_fecha) 
		and not (registro is null or ltrim(registro)='') and codi_clie_prov=@prov 
		--and registro='410L0004'
		and registro in
			(select distinct M.registro from movi_contables M (nolock)
			where M.anio=@anio and M.mes=@mes and M.subdia in ('L','S') and M.compr=@compr and codi_clie_prov=@prov)
									
		group by codi_clie_prov,nro_cuen,registro 
		having not (isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0)=0
				and isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0)=0)
end

select M.anio, M.mes, M.subdia, M.compr , fecha, nro_cuen , codi_nota_ingr, registro , codi_clie_prov, 
	codi_tipo_docu, serie , nro_docu, importe, importe_d,
	
	(select FS from #Px P where P.regis=M.registro) as fecha_vence,
	case when registro='' then null else
			isnull((select top 1 MC.fecha from movi_contables MC(nolock) where MC.registro=M.registro and MC.subdia='E' and left(MC.banco,3) in ('104','101') ),
					(select top 1 MC.fecha from movi_contables MC(nolock) where MC.registro=M.registro and MC.subdia='M'))
		end as fecha_cance
	
from movi_contables M (nolock)
where M.anio=@anio and M.mes=@mes and M.subdia in ('L','S') and M.compr=@compr and  codi_clie_prov=@prov


drop table #Px
GO
