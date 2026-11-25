CREATE PROCEDURE [dbo].[PA_Generar_Asiento_Ventas]
	@anio [char](4),
	@mes [char](2),
	@codi_conta [varchar](4),
	@tipo_venta [char](1),
	@hecho_por [char](5),
	@glosa [varchar](200) = null,
	@compr [varchar](10) = null,
	@codi_fact [char](10),
	@tipo_docu [char](1)
WITH EXECUTE AS CALLER
AS
--Tomamos las variables de contabilizacion
Declare
	@cuenta_12		char(7),
	@ca_12		char(1),
	@cuenta_70		char(7),
	@ca_70		char(1),
	@cuenta_40		char(7),
	@ca_40		char(1),
	@subdia		char(1),
	@codi_tipo_docu	char(4),
	@glosa2		varchar(100),
	@glosa3		varchar(100),
	@ESTADO		CHAR(1)

Select 	@cuenta_12 = CUENTA1,	@ca_12	= CA1,
       	@cuenta_40 = CUENTA2,	@ca_40	= CA2,
       	@cuenta_70 = CUENTA4,	@ca_70	= CA4,
       	@subdia = SUBDIARIO ,   
	@glosa 	= case when @glosa is null 	then desc1 else @glosa end ,
	@glosa2 = case when @glosa is not null 	then desc2 else @glosa end ,
	@glosa3 = case when @glosa is not null 	then desc4 else @glosa end ,
	@codi_tipo_docu = tipod
From Contabilizacion
where CODIGO = @codi_conta


----------------------------------------------GLOSA--------------------------------------------
if @tipo_docu = 'F' or  @tipo_docu = 'B'
   begin
	select 	@glosa 	= case when estado = 'A' then	'ANULADO' else @glosa end,
		@glosa2 = case when estado = 'A' then 	'ANULADO' else @glosa2 end,
		@glosa3 = case when estado = 'A' then 	'ANULADO' else @glosa3 end,
		@ESTADO = estado
	from factura
	where codi_fact = @codi_fact
   end

if @tipo_docu = 'C' 
   begin
	select 	@glosa 	= case when estado = 'A' then	'ANULADO' else @glosa end,
		@glosa2 = case when estado = 'A' then 	'ANULADO' else @glosa2 end,
		@glosa3 = case when estado = 'A' then 	'ANULADO' else @glosa3 end,
		@ESTADO = estado
	from NOTA_CREDITO
	where codi_nota_cred = replicate('0', 10 - len(cast(@codi_fact as varchar(10)))) + cast(@codi_fact as varchar(10))
   end

if @tipo_docu = 'D' 
   begin
	select 	@glosa 	= case when estado = 'A' then	'ANULADO' else @glosa end,
		@glosa2 = case when estado = 'A' then 	'ANULADO' else @glosa2 end,
		@glosa3 = case when estado = 'A' then 	'ANULADO' else @glosa3 end,
		@ESTADO = estado
	from NOTA_DEBITO
	where codi_nota_debi = replicate('0', 10 - len(cast(@codi_fact as varchar(10)))) + cast(@codi_fact as varchar(10))
   end


Create Table #asiento
		(Codi_Mone		char(2), 
		 Fecha			datetime,
		 Codi_Clie_Prov		char(5), 
		 Serie			varchar(5), 
		 Nro_Docu		varchar(10), 
		 Codi_Tipo_Docu 	char(4),
		 Importe			decimal(18,2),
		 Igv			decimal(18,2),
		 total			decimal(18,2),
		 Importe_d		decimal(18,2),
		 igv_d			decimal(18,2),
		 total_d			decimal(18,2),
		 tipo_cambio		decimal(18,4))


--------------------------------------------------DATOS DE DOCUMENTO A CONTABILIZAR ------------------------------------------------------
if @tipo_docu = 'F' or  @tipo_docu = 'B'
   begin
	insert into #asiento
	Select 	codi_mone, fech_fact, codi_clie_prov  , replicate('0', 4 - len(cast(ser_fact as varchar(4))))+cast(ser_fact as varchar(4)) as serie, 
		cast(nro_fact as varchar(10)) as nro_docu , codi_tipo_docu , 
		case when codi_mone='01' then subtota_fact 	else subtota_fact * (select venta from tipo_cambio_a_dolar where fech_camb = fech_fact) 	end as vv_soles,
		case when codi_mone='01' then igv_fact	 	else igv_fact  	* (select venta from tipo_cambio_a_dolar where fech_camb = fech_fact)	end as igv_soles,
		case when codi_mone='01' then tota_fact	else tota_fact	* (select venta from tipo_cambio_a_dolar where fech_camb = fech_fact)	end as pv_soles,
		case when codi_mone='01' then 0.00	 	else subtota_fact									end as vv_dolar,
		case when codi_mone='01' then 0.00	 	else igv_fact	  									end as igv_dolar,
		case when codi_mone='01' then 0.00	 	else tota_fact										end as pv_dolar,
		case when codi_mone='01' then 0.00         	else (select venta from tipo_cambio_a_dolar where fech_camb = fech_fact) 		end as tipo_cambio
	--	tipo_cambio
	From Factura Where codi_fact = @codi_fact 
   end

