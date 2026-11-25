CREATE PROCEDURE [dbo].[sp_repo_libr_inve_bala]
	@anio [char](4),
	@indi [char](2),
	@fech_maxi [datetime]
WITH EXECUTE AS CALLER
AS
begin
	Declare @codi_cc char(2)
	Declare @nc char(7)
	Declare @ta char(2)
	Declare @mes char(2)
	Declare @mes_f char(2)
	Declare @desc_cuen varchar(200)
	Declare @nro_docu char(15)
	Declare @compr char(10)
	Declare @subdia char(1)
	Declare @glosa varchar(200)
	Declare @razo_soci_cp varchar(200)
	Declare @fecha datetime
	Declare @codi_clie_prov char(5)
	Declare @carg_abon char(1)
	Declare @mone char(2)
	Declare @regi char(15)
	Declare @ruc char(15)
	Declare @sum_carg decimal(15,2)
	Declare @sum_abon decimal(15,2)
	Declare @sum_cargd decimal(15,2)
	Declare @sum_abond decimal(15,2)
	Declare @impo_c decimal(15,2)
	Declare @impo_a decimal(15,2)
	Declare @impo_cd decimal(15,2)
	Declare @impo_ad decimal(15,2)
	Declare @impo decimal(15,2)
	Declare @impo_d decimal(15,2)		
	IF datepart( month , @fech_maxi) < 10 Begin set @MES_F = '0' + CAST ( datepart( month , @fech_maxi) as char ) end
	IF datepart( month , @fech_maxi) >= 10 Begin Set @MES_F = CAST ( datepart( month , @fech_maxi) as char ) end

	Create table #libr_inve_bala ( nro_cuen char(7), desc_cuen varchar(250), codi_prov char (5) null , ruc char (15) null , prov varchar (250) null , fech_docu datetime null ,
		nro_docu char (15) null , impo_carg decimal(18,2) null ,  impo_abon decimal(18,2) null, impo_cargd decimal(18,2) null,  impo_abond decimal(18,2) null, 
		concepto varchar (250) null , fecha datetime null , mes char(2)  null , codi_mone char(2) null  , tfm char (2) ) ;

	Declare Curs_carg_nro_cuen cursor for
	Select codi_clas_cuen, tipo_form_most from tipo_form_most_eeff
	where codi_tipo_eeff = '01'
	order by codi_clas_cuen;	
	Open Curs_carg_nro_cuen;
	FETCH Curs_carg_nro_cuen into @codi_cc, @ta;
	while @@fetch_status = 0
	begin
		Declare curs_carg_cuen_movi_cont cursor for 
		Select distinct nro_cuen From movi_contables
		where left( nro_cuen , 2 ) = @codi_cc
		order by nro_cuen;
		Open curs_carg_cuen_movi_cont;
		Fetch curs_carg_cuen_movi_cont into @nc;
		while @@fetch_status = 0
		begin
