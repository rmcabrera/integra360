CREATE PROCEDURE [dbo].[PA_Genera_Asiento_Auto_Nota_Ingreso_Aceite]
	@codi_clie_prov [char](5),
	@serie [varchar](3),
	@nro_docu [varchar](10)
WITH EXECUTE AS CALLER
AS
--SELECCIONAMOS LA FECHA Y LA MONEDA DE LA FACTURA 
Declare @fecha_factu	smalldatetime
Declare @codi_mone 	char(2)
set  @fecha_factu = ( Select  top 1 Fecha_Fact  From Nota_ingreso_Aceite  where codi_clie_prov = @codi_clie_prov and serfact = @serie and nrofact=@nro_docu)
set  @codi_mone   = ( Select  top 1 codi_mone   From Nota_ingreso_Aceite  where codi_clie_prov = @codi_clie_prov and serfact = @serie and nrofact=@nro_docu)


--ASIGNAMOS EL VALOR DEL IGV
Declare @valor_igv decimal (18,2)

Select @valor_igv = valor  
From  Valores_Unitarios_Anuales
where Codi_Valo_Unit = '2' And  Fech_Asig <= @fecha_FACTu And Fech_Asig_Fin >= @fecha_FACTu


--SELECCIONAMOS EL TIPO DE CAMBIO DE LA FECHA DE LA FACTURA
Declare @tipo_cambio 	decimal (18,4)
Set @tipo_cambio = 0.0
if @codi_mone <> '01'
   BEGIN
	Select @tipo_cambio = venta 
	from tipo_cambio_a_dolar 
	where   CODI_MONE_CAMB= @CODI_MONE AND FECH_CAMB= @fecha_FACTu
   END

--CREAMOS LA TABLA QUE ALMACENARA 
Create table #tempo
	( subdia			char(1) ,
	nro_cuen   		char(7) null,
	 importe    		decimal (18,2),
 	 importe_d  		decimal (18,2) NULL ,
	 codi_ingr  		numeric null,
	 codi_alma  		char(2) null,
	 Cargo_Abono 		char(1),
	 Codi_Unid_Oper	char(5) null,
	 orden			tinyint,
	 tipo_cambio		decimal (12,4),
	codi_mone		char(2)
         )
	--( subdia, nro_cuen   ,	 importe    , 	 importe_d  ,	 codi_ingr  ,	 codi_alma  ,	 Cargo_Abono ,Codi_Unid_Oper ,  orden	 )

--CARGAMOS A LA 60 (Seleccionado en el momento de registro de la NI)/ el where jala todos los ingresos de una factura de un cliente_proveedor
   --Si es dolar
    if @codi_mone <> '01'
   	BEGIN
		Declare @importe_dolar decimal (18,2)
		Declare @importe_soles decimal (18,2)

		Create Table #tempo_dolar(
					  nro_cuen   	char(7) null,
		 			  impo        	decimal (18,2),
		 			  codi_ingr  	numeric,
		 			  codi_alma  	char(2)
					  )
		
		Insert Into #tempo_dolar
		Select  ka.nro_cuen, sum(ka.total), ka.codi_transa, ka.codi_alma
		From Kardex_Almacenes ka inner join nota_ingreso_Aceite nia on nia.codi_ingr = ka.codi_transa and ka.codi_alma = nia.codi_alma and ka.i_o ='I'  
		Where nia.codi_clie_prov = @codi_clie_prov and nia.serfact = @serie and nia.nrofact=@nro_docu 
		Group By ka.nro_cuen , ka.codi_transa , ka.codi_alma

		Insert Into #tempo
			( subdia, nro_cuen   ,	 importe    	, importe_d , codi_ingr , codi_alma  , Cargo_Abono , Codi_unid_oper, orden			   , tipo_cambio, codi_mone  )
		Select   'C', nro_cuen   ,impo * @tipo_cambio, impo      , codi_ingr , codi_alma  ,	'C'   , dbo.f_CODI_UNID_OPER( codi_ingr , codi_alma )  , 1 , @tipo_cambio, @codi_mone
		From #tempo_dolar 
	END
    --Si es soles
    else 
   	BEGIN
		Insert Into #tempo         
		Select 'C', ka.nro_cuen, sum(ka.total),  0  -- sum(total)*@tipo_cambio(0)
		       , ka.codi_transa, ka.codi_alma , 'C' , dbo.f_CODI_UNID_OPER(  ka.codi_transa  , ka.codi_alma )  , 1
			, @tipo_cambio, @codi_mone
		From Kardex_Almacenes ka inner join nota_ingreso_Aceite nia on nia.codi_ingr = ka.codi_transa and ka.codi_alma = nia.codi_alma and ka.i_o ='I'  
		Where nia.codi_clie_prov = @codi_clie_prov and nia.serfact = @serie and nia.nrofact=@nro_docu  
		Group By ka.nro_cuen, ka.codi_transa , ka.codi_alma
	END


