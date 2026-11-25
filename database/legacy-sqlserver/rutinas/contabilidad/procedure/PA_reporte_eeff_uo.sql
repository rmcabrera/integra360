CREATE PROCEDURE [dbo].[PA_reporte_eeff_uo]
	@anio [char](4),
	@mes [char](2),
	@repo [int]
WITH EXECUTE AS CALLER
AS
--declare @anio char(4) ,@mes char(2), @repo int
--select @anio='2012', @mes='12', @repo =1

declare @Saldos_cuentas table ( nro_cuen char(7) null, mesanio char(6) null, saldoant  numeric(12,2) null,
                                               cargo numeric(12,2) null, abono numeric(12,2) null, saldonue numeric(12,2) null, 
                                               codi_unid_oper char(5) null)

set nocount on
                                   
insert  @Saldos_cuentas
select nro_cuen, @mes +@anio as  mesanio, 
            sum(case when mes<@mes then importe else 0 end *case when cargo_Abono='C' then 1 else -1 end ) saldoant, 
            sum(case when mes=@mes then importe else 0 end *case when cargo_Abono='C' then 1 else 0 end ) cargo, 
            sum(case when mes=@mes then importe else 0 end *case when cargo_Abono='A' then 1 else 0 end ) abono,
            sum(importe *case when cargo_Abono='C' then 1 else -1 end ) saldonue, 
            codi_unid_oper
            from movi_contables (nolock)  where anio=@anio and mes<=@mes
group by nro_cuen,codi_unid_oper
   
declare @Tx table(cta char(2), descri varchar(150) null, codi_unid_oper char(5) null, uo varchar(50) null,
	          saldoant numeric(18,2) null, cargo numeric(18,2) null, abono numeric(18,2) null, saldonue numeric(18,2) null)

insert @Tx
select left(E.nro_cuen,2) cta, C.descripcion, codi_unid_oper,
       isnull((select isnull(nemo_uo,desc_unid_oper) from unid_oper U (nolock) where u.codi_unid_oper=F.codi_unid_oper),'') Desc_unid,
       saldoant, cargo, abono, saldonue
      /*A.codi_repo, desc_repo, B.codi_grupo, desc_grupo,B.orden,
      C.tipo_cuen, C.descripcion , c.orden , D.codi_partida, 
      d.descripcion, E.nro_cuen, saldoant, cargo, abono, saldonue, d.orden ,  codi_unid_oper,
      isnull((select isnull(nemo_uo,desc_unid_oper) from unid_oper U (nolock) where u.codi_unid_oper=F.codi_unid_oper),'') Desc_unid,
      (select top 1 razon_social from empresa (nolock) ) empresa*/
from reporte_eeff A(nolock)
join reporte_eeff_grupo B (nolock)
on A.codi_repo=B.codi_repo
join cuentas_reporte  C (nolock)
on B.codi_grupo=C.codi_grupo
join cuentas_partida d (nolock)
on c.tipo_cuen=D.tipo_cuen
join cuentas_partida_reporte E (nolock)
on D.codi_partida=E.codi_partida
join @saldos_cuentas F 
on F.nro_cuen=E.nro_cuen
where A.codi_Repo=@repo and F.mesanio=@mes+@anio
order by A.codi_repo, B.codi_grupo, B.orden, C.tipo_cuen, C.orden


select cta, upper(dbo.uf_nom_cuen(cta)) des_cta, 
       isnull(codi_unid_oper,'')+' - '+isnull(max(uo),'') uo, /*max(descri)*/ descri, 
       sum(saldoant) saldoant, sum(cargo) cargo, sum(abono) abono, sum(saldonue) saldonue,
       (select top 1 razon_social from empresa (nolock) ) empresa
from @Tx
group by descri, cta, codi_unid_oper 
order by descri, cta, codi_unid_oper
GO
