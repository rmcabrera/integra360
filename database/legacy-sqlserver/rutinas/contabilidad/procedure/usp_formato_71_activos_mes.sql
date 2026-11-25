CREATE PROCEDURE [dbo].[usp_formato_71_activos_mes]
	@anio [int],
	@mes_i [int],
	@mes_f [int]
WITH EXECUTE AS CALLER
AS
--declare @anio int  ,@mes_i int ,@mes_f int
--select @anio = 2023, @mes_i=1 ,@mes_f=12
  
set nocount on   
  
declare @Fec char(6)  
declare @mes int

declare @t table (codi_activo char(7),nro_cuen char(7),descri_activo varchar(100),Codi_Marca varchar (50),modelo varchar(50),serie varchar(80),saldo_inicial decimal(12,2),
	adiciones decimal(12,2), mejoras decimal(12,0) ,retiros decimal(12,2), otros decimal(12,0),costo_hist decimal(12,2),ajust_hist decimal(12,0),costo_ajus decimal(12,2),
	fech_ingre datetime,fecha_depre datetime,Metodo varchar(200),nro_docu varchar(20), tasa varchar(100),depre_hist_ant decimal (12,2),depre_hist_act  decimal (12,2),
	ajustes decimal(12,2),depre_acum_hist decimal (12,2),ajus_depre decimal(12,0),depre_acum_ajus decimal (12,2),empresa varchar (200),ruc varchar(50),mes int,nombre_mes varchar(50),
	depre_retiro decimal(12,2) null)


set @mes=@mes_i
WHILE @mes <= @mes_f
BEGIN
	set @Fec = cast(@anio as varchar) + right('00'+cast(@mes as varchar),2)

	insert @t
	select A.codi_activo, nro_cuen , left(descri_activo,100),  
		(select desc_marca from marca M(nolock) where M.codi_marca=A.codi_marca) as codi_marca, 
		modelo ,  
		serie + ' '+ rtrim(matricula) serie,
		case when /*depre_hist_ant<>0*/ left(fecha_activo,4) < @anio then costo_hist else 0 end saldo_inicial, 
		case when /*depre_hist_ant=0*/ left(fecha_activo,4) = @anio then costo_hist else 0 end adiciones,
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
	
		/*case when isnull(reclasi,'0') ='0' then depre_hist_ant else
				case when isnull(reclasi,'0')='1' and year(fecha_retiro)=@anio 
					then 0 else depre_hist_Ant end end  as */depre_hist_ant, 
	/*
		case when isnull(reclasi,'0') ='0' then depre_hist_act else 
				case when isnull(reclasi,'0')='1' and year(fecha_retiro)=@anio 
					then 0 else depre_hist_act end  end  as*/ depre_hist_act, 
	 
		0 ajustes, 
		case when retirado<>'0' then 0 else depre_acum_hist end depre_acum_hist, 
		0 ajus_depre,  
		case when retirado<>'0' then 0 else depre_acum_ajus end depre_acum_ajus,
		(Select razon_social from empresa (nolock)) Empresa,
		(Select ruc from empresa (nolock)) ruc,
		@mes,
		case @mes when 1 then 'ENERO'
	  		 when 2 then 'FEBRERO' 
	  		 when 3 then 'MARZO' 
	  		 when 4 then 'ABRIL' 
	  		 when 5 then 'MAYO' 
	  		 when 6 then 'JUNIO' 
	  		 when 7 then 'JULIO' 
	  		 when 8 then 'AGOSTO' 
	  		 when 9 then 'SETIEMBRE' 
	  		 when 10 then 'OCTUBRE' 
	  		 when 11 then 'NOVIEMBRE' 
	  		 when 12 then 'DICIEMBRE' 
			END nombre_mes,
			case when retirado<>'0' then -1*depre_acum_hist else 0 end depre_retiro			
			
/*		case when retirado<>'0' then -1*depre_acum_hist 
			else case when isnull(reclasi,'0')='1' and year(fecha_retiro)=@anio then depre_acum_hist else 0 end end +
			depre_rela_reti as depre_retiro*/
	from activos A (nolock)   
	join detalle_calc_af B (nolock)  
	on A.codi_Activo=B.codi_Activo  
	where year(fech_ingre) <= @anio and fecha_detalle=@Fec  
--		and not (year(fecha_retiro)<@anio and fecha_retiro is not null)
	and ((select  left(min(fecha_detalle),4) from detalle_calc_Af D 
			where D.codi_activo = A.codi_activo and D.retirado<>'0')>=@anio or B.retirado='0')
--		and isnull(retirado,0) not in (3,4)
	set @mes=@mes+1
end

select codi_activo ,nro_cuen ,descri_activo ,Codi_Marca ,modelo ,serie ,saldo_inicial ,
		adiciones , mejoras  ,retiros , otros ,costo_hist ,ajust_hist ,costo_ajus,  
		fech_ingre ,fecha_depre ,Metodo ,nro_docu , tasa ,depre_hist_ant ,depre_hist_act  ,
		ajustes ,depre_acum_hist ,ajus_depre ,depre_acum_ajus ,empresa ,ruc ,mes ,nombre_mes , depre_retiro
from @t
--where codi_activo in (0002807,0002808)
GO
