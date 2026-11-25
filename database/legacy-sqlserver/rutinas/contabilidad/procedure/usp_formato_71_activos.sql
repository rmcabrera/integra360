CREATE PROCEDURE [dbo].[usp_formato_71_activos]
	@anio [int]
WITH EXECUTE AS CALLER
AS
--declare @anio int
--select @anio = 2023

set nocount on 

declare @Fec char(6)
set @Fec = cast(@anio as varchar) + '12'

select A.codi_activo, nro_cuen , descri_activo,  
	(select desc_marca from marca M(nolock) where M.codi_marca=A.codi_marca) as codi_marca, 
	modelo ,  
	serie + ' '+ rtrim(matricula) serie,
	case when depre_hist_ant<>0 or year(fech_ingre)<@anio then costo_hist else 0 end saldo_inicial, 
	case when depre_hist_ant=0 and year(fech_ingre)=@anio then costo_hist else 0 end adiciones,
	0 Mejoras, 
	case when retirado<>'0' then -1*costo_hist else 0 end retiros, 
	0 otros, 
	case when retirado<>'0' then 0 else costo_hist end costo_hist, 
	0 ajust_hist,  
	case when retirado<>'0' then 0 else costo_ajus end costo_ajus, 
	fech_ingre, 
	fecha_depre,
	'Linea Recta' Metodo, 
	nro_docu, 
	cast(cast(tdac*100.00 as numeric(12,2)) as varchar)+ '%' Tasa,
	depre_hist_ant , 
	depre_hist_act, 
	0 ajustes, 
	case when retirado<>'0' then 0 else depre_acum_hist end depre_acum_hist, 
	0 ajus_depre,  
	case when retirado<>'0' then 0 else depre_acum_ajus end depre_acum_ajus,
	(Select razon_social from empresa (nolock)) Empresa,
	(Select ruc from empresa (nolock)) ruc,
	case when retirado<>'0' then -1*depre_acum_hist else 0 end depre_retiro
from activos A (nolock) 
join detalle_calc_af B (nolock)
on A.codi_Activo=B.codi_Activo
where year(fech_ingre) <= @anio and fecha_detalle=@Fec
--		and a.codi_activo=46
GO
