CREATE PROCEDURE [dbo].[PA_Personal_Trab_Exporta]
	@anio [int],
	@mes [int]
WITH EXECUTE AS CALLER
AS
--declare @anio int , @mes int
--select @anio =2008 , @mes =10
set nocount on
create table #personal_aux ( personal_datos char(5)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL )

declare @codi_pers char(5)
declare @personal varchar(300)
declare @tasa_aux varchar(5)

declare @mes_aux int
declare @anio_aux int

if @mes=12
begin
	set @mes_aux=1 
	set @anio_aux=@anio + 1
end
else
begin
	set @mes_aux=@mes  + 1 
	set @anio_aux=@anio
end

--- SELECCIONAMOS A TODOS EL PERSONAL QUE ESTE DENTRO DE PLANILLAS DE EMPLEADO
insert into #personal_aux(personal_datos) 
SELECT DISTINCT CODI_PERS FROM dbo.PLANILLA_DE_EMPLEADOS PE (nolock)  
WHERE (Pe.ANIO =@anio ) AND  ( Pe.MES = @mes )

-------FIN DE LOS EMPLEADOS----------------------------------

--- SELECCIONAMOS A TODOS EL PERSONAL QUE ESTE DENTRO DE PLANILLAS DE OBREROS
insert into #personal_aux(personal_datos)
SELECT DISTINCT CODI_PERS FROM dbo.PLANILLA_DE_OBREROS PO (nolock)  
WHERE (PO.ANIO =@anio ) AND  ( PO.MES = @mes) 
--- FIN DE PLANILLAS DE OBREROS

