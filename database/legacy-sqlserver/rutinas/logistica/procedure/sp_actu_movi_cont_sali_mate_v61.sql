CREATE PROCEDURE [dbo].[sp_actu_movi_cont_sali_mate_v61]
	@MESS [int],
	@AnioS [int],
	@cuen_61 [char](7)
WITH EXECUTE AS CALLER
AS
begin
	declare @cuenta char(7)
	declare @a1 char(10)
	declare @a2 char(8)
	declare @a3 char(7)
	declare @cp char (8)
	declare @uor char (8)
	declare @cant numeric (15,4)
	declare @prec numeric (15,4)
	declare @impo numeric (15,2)
	declare @impo_t numeric (15,2)
	declare @max_cc numeric (12,0)
	declare @max_ccs char(10)
	declare @nc char( 7 )
	declare @nsc char( 7 )
	declare @subd char( 1 )
	declare @FECH datetime
	declare @anio as char(4)
	declare @mes as char(2)
	declare @anioi as integer
	declare @mei as integer
	declare @contin as integer	
	declare @comp as char(4)
	declare @codi_vouc as char(10)
	declare @nro_sub_cuen as char(10)
	declare @nro_cuen_prod_sali as char(10)
	declare @nro_cuen_79 as char(10)
	declare @nro_sub_cuen_79 as char(10)
	declare @csema as char(10)
	declare @MENS as VARchar(100)
	declare @MESauxi as char(2)
	declare @anioauxi as char(4)
	Declare @ck as char(20)
	declare @vive int
	set @mesauxi = cast(@mess as char(2))	
	set @mesauxi = replicate ( '0' , 2 - len( @mesauxi) ) + @mesauxi
	set @anioauxi = cast(@anios as char(4))	
	set @anioauxi = replicate ( '0' , 4 - len( @anioauxi) ) + @anioauxi

	Select @subd = nemotec from subdiario where upper( descrip ) = 'ALMACEN' OR upper( descrip ) = 'ALMACÉN'
	Select @nro_sub_cuen = nro_sub_cuen from cuentas_contable where nro_cuen = @cuenta

	Delete from movi_contables 
	where subdia = @subd and mes = @mesauxi and anio = @anioauxi
		
	Create Table #tabla (codi_docu_sali char(10), codi_prod char(8))
	
	declare CURS1 cursor for select codi_docu_sali , codi_unid_oper_rece, fech_emis, VIVERES from docu_sali_mate 
	WHERE DATEPART(MONTH, FECH_EMIS)  = @MESS and  DATEPART( year , FECH_EMIS)  = @AnioS
	order by FECH_EMIS;
	open CURS1;
	fetch CURS1 into @a1, @uor, @fech, @vive ;
	WHILE @@FETCH_STATUS = 0
	begin
		if @vive <> 1
		begin
			set @impo_t = 0
			set @anioi = datepart( year , @fech) 
			set @anio = cast( @anioi as char(4) )
			set @mes = cast ( datepart( month , @fech)  as char(2) )
			set @mes = replicate ( '0' , 2 - len( @mes) ) + @mes
			
			--Crear 61 a la 26
			Select @max_cc = isnull( max( cast( codi_vouc as integer ) )  , 0  ) from movi_contables where subdia = @subd ;		
			set @codi_vouc = cast ( @max_cc + 1  as char ( 10 ) )
			Set @codi_vouc = replicate( '0', 10 - len (@codi_vouc)  ) + @codi_vouc
			
			
			Select @max_cc = isnull( max( cast( compr as integer ) )  , 0 ) from movi_contables where anio = @anio and mes  = @mes and subdia = @subd ;
			set @comp = cast( @max_cc + 1 as char(4))
			set @csema = 'SM' + cast( cast ( @a1 as numeric(10,0)  ) as char(6) )
	
			Declare Curs_carg_deta_sali cursor for 
			select codi_prod, isnull( cantidad , 0 ) , isnull( prec_prom , 0 ) from detalle_docu_sali
			where codi_docu_sali = @a1 ;
			Open Curs_carg_deta_sali;
			Fetch  Curs_carg_deta_sali into @cp, @cant, @prec;
			WHILE @@FETCH_STATUS = 0
			begin	
				set @impo = 0
				
				Select @prec = prec_prom from kardex 
				where codi_prod = @cp and datepart( month, fech_tran ) = datepart( month, @fech ) and datepart( day, fech_tran ) = datepart( day, @fech )
				and datepart( year, fech_tran ) = datepart( year, @fech ) and i_o = 2 and cast(Codi_Docu_I_O as numeric) = cast( @a1 as numeric)
				
				Select  @nc = nro_cuen From productos where codi_prod = @cp
				Select @cuenta = nro_sub_cuen from cuentas_contable where nro_cuen = @nc
				Select @nro_sub_cuen = nro_sub_cuen from cuentas_contable where nro_cuen = @cuenta
				IF left(@nc, 2) <> '33'
				begin
					set @impo = @cant * @prec
					set @impo_t = @impo_t + @impo
					Select @nsc = nro_sub_cuen from cuentas_contable where nro_cuen = @nc;
					if @cuen_61 <> '' 						
					begin 
						set @nsc = @cuen_61
					end
					Select @max_cc = isnull( max( cast( codi_contable as numeric(12,0) )  ) , 0 )  from movi_contables ;
					Set @max_ccs = cast( @max_cc + 1 as char(10) )
					Set @max_ccs = replicate ('0', 10 - len( @max_cc ) ) + @max_ccs
					Insert Into Movi_Contables (codi_contable, subdia, compr, codi_mone, fecha, nro_cuen, nro_sub_cuen,
					importe, igv, otros, total, importe_d, igv_d, otros_d, total_d, registro, codi_unid_oper,
					glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, NRO_DOCU )
					Values (@max_ccs, @SUBD, @comp, '01', @Fech,  @nc, @nsc, @impo, 0, 0, 0, 0, 0, 0, 0, '', @uor, 
					'Por Consumo de Producto ' + @cp + ' en Consumo Nº ' + @a1 , 'A', @mes, @anio, 0, @codi_vouc, @csema , cast( cast( @a1 as numeric(10,0) )  as  char(10) ) ); 
					
					Select @max_cc = isnull( max( cast( codi_contable as numeric(12,0) )  ) , 0 )  from movi_contables ;
					Set @max_ccs = cast( @max_cc + 1 as char(10) )
					Set @max_ccs = replicate ('0', 10 - len( @max_cc ) )  + @max_ccs
					Insert Into Movi_Contables (codi_contable, subdia, compr, codi_mone, fecha, nro_cuen, nro_sub_cuen,
					importe, igv, otros, total, importe_d, igv_d, otros_d, total_d, registro, codi_unid_oper,
					glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_docu )		
					Values (@max_ccs, @SUBD, @comp, '01', @Fech,  @cuenta, @nro_sub_cuen , @impo, 0, 0, 0, 
					0, 0, 0, 0, '', @uor, 'Por Consumo de Producto ' + @cp + ' en Consumo Nº ' + @a1  , 'C', @mes, @anio, 0, @codi_vouc, @csema  , cast( cast( @a1 as numeric(10,0) )  as  char(10) ) ); 
	
				end
