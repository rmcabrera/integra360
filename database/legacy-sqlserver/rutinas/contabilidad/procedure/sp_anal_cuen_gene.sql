CREATE PROCEDURE [dbo].[sp_anal_cuen_gene]
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
/*declare @cuenta char(7), @anio char(4), @mesi char(2), @mesf char(2) , @fechai datetime, @fechaf datetime, @fech_mes char(1), @prov char(5), 
	@tipo char(1) , @unid_oper char(5) , @tipo_agru char(2)
select  @cuenta ='1011116', @anio ='2012', @mesi ='01', @mesf ='12', @fechai ='01/01/2012',
	 @fechaf ='30/09/2012', @fech_mes ='M', @prov ='',  @tipo= '1', @unid_oper ='', @tipo_agru ='C'
*/
set nocount on 

Begin
	--declare @tipo_agru char(2) 
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
				ruc_prov varchar(15) null )
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
	if @tipo_agru = 'PC' 
	begin
		Declare Curs_Carg_cuen cursor for
		Select nro_cuen, desc_cuen, isnull(codi_mone , '01' ) from cuentas_contable(nolock)
		where nro_cuen in (Select distinct nro_cuen from movi_contables where codi_clie_prov = @prov )
		ORDER BY NRO_CUEN;
	end 
	if @tipo_agru = 'UC' 
	begin
		Declare Curs_Carg_cuen cursor for
		Select nro_cuen, desc_cuen, isnull(codi_mone , '01' ) from cuentas_contable(nolock)
		where nro_cuen in (Select distinct nro_cuen from movi_contables where codi_UNID_oper = @unid_oper )
		ORDER BY NRO_CUEN;
	end 
	if @tipo_agru = 'RC' 
	begin
		Select @ruc_p = ruc from cliente_proveedor where codi_clie_prov = @prov
		Declare Curs_Carg_cuen cursor for
		Select nro_cuen, desc_cuen, isnull(codi_mone , '01' ) from cuentas_contable(nolock)
		where nro_cuen in (Select distinct nro_cuen from movi_contables 
					where codi_clie_prov  in ( Select  codi_clie_prov From cliente_proveedor(nolock) where ruc = @ruc_p ) )
		ORDER BY NRO_CUEN;
	end 
	if @tipo_agru = 'CR' 
	begin
		Select @ruc_p = ruc from cliente_proveedor(nolock) where codi_clie_prov = @prov
		Declare Curs_Carg_cuen cursor for
		Select nro_cuen, desc_cuen, isnull(codi_mone , '01' ) from cuentas_contable(nolock)
		where left( nro_cuen, len(@cuenta) ) = @cuenta and nro_cuen in (Select distinct nro_cuen from movi_contables (nolock)
					where codi_clie_prov  in ( Select  codi_clie_prov From cliente_proveedor(nolock) where ruc = @ruc_p ) )
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
				importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov )
			Values ('' , @codi_mone, @fechai, @nro_cuen, @prov, @unid_oper, '', '', '', 'Saldo Anterior', @subdia_sald, @mes, @anio, 
				abs(@sald_sole), abs(@sald_dola), '', 0, @nro_cuen, @carg_abon_sald, @desc_cuen, @cuenta, @desc_fami_cuen, @desc_prov, @desc_unid_oper, @ruc_p )
			IF @fech_mes = 'M' 
			begin
				if @prov = '' 
				begin
					if @unid_oper = ''
					begin
						Declare curs_carg_regi_anal_cuen cursor for
						Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
						         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
						From Movi_contables (nolock)
						where anio = @anio and mes >= @mes and mes <= @mesf and left(nro_cuen, len(@nro_cuen)) = @nro_cuen		
					end
					else
					begin
						Declare curs_carg_regi_anal_cuen cursor for
						Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
						         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
						From Movi_contables (nolock)
						where anio = @anio  and mes >= @mes and mes <= @mesf and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_unid_oper = @unid_oper			
					end
				end
				else
				begin
					if @unid_oper = ''
					begin
						Declare curs_carg_regi_anal_cuen cursor for
						Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
						         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
						From Movi_contables (nolock)
						where anio = @anio and mes >= @mes and mes <= @mesf and left(nro_cuen, len(@nro_cuen)) = @nro_cuen and codi_clie_prov = @prov	
					end
					else
					begin
						Declare curs_carg_regi_anal_cuen cursor for
						Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
						         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
						From Movi_contables (nolock)
						where anio = @anio and mes >= @mes and mes <= @mesf and left(nro_cuen, len(@nro_cuen)) = @nro_cuen and codi_clie_prov = @prov 
						and codi_unid_oper = @unid_oper
					end
				end
			end	
			IF @fech_mes = 'F' 
			begin
				if @prov = '' 
				begin
					if @unid_oper = ''
					begin
						IF @TIPO = 1
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen
						end
						else
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen and anio <= @anio 
						end
					end
					else
					begin
						IF @TIPO = 1
						begin					
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen
							and codi_unid_oper = @unid_oper
						end
						else
						begin					
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen
							and codi_unid_oper = @unid_oper and anio <= @anio 
						end
					end	
				end
				else
				begin
					if @unid_oper = ''
					begin
						if @tipo = 1
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_clie_prov = @prov
						end
						else
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_clie_prov = @prov  and anio <= @anio 
						end
					END
					else
					begin
						if @tipo = 1
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_clie_prov = @prov and codi_unid_oper = @unid_oper
						end
						else
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_clie_prov = @prov and codi_unid_oper = @unid_oper and anio <= @anio 
						end
					end			
				end
			end
			OPEN curs_carg_regi_anal_cuen;
			fetch curs_carg_regi_anal_cuen into @Compr , @Codi_Mone, @Fecha_comp, @Nro_Cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu,
					          @Codi_Tipo_Docu, @Glosa, @subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono 
			while @@fetch_status = 0
			begin
				--set @cont = @cont + 1
				set @desc_prov = ( Select isnull( dbo.F_Cliente_Proveedor( @Codi_Clie_Prov ) , '')  from cliente_proveedor where codi_clie_prov = @Codi_Clie_Prov )
				set @desc_unid_oper =  (Select desc_unid_oper from unid_oper where codi_unid_oper = @Codi_unid_oper )	
				Select @ruc_p = ruc from cliente_proveedor where codi_clie_prov = @Codi_Clie_Prov	
				insert into #movi_cont(compr, codi_mone, fecha, nro_cuen, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, glosa, subdia, mes, anio,
					importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov )
				Values ( @Compr , @codi_mone, @Fecha_comp, @nro_cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu, @Codi_Tipo_Docu, @glosa,
					@subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono, @desc_cuen, @cuenta, 
						@desc_fami_cuen, @desc_prov, @desc_unid_oper, @ruc_p )
				
				fetch curs_carg_regi_anal_cuen into @Compr , @Codi_Mone, @Fecha_comp, @Nro_Cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu,
						          @Codi_Tipo_Docu, @Glosa, @subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono 
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
		if @tipo_agru = 'CP'  or @tipo_agru = 'PC'  or @tipo_agru = 'RC'  or @tipo_agru = 'CR' 
		begin
			if @prov = ''
			begin
				Declare curs_carg_prov_x_cuen cursor for
				Select distinct codi_clie_prov from movi_contables(nolock) where nro_cuen = @nro_cuen;
			end
			else
			begin
				if @tipo_agru = 'RC'  or @tipo_agru = 'CR' 
				begin
					Select @ruc_p = ruc from cliente_proveedor(nolock) where codi_clie_prov = @Codi_Clie_Prov
					Declare curs_carg_prov_x_cuen cursor for
					Select distinct codi_clie_prov from movi_contables (nolock)where nro_cuen = @nro_cuen 
					and codi_clie_prov in ( Select codi_clie_prov from cliente_proveedor (nolock)where ruc = @ruc_p );
				end
				else
				begin
					Declare curs_carg_prov_x_cuen cursor for
					Select distinct codi_clie_prov from movi_contables(nolock) where nro_cuen = @nro_cuen and codi_clie_prov = @prov;
				end
			end		
			open curs_carg_prov_x_cuen ;
			fetch curs_carg_prov_x_cuen into @codi_clie_prov_auxi
			while @@fetch_status = 0
			begin
				set @desc_prov = ''
				set @desc_prov = ( Select isnull( dbo.F_Cliente_Proveedor( @codi_clie_prov_auxi ) , '')  from cliente_proveedor (nolock)where codi_clie_prov = @codi_clie_prov_auxi )
				set @desc_unid_oper = (Select isnull( desc_unid_oper , '') from unid_oper (nolock)where codi_unid_oper = @unid_oper )
				Select @ruc_p = ruc from cliente_proveedor (nolock)where codi_clie_prov = @Codi_Clie_Prov