--GENERAMOS AUTOMATICO
	Create table #tempo_Auto
	( subdia		char(1) ,
	 nro_cuen   	char(7) null,
	 nro_sub_cuen	char (7) null,
	 importe    	decimal (18,2),
 	 importe_d  	decimal (18,2),
	 codi_ingr  	numeric ,
	 codi_alma  	char(2) ,
	 Cargo_Abono 	char(1),
	 Codi_Unid_Oper	char(5),
	 Condi		char(2))

	Insert Into #TEMPO_auto 
	Select 	'A', dbo.F_NRO_SUB_CUEN (NRO_CUEN), 
		dbo.F_NRO_SUB_CUEN (dbo.F_NRO_SUB_CUEN (NRO_CUEN)), 
		importe, importe_d, codi_ingr, codi_alma, cargo_abono, codi_unid_oper,'1C'
	From 	#TEMPO  


	Insert Into #TEMPO_auto 
	Select 	'A',  dbo.F_NRO_SUB_CUEN (NRO_CUEN), 
		dbo.F_NRO_SUB_CUEN (dbo.F_NRO_SUB_CUEN (NRO_CUEN)), 
		importe, importe_d, codi_ingr, codi_alma, 'A', codi_unid_oper,'1A'
	From 	#TEMPO_AUTO  


	Insert Into #TEMPO_auto 
	Select 	'A',  dbo.F_NRO_SUB_CUEN (NRO_CUEN), 
		dbo.F_NRO_SUB_CUEN (dbo.F_NRO_SUB_CUEN (NRO_CUEN)), 
		importe, importe_d, codi_ingr, codi_alma, 'C', codi_unid_oper, '2C'
	From 	#TEMPO_AUTO  
	Where  condi='1A'


	Insert Into #TEMPO_auto 
	Select 	'A',  dbo.F_NRO_SUB_CUEN (NRO_CUEN), 
		dbo.F_NRO_SUB_CUEN (dbo.F_NRO_SUB_CUEN (NRO_CUEN)), 
		importe, importe_d, codi_ingr, codi_alma, 'A', codi_unid_oper, '2A'
	From 	#TEMPO_AUTO  
	Where  condi='2C'

	
--CARGAMOS A LA CUARENTA
Declare @cuen_igv 	 char(7)
Declare @importe_igv_sol decimal (18,2)
Declare @importe_igv_dol decimal (18,2)

Select @cuen_igv    	= cuenta From cuentas_provision where codigo='01'

declare @igv_soles  decimal (18,2)
declare @igv_dolar   decimal (18,2)
Select @igv_soles = sum(importe) from #tempo
Select @igv_dolar = sum(importe_d) from #tempo

set  @importe_igv_sol   =  round (   @igv_soles *  @valor_igv   /  100   , 2)
set  @importe_igv_dol   =  round (   @igv_dolar *  @valor_igv   /  100   , 2)


Insert Into #Tempo ( subdia, nro_cuen, importe         ,importe_d	, cargo_abono, orden , tipo_cambio, codi_mone )
	      values (  'C'      , @cuen_igv, @importe_igv_sol,@importe_igv_dol, 'C' ,2 , @tipo_cambio, @codi_mone	 ) 


--ABONAMOS A LA 42
Declare @cuen_42 char(7)
Declare @importe_42_sol decimal(18,2)
Declare @importe_42_dol decimal(18,2)

Select @cuen_42 = cuenta From cuentas_provision where codigo='02'
Select @importe_42_sol = sum(importe)  from #tempo
Select @importe_42_dol = sum(importe_d)from #tempo

Insert Into #Tempo ( SUBDIA , nro_cuen , importe	      , importe_d 	,  cargo_abono, orden , tipo_cambio, codi_mone )
	    values ( 'C' , @cuen_42, @importe_42_sol ,	@importe_42_dol ,'A' , 3 , @tipo_cambio, @codi_mone)



--ASIENTO GENERADO
Select  /*orden,  @codi_mone, @tipo_cambio, */ subdia, nro_cuen , dbo.f_nro_sub_cuen(nro_cuen) ,    importe  ,  importe_d  , codi_ingr , codi_alma , Cargo_Abono ,Codi_Unid_Oper 
From #tempo
order by orden
/*
UNION
Select 4,  @codi_mone, @tipo_cambio,  subdia, nro_cuen  , importe  , importe_d  , codi_ingr , codi_alma  ,Cargo_Abono 	, Codi_Unid_Oper	
from #TEMPO_auto
order by subdia desc*/
GO
