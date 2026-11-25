CREATE PROCEDURE [dbo].[usp_cuen_caja]
	@cuenta [char](7),
	@anio [char](4),
	@mesi [char](2),
	@mesf [char](2),
	@fechai [datetime],
	@fechaf [datetime],
	@fech_mes [char](1),
	@prov [char](5),
	@tipo [char](1),
	@unid_oper [char](5),
	@tipo_agru [char](2)
WITH EXECUTE AS CALLER
AS
/*
declare @cuenta char(7), @anio char(4), @mesi char(2), @mesf char(2) , @fechai datetime, @fechaf datetime, @fech_mes char(1), @prov char(5), 
	@tipo char(1) , @unid_oper char(5) , @tipo_agru char(2)
select  @cuenta ='1011118', @anio ='2022', @mesi ='12', @mesf ='12', @fechai ='01/12/2022',
 @fechaf ='31/12/2022', @fech_mes ='M', @prov ='',  @tipo= '1', @unid_oper ='', @tipo_agru ='C'
*/
set nocount on 

Begin
	--declare @tipo_agru char(2) 
	declare @codivouc varchar(10)
	declare @codconta char(10)
	declare @compr char(5)
	declare @codi_mone char(2)
	declare @fecha_comp datetime
	declare @nro_cuen char(7)
	declare @desc_cuen varchar(150)
	declare @codi_clie_prov char(5)
	declare @codi_clie_prov_auxi char(5)
	declare @desc_prov varchar(200)
	declare @codi_unid_oper char(5)
	declare @codi_unid_oper_auxi char(5)
	declare @desc_unid_oper varchar(150)
	declare @serie chaR(5)
	declare @nro_docu chaR(10)
	declare @Codi_Tipo_Docu char(4)
   	declare @Glosa varchar(200)
   	declare @Subdia char(2)
   	declare @Mes_comp char(2)
   	declare @Anio_comp CHAR(4)
   	declare @importe decimal(12,2)
   	declare @Importe_d decimal(12,2)
   	declare @sald_sole decimal(12,2)
   	declare @sald_dola decimal(12,2)
	declare @registro char(10)
	declare @tipo_cambio decimal(9,3)
	declare @banco char(7)
	declare @cargo_abono char(1)
	declare @razo_Soci varchar(150)
	declare @ruc varchar(15)
	declare @direccion varchar(200)
	declare @desc_fami_cuen varchar(200)	
	declare @carg_abon_sald char(1)
	declare @subdia_sald char(1)
	declare @cont integer
	declare @mes char(2)
	declare @ruc_p VARchar(15)

	set @mes = @mesi
	Create table #movi_cont (compr char(6) null, codi_mone char(2) null, fecha datetime null, nro_cuen char(7) null, codi_clie_prov char(5) null, codi_unid_oper char(5) null,
				serie char(5) null, nro_docu char(10) null, codi_tipo_docu char(4) null, glosa varchar(200) null, subdia char(1) null, mes char(2) null, anio char(4) null,
				importe_s decimal(12,2) null, importe_d decimal(12,2) null, registro char(10) null, tipo_camb decimal(9,3) null, banco char(7) null, cargo_abono char(1) null, 
				desc_cuen varchar(200) null, fami_cuen char(7) null, desc_fami_cuen varchar(200) null, desc_prov varchar(200) null, desc_unid_oper varchar(150) null,
				ruc_prov varchar(15) null, codi_contable char(10) null, codi_vouc varchar(10) null)
	if @cuenta <> '' 
	begin
		if len( @cuenta ) = 2 begin Select @desc_fami_cuen = desc_clas_cuen from clases_cuentas (nolock)where codi_clas_cuen = @cuenta end
		if len( @cuenta ) = 3 begin Select @desc_fami_cuen = desc_subc from SUB_CLAS_CUEN (nolock)where codi_subc = @cuenta end
		if len( @cuenta ) = 5 begin Select @desc_fami_cuen = desc_LCC from LINEA_CLASE_C (nolock)where CODI_LCC = @cuenta end
		if len( @cuenta ) = 7 begin Select @desc_fami_cuen = desc_cuen from cuentas_contable(nolock) where nro_cuen = @cuenta end
	end	

	if @tipo_agru = 'C' or @tipo_agru = 'CP' or @tipo_agru = 'CU' 
	begin
		Declare Curs_Carg_cuen cursor for
		Select nro_cuen, desc_cuen, isnull(codi_mone , '01' ) from cuentas_contable (nolock)
		where left( nro_cuen, len(@cuenta) ) = @cuenta
		ORDER BY NRO_CUEN;
	end 

	Open Curs_Carg_cuen ;
	Fetch Curs_Carg_cuen  into @nro_cuen, @desc_cuen, @codi_mone  ;
	while @@fetch_status = 0
	begin
		if @tipo_agru = 'C'
		begin			
			Select @ruc_p = ruc from cliente_proveedor where codi_clie_prov = @prov
			set @desc_prov = ''
			set @desc_prov = ( Select isnull( dbo.F_Cliente_Proveedor( @prov ) , '')  from cliente_proveedor (nolock)where codi_clie_prov = @prov )
			set @desc_unid_oper = (Select isnull( desc_unid_oper , '') from unid_oper(nolock) where codi_unid_oper = @unid_oper )
			set @cont = 0
			set @sald_sole = 0
			set @sald_dola = 0
			set @sald_sole = (Select isnull( dbo.F_sald_cuen_mes_inve( @nro_cuen, @mes , @anio , @fechai, @fech_MES , @tipo, @prov, @unid_oper ) , 0 )
						From Cuentas_contable (nolock)where nro_cuen = @nro_cuen)	
			set @sald_dola = (Select isnull( dbo.F_sald_cuen_mes_inve_dola( @nro_cuen, @mes , @anio , @fechai, @fech_MES , @tipo, @prov, @unid_oper ) , 0 )
						From Cuentas_contable (nolock)where nro_cuen = @nro_cuen)	
			
			------------------------------------- caso 10 soles
			if left(@nro_cuen,2)='10' and @codi_mone='01' set @sald_dola=null
			-------------------------------------------
			IF @codi_mone = '01' 
			begin
				if @sald_sole >= 0 
				begin 
					set @carg_abon_sald = 'C' 
					set @subdia_sald = 'I'
				end 
				else 
				begin 
					set @carg_abon_sald = 'A' 
					set @subdia_sald = 'E' 	
				end 
			end
			else
			begin
				if @sald_dola >= 0 
				begin 
					set @carg_abon_sald = 'C' 
					set @subdia_sald = 'I'
				end 
				else 
				begin 
					set @carg_abon_sald = 'A' 
					set @subdia_sald = 'E' 	
				end 
			end

			insert into #movi_cont(compr, codi_mone, fecha, nro_cuen, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, glosa, subdia, mes, anio,
				importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, codi_contable )
			Values ('' , @codi_mone, @fechai, @nro_cuen, @prov, @unid_oper, '', '', '', 'Saldo Anterior', @subdia_sald, @mes, @anio, 
				abs(@sald_sole), abs(@sald_dola), '', 0, @nro_cuen, @carg_abon_sald, @desc_cuen, @cuenta, @desc_fami_cuen, @desc_prov, @desc_unid_oper, @ruc_p, null )
			IF @fech_mes = 'M' 
			begin
				if @prov = '' 
				begin
					if @unid_oper = ''
					begin
						Declare curs_carg_regi_anal_cuen cursor for
						Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
						         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono , codi_contable, codi_vouc
						From Movi_contables (nolock)
						where anio = @anio and mes >= @mes and mes <= @mesf and left(nro_cuen, len(@nro_cuen)) = @nro_cuen		
					end
				end
			end	

			OPEN curs_carg_regi_anal_cuen;
			fetch curs_carg_regi_anal_cuen into @Compr , @Codi_Mone, @Fecha_comp, @Nro_Cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu,
					          @Codi_Tipo_Docu, @Glosa, @subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono ,@codconta, @codivouc
			while @@fetch_status = 0
			begin
				--set @cont = @cont + 1
				set @desc_prov = ( Select isnull( dbo.F_Cliente_Proveedor( @Codi_Clie_Prov ) , '')  from cliente_proveedor where codi_clie_prov = @Codi_Clie_Prov )
				set @desc_unid_oper =  (Select desc_unid_oper from unid_oper where codi_unid_oper = @Codi_unid_oper )	
				Select @ruc_p = ruc from cliente_proveedor where codi_clie_prov = @Codi_Clie_Prov	
				insert into #movi_cont(compr, codi_mone, fecha, nro_cuen, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, glosa, subdia, mes, anio,
					importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov , codi_contable,
					codi_vouc)
				Values ( @Compr , @codi_mone, @Fecha_comp, @nro_cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu, @Codi_Tipo_Docu, @glosa,
					@subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono, @desc_cuen, @cuenta, 
						@desc_fami_cuen, @desc_prov, @desc_unid_oper, @ruc_p , @codconta, @codivouc)
				
				fetch curs_carg_regi_anal_cuen into @Compr , @Codi_Mone, @Fecha_comp, @Nro_Cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu,
						          @Codi_Tipo_Docu, @Glosa, @subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono, @codconta, @codivouc 
			end
			close curs_carg_regi_anal_cuen;
			deallocate curs_carg_regi_anal_cuen;
			Select @cont = count(nro_cuen) from #movi_cont where nro_cuen = @nro_cuen;
			if @cont = 1 --and (  isnull( @sald_sole , 0) = 0 ) and ( isnull( @sald_dola , 0) = 0 )
			begin
				if (  isnull( @sald_sole , 0) = 0 ) and ( isnull( @sald_dola , 0) = 0 )
				begin
					Delete from #movi_cont where nro_cuen = @nro_cuen;
				end
			end 
		end

		Fetch Curs_Carg_cuen  into @nro_cuen, @desc_cuen, @codi_mone;
	end
	CLOSE Curs_Carg_cuen;
	Deallocate Curs_Carg_cuen;
	IF @tipo_agru = 'C' 
	BEGIN
		Select anio, mes, subdia, compr, codi_contable, codi_vouc, fecha from #movi_cont
		where subdia<>'S'
		--and compr='0047'
		order by nro_cuen, fecha, compr
	END
	
	drop table #movi_cont
End
GO