--				PRINT @codi_clie_prov_auxi
--				PRINT @desc_prov
--				PRINT @ruc_p
				set @cont = 0
				set @sald_sole = 0
				set @sald_dola = 0
				set @sald_sole = (Select isnull( dbo.F_sald_cuen_mes_inve( @nro_cuen, @mes , @anio , @fechai, @fech_MES , @tipo, @codi_clie_prov_auxi, @unid_oper ) , 0 )
							From Cuentas_contable (nolock)where nro_cuen = @nro_cuen )

				set @sald_dola = (Select isnull( dbo.F_sald_cuen_mes_inve_dola( @nro_cuen, @mes , @anio , @fechai, @fech_MES , @tipo, @codi_clie_prov_auxi, @unid_oper ) , 0 )
							From Cuentas_contable (nolock)where nro_cuen = @nro_cuen )

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
				insert into #movi_cont(compr, codi_mone, fecha, nro_cuen, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, glosa, subdia, mes, anio,
					importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov )
				Values ('' , @codi_mone, @fechai, @nro_cuen, @codi_clie_prov_auxi, @unid_oper, '', '', '', 'Saldo Anterior', @subdia_sald, @mes, @anio, 
					abs(@sald_sole), abs(@sald_dola), '', 0, @nro_cuen, @carg_abon_sald, @desc_cuen, @cuenta, @desc_fami_cuen, @desc_prov, @desc_unid_oper, @ruc_p )
				IF @fech_mes = 'M'
				begin
					begin
						if @unid_oper = ''
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and mes >= @mes and mes <= @mesf and left(nro_cuen, len(@nro_cuen)) = @nro_cuen and codi_clie_prov = @codi_clie_prov_auxi
						end
						else
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and mes >= @mes and mes <= @mesf and left(nro_cuen, len(@nro_cuen)) = @nro_cuen and codi_clie_prov = @codi_clie_prov_auxi 
							and codi_unid_oper = @unid_oper
						end
					end
				end	
				IF @fech_mes = 'F' 
				begin
					if @unid_oper = ''
					begin
						if @tipo = 1
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_clie_prov = @codi_clie_prov_auxi
						end
						else
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_clie_prov = @codi_clie_prov_auxi  and anio <= @anio 
						end
					END
					else
					begin
						if @tipo = 1
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_clie_prov = @codi_clie_prov_auxi and codi_unid_oper = @unid_oper
						end
						else
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_clie_prov = @codi_clie_prov_auxi and codi_unid_oper = @unid_oper and anio <= @anio 
						end
					end			
				end
				OPEN curs_carg_regi_anal_cuen;
				fetch curs_carg_regi_anal_cuen into @Compr , @Codi_Mone, @Fecha_comp, @Nro_Cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu,
						          @Codi_Tipo_Docu, @Glosa, @subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono 
				while @@fetch_status = 0
				begin
					--set @cont = @cont + 1
					set @desc_prov = ( Select isnull( dbo.F_Cliente_Proveedor( @Codi_Clie_Prov ) , '')  from cliente_proveedor(nolock) where codi_clie_prov = @Codi_Clie_Prov )
					set @desc_unid_oper =  (Select desc_unid_oper from unid_oper (nolock)where codi_unid_oper = @Codi_unid_oper )	
					Select @ruc_p = ruc from cliente_proveedor (nolock)where codi_clie_prov = @Codi_Clie_Prov
					insert into #movi_cont(compr, codi_mone, fecha, nro_cuen, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, glosa, subdia, mes, anio,
						importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov )
					Values ( @Compr , @codi_mone, @Fecha_comp, @nro_cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu, @Codi_Tipo_Docu, @glosa,
						@subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono, @desc_cuen, @cuenta, 
							@desc_fami_cuen, @desc_prov, @desc_unid_oper, @ruc_p )
					
					fetch curs_carg_regi_anal_cuen into @Compr , @Codi_Mone, @Fecha_comp, @Nro_Cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu,
							          @Codi_Tipo_Docu, @Glosa, @subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono 
				end
				close curs_carg_regi_anal_cuen;
				deallocate curs_carg_regi_anal_cuen;
				Select @cont = count(nro_cuen) from #movi_cont where nro_cuen = @nro_cuen AND codi_clie_prov = @codi_clie_prov_auxi;
				if @cont = 1 --and (  isnull( @sald_sole , 0) = 0 ) and ( isnull( @sald_dola , 0) = 0 )
				begin
					if (  isnull( @sald_sole , 0) = 0 ) and ( isnull( @sald_dola , 0) = 0 )
					begin
						Delete from #movi_cont where nro_cuen = @nro_cuen AND codi_clie_prov = @codi_clie_prov_auxi;
					end
				end 				
				fetch curs_carg_prov_x_cuen into @codi_clie_prov_auxi
			end
			CLOSE curs_carg_prov_x_cuen ;
			Deallocate curs_carg_prov_x_cuen ;
		end
		if @tipo_agru = 'CU'  or @tipo_agru = 'UC' 
		begin
			if @unid_oper = ''
			begin
				Declare curs_carg_uo_x_cuen cursor for
				Select distinct codi_unid_oper from movi_contables (nolock)where nro_cuen = @nro_cuen;
			end
			else
			begin
				Declare curs_carg_uo_x_cuen cursor for
				Select distinct codi_unid_oper from movi_contables (nolock) where nro_cuen = @nro_cuen and codi_unid_oper = @unid_oper;
			end		
			open curs_carg_uo_x_cuen ;
			fetch curs_carg_uo_x_cuen into @codi_unid_oper_auxi
			while @@fetch_status = 0
			begin
				set @desc_prov = ''
				set @desc_prov = ( Select isnull( dbo.F_Cliente_Proveedor( @prov ) , '')  from cliente_proveedor (nolock)where codi_clie_prov = @prov )
				set @desc_unid_oper = (Select isnull( desc_unid_oper , '') from unid_oper (nolock)where codi_unid_oper = @codi_unid_oper_auxi )
				set @cont = 0
				set @sald_sole = 0
				set @sald_dola = 0
				set @sald_sole = (Select isnull( dbo.F_sald_cuen_mes_inve( @nro_cuen, @mes , @anio , @fechai, @fech_MES , @tipo, @prov, @codi_unid_oper_auxi ) , 0 )
							From Cuentas_contable(nolock) where nro_cuen = @nro_cuen)	
				set @sald_dola = (Select isnull( dbo.F_sald_cuen_mes_inve_dola( @nro_cuen, @mes , @anio , @fechai, @fech_MES , @tipo, @prov, @codi_unid_oper_auxi ) , 0 )
							From Cuentas_contable(nolock) where nro_cuen = @nro_cuen)	
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
				insert into #movi_cont(compr, codi_mone, fecha, nro_cuen, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, glosa, subdia, mes, anio,
					importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper )
				Values ('' , @codi_mone, @fechai, @nro_cuen, @prov, @codi_unid_oper_auxi, '', '', '', 'Saldo Anterior', @subdia_sald, @mes, @anio, 
					abs(@sald_sole), abs(@sald_dola), '', 0, @nro_cuen, @carg_abon_sald, @desc_cuen, @cuenta, @desc_fami_cuen, @desc_prov, @desc_unid_oper )
				IF @fech_mes = 'M' 
				begin
					begin
						if @PROV = ''
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and mes >= @mes and mes <= @mesf and left(nro_cuen, len(@nro_cuen)) = @nro_cuen and codi_unid_oper = @codi_unid_oper_auxi
						end
						else
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and mes >= @mes and mes <= @mesf and left(nro_cuen, len(@nro_cuen)) = @nro_cuen and codi_clie_prov = @PROV 
							and codi_unid_oper = @codi_unid_oper_auxi
						end
					end
				end	
				IF @fech_mes = 'F' 
				begin
					if @prov = ''
					begin
						if @tipo = 1
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_unid_oper = @codi_unid_oper_auxi
						end
						else
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_unid_oper = @codi_unid_oper_auxi  and anio <= @anio 
						end
					END
					else
					begin
						if @tipo = 1
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where anio = @anio and fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_clie_prov = @prov and codi_unid_oper = @codi_unid_oper_auxi
						end
						else
						begin
							Declare curs_carg_regi_anal_cuen cursor for
							Select Compr , Codi_Mone, Fecha, Nro_Cuen, Codi_Clie_Prov, Codi_unid_oper, Serie, Nro_Docu, Codi_Tipo_Docu, Glosa, subdia , Mes,
							         Anio, Importe, Importe_d, registro, tipo_cambio, banco, Cargo_Abono 
							From Movi_contables(nolock)
							where fecha >= @fechai and fecha < dateadd(day, 1, @fechaf) and left(nro_cuen, len(@nro_cuen)) = @nro_cuen 
							and codi_clie_prov = @prov and codi_unid_oper = @codi_unid_oper_auxi and anio <= @anio 
						end
					end			
			end
				OPEN curs_carg_regi_anal_cuen;
				fetch curs_carg_regi_anal_cuen into @Compr , @Codi_Mone, @Fecha_comp, @Nro_Cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu,
						          @Codi_Tipo_Docu, @Glosa, @subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono 
				while @@fetch_status = 0
				begin
					--set @cont = @cont + 1
					set @desc_prov = ( Select isnull( dbo.F_Cliente_Proveedor( @Codi_Clie_Prov ) , '')  from cliente_proveedor (nolock)where codi_clie_prov = @Codi_Clie_Prov )
					set @desc_unid_oper =  (Select desc_unid_oper from unid_oper(nolock) where codi_unid_oper = @Codi_unid_oper )	
					Select @ruc_p = ruc from cliente_proveedor (nolock) where codi_clie_prov = @Codi_Clie_Prov
		
					insert into #movi_cont(compr, codi_mone, fecha, nro_cuen, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, glosa, subdia, mes, anio,
						importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov )
					Values ( @Compr , @codi_mone, @Fecha_comp, @nro_cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu, @Codi_Tipo_Docu, @glosa,
						@subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono, @desc_cuen, @cuenta, 
							@desc_fami_cuen, @desc_prov, @desc_unid_oper, @ruc_p )
					
					fetch curs_carg_regi_anal_cuen into @Compr , @Codi_Mone, @Fecha_comp, @Nro_Cuen, @Codi_Clie_Prov, @Codi_unid_oper, @Serie, @Nro_Docu,
							          @Codi_Tipo_Docu, @Glosa, @subdia, @Mes_comp, @Anio_comp, @Importe, @Importe_d, @registro, @tipo_cambio, @banco, @Cargo_Abono 
				end
				close curs_carg_regi_anal_cuen;
				deallocate curs_carg_regi_anal_cuen;
				Select @cont = count(nro_cuen) from #movi_cont where nro_cuen = @nro_cuen AND codi_unid_oper = @codi_unid_oper_auxi;
				if @cont = 1 --and (  isnull( @sald_sole , 0) = 0 ) and ( isnull( @sald_dola , 0) = 0 )
				begin
					if (  isnull( @sald_sole , 0) = 0 ) and ( isnull( @sald_dola , 0) = 0 )
					begin
						Delete from #movi_cont where nro_cuen = @nro_cuen AND codi_unid_oper = @codi_unid_oper_auxi;
					end
				end 				
				fetch curs_carg_uo_x_cuen into @codi_unid_oper_auxi
			end
			CLOSE curs_carg_uo_x_cuen ;
			Deallocate curs_carg_uo_x_cuen ;
		end
		Fetch Curs_Carg_cuen  into @nro_cuen, @desc_cuen, @codi_mone;
	end
	CLOSE Curs_Carg_cuen;
	Deallocate Curs_Carg_cuen;
	IF @tipo_agru = 'C' 
	BEGIN
		Select * from #movi_cont
		order by nro_cuen, fecha, compr
	END
	IF @tipo_agru = 'CP'  or @tipo_agru = 'PC' 
	BEGIN
		Select * from #movi_cont
		order by nro_cuen, desc_prov, codi_clie_prov, fecha, compr
	END
	IF @tipo_agru = 'RC'  or @tipo_agru = 'CR'  
	BEGIN
		Select * from #movi_cont
		order by nro_cuen, ruc_prov, desc_prov, codi_clie_prov, fecha, compr
	END
	IF @tipo_agru = 'CU'  or @tipo_agru = 'UC' 
	BEGIN
		Select * from #movi_cont
		order by nro_cuen, desc_unid_oper, codi_unid_oper, fecha, compr
	END
	
	drop table #movi_cont
End
GO