/*				else
				begin
					set @impo = @cant * @prec
					set @impo_t = @impo_t + @impo
					Select @nsc = nro_sub_cuen from cuentas_contable where nro_cuen = @nc;
					if @cuen_61 <> '' 						
					begin 
						set @nsc = @cuen_61
					end
					Select @max_cc = isnull( max( cast( codi_contable as numeric(12,0) )  ) , 0 )  from movi_contables ;
					Set @max_ccs = cast( @max_cc + 1 as char(10) )
					Set @max_ccs = replicate ('0', 10 - len( @max_cc ) ) + @max_ccs
					Insert Into Movi_Contables (codi_contable, subdia, compr, codi_mone, fecha, nro_cuen, nro_sub_cuen,
					importe, igv, otros, total, importe_d, igv_d, otros_d, total_d, registro, codi_unid_oper,
					glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, NRO_DOCU )
					Values (@max_ccs, @SUBD, @comp, '01', @Fech,  @nc, @nsc, @impo, 0, 0, 0, 0, 0, 0, 0, '', @uor, 
					'Por Consumo de Producto ' + @cp + ' en Consumo Nº ' + @a1 , 'A', @mes, @anio, 0, @codi_vouc, @csema , cast( cast( @a1 as numeric(10,0) )  as  char(10) ) ); 
					
					Select @max_cc = isnull( max( cast( codi_contable as numeric(12,0) )  ) , 0 )  from movi_contables ;
					Set @max_ccs = cast( @max_cc + 1 as char(10) )
					Set @max_ccs = replicate ('0', 10 - len( @max_cc ) )  + @max_ccs
					Insert Into Movi_Contables (codi_contable, subdia, compr, codi_mone, fecha, nro_cuen, nro_sub_cuen,
					importe, igv, otros, total, importe_d, igv_d, otros_d, total_d, registro, codi_unid_oper,
					glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_docu )		
					Values (@max_ccs, @SUBD, @comp, '01', @Fech,  @cuenta, @nro_sub_cuen , @impo, 0, 0, 0, 
					0, 0, 0, 0, '', @uor, 'Por Consumo de Producto ' + @cp + ' en Consumo Nº ' + @a1  , 'C', @mes, @anio, 0, @codi_vouc, @csema  , cast( cast( @a1 as numeric(10,0) )  as  char(10) ) ); 
	
				end*/
				Fetch  Curs_carg_deta_sali into @cp, @cant, @prec;
			end
			Close Curs_carg_deta_sali;
			Deallocate Curs_carg_deta_sali;
	
			--Fin 61 a la 26

			-- Crear 9 a la 79		
			set @impo_t = 0
			Select @max_cc = isnull( max( cast( codi_vouc as integer ) )  , 0  ) from movi_contables where subdia = @subd ;		
			set @codi_vouc = cast ( @max_cc + 1  as char ( 10 ) )
			Set @codi_vouc = replicate( '0', 10 - len (@codi_vouc)  ) + @codi_vouc		
			Select @max_cc = isnull( max( cast( compr as integer ) )  , 0 ) from movi_contables where anio = @anio and mes  = @mes and subdia = @subd ;
			set @comp = cast( @max_cc + 1 as char(4))
			set @csema = 'SM' + cast( cast ( @a1 as numeric(10,0)  ) as char(6) )
			
			Select @nro_cuen_79 = min(nro_cuen) From cuentas_contable where left(nro_cuen, 2) = '79'
			Select @nro_sub_cuen_79 = nro_sub_cuen from cuentas_contable where nro_cuen = @nro_cuen_79
			
			Declare Curs_carg_deta_sali_2 cursor for 
			select codi_prod, isnull( cantidad , 0 ) , isnull( prec_prom , 0 ) , nro_cuen from detalle_docu_sali
			where codi_docu_sali = @a1 ;
			Open Curs_carg_deta_sali_2;
			Fetch  Curs_carg_deta_sali_2 into @cp, @cant, @prec, @nc;
			WHILE @@FETCH_STATUS = 0
			begin	
				set @impo = 0
				
				Select @prec = prec_prom from kardex 
				where codi_prod = @cp and datepart( month, fech_tran ) = datepart( month, @fech ) and datepart( day, fech_tran ) = datepart( day, @fech )
				and datepart( year, fech_tran ) = datepart( year, @fech ) and i_o = 2 and cast(Codi_Docu_I_O as numeric) = cast( @a1 as numeric)
				--where codi_kard = @ck
				
				--Select @prec = prec_prom from kardex where codi_kard = @ck
	
				Select @nro_cuen_prod_sali =  nro_cuen from productos where codi_prod = @cp;
				if left( @nro_cuen_prod_sali , 2 ) <> '33'
				begin
					set @impo = @cant * @prec
					set @impo_t = @impo_t + @impo			
					Select @nsc = nro_sub_cuen from cuentas_contable where nro_cuen = @nc
					Select @max_cc = isnull( max( cast( codi_contable as numeric(12,0) )  ) , 0 )  from movi_contables ;
					Set @max_ccs = cast( @max_cc + 1 as char(10) )
					Set @max_ccs = replicate ('0', 10 - len( @max_cc ) )  + @max_ccs
					Insert Into Movi_Contables (codi_contable, subdia, compr, codi_mone, fecha, nro_cuen, nro_sub_cuen,
					importe, igv, otros, total, importe_d, igv_d, otros_d, total_d, registro, codi_unid_oper,
					glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_docu)
					Values (@max_ccs, @SUBD, @comp, '01', @Fech,  @nc, @nsc, @impo, 0, 0, 0, 0, 0, 0, 0, '', @uor, 
					'Por Consumo de Producto ' + @cp + ' en Consumo Nº ' + @a1 , 'C', @mes, @anio, 0, @codi_vouc, @csema  , cast( cast( @a1 as numeric(10,0) )  as  char(10) ) ); 
		
		/*			set @contin = (Select count(codi_contable ) From Movi_contables where codi_contable = @max_ccs)
					if @contin <= 0 
					begin
						Insert Into #tabla ( codi_docu_sali , codi_prod ) values (@a1, @cp )
					end*/
				end	
				
				Fetch  Curs_carg_deta_sali_2 into @cp, @cant, @prec, @nc;
			end
			Close Curs_carg_deta_sali_2;
			Deallocate Curs_carg_deta_sali_2;
			IF @impo_t <> 0
			begin	
				Select @max_cc = isnull( max( cast( codi_contable as numeric(12,0) )  ) , 0 )  from movi_contables ;
				Set @max_ccs = cast( @max_cc + 1 as char(10) )
				Set @max_ccs = replicate ('0', 10 - len( @max_cc ) )  + @max_ccs
				Insert Into Movi_Contables (codi_contable, subdia, compr, codi_mone, fecha, nro_cuen, nro_sub_cuen,
				importe, igv, otros, total, importe_d, igv_d, otros_d, total_d, registro, codi_unid_oper,
				glosa, cargo_abono, mes, anio, tipo_cambio, codi_vouc, codi_sema, nro_docu)
				Values (@max_ccs, @SUBD, @comp, '01', @Fech,  @nro_cuen_79, @nro_sub_cuen_79 , @impo_t, 0, 0, 0, 		
				0, 0, 0, 0, '', @uor, 'Por Consumo Nº ' + @a1 , 'A', @mes, @anio, 0, @codi_vouc, @csema  , cast( cast( @a1 as numeric(10,0) )  as  char(10) )  ); 
			end
			--Fin 9 a la 79
		end
		fetch CURS1 into @a1, @uor, @fech, @vive ;
	end
	close CURS1;
	deallocate CURS1;
end

Select * from #tabla
GO
