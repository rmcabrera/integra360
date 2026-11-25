CREATE PROCEDURE [dbo].[PA_Personal_Periodos_Exporta]
	@anio [int],
	@mes [int]
WITH EXECUTE AS CALLER
AS
--declare @anio int, @mes int
--select @anio =2008, @mes =10
set nocount on 
create table #personal_aux ( personal_datos char(5)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL )

declare @codi_pers char(5)
declare @personal varchar(300)


declare @mes_aux int
declare @anio_aux int

if @mes=12 
begin
	set @mes_aux=1 
	set @anio_aux=@anio  + 1
end
else
begin
	set @mes_aux=@mes + 1 
	set @anio_aux= @anio
end


--- SELECCIONAMOS A TODOS EL PERSONAL QUE ESTE DENTRO DE PLANILLAS DE EMPLEADO
insert into #personal_aux(personal_datos)  
SELECT DISTINCT CODI_PERS
FROM dbo.PLANILLA_DE_EMPLEADOS PE (nolock)  
WHERE ( Pe.ANIO =@anio ) AND  ( Pe.MES = @mes )

-------FIN DE LOS EMPLEADOS----------------------------------

--- SELECCIONAMOS A TODOS EL PERSONAL QUE ESTE DENTRO DE PLANILLAS DE OBREROS
insert into #personal_aux(personal_datos)  
SELECT DISTINCT CODI_PERS FROM dbo.PLANILLA_DE_OBREROS PO (nolock)  
WHERE ( PO.ANIO =@anio ) AND  ( PO.MES = @mes) 

--- FIN DE PLANILLAS DE OBREROS


--LISTAMOS A TODO EL PERSONAL QUE SU FECHA DE INGRESO SEA MENOR AL PERIODO


SELECT  isnull(cast(TDI.Codi_Sunat as varchar(2)),'')		+ '|'+
	left(isnull(P.nro_docu_iden,'') ,15)			+ '|1|'+
	isnull(convert(char(10), Pp.Fech_inicio,103),'') 		+ '|'+
	isnull(convert(char(10), PP.Fech_FIN,103),'') 		+ '|'+
	isnull(cast(MFP.Codi_Moti_Fin_Peri_SUNAT as varchar(2)) , '')+ '||'   
 
	From dbo.Personal P (nolock) join #personal_aux as  temporal 
		on p.codi_pers=temporal.personal_datos
		left join dbo.Tipo_Docu_Iden TDI (nolock) on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden 
		left join dbo.PERSONAL_CATEGORIA PC (nolock) on PC.codi_PERS=p.CODI_PERS
		left join dbo.PERSONAL_PERIODO PP (nolock) on PP.codi_PERS_CATEG=pC.CODI_PERS_CATEG
		left JOIN dbo.MOTI_FIN_PERIODO MFP (nolock) ON MFP.Codi_Moti_Fin_Peri=PP.Codi_Moti_Fin_Peri
	
WHERE PC.TIPO_CAT_TRAB='T' 

union all

SELECT  isnull(cast(TDI.Codi_Sunat as varchar(2)),'')		+ '|'+
	left(isnull(P.nro_docu_iden,'') ,15)			+ '|5|'+
	isnull(convert(char(10), Pp.Fech_Inicio,103),'') 		+ '|'+
	isnull(convert(char(10), PP.Fech_FIN,103),'') 		+ '||' +
 	isnull(MF.Codi_Moda_Forma_Sunat , '') + '|'    
From dbo.Personal P  (nolock) join (select distinct personal_datos from #personal_aux) temporal on p.codi_pers=temporal.personal_datos
	left join dbo.Tipo_Docu_Iden TDI (nolock) on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden 
	left join dbo.PERSONAL_CATEGORIA PC (nolock) on PC.codi_PERS=p.CODI_PERS
	left join dbo.PERSONAL_PERIODO PP (nolock) on PP.codi_PERS_CATEG=pC.CODI_PERS_CATEG
	left JOIN  dbo.modalidad_formativa MF (nolock) ON MF.Codi_Moda_Forma=PP.Codi_Moda_Forma
WHERE PC.TIPO_CAT_TRAB='M'

drop table #personal_aux
GO
