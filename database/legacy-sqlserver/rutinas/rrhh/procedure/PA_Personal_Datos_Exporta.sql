CREATE PROCEDURE [dbo].[PA_Personal_Datos_Exporta]
	@anio [int],
	@mes [int]
WITH EXECUTE AS CALLER
AS
--declare @anio int , @mes int
--select  @anio =2008 , @mes =06
set nocount on
create table #personal_aux ( personal_datos char(5)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL  , Codi_Tipo_Docu_Iden tinyint )

declare @codi_pers char(5)
declare @personal varchar(300)
declare @tasa_aux varchar(5)
declare @Codi_Tipo_Docu_Iden tinyint

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

insert into #personal_aux(personal_datos , Codi_Tipo_Docu_Iden )  
SELECT DISTINCT p.CODI_PERS , p.Codi_Tipo_Docu_Iden 
FROM dbo.PERSONAL P (nolock) ,  dbo.PLANILLA_DE_EMPLEADOS PE (nolock)  
WHERE ( Pe.CODI_PERS = P.CODI_PERS ) and ( Pe.ANIO =@anio ) AND  ( Pe.MES = @mes )
-------FIN DE LOS EMPLEADOS----------------------------------

--- SELECCIONAMOS A TODOS EL PERSONAL QUE ESTE DENTRO DE PLANILLAS DE OBREROS

insert into #personal_aux(personal_datos , Codi_Tipo_Docu_Iden)  
SELECT DISTINCT p.CODI_PERS , p.Codi_Tipo_Docu_Iden 
FROM dbo.PERSONAL P (nolock) ,  dbo.PLANILLA_DE_OBREROS PO  (nolock) 
WHERE ( PO.CODI_PERS = P.CODI_PERS ) and ( PO.ANIO =@anio ) AND  ( PO.MES = @mes) 

--- FIN DE PLANILLAS DE OBREROS

---******************************************* 
---empezamos la union de datos--**************

Select ( isnull(cast(TDI.Codi_Sunat as varchar(5)),'')		+ '|'+
	left(isnull(P.nro_docu_iden,'') ,15)			+ '|'+
	left(isnull(P.apel_1,'')	,40)			+ '|'+
	left(isnull(P.apel_2,'')	,40)			+ '|'+
	left(rtrim(isnull(P.nomb_1,'') + ' ' + isnull(P.nomb_2,'')),40)  	+ '|'+
	isnull(convert(char(10), P.fech_naci,103),'') 		+ '|'+
	isnull(Case when Sexo='F' then '2' else '1' end ,'')	+ '|'+
	isnull(n.codi_nacion_sunat,'')		+ '|'+
	rtrim(isnull(P.telefono,'')) 				+ '|'+
	left(rtrim(isnull(P.e_mail,'')),50) 			+ '|' +
	isnull(case when essalud = 1 	then '1' else '0' end ,'0') + '|'+
	isnull(case when condi_domi= 1 then '1' else '2' end ,'2')  + '|'+

--Datos de direccion
	 '||||||||' )      COLLATE SQL_Latin1_General_CP1_CI_AS as PERS  

From dbo.Personal P (nolock) 
join (select distinct personal_datos from #personal_aux) temporal on p.codi_pers=temporal.personal_datos
join dbo.Tipo_Docu_Iden TDI (nolock)  on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden 
join dbo.nacion n (nolock)  on n.codi_nacion=p.codi_nacion
left join dbo.via v (nolock)  on v.codi_via=p.codi_via
where TDI.Codi_Sunat=1 

union all


Select ( isnull(cast(TDI.Codi_Sunat as varchar(5)),'')		+ '|'+
	left(isnull(P.nro_docu_iden,'') ,15)			+ '|'+
	left(isnull(P.apel_1,'')	,40)			+ '|'+
	left(isnull(P.apel_2,'')	,40)			+ '|'+
	left(rtrim(isnull(P.nomb_1,'') + ' ' + isnull(rtrim(P.nomb_2),'')),40)  	+ '|'+
	isnull(convert(char(10), P.fech_naci,103),'') 		+ '|'+
	isnull(Case when Sexo='F' then '2' else '1' end ,'')	+ '|'+
	isnull(n.codi_nacion_sunat,'')		+ '|'+
	rtrim(isnull(P.telefono,'')) 				+ '|'+
	left(rtrim(isnull(P.e_mail,'')),50) 			+ '|' +
	isnull(case when essalud = 1 	then '1' else '0' end ,'0') + '|'+
	isnull(case when condi_domi= 1 then '1' else '2' end ,'2')  + '|'+
-----Datos de direccion
	isnull(cast(v.codi_via_sunat as varchar(5)),'')	 		   + '|'+
	isnull(nomb_via  , '')					+ '|'+
	isnull(num_via,'')					+ '|'+
	isnull(Interior_via,'')					+ '|'+
	isnull(cast(z.codi_zona_sunat as varchar(5)),'')		+ '|'+  
	isnull(nomb_zona ,'')					+ '|'+
	isnull(refe_zona,'')					+ '|' + 

	isnull(dbo.f_ubigeo_distrito(isnull(p.codi_ubi_dist,0)) ,'') + '|' ) COLLATE SQL_Latin1_General_CP1_CI_AS as PERS

From dbo.Personal P (nolock) inner join (select * from #personal_aux  aux where aux.Codi_Tipo_Docu_Iden=3)  temporal on p.codi_pers=temporal.personal_datos
	join dbo.Tipo_Docu_Iden TDI (nolock)  on TDI.Codi_Tipo_Docu_Iden = P.Codi_Tipo_Docu_Iden 
	join dbo.nacion n (nolock)  on n.codi_nacion=p.codi_nacion
	left join dbo.via v (nolock)  on v.codi_via=p.codi_via
	left join dbo.zona z (nolock) on z.codi_zona=p.codi_zona

where TDI.Codi_Sunat not in (1) 

drop table  #personal_aux
GO
