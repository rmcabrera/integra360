CREATE PROCEDURE [dbo].[usp_lista_trasla_prod]
	@f1 [datetime],
	@F2 [datetime],
	@codi_prod [char](8),
	@alma [char](2),
	@tipo [int]
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime , @F2 datetime , @codi_prod char(8), @alma char(2), @tipo int
--select @f1='01/01/2014', @f2='31/10/2014', @codi_prod='00081216', @alma='02' , @tipo =2 

set nocount on

------------------------- Traslados por ingresos
if @tipo=1

	select fech_nota_ingr, nro_nota_ingr , cantidad, prec_unit, round(prec_unit*cantidad,4) Total, 'Ingreso' as tipo, 
			(select nemo_alma from almacen x (nolock) where x.codi_alma=codi_alma_desti) Alma
	from nota_ingreso A(nolock)
	join detalle_nota_ingreso B (nolock)
	on A.codi_nota_ingr= B.codi_nota_ingr
	where cast(convert(char(10),fech_nota_ingr,103) as datetime) between @f1 and @F2 
			and codi_prod=@codi_prod and tipo_nota_ingr='23' and A.codi_alma=@alma
	order by 1		


------------------------- otros ingresos
if @tipo=2
	select fech_nota_ingr, nro_nota_ingr , cantidad, prec_unit, round(prec_unit*cantidad,4) Total, 'Ingreso' as tipo, ''
	from nota_ingreso A(nolock)
	join detalle_nota_ingreso B (nolock)
	on A.codi_nota_ingr= B.codi_nota_ingr
	where A.codi_alma=@alma and 
			cast(convert(char(10),fech_nota_ingr,103) as datetime) between @f1 and @F2  and 
			codi_prod=@codi_prod and 
			not ( tipo_nota_ingr  in ('01','23') or (tipo_nota_ingr ='04' and 
														 left(CONVERT(char(10),fech_nota_ingr, 103),5)='01/01'))
	order by 1		

------------------------- Traslados por salidas
if @tipo=3

	select fech_emis, nro_Sali, cantidad, prec_prom, round(prec_prom*cantidad,4) Total, 'Salida' as tipo,
			(select nemo_alma from almacen x (nolock) where x.codi_alma=A.codi_alma_desti) Alma	
	from docu_Sali_mate A(nolock)
	join detalle_docu_sali B (nolock)
	on A.codi_docu_sali = B.codi_docu_sali
	where cast(convert(char(10),fech_emis,103) as datetime) between @f1 and @F2 
			and codi_prod=@codi_prod and tipo_sali='17' and A.codi_alma=@alma
	order by 1		


------------------------- otras salidas
if @tipo=4

	select fech_emis, nro_Sali, cantidad, prec_prom, round(prec_prom*cantidad,4) Total, 'Salida' as tipo, ''
	from docu_Sali_mate A(nolock)
	join detalle_docu_sali B (nolock)
	on A.codi_docu_sali = B.codi_docu_sali
	where cast(convert(char(10),fech_emis,103) as datetime) between @f1 and @F2 
			and codi_prod=@codi_prod and tipo_Sali not in('17','23','08') and A.codi_alma=@alma
	order by 1
GO