SELECT  
        (cast( (select td.Codi_Sunat from dbo.TIPO_DOCU_IDEN td (nolock) where td.Codi_Tipo_Docu_Iden=PERSONAL.Codi_Tipo_Docu_Iden) as char(1)) + '|' +		
        isnull(cast( PERSONAL.NRO_DOCU_IDEN  as varchar(15)) , '')+ '|'    + 	
        isnull(cast( TIPO_PERSONAL.Codi_Tipo_Pers_SUNAT  as varchar(2)) , '') + '|'+  
        isnull(cast(PERSONAL_CATEGORIA.Regi_Labo as varchar(1))  , '') + '|'+   		
        isnull( cast (NIVEL.Codi_Nivel_Sunat as varchar (2)) , '')+ '|'+   
        isnull( cast (OCUPACION.Codi_Ocu_Sunat  as varchar (6)) , '') + '|'+  		
        isnull( cast( PERSONAL_CATEGORIA.Discapacidad  as varchar(1)) , '0') + '|'+   
        isnull(cast(PENSION.Codi_Pension_SUNAT as varchar(2)) , '')+ '|'+  		 
        isnull(convert(char(10), PERSONAL_CATEGORIA.FECH_INGRE,103),'') + '|'+		     
        isnull(cast( PERSONAL_CATEGORIA.NRO_CUPSS  as varchar(12)) , '') + '|'+   
        isnull(cast(PERSONAL_CATEGORIA.SCRT as varchar(1)) , '')+ '|'+   
        isnull(cast(PERSONAL_CATEGORIA.SCTR_PENSION as varchar(1)) ,'') + '|'+   
        isnull(cast(TIPO_CONTRATO.Codi_Tipo_Cont_Sunat as varchar(2)) ,'')+ '|'+   		
        isnull(cast( PERSONAL_CATEGORIA.sujeto_reg_alter as varchar(1)) , '')+ '|'+   
        isnull(cast( PERSONAL_CATEGORIA.sujeto_jornada_max as varchar(1)) , '') + '|'+   
        isnull(cast( PERSONAL_CATEGORIA.horario_noctur as varchar(1)) , '') + '|'+   		
        isnull(cast( PERSONAL_CATEGORIA.infor_otros_ingr_qta_cat as varchar(1)) , '') + '|'+  		
        isnull(cast( PERSONAL_CATEGORIA.Sindicalizado as varchar(1)) , '') + '|'+   
        isnull(cast( PERIODICIDAD.Codi_Periodo_Sunat as varchar(1)) ,'')+ '|'+   		
        isnull(cast( PERSONAL_CATEGORIA.afi_eps_serv_prop as varchar(1)) ,'')+ '|'+   		
        isnull(cast( ENTIDAD_SALUD.Codi_Enti_Sunat as varchar(1)) ,'')+ '|'+   
        isnull(cast(SITU_TRAB_PENS.Codi_Situ_Trab_Pens_Sunat as varchar(2)) , '')+ '|'+   		
        isnull(cast( PERSONAL_CATEGORIA.renta_qta_cat_exo_inaf as varchar(1)) ,'')+ '|'+   	
        isnull( cast( Case when CATEGORIA_TRABAJADOR.ORDE_CATE_TRAB=10 then 0 else CATEGORIA_TRABAJADOR.ORDE_CATE_TRAB end as varchar(1)) ,'')	+ '|'+		
        isnull( cast(TIPO_PAGO.Codi_Sunat as varchar(1)) , '' ) + '|' +
        isnull(cast( PERSONAL_CATEGORIA.afilia_asegura_pension as char(1)),'0') + '|' +
        isnull(cast( CO.codigo_sunat as varchar(2)),'0') + '|'  + 
        isnull(cast( CET.cod_sunat as varchar(2)),'0') + '|'   ) 

     FROM dbo.PERSONAL (nolock) join (select distinct personal_datos from #personal_aux) temporal on personal.codi_pers=temporal.personal_datos
         left JOIN dbo.PERSONAL_CATEGORIA (nolock) ON PERSONAL.CODI_PERS = PERSONAL_CATEGORIA.CODI_PERS
         left JOIN dbo.TIPO_PERSONAL (nolock) ON TIPO_PERSONAL.Codi_Tipo_Pers=PERSONAL_CATEGORIA.Codi_Tipo_Pers
         left JOIN dbo.PENSION (nolock) ON PENSION.Codi_PENSION=PERSONAL_CATEGORIA.Codi_PENSION
         left JOIN dbo.NIVEL (nolock) ON NIVEL.CODI_NIVEL= PERSONAL_CATEGORIA.CODI_NIVEL  
         left JOIN dbo.OCUPACION (nolock) ON OCUPACION.CODI_OCU=PERSONAL_CATEGORIA.CODI_OCU   
         left JOIN dbo.TIPO_CONTRATO (nolock) ON TIPO_CONTRATO.Codi_Tipo_Cont=PERSONAL_CATEGORIA.Codi_Tipo_Cont  
         left JOIN dbo.PERIODICIDAD (nolock) ON PERIODICIDAD.Codi_Periodo=PERSONAL_CATEGORIA.Codi_Periodo   
         left JOIN dbo.SITU_TRAB_PENS (nolock) ON  SITU_TRAB_PENS.Codi_Situ_Trab_Pens= PERSONAL_CATEGORIA.Codi_Situ_Trab_Pens  
         left JOIN dbo.TIPO_PAGO (nolock) ON TIPO_PAGO.Codi_Tipo_Medio_Pago=PERSONAL_CATEGORIA.Codi_Tipo_Medio_Pago  
         left join dbo.ENTIDAD_SALUD (nolock) on ENTIDAD_SALUD.Codi_Enti =PERSONAL_CATEGORIA.Codi_Enti 
         left join dbo.CATEGORIA_TRABAJADOR (nolock) on CATEGORIA_TRABAJADOR.CODI_CATE_TRAB=PERSONAL_CATEGORIA.CODI_CATE_TRAB 		
         left join dbo.CATEGORIA_OCUPACIONAL CO (nolock) on  PERSONAL_CATEGORIA.cod_categ_ocup = CO.cod_categ_ocup
         left join dbo.CONVENIO_EVITA_DOBLE_TRIBUTACION CET (nolock) on PERSONAL_CATEGORIA.cod_conv_evita_dob_tribu = CET.cod_conv_evita_dob_tribu 

drop table #personal_aux
GO
