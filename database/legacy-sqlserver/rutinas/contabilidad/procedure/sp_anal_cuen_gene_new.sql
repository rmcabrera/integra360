CREATE PROCEDURE [dbo].[sp_anal_cuen_gene_new]
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
Begin
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
	declare @ruc_p Varchar(15)

	set @mes = @mesi
	Create table #movi_cont (nro_cuen char(7) null, subdia char(1) null, compr char(6) null, codi_mone char(2) null, fecha datetime null, codi_clie_prov char(5) null, codi_unid_oper char(5) null,
				serie char(4) null, nro_docu char(10) null, codi_tipo_docu char(4) null, glosa varchar(200) null, mes char(2) null, anio char(4) null,
				importe_s decimal(12,2) null, importe_d decimal(12,2) null, registro char(10) null, tipo_camb decimal(9,3) null, banco char(7) null, cargo_abono char(1) null, 
				desc_cuen varchar(200) null, fami_cuen char(7) null, desc_fami_cuen varchar(200) null, desc_prov varchar(200) null, desc_unid_oper varchar(150) null,
				ruc_prov varchar(15) null , docu varchar(10))
	if @fech_mes = 'M' 
	begin
		if @unid_oper = ''
		begin
			if @prov = '' --Si es mensual, por Cuenta, sin Unid. Oper ni proveedor
			begin
				Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
				(	Select nro_cuen, subdia, compr, codi_mone, Fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, isnull( importe, 0 ) , isnull( importe_d, 0 ), registro, tipo_cambio, banco, cargo_abono, 							
						( Select desc_cuen from cuentas_contable where nro_cuen = mc.nro_cuen) as  desc_cuen, 
						 left ( isnull( nro_cuen, '00') , len(  @cuenta )  ) as fami_cuen, 
						( case len( @cuenta ) 
							when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
							when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
							when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
							when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
						end  ) as desc_fami_cuen, 
						( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov )  as desc_prov,
						( Select desc_unid_oper from unid_oper where codi_unid_oper = mc.codi_unid_oper ) as desc_unid_oper,
						( Select ruc	From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov ) as ruc_prov,							
						( Select nemo from tipo_documento where codi_tipo_docu = mc.codi_tipo_docu ) as docu
					From Movi_contables mc where  left( mc.nro_cuen, 1) > '0' and left( mc.nro_cuen, len( @cuenta ) )  = @cuenta
						and year(mc.fecha) = @anio and mes >= @mesi and mes <= @mesf						
				)
				if @tipo = 1 --Saldo si tiene inventario -Si es mensual, por Cuenta, sin Unid. Oper ni proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( 	Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, '' codi_clie_prov, '' codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 
							(	Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  ) importe_s,
							(	Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) ) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when ( Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c where nro_cuen = cc.nro_cuen 
									and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) )  > 0 then  'C' else 'A'  end
							else
								case when ( Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c where nro_cuen = cc.nro_cuen 
									and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) )  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 
							desc_cuen, 
							 left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len(   @cuenta  ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, '' as desc_prov, ''  as desc_unid_oper, '' as ruc_prov, '' as docu
						From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
											and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta ) 
					)
				end
				else -- Saldo si no tiene inventario, Si es mensual, por Cuenta, sin Unid. Oper ni proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, '' codi_clie_prov, '' codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 	
						(Select sum( importe) from
							( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
							union all
							Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
							)  importe	) importe_s,
						(Select sum( importe_d) from
							( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
							union all
							Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
							)  importe 	) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
										where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									union all
									Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
										where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
									)  importe	)  > 0 then  'C' else 'A'  end
							else
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
										where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									union all
									Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
										where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
									)  importe	)  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 								
							desc_cuen, left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, '' as desc_prov, ''  as desc_unid_oper, '' as ruc_prov, '' as docu
					From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
									and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta ) 
					)
				end --fin Saldo
			end --Fin Si es mensual, por Cuenta, sin Unid. Oper ni proveedor
			else
			begin --Si es mensual, por Cuenta, sin Unid. Oper y tiene proveedor
				Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
				(	Select nro_cuen, subdia, compr, codi_mone, Fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, isnull( importe, 0 ) , isnull( importe_d, 0 ), registro, tipo_cambio, banco, cargo_abono, 							
						( Select desc_cuen from cuentas_contable where nro_cuen = mc.nro_cuen) as  desc_cuen, 
						 left ( isnull( nro_cuen, '00') , len(  @cuenta )  ) as fami_cuen, 
						( case len( @cuenta ) 
							when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
							when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
							when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
							when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
						end  ) as desc_fami_cuen, 
						( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov )  as desc_prov,
						( Select desc_unid_oper from unid_oper where codi_unid_oper = mc.codi_unid_oper ) as desc_unid_oper,
						( Select ruc	From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov ) as ruc_prov,
						( Select nemo from tipo_documento where codi_tipo_docu = mc.codi_tipo_docu ) as docu
					From Movi_contables mc where  left( mc.nro_cuen, 1) > '0' and left( mc.nro_cuen, len( @cuenta ) )  = @cuenta
						and year(mc.fecha) = @anio and mes >= @mesi and mes <= @mesf and codi_clie_prov = @prov
				)
				if @tipo = 1 --Saldo si tiene inventario, Si es mensual, por Cuenta, sin Unid. Oper y tiene proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( 	Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, @prov as codi_clie_prov, '' codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 
							(	Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_p 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  and codi_clie_prov = @prov ) importe_s,
							(	Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_p 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_clie_prov = @prov ) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when ( Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_p 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  and codi_clie_prov = @prov )  > 0 then  'C' else 'A'  end
							else
								case when ( Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_p 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  and codi_clie_prov = @prov )  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 
							desc_cuen, 
							 left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
								From Cliente_proveedor where codi_clie_prov = @prov )  as desc_prov,								
							''  as desc_unid_oper, ( Select ruc From Cliente_proveedor where codi_clie_prov = @prov ) as ruc_prov, '' as docu
						From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
									and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00'), len( @cuenta )  )  = @cuenta  and codi_clie_prov = @prov ) 
					)
				end
				else -- Saldo si no tiene inventario, Si es mensual, por Cuenta, sin Unid. Oper y tiene proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, @prov as codi_clie_prov, '' codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 	
						(Select sum( importe) from
							( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_clie_prov = @prov 
							union all
							Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_clie_prov = @prov 
							)  importe	) importe_s,
						(Select sum( importe_d) from
							( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_p
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_clie_prov = @prov 
							union all
							Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_p
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_clie_prov = @prov 
							)  importe 	) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_clie_prov = @prov 
								union all
								Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
									where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_clie_prov = @prov 
								)  importe	)  > 0 then  'C' else 'A'  
							end
							else
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_clie_prov = @prov 
								union all
								Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
									where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_clie_prov = @prov 
								)  importe	)  > 0 then  'C' else 'A'  
							end
							END AS cargo_abono, 
							desc_cuen, left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
								From Cliente_proveedor where codi_clie_prov = @prov )  as desc_prov,								
							''  as desc_unid_oper, ( Select ruc From Cliente_proveedor where codi_clie_prov = @prov ) as ruc_prov, '' as docu
					From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
									and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta  and codi_clie_prov = @prov ) 
					)
				end --fin Saldo
			end -- Fin Si es mensual, por Cuenta, sin Unid. Oper y tiene proveedor
		end
		else
		begin -- Si es mensual, por Cuenta, con Unid. Oper 
			if @prov = '' -- Si es mensual, por Cuenta, con Unid. Oper y sin  proveedor
			begin
				Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
				(	Select nro_cuen, subdia, compr, codi_mone, Fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, isnull( importe, 0 ) , isnull( importe_d, 0 ), registro, tipo_cambio, banco, cargo_abono, 							
						( Select desc_cuen from cuentas_contable where nro_cuen = mc.nro_cuen) as  desc_cuen, 
						 left ( isnull( nro_cuen, '00') , len(  @cuenta )  ) as fami_cuen, 
						( case len( @cuenta ) 
							when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
							when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
							when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
							when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
						end  ) as desc_fami_cuen, 
						( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov )  as desc_prov,
						( Select desc_unid_oper from unid_oper where codi_unid_oper = mc.codi_unid_oper ) as desc_unid_oper,
						( Select ruc From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov ) as ruc_prov,							
						( Select nemo from tipo_documento where codi_tipo_docu = mc.codi_tipo_docu ) as docu
					From Movi_contables mc where  left( mc.nro_cuen, 1) > '0' and left( mc.nro_cuen, len( @cuenta ) )  = @cuenta
						and year(mc.fecha) = @anio and mes >= @mesi and mes <= @mesf and codi_unid_oper = @unid_oper
				)
				if @tipo = 1 --Saldo si tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y sin  proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( 	Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, '' codi_clie_prov, @unid_oper as codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 
							(	Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_uo 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  
									and codi_unid_oper = @unid_oper ) importe_s,
							(	Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_uo
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									and codi_unid_oper = @unid_oper ) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when ( Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_uo 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  
									and codi_unid_oper = @unid_oper )  > 0 then  'C' else 'A'  end
							else
								case when ( Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_uo
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									and codi_unid_oper = @unid_oper  )  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 
							desc_cuen, 
							 left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							'' as desc_prov, ( Select desc_unid_oper from unid_oper where codi_unid_oper = @unid_oper ) as desc_unid_oper,
							'' as ruc_prov, '' as docu
						From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio and left( mc.nro_cuen,1 ) > '0' 
												and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta and codi_unid_oper = @unid_oper )  
					)
				end
				else  --Saldo si no tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y sin  proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, '' codi_clie_prov, @unid_oper as codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 	
						(Select sum( importe) from
							( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_unid_oper = @unid_oper
							union all
							Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_unid_oper = @unid_oper
							)  importe	) importe_s,
						(Select sum( importe_d) from
							( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_uo 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_unid_oper = @unid_oper
							union all
							Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_uo 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_unid_oper = @unid_oper
							)  importe 	) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo where nro_cuen = cc.nro_cuen 
										and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_unid_oper = @unid_oper
									union all
									Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo where nro_cuen = cc.nro_cuen 
										and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_unid_oper = @unid_oper
									)  importe	)  > 0 then  'C' else 'A'  end
							else
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo where nro_cuen = cc.nro_cuen 
										and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_unid_oper = @unid_oper
									union all
									Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo where nro_cuen = cc.nro_cuen 
										and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_unid_oper = @unid_oper
									)  importe	)  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 								
							desc_cuen, left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							'' as desc_prov, ( Select desc_unid_oper from unid_oper where codi_unid_oper = @unid_oper ) as desc_unid_oper,
							'' as ruc_prov, '' as docu
					From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
									and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta and codi_unid_oper = @unid_oper ) 
					)
				end  -- Fin Saldo si no tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y sin  proveedor
			end
			else
			begin -- Si es mensual, por Cuenta, con Unid. Oper y con Proveedor
				Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
				(	Select nro_cuen, subdia, compr, codi_mone, Fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, isnull( importe, 0 ) , isnull( importe_d, 0 ), registro, tipo_cambio, banco, cargo_abono, 							
						( Select desc_cuen from cuentas_contable where nro_cuen = mc.nro_cuen) as  desc_cuen, 
						 left ( isnull( nro_cuen, '00') , len(  @cuenta )  ) as fami_cuen, 
						( case len( @cuenta ) 
							when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
							when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
							when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
							when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
						end  ) as desc_fami_cuen, 
						( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov )  as desc_prov,
						( Select desc_unid_oper from unid_oper where codi_unid_oper = mc.codi_unid_oper ) as desc_unid_oper,
						( Select ruc From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov ) as ruc_prov,							
						( Select nemo from tipo_documento where codi_tipo_docu = mc.codi_tipo_docu ) as docu
					From Movi_contables mc where  left( mc.nro_cuen, 1) > '0' and left( mc.nro_cuen, len( @cuenta ) )  = @cuenta
						and year(mc.fecha) = @anio and mes >= @mesi and mes <= @mesf and codi_unid_oper = @unid_oper
						and codi_clie_prov = @prov
				)
				if @tipo = 1 --Saldo si tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y con proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( 	Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, @prov as codi_clie_prov, @unid_oper as codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 
							(	Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_uo_p 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  
									and codi_unid_oper = @unid_oper ) importe_s,
							(	Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_uo_p
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									and codi_unid_oper = @unid_oper ) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when ( Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_uo_p 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  
									and codi_unid_oper = @unid_oper )  > 0 then  'C' else 'A'  end
							else
								case when ( Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_uo_p
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									and codi_unid_oper = @unid_oper  )  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 
							desc_cuen, 
							 left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = @prov )  as desc_prov,
							( Select desc_unid_oper from unid_oper where codi_unid_oper = @unid_oper ) as desc_unid_oper,
							( Select ruc From Cliente_proveedor where codi_clie_prov = @prov ) as ruc_prov,	 '' as docu
						From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio and left( mc.nro_cuen,1 ) > '0' 
									and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta and codi_unid_oper = @unid_oper and codi_clie_prov = @prov )  
					)
				end
				else  --Saldo si no tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y con  proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, @prov as codi_clie_prov, @unid_oper as codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 	
						(Select sum( importe) from
							( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
								and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
							union all
							Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
								and codi_unid_oper = @unid_oper  and codi_clie_prov = @prov
							)  importe	) importe_s,
						(Select sum( importe_d) from
							( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_uo_p 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
								and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
							union all
							Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_uo_p 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
								and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
							)  importe 	) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p where nro_cuen = cc.nro_cuen 
										and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
										and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
									union all
									Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p where nro_cuen = cc.nro_cuen 
										and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
										and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
									)  importe	)  > 0 then  'C' else 'A'  end
							else
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p where nro_cuen = cc.nro_cuen 
										and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
										and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
									union all
									Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p where nro_cuen = cc.nro_cuen 
										and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
									)  importe	)  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 								
							desc_cuen, left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = @prov )  as desc_prov,
							( Select desc_unid_oper from unid_oper where codi_unid_oper = @unid_oper ) as desc_unid_oper,
							( Select ruc From Cliente_proveedor where codi_clie_prov = @prov ) as ruc_prov,	 '' as docu
					From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
										and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta 
										and codi_unid_oper = @unid_oper and codi_clie_prov = @prov) 
					)
				end  -- Fin Saldo si no tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y con  proveedor
			end
		end			
	end
	else -- Si es 'F' si es por fecha
	begin
		if @unid_oper = ''
		begin
			if @prov = '' --Si es fecha, por Cuenta, sin Unid. Oper ni proveedor
			begin
				Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
				(	Select nro_cuen, subdia, compr, codi_mone, Fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, isnull( importe, 0 ) , isnull( importe_d, 0 ), registro, tipo_cambio, banco, cargo_abono, 							
						( Select desc_cuen from cuentas_contable where nro_cuen = mc.nro_cuen) as  desc_cuen, 
						 left ( isnull( nro_cuen, '00') , len(  @cuenta )  ) as fami_cuen, 
						( case len( @cuenta ) 
							when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
							when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
							when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
							when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
						end  ) as desc_fami_cuen, 
						( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov )  as desc_prov,
						( Select desc_unid_oper from unid_oper where codi_unid_oper = mc.codi_unid_oper ) as desc_unid_oper,
						( Select ruc	From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov ) as ruc_prov,					
						( Select nemo from tipo_documento where codi_tipo_docu = mc.codi_tipo_docu ) as docu
					From Movi_contables mc where  left( mc.nro_cuen, 1) > '0' and left( mc.nro_cuen, len( @cuenta ) )  = @cuenta
						and year(mc.fecha) = @anio and mc.fecha >= @fechai  and mc.fecha < dateadd( day, @fechaf, 1 ) 
				)
				if @tipo = 1 --Saldo si tiene inventario -Si es fecha, por Cuenta, sin Unid. Oper ni proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( 	Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, '' codi_clie_prov, '' codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 
							(	Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  ) importe_s,
							(	Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) ) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when ( Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c where nro_cuen = cc.nro_cuen 
									and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) )  > 0 then  'C' else 'A'  end
							else
								case when ( Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c where nro_cuen = cc.nro_cuen 
									and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) )  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 
							desc_cuen, 
							 left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len(   @cuenta  ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, '' as desc_prov, ''  as desc_unid_oper, '' as ruc_prov, '' as docu
						From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
											and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta ) 
					)
				end
				else -- Saldo si no tiene inventario, Si es fecha, por Cuenta, sin Unid. Oper ni proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, '' codi_clie_prov, '' codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 	
						(Select sum( importe) from
							( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
							union all
							Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
							)  importe	) importe_s,
						(Select sum( importe_d) from
							( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
							union all
							Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
							)  importe 	) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
										where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									union all
									Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
										where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
									)  importe	)  > 0 then  'C' else 'A'  end
							else
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
										where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									union all
									Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c 
										where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
									)  importe	)  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 								
							desc_cuen, left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, '' as desc_prov, ''  as desc_unid_oper, '' as ruc_prov, '' as docu
					From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
									and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta ) 
					)
				end --fin Saldo
			end --Fin Si es mensual, por Cuenta, sin Unid. Oper ni proveedor
			else
			begin --Si es mensual, por Cuenta, sin Unid. Oper y tiene proveedor
				Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
				(	Select nro_cuen, subdia, compr, codi_mone, Fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, isnull( importe, 0 ) , isnull( importe_d, 0 ), registro, tipo_cambio, banco, cargo_abono, 							
						( Select desc_cuen from cuentas_contable where nro_cuen = mc.nro_cuen) as  desc_cuen, 
						 left ( isnull( nro_cuen, '00') , len(  @cuenta )  ) as fami_cuen, 
						( case len( @cuenta ) 
							when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
							when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
							when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
							when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
						end  ) as desc_fami_cuen, 
						( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov )  as desc_prov,
						( Select desc_unid_oper from unid_oper where codi_unid_oper = mc.codi_unid_oper ) as desc_unid_oper,
						( Select ruc	From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov ) as ruc_prov,
						( Select nemo from tipo_documento where codi_tipo_docu = mc.codi_tipo_docu ) as docu
					From Movi_contables mc where  left( mc.nro_cuen, 1) > '0' and left( mc.nro_cuen, len( @cuenta ) )  = @cuenta
						and year(mc.fecha) = @anio and mes >= @mesi and mes <= @mesf and codi_clie_prov = @prov
				)
				if @tipo = 1 --Saldo si tiene inventario, Si es mensual, por Cuenta, sin Unid. Oper y tiene proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( 	Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, @prov as codi_clie_prov, '' codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 
							(	Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_p 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  and codi_clie_prov = @prov ) importe_s,
							(	Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_p 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_clie_prov = @prov ) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when ( Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_p 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  and codi_clie_prov = @prov )  > 0 then  'C' else 'A'  end
							else
								case when ( Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_p 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  and codi_clie_prov = @prov )  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 
							desc_cuen, 
							 left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
								From Cliente_proveedor where codi_clie_prov = @prov )  as desc_prov,								
							''  as desc_unid_oper, ( Select ruc From Cliente_proveedor where codi_clie_prov = @prov ) as ruc_prov, '' as docu
						From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
									and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00'), len( @cuenta )  )  = @cuenta  and codi_clie_prov = @prov ) 
					)
				end
				else -- Saldo si no tiene inventario, Si es mensual, por Cuenta, sin Unid. Oper y tiene proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, @prov as codi_clie_prov, '' codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 	
						(Select sum( importe) from
							( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_clie_prov = @prov 
							union all
							Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_clie_prov = @prov 
							)  importe	) importe_s,
						(Select sum( importe_d) from
							( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_p
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_clie_prov = @prov 
							union all
							Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_p
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_clie_prov = @prov 
							)  importe 	) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_clie_prov = @prov 
								union all
								Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
									where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_clie_prov = @prov 
								)  importe	)  > 0 then  'C' else 'A'  
							end
							else
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_clie_prov = @prov 
								union all
								Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_p
									where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_clie_prov = @prov 
								)  importe	)  > 0 then  'C' else 'A'  
							end
							END AS cargo_abono, 
							desc_cuen, left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
								From Cliente_proveedor where codi_clie_prov = @prov )  as desc_prov,								
							''  as desc_unid_oper, ( Select ruc From Cliente_proveedor where codi_clie_prov = @prov ) as ruc_prov, '' as docu
					From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
									and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta  and codi_clie_prov = @prov ) 
					)
				end --fin Saldo
			end -- Fin Si es mensual, por Cuenta, sin Unid. Oper y tiene proveedor
		end
		else
		begin -- Si es mensual, por Cuenta, con Unid. Oper 
			if @prov = '' -- Si es mensual, por Cuenta, con Unid. Oper y sin  proveedor
			begin
				Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
				(	Select nro_cuen, subdia, compr, codi_mone, Fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, isnull( importe, 0 ) , isnull( importe_d, 0 ), registro, tipo_cambio, banco, cargo_abono, 							
						( Select desc_cuen from cuentas_contable where nro_cuen = mc.nro_cuen) as  desc_cuen, 
						 left ( isnull( nro_cuen, '00') , len(  @cuenta )  ) as fami_cuen, 
						( case len( @cuenta ) 
							when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
							when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
							when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
							when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
						end  ) as desc_fami_cuen, 
						( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov )  as desc_prov,
						( Select desc_unid_oper from unid_oper where codi_unid_oper = mc.codi_unid_oper ) as desc_unid_oper,
						( Select ruc From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov ) as ruc_prov,							
						( Select nemo from tipo_documento where codi_tipo_docu = mc.codi_tipo_docu ) as docu
					From Movi_contables mc where  left( mc.nro_cuen, 1) > '0' and left( mc.nro_cuen, len( @cuenta ) )  = @cuenta
						and year(mc.fecha) = @anio and mes >= @mesi and mes <= @mesf and codi_unid_oper = @unid_oper
				)
				if @tipo = 1 --Saldo si tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y sin  proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( 	Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, '' codi_clie_prov, @unid_oper as codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 
							(	Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_uo 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  
									and codi_unid_oper = @unid_oper ) importe_s,
							(	Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_uo
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									and codi_unid_oper = @unid_oper ) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when ( Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_uo 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  
									and codi_unid_oper = @unid_oper )  > 0 then  'C' else 'A'  end
							else
								case when ( Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_uo
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									and codi_unid_oper = @unid_oper  )  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 
							desc_cuen, 
							 left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							'' as desc_prov, ( Select desc_unid_oper from unid_oper where codi_unid_oper = @unid_oper ) as desc_unid_oper,
							'' as ruc_prov, '' as docu
						From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio and left( mc.nro_cuen,1 ) > '0' 
												and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta and codi_unid_oper = @unid_oper )  
					)
				end
				else  --Saldo si no tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y sin  proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, '' codi_clie_prov, @unid_oper as codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 	
						(Select sum( importe) from
							( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_unid_oper = @unid_oper
							union all
							Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_unid_oper = @unid_oper
							)  importe	) importe_s,
						(Select sum( importe_d) from
							( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_uo 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_unid_oper = @unid_oper
							union all
							Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_uo 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_unid_oper = @unid_oper
							)  importe 	) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo where nro_cuen = cc.nro_cuen 
										and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_unid_oper = @unid_oper
									union all
									Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo where nro_cuen = cc.nro_cuen 
										and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_unid_oper = @unid_oper
									)  importe	)  > 0 then  'C' else 'A'  end
							else
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo where nro_cuen = cc.nro_cuen 
										and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) and codi_unid_oper = @unid_oper
									union all
									Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo where nro_cuen = cc.nro_cuen 
										and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_unid_oper = @unid_oper
									)  importe	)  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 								
							desc_cuen, left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							'' as desc_prov, ( Select desc_unid_oper from unid_oper where codi_unid_oper = @unid_oper ) as desc_unid_oper,
							'' as ruc_prov, '' as docu
					From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
									and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta and codi_unid_oper = @unid_oper ) 
					)
				end  -- Fin Saldo si no tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y sin  proveedor
			end
			else
			begin -- Si es mensual, por Cuenta, con Unid. Oper y con Proveedor
				Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
				(	Select nro_cuen, subdia, compr, codi_mone, Fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, isnull( importe, 0 ) , isnull( importe_d, 0 ), registro, tipo_cambio, banco, cargo_abono, 							
						( Select desc_cuen from cuentas_contable where nro_cuen = mc.nro_cuen) as  desc_cuen, 
						 left ( isnull( nro_cuen, '00') , len(  @cuenta )  ) as fami_cuen, 
						( case len( @cuenta ) 
							when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
							when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
							when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
							when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
						end  ) as desc_fami_cuen, 
						( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov )  as desc_prov,
						( Select desc_unid_oper from unid_oper where codi_unid_oper = mc.codi_unid_oper ) as desc_unid_oper,
						( Select ruc From Cliente_proveedor where codi_clie_prov = mc.codi_clie_prov ) as ruc_prov,							
						( Select nemo from tipo_documento where codi_tipo_docu = mc.codi_tipo_docu ) as docu
					From Movi_contables mc where  left( mc.nro_cuen, 1) > '0' and left( mc.nro_cuen, len( @cuenta ) )  = @cuenta
						and year(mc.fecha) = @anio and mes >= @mesi and mes <= @mesf and codi_unid_oper = @unid_oper
						and codi_clie_prov = @prov
				)
				if @tipo = 1 --Saldo si tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y con proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( 	Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, @prov as codi_clie_prov, @unid_oper as codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 
							(	Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_uo_p 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  
									and codi_unid_oper = @unid_oper ) importe_s,
							(	Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_uo_p
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									and codi_unid_oper = @unid_oper ) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when ( Select isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) from sald_tota_c_uo_p 
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric)  
									and codi_unid_oper = @unid_oper )  > 0 then  'C' else 'A'  end
							else
								case when ( Select isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) from sald_tota_c_uo_p
									where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
									and codi_unid_oper = @unid_oper  )  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 
							desc_cuen, 
							 left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = @prov )  as desc_prov,
							( Select desc_unid_oper from unid_oper where codi_unid_oper = @unid_oper ) as desc_unid_oper,
							( Select ruc From Cliente_proveedor where codi_clie_prov = @prov ) as ruc_prov,	 '' as docu
						From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio and left( mc.nro_cuen,1 ) > '0' 
									and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta and codi_unid_oper = @unid_oper and codi_clie_prov = @prov )  
					)
				end
				else  --Saldo si no tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y con  proveedor
				begin
					Insert into #movi_cont ( nro_cuen, subdia, compr, codi_mone, fecha, codi_clie_prov, codi_unid_oper, serie, nro_docu, codi_tipo_docu, 
						glosa, mes, anio, importe_s, importe_d, registro, tipo_camb, banco, cargo_abono, 
						desc_cuen, fami_cuen, desc_fami_cuen, desc_prov, desc_unid_oper, ruc_prov, docu )
					( Select cc.nro_cuen, 'S'  subdia, ' ' as compr, isnull( cc.codi_mone, '01' ) codi_mone, @fechai, @prov as codi_clie_prov, @unid_oper as codi_unid_oper, '' serie, '' nro_docu, '' codi_tipo_docu, 
						'SALDO ANTERIOR ' glosa, @mesi as mes, @anio as anio, 	
						(Select sum( importe) from
							( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
								and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
							union all
							Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
								and codi_unid_oper = @unid_oper  and codi_clie_prov = @prov
							)  importe	) importe_s,
						(Select sum( importe_d) from
							( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_uo_p 
								where nro_cuen = cc.nro_cuen and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
								and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
							union all
							Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe_d from sald_tota_c_uo_p 
								where nro_cuen = cc.nro_cuen and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
								and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
							)  importe 	) importe_d,
							'' registro, 0 tipo_cambio, '' banco, 
							case when cc.codi_mone = '01' then
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p where nro_cuen = cc.nro_cuen 
										and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
										and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
									union all
									Select ( isnull( sum(  isnull( importe_c, 0)  -  isnull( importe_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p where nro_cuen = cc.nro_cuen 
										and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  
										and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
									)  importe	)  > 0 then  'C' else 'A'  end
							else
								case when (Select sum( importe) from
									( Select (  isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p where nro_cuen = cc.nro_cuen 
										and anio = @anio and cast( mes as numeric ) < cast( @mesi as numeric) 
										and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
									union all
									Select ( isnull( sum(  isnull( importe_d_c, 0)  -  isnull( importe_d_a , 0 ) ) , 0 ) ) importe from sald_tota_c_uo_p where nro_cuen = cc.nro_cuen 
										and  ( cast( anio  as numeric ) = cast( @anio as numeric ) - 1 )  and codi_unid_oper = @unid_oper and codi_clie_prov = @prov
									)  importe	)  > 0 then  'C' else 'A'  end
							END AS cargo_abono, 								
							desc_cuen, left ( isnull( nro_cuen, '00') , len( @cuenta )  ) as fami_cuen, 
							( case len( @cuenta ) 
								when 2 then ( select desc_clas_cuen from clases_cuentas where codi_clas_cuen = @cuenta ) 
								when 3 then ( select desc_subc from sub_clas_cuen where codi_subc = @cuenta ) 
								when 5 then ( select desc_lcc from linea_clase_c where codi_lcc = @cuenta ) 
								when 7 then ( select desc_cuen from cuentas_contable where nro_cuen = @cuenta ) 
							end  ) as desc_fami_cuen, 
							( Select case  tipo_pers when 'N' then apel_1 + ' ' + apel_2 + ' ' + nomb_1 + isnull(nomb_2, '') else razo_soci end
							From Cliente_proveedor where codi_clie_prov = @prov )  as desc_prov,
							( Select desc_unid_oper from unid_oper where codi_unid_oper = @unid_oper ) as desc_unid_oper,
							( Select ruc From Cliente_proveedor where codi_clie_prov = @prov ) as ruc_prov,	 '' as docu
					From Cuentas_contable cc where nro_cuen in ( Select distinct nro_cuen from movi_contables mc where  year(mc.fecha) = @anio 
										and left( mc.nro_cuen,1 ) > '0' and left ( isnull( nro_cuen, '00') , len( @cuenta )  )  = @cuenta 
										and codi_unid_oper = @unid_oper and codi_clie_prov = @prov) 
					)
				end  -- Fin Saldo si no tiene inventario, Si es mensual, por Cuenta, con Unid. Oper y con  proveedor
			end
		end
	end

	Select * from #movi_cont
	order by nro_cuen, compr, fecha, subdia

End
GO
