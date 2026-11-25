CREATE PROCEDURE [dbo].[usp_compras_SUCURSALES_PERIODO]
	@tipo [int],
	@anio [int],
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @tipo int  , @anio int , @codi_alma char(2)
--select @tipo =0 , @anio =2010, @codi_alma ='00'

set nocount on 

declare @alma table (codi_alma char(2) null)
IF @codi_alma = '00'
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock)
END
ELSE
BEGIN
	insert @alma
	Select codi_alma from almacen (nolock) where codi_alma = @codi_alma
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
select  m.nro_mes , 'VALOR COMPRA' tipo, isnull(v.monto,0) as monto
from #Mes M 
left join 
	( select   month(isnull(fech_reg_fact, fech_guia_remi) ) mes , 
		 sum((CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * prec_tota ) monto
	 FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC (nolock)  on suc.codi_alma=FAC.codi_alma
	 where year(isnull(fech_reg_fact, fech_guia_remi))= @anio and  
		TIPO_NOTA_INGR='01'  and 
                SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from @alma)
	 group by  SUC.NEMO_ALMA , MONTH(isnull(fech_reg_fact, fech_guia_remi)) 
	 ) v	on m.nro_mes=v.mes
) RV

order by tipo desc

drop table #Mes
GO