/*			print @nc 
			print @ta
			print @indi */
			Select @desc_cuen = desc_cuen from cuentas_contable where nro_cuen = @nc
			if @ta = 'A' 
			begin			
				if @indi = 'M' 
				begin
					select @sum_carg = isnull( sum ( isnull( importe ,0 ) ) , 0 ), @sum_cargd = isnull( sum ( isnull( importe_d ,0 ) ) , 0 )
					from movi_contables, cuentas_contable
					where  movi_contables.nro_cuen=cuentas_contable.nro_cuen and cargo_abono = 'C' 
						and  anio = @anio and cuentas_contable.nro_cuen = @nc and cast ( mes as integer ) <= datepart(month, @fech_maxi)
					select @sum_abon = isnull( sum ( isnull( importe ,0 ) ) , 0 ), @sum_abond = isnull( sum ( isnull( importe_d ,0 ) ) , 0 )
					from movi_contables, cuentas_contable
					where  movi_contables.nro_cuen=cuentas_contable.nro_cuen and cargo_abono = 'A' 
						and  anio = @anio and cuentas_contable.nro_cuen = @nc and cast ( mes as integer ) <= datepart(month, @fech_maxi)
					
				end
				if @indi = 'F' 
				begin
					select @sum_carg = isnull( sum ( isnull( importe ,0 ) ) , 0 ), @sum_cargd = isnull( sum ( isnull( importe_d ,0 ) ) , 0 )
					from movi_contables, cuentas_contable
					where  movi_contables.nro_cuen=cuentas_contable.nro_cuen and cargo_abono = 'C' 
						and  anio = @anio and cuentas_contable.nro_cuen = @nc and fecha < dateadd(day , 1,  @fech_maxi)
					select @sum_abon = isnull( sum ( isnull( importe ,0 ) ) , 0 ), @sum_abond = isnull( sum ( isnull( importe_d ,0 ) ) , 0 )
					from movi_contables, cuentas_contable
					where  movi_contables.nro_cuen=cuentas_contable.nro_cuen and cargo_abono = 'A' 
						and  anio = @anio and cuentas_contable.nro_cuen = @nc and fecha < dateadd(day , 1,  @fech_maxi)
				end
				if @indi = 'A' 
				begin
					select @sum_carg = isnull( sum ( isnull( importe ,0 ) ) , 0 ), @sum_cargd = isnull( sum ( isnull( importe_d ,0 ) ) , 0 )
					from movi_contables, cuentas_contable
					where  movi_contables.nro_cuen=cuentas_contable.nro_cuen and cargo_abono = 'C' 
						and  anio = @anio and cuentas_contable.nro_cuen = @nc and SUBDIA = 'S'
					select @sum_abon = isnull( sum ( isnull( importe ,0 ) ) , 0 ), @sum_abond = isnull( sum ( isnull( importe_d ,0 ) ) , 0 )
					from movi_contables, cuentas_contable
					where  movi_contables.nro_cuen=cuentas_contable.nro_cuen and cargo_abono = 'A' 
						and  anio = @anio and cuentas_contable.nro_cuen = @nc and  SUBDIA = 'S'
				end
				if isnull(@sum_carg , 0 ) >= isnull( @sum_abon  , 0 )
				begin
					set @impo_c = @sum_carg - @sum_abon
					set @impo_a = 0
				end
				else
				begin	
					set @impo_c = 0
					set @impo_a = @sum_abon - @sum_carg 
				end
				if @sum_cargd >= @sum_abond
				begin
					set @impo_cd = @sum_cargd - @sum_abond
					set @impo_ad = 0
				end
				else
				begin	
					set @impo_cd = 0
					set @impo_ad = @sum_abon - @sum_carg 
				end				
				Insert Into  #libr_inve_bala ( nro_cuen, desc_cuen, codi_prov, ruc, prov, fech_docu, nro_docu, impo_carg,  impo_abon, impo_cargd,  impo_abond, 
					concepto, fecha, mes, codi_mone, tfm)
				Values (@nc, @desc_cuen, '', '', '', '', '', @impo_c, @impo_a, @impo_cd, @impo_ad, '', @fech_maxi, @MES_f , '01', @ta)
			end
			if @ta = 'D' 
			begin		
				if @indi = 'M'	
				begin
					Declare curs_carg_deta Cursor for
					Select codi_clie_prov,Imp , ImpD, Fs, Registro, nro_cuen, desc_cuen, nro_docu, compr, glosa, subdia, mes, codi_mone 
					From ( 	
						select Est.codi_clie_prov,Imp , ImpD, Fs, Est.Registro, Est.nro_cuen, desc_cuen, nro_docu,compr, glosa, subdia, mes, Sg.codi_mone 
						from					
						(select max(fecha) as Fs, codi_clie_prov, isnull( sum(importe) , 0 ) as Imp , isnull( sum(importe_d) , 0 ) as ImpD, registro,nro_cuen  from 				
							(select fecha, codi_clie_prov, isnull( importe, 0 ) as importe , isnull( importe_d, 0 ) as importe_d, cargo_abono, registro, nro_cuen, codi_contable 
							from movi_contables
							 where nro_cuen = @nc  and cast ( mes as integer ) <= datepart( month , @fech_maxi)  and anio = @anio and cargo_abono='C' and not (registro is null)
							union
							 select fecha, codi_clie_prov,-1*importe,-1*importe_d, cargo_abono, registro, nro_cuen, codi_contable from movi_contables
							 where nro_cuen = @nc and cast ( mes as integer ) <= datepart( month , @fech_maxi)   and anio = @anio  and cargo_abono='A' and not (registro is null)
								) as Sl group by codi_clie_prov, nro_cuen,registro) 
							as Est , empresa, cuentas_contable,				
						(select codi_clie_prov, nro_cuen, registro,compr, nro_docu,glosa, subdia, mes, codi_mone
						 from movi_contables as Ct  , (select min(codi_contable) as cod from movi_contables, 
							(select codi_clie_prov, registro, nro_cuen from movi_contables where nro_cuen=@nc
								group by codi_clie_prov, registro, nro_cuen) as GR where movi_contables.nro_cuen=gr.nro_cuen and
								movi_contables.codi_clie_prov=Gr.codi_clie_prov and gr.registro=movi_contables.registro 
							group by movi_contables.codi_clie_prov,movi_contables.nro_cuen, movi_contables.registro) as Sl
							where sl.cod=ct.codi_contable and cast ( ct.mes as integer ) <= datepart( month , @fech_maxi)  ) as SG						
						 where	not (imp=0 and impd=0) and cuentas_contable.nro_cuen=est.nro_cuen and SG.codi_clie_prov=est.codi_clie_prov
						and SG.nro_Cuen=est.nro_cuen and Sg.registro=est.registro	
						)  U
					order by subdia, compr, registro, fs ;
				end
				if @indi = 'F' 
				begin
					Declare curs_carg_deta Cursor for
					Select codi_clie_prov,Imp , ImpD, Fs, Registro, nro_cuen, desc_cuen, nro_docu, compr, glosa, subdia, mes, codi_mone 
					From ( 	
						select Est.codi_clie_prov,Imp , ImpD, Fs, Est.Registro, Est.nro_cuen, desc_cuen, nro_docu,compr, glosa, subdia, mes, Sg.codi_mone 
						from 
					
						(select max(fecha) as Fs, codi_clie_prov, isnull( sum(importe) , 0 ) as Imp , isnull( sum(importe_d) , 0 ) as ImpD, registro,nro_cuen  from 				
							(select fecha, codi_clie_prov, isnull( importe, 0 ) as importe , isnull( importe_d, 0 ) as importe_d, cargo_abono, registro, nro_cuen, codi_contable 
							from movi_contables
							 where nro_cuen = @nc  and fecha < dateadd(day , 1,  @fech_maxi) and anio = @anio and cargo_abono='C' and not (registro is null)
							union
							 select fecha, codi_clie_prov,-1*importe,-1*importe_d, cargo_abono, registro, nro_cuen, codi_contable from movi_contables
							 where nro_cuen = @nc and fecha < dateadd(day , 1,  @fech_maxi)  and anio = @anio  and cargo_abono='A' and not (registro is null)
								) as Sl group by codi_clie_prov, nro_cuen,registro) 
							as Est , empresa, cuentas_contable,				
						(select codi_clie_prov, nro_cuen, registro,compr, nro_docu,glosa, subdia, mes, codi_mone, fecha
						 from movi_contables as Ct, (select min(codi_contable) as cod from movi_contables, 
							(select codi_clie_prov, registro, nro_cuen from movi_contables where nro_cuen=@nc
								group by codi_clie_prov, registro, nro_cuen) as GR where movi_contables.nro_cuen=gr.nro_cuen and
								movi_contables.codi_clie_prov=Gr.codi_clie_prov and gr.registro=movi_contables.registro 
							group by movi_contables.codi_clie_prov,movi_contables.nro_cuen, movi_contables.registro) as Sl
							where sl.cod=ct.codi_contable and ct.fecha < dateadd(day , 1,  @fech_maxi)  ) as SG						
						 where	not (imp=0 and impd=0) and cuentas_contable.nro_cuen=est.nro_cuen and SG.codi_clie_prov=est.codi_clie_prov
						and SG.nro_Cuen=est.nro_cuen and Sg.registro=est.registro	
						)  U
					order by subdia, compr, registro, fs ;					
				end	
				if @indi = 'A' 
				begin
					--print 'xx'
					Declare curs_carg_deta Cursor for
					select Est.codi_clie_prov,Imp , ImpD, Fs, Est.Registro, Est.nro_cuen, desc_cuen, nro_docu,compr, glosa, subdia, mes, est.codi_mone 
					from 					
					(
						select fecha as Fs, codi_clie_prov, isnull( sum(importe) , 0 ) as Imp , isnull( sum(importe_d) , 0 ) as ImpD, registro,nro_cuen, nro_docu,
						compr, glosa, subdia, mes, Sl.codi_mone
						  from 				
						(select fecha, codi_clie_prov, isnull( importe, 0 ) as importe , isnull( importe_d, 0 ) as importe_d, cargo_abono, registro, nro_cuen, codi_contable, nro_docu,
						compr, glosa, subdia, mes, codi_mone			
						from movi_contables
						 where nro_cuen = @nc and SUBDIA = 'S' and anio = @anio and cargo_abono='C' and not (registro is null)
						union ALL
						 select fecha, codi_clie_prov,-1*importe,-1*importe_d, cargo_abono, registro, nro_cuen, codi_contable, nro_docu, compr, glosa, subdia, mes, codi_mone
						 from movi_contables
						where nro_cuen = @nc and SUBDIA = 'S' and anio = @anio and cargo_abono='A' and not (registro is null)
						) as Sl 
						group by codi_clie_prov, nro_cuen,registro, FECHA, nro_docu, compr, glosa, subdia, mes, Sl.codi_mone
					) as Est, empresa, cuentas_contable							
					 where	not (imp=0 and impd=0) and cuentas_contable.nro_cuen=est.nro_cuen 	
					
					order by subdia, compr, registro, fs ;					
				end
				Open curs_carg_deta;
				Fetch curs_carg_deta into @codi_clie_prov, @impo, @impo_d, @fecha, @regi , @nc, @desc_cuen, @nro_docu, @compr, @glosa, 
					@subdia, @mes, @mone
				WHILE @@fetch_status = 0
				begin			
					/*if @nc = '1920401' 
					begin
						print @codi_clie_prov
						print @impo
						print @impo_d
						print @regi
					end		*/
					if isnull(@impo , 0 ) >= 0
					begin
						set @impo_c = @impo
						set @impo_a = 0
					end
					else
					begin	
						set @impo_c = 0
						set @impo_a = ABS( @impo)
					end
					if isnull( @impo_d , 0 ) >= 0
					begin
						set @impo_cd = @impo_d
						set @impo_ad = 0
					end
					else
					begin	
						set @impo_cd = 0
						set @impo_ad = ABS( @impo_d)
					end
					Select  @ruc = ruc, @razo_soci_cp = case upper( left ( tipo_pers,1) )  when 'J' then razo_soci  
						when 'N' then apel_1 + ' ' + apel_2 +  ' ' + nomb_1	+ ' ' + isnull( nomb_2, '') end 
					from cliente_proveedor where codi_clie_prov = @codi_clie_prov;

					Insert Into  #libr_inve_bala ( nro_cuen, desc_cuen, codi_prov, ruc, prov, fech_docu, nro_docu, impo_carg,  impo_abon, 
						impo_cargd,  impo_abond, concepto, fecha, mes, codi_mone, tfm)
					Values (@nc, @desc_cuen, @codi_clie_prov, @ruc, @razo_soci_cp, @fecha, @nro_docu, @impo_c, @impo_a, 
						@impo_cd, @impo_ad, @glosa, @fech_maxi, @mes , @mone, @ta)

					Fetch curs_carg_deta into @codi_clie_prov, @impo, @impo_d, @fecha, @regi , @nc, @desc_cuen, @nro_docu, @compr, @glosa, 
					@subdia, @mes, @mone
				end
				Close curs_carg_deta;
				Deallocate curs_carg_deta;
			end
			Fetch curs_carg_cuen_movi_cont into @nc;
			
		end
		close curs_carg_cuen_movi_cont ;
		Deallocate curs_carg_cuen_movi_cont;
		FETCH Curs_carg_nro_cuen into @codi_cc, @ta;
	end
	close Curs_carg_nro_cuen;
	Deallocate Curs_carg_nro_cuen;

Select *
from #libr_inve_bala
order by nro_cuen
end
GO