if @tipo_docu = 'C' 
   begin
	insert into #asiento
	Select 	codi_mone, cast(convert(char(10),fech_nota_cred,103) as smalldatetime), codi_clie_prov, ser_nota_cred as serie, 
		cast(cast(nro_nota_cred as numeric) as varchar(10)) as nro_docu, '0007',  --Nota de credito
		case when codi_mone='01' then valo_vent 	else valo_vent 	* (select venta from tipo_cambio_a_dolar where fech_camb = cast(convert(char(10),fech_nota_cred,103) as smalldatetime)) end as vv_soles,
		case when codi_mone='01' then igv	 	else igv	* (select venta from tipo_cambio_a_dolar where fech_camb = cast(convert(char(10),fech_nota_cred,103) as smalldatetime)) end as igv_soles,
		case when codi_mone='01' then prec_vent 	else prec_vent	* (select venta from tipo_cambio_a_dolar where fech_camb = cast(convert(char(10),fech_nota_cred,103) as smalldatetime)) end as pv_soles,
		case when codi_mone='01' then 0.00	 	else valo_vent																 end as vv_dolar,
		case when codi_mone='01' then 0.00	 	else igv	  															 end as igv_dolar,
		case when codi_mone='01' then 0.00	 	else prec_vent																 end as pv_dolar,
		case when codi_mone='01' then 0.00         	else (select venta from tipo_cambio_a_dolar where fech_camb = cast(convert(char(10),fech_nota_cred,103) as smalldatetime)) 		 end as tipo_cambio
	From Nota_Credito
	where codi_nota_cred = replicate('0', 10 - len(cast(@codi_fact as varchar(10)))) + cast(@codi_fact as varchar(10))
   end

if @tipo_docu = 'D' 
   begin
	insert into #asiento
	Select 	codi_mone, cast(convert(char(10),fech_nota_debi,103) as smalldatetime), codi_clie_prov, ser_nota_debi as serie, 
		cast(cast(nro_nota_debi as numeric) as varchar(10)) as nro_docu, '0008',  --Nota de credito
		case when codi_mone='01' then valo_vent 	else valo_vent 	* (select venta from tipo_cambio_a_dolar where fech_camb = cast(convert(char(10),fech_nota_debi,103) as smalldatetime)) end as vv_soles,
		case when codi_mone='01' then igv	 	else igv	* (select venta from tipo_cambio_a_dolar where fech_camb = cast(convert(char(10),fech_nota_debi,103) as smalldatetime)) end as igv_soles,
		case when codi_mone='01' then prec_vent	else prec_vent	* (select venta from tipo_cambio_a_dolar where fech_camb = cast(convert(char(10),fech_nota_debi,103) as smalldatetime)) end as pv_soles,
		case when codi_mone='01' then 0.00	 	else valo_vent																 end as vv_dolar,
		case when codi_mone='01' then 0.00	 	else igv	  															 end as igv_dolar,
		case when codi_mone='01' then 0.00	 	else prec_vent																 end as pv_dolar,
		case when codi_mone='01' then 0.00         	else (select venta from tipo_cambio_a_dolar where fech_camb = cast(convert(char(10),fech_nota_debi,103) as smalldatetime)) 		 end as tipo_cambio
	From Nota_Debito
	where codi_nota_debi = replicate('0', 10 - len(cast(@codi_fact as varchar(10)))) + cast(@codi_fact as varchar(10))
   end


---------------------------------------------------PROVISION-----------------------------------------------------------------
if @ESTADO = 'A'
   begin
	update #asiento	set Importe = 0.00, Igv = 0.00,  total=0.00,  Importe_d= 0.00, igv_d = 0.00, total_d = 0.00,  tipo_cambio = 0.00
   end

--Asignamos valores unicos de comprobante
if @compr is null
    begin
	set @compr 	= (select cast( isnull(	max(cast(compr as numeric)),0) + 1   as varchar(4) )
			   from movi_contables 
			   where anio=@anio and mes = @mes and  subdia = @subdia )
   end

Declare @registro 	varchar(10)
set @registro 	=  (select right(@anio,1) + @mes + @subdia + replicate('0', 4 - len(@compr)) + @compr)

--Insertamos la 12
Select @cuenta_12 as nro_cuen, codi_clie_prov, serie, nro_docu, total as importe , total_d as importe_d , @ca_12 as cargo_abono , codi_mone, @subdia as subdia , fecha, 
	@registro as registro , @glosa as glosa , @registro as codi_vouc , tipo_cambio, @codi_tipo_docu as codi_tipo_docu, @compr as compr, @hecho_por as hecho_por, @mes as mes, @anio as anio
From #asiento
union
--Insertamos la 40
Select @cuenta_40 as nro_cuen , codi_clie_prov, serie, nro_docu, igv as importe , igv_d as importe_d, @ca_40 as cargo_abono, codi_mone, @subdia as subdia, fecha   , 
	null as registro , @glosa2 as glosa , @registro as codi_vouc , tipo_cambio, @codi_tipo_docu as codi_tipo_docu, @compr as compr, @hecho_por as hecho_por, @mes as mes, @anio as anio
From #asiento
union
--Insertamos la 70
Select @cuenta_70 as nro_cuen , codi_clie_prov, serie, nro_docu, importe as importe , importe_d as importe_d, @ca_70 as cargo_abono , codi_mone, @subdia as subdia, fecha, 
	null as registro , @glosa3 as glosa , @registro as codi_vouc , tipo_cambio, @codi_tipo_docu as codi_tipo_docu, @compr as compr, @hecho_por as hecho_por, @mes as mes, @anio as anio
From #asiento
GO
