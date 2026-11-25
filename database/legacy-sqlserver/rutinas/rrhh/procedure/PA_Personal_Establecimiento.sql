CREATE PROCEDURE [dbo].[PA_Personal_Establecimiento]
	@anio [char](4),
	@mes [char](2),
	@ruc [varchar](11),
	@codi_estab [varchar](4),
	@tasa [numeric](3, 2)
WITH EXECUTE AS CALLER
AS
--DECLARE @anio char(4),@mes char(2) , @ruc varchar(11),@codi_estab varchar(4), @tasa numeric(3,2)
--SELECT @anio = '2008', @mes ='10', @ruc ='20114228452', @codi_estab ='1', @tasa = '0'
set nocount on
create table #personal_aux ( personal_datos char(5)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL )

declare @codi_pers varchar(5)
declare @personal varchar(130)
declare @tasa_aux varchar(5)

declare @mes_aux int
declare @anio_aux int

if @mes='12' 
begin
	set @mes_aux=1 
	set @anio_aux=cast(@anio as int) + 1
end
else
begin
	set @mes_aux=cast(@mes as int) + 1 
	set @anio_aux= cast(@anio as int)
end


set @tasa_aux=cast(@tasa as varchar(5))
if @tasa=0 set  @tasa_aux=''

--- SELECCIONAMOS A TODOS EL PERSONAL QUE ESTE DENTRO DE PLANILLAS DE EMPLEADO
insert into #personal_aux(personal_datos)
SELECT DISTINCT CODI_PERS  FROM dbo.PLANILLA_DE_EMPLEADOS PE (nolock)  
WHERE (  Pe.ANIO =@anio ) AND  ( Pe.MES = @mes) 

-------FIN DE LOS EMPLEADOS----------------------------------

--- SELECCIONAMOS A TODOS EL PERSONAL QUE ESTE DENTRO DE PLANILLAS DE OBREROS
insert into #personal_aux(personal_datos)
SELECT DISTINCT CODI_PERS FROM dbo.PLANILLA_DE_OBREROS PO  (nolock) 
WHERE ( PO.ANIO =@anio ) AND  ( PO.MES = @mes) 

--- FIN DE PLANILLAS DE OBREROS

SELECT  (cast( (select td.Codi_Sunat from dbo.TIPO_DOCU_IDEN td (nolock) where td.Codi_Tipo_Docu_Iden=PERSONAL.Codi_Tipo_Docu_Iden) as char(1)) + '|'+ 
	PERSONAL.NRO_DOCU_IDEN + '|' + @ruc + '|' + @codi_estab + '|' + @tasa_aux  + '|'  ) 
FROM dbo.PERSONAL (nolock)
join 
(select  distinct personal_datos from  #personal_aux) tempo 
on personal.codi_pers=tempo.personal_datos 

drop table #personal_aux
GO
