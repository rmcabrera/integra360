CREATE PROCEDURE [dbo].[PA_VENTAS_SUCURSALES_PERIODO]
	@tipo [int],
	@anio [int],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
declare @alma table (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen
END
ELSE
BEGIN
	insert @alma
	Select codi_alma from almacen where codi_alma = @codi_alma
END

set nocount on

-- UTILIZADO PARA EL REPORTE DE ESTADISTICAS - GRAFICO
create table #Mes (nro_mes int   , monto decimal (9,3))
declare @nro_meses int

set @nro_meses=1
while @nro_meses<13
	begin 
	  insert into 	#Mes (nro_mes ,   monto)
		 values      (@nro_meses  ,0)
	  set @nro_meses = @nro_meses + 1 
	end

if @tipo=1 or @tipo=4     -- Contado o Credito
begin
	select  case NRO_MES
				  WHEN '1' THEN 'A ENERO'
				  WHEN '2' THEN 'B FEBRERO'
				  WHEN '3' THEN 'C MARZO'
				  WHEN '4' THEN 'D ABRIL'
				  WHEN '5' THEN 'E MAYO'
				  WHEN '6' THEN 'F JUNIO'
				  WHEN '7' THEN 'G JULIO'
				  WHEN '8' THEN 'H AGOSTO'
				  WHEN '9' THEN 'I SETIEMBRE'
				  WHEN '10' THEN 'J OCTUBRE'
				  WHEN '11' THEN 'K NOVIEMBRE'
				  WHEN '12' THEN 'L DICIEMBRE'
		        end as mes ,
	
		TIPO , MONTO
	
	from 
	
	(
	select  m.nro_mes , 'VALOR VENTA' tipo, isnull(v.monto,0) as monto
	from #Mes M left join 
		( select   month(FAC.FECH_FACT) mes , 
		 sum((CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )) monto

		 FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
			inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		 where year(FAC.FECH_FACT)= @anio and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)	and FAC.CODI_TIPO_PAGO=@tipo 
	              and SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
	
		 group by  SUC.NEMO_ALMA , MONTH(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO 
		
	 ) v
	on m.nro_mes=v.mes
	
	union all
	
	select  m.nro_mes ,'VALOR COSTO' AS TIPO, isnull(v.monto,0) as monto
	from #Mes M left join 
		(select  month(FAC.FECH_FACT) mes ,
		sum((CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO )) monto

		FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		inner join PRODUCTOS as PROD on FD.codi_prod=PROD.codi_prod
		where year(FAC.FECH_FACT)= @anio   and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)  and FAC.CODI_TIPO_PAGO=@tipo  
                                     and SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
		group by  SUC.NEMO_ALMA , MONTH(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO ) as V
	
	on m.nro_mes=v.mes	
		
	union all
	
	select m.nro_mes ,'UTILIDAD' AS TIPO, isnull(v.monto,0) as monto
	from #Mes M left join 
		(select   month(FAC.FECH_FACT) mes ,
		 sum((CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM )) - 
		sum((CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO) ) monto

		FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		inner join PRODUCTOS as PROD on FD.codi_prod=PROD.codi_prod
		where year(FAC.FECH_FACT)= @anio   and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL) and FAC.CODI_TIPO_PAGO=@tipo
                                     and SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
		group by  SUC.NEMO_ALMA , MONTH(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO ) as V
	
	on m.nro_mes=v.mes) RV
	
	order by tipo desc
	end

else

-- TODAS LAS VENTAS CONTADO Y CREDITO

begin
	select  case NRO_MES
				  WHEN '1' THEN 'A ENERO'
				  WHEN '2' THEN 'B FEBRERO'
				  WHEN '3' THEN 'C MARZO'
				  WHEN '4' THEN 'D ABRIL'
				  WHEN '5' THEN 'E MAYO'
				  WHEN '6' THEN 'F JUNIO'
				  WHEN '7' THEN 'G JULIO'
				  WHEN '8' THEN 'H AGOSTO'
				  WHEN '9' THEN 'I SETIEMBRE'
				  WHEN '10' THEN 'J OCTUBRE'
				  WHEN '11' THEN 'K NOVIEMBRE'
				  WHEN '12' THEN 'L DICIEMBRE'
		        end as mes ,
	
		TIPO , MONTO
	
	from 
	
	(
	select  m.nro_mes , 'VALOR VENTA' tipo, isnull(v.monto,0) as monto
	from #Mes M left join 
		( select   month(FAC.FECH_FACT) mes , 
		 sum((CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM *  FD.PREC_ITEM )) monto
			
		 FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
			inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		 where year(FAC.FECH_FACT)= @anio and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL) 
                                     and SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
	
		 group by  SUC.NEMO_ALMA , MONTH(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO 
		
	 ) v
	on m.nro_mes=v.mes
	
	union all
	
	select  m.nro_mes ,'VALOR COSTO' AS TIPO, isnull(v.monto,0) as monto
	from #Mes M left join 
		(select  month(FAC.FECH_FACT) mes ,
		sum((CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO )) monto
			
		FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		inner join PRODUCTOS as PROD on FD.codi_prod=PROD.codi_prod
		where year(FAC.FECH_FACT)= @anio   and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
                                     and SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
		group by  SUC.NEMO_ALMA , MONTH(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO ) as V
	
	on m.nro_mes=v.mes	
		
	union all
	
	select m.nro_mes ,'UTILIDAD' AS TIPO, isnull(v.monto,0) as monto
	from #Mes M left join 
		(select   month(FAC.FECH_FACT) mes ,
		 sum((CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tcambio END ) * ( FD.CANT_ITEM * FD.PREC_ITEM )) - 
	  	 sum((CASE PROD.COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+dbo.f_igv(fech_fact)/100 END ) * ( FD.CANT_ITEM * FD.PREC_COSTO) ) monto
			
		FROM ALMACEN as SUC inner join FACTURA as FAC on suc.codi_alma=FAC.codi_alma
		inner join FACTURA_DETALLE as FD on FAC.codi_fact = FD.codi_fact
		inner join PRODUCTOS as PROD on FD.codi_prod=PROD.codi_prod
		where year(FAC.FECH_FACT)= @anio   and  ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
                                     and SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
		group by  SUC.NEMO_ALMA , MONTH(FAC.FECH_FACT) , FAC.CODI_TIPO_PAGO ) as V
	
	on m.nro_mes=v.mes) RV
	
	order by tipo desc
end

drop table #Mes
GO
