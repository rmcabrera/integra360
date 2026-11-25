CREATE PROCEDURE [dbo].[PA_RESUMEN_ANUAL_FACTURAS]
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime , @f2 datetime
--select @f1 ='01/01/2014' , @f2 ='13/08/2014'

set nocount on 

declare @F1x datetime , @F2X datetime, @l_ani int
set @F1x=@F1
set @F2x=@F2+' 23:59:59'
set @l_ani=year(@F1)


SELECT   codi_clie_prov as  'codi_clie', 
	(select case when left(tipo_pers,1)='N' 
			then isnull(apel_1+isnull(' '+cp.apel_2,'') + isnull(' '+cp.nomb_1,'') + isnull(' '+cp.nomb_2,'') ,denominacion)
		else isnull(razo_soci,denominacion) end from cliente_proveedor Cp (nolock)  where cp.codi_clie_prov= ventas.codi_clie_prov)	DENOMINACION , 
	 sum(case  mes when '01' then isnull(Importe,0) else 0 end ) as 'Enero' ,	
	 sum(case  mes when '02' then isnull(Importe,0) else 0 end ) as 'Febrero' ,
	 sum(case  mes when '03' then isnull(Importe,0) else 0 end ) as 'Marzo' ,
	 sum(case  mes when '04' then isnull(Importe,0) else 0 end ) as 'Abril' ,
	 sum(case  mes when '05' then isnull(Importe,0) else 0 end ) as 'Mayo' ,	
	 sum(case  mes when '06' then isnull(Importe,0) else 0 end ) as 'Junio' ,
	 sum(case  mes when '07' then isnull(Importe,0) else 0 end ) as 'Julio' ,
	 sum(case  mes when '08' then isnull(Importe,0) else 0 end ) as 'Agosto' ,
	 sum(case  mes when '09' then isnull(Importe,0) else 0 end ) as 'Setiembre' ,	
	 sum(case  mes when '10' then isnull(Importe,0) else 0 end ) as 'Octubre' ,
	 sum(case  mes when '11' then isnull(Importe,0) else 0 end ) as 'Noviembre' ,
	 sum(case  mes when '12' then isnull(Importe,0) else 0 end ) as 'Diciembre'
 
        FROM 
	(SELECT  
		anio, mes, codi_clie_prov, 
		sum(importe*case when cargo_abono='C' then 1 else -1 end) as importe
	FROM Movi_Contables (nolock)                
	WHERE anio=@l_ani and Subdia = 'V' and left(nro_cuen,1)='1'  and fecha between @f1x and @f2x   		
	group by anio, mes , codi_clie_prov) as Ventas
group by  codi_clie_prov  
order by 2
GO
