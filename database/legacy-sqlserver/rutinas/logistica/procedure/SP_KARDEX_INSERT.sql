CREATE PROCEDURE [dbo].[SP_KARDEX_INSERT]
	@codi [char](10),
	@det [char](12),
	@prod [char](8),
	@tp [char](1)
WITH EXECUTE AS CALLER
AS
--declare @codi char(10), @det char(12) , @prod char(8) , @tp char(1)
--select @codi ='0000000001' , @det ='000000000101' , @prod ='00060082' , @tp ='2'

set nocount on
Begin
	Declare @mx numeric(20)
	declare @mkar char(20)
	declare @sto numeric(18,4)
	declare @sald numeric(18,4)
	declare @promed numeric(18,4)
	declare @ingr numeric(18,4)
	declare @egre numeric(18,4)
	declare @pr numeric(18,4)
	declare @mn char(2)
	declare @tpc numeric(18,4)
	declare @fec datetime
	declare  @tpd char(4)
	declare @ser char(5)
	declare @nro varchar(15)
	declare @codi_unid_soli char(5)
	declare @codi_unid_dest char(5)
	declare @cuen char(7)
	declare @fech datetime
	declare  @valo_i numeric(18,4)
	declare @valo_s numeric(18,4)
	declare @gui varchar(15)
	declare @con varchar(250)
	declare @cli char(5)
	declare @maxf smalldatetime
	declare @maxK char(20)
	declare @peri int
	declare @codi_alma char(2)
		
	-----ARQUIÑO
	DECLARE @TIPO_INGR char(2)
	DECLARE @TIPO_SALI char(2)
	DECLARE @codi_alma_ini char(2)
	DECLARE @codi_alma_des char(2)
	DECLARE @codi_clie_provee char(5)

	Declare @valo_saldo_alma numeric(18,4)
	declare @codi_alma_aux char(2)
	declare @maxf_alma smalldatetime
	declare @maxK_alma char(20)
	declare @cant_saldo_alma numeric(18,4)
	declare @prec_prom_alma numeric(18,4)
	declare @valor_ingreso_alma numeric(18,4)
	declare @valor_egreso_alma numeric(18,4)
	declare @valor_saldo_alma numeric(18,4)
	----

	if(@tp='1')
	begin
		select	@fech = cast( convert(char(10),fech_nota_ingr,103) as smalldatetime) , @codi_alma_aux=codi_alma   from dbo.nota_ingreso (nolock) where codi_nota_ingr=@codi
	end
	if(@tp='2')
	begin
	        select 	@Fech = cast( convert(char(10),fech_emis,103) as smalldatetime)  , @codi_alma_aux=codi_alma from dbo.docu_Sali_mate  (nolock) where codi_docu_sali=@codi		
	end

	set @peri= year(@fech)

	select @mx= max(codi_kard) from dbo.kardex  (nolock) --- selecciono el maximo codigo de kardex antes de insertar
	if (@mx is null) set @mx=0
	set @mx=@mx+1
	set @mkar = replicate('0', 20 - len(convert(char(20),@mx) )) +convert(char(20),@mx)  ---creo el nuevo codigo kardex para insertar

	set  @maxF=@FEch	
	-------------- PARA EL GENERAL
	select @maxF=cast(convert(char(10),max(fech_tran),103) as smalldatetime) from dbo.kardex  (nolock)
			where periodo=@peri and codi_prod=@prod and cast(convert(char(10),fech_tran,103) as smalldatetime)<@maxF 
	
	select @maxK = max(codi_kard) from dbo.kardex  (nolock) where periodo=@peri and codi_prod=@prod and fech_tran  =@maxF  
	------ FIN DE PARA EL GENERAL

	if (@maxF is null) set @maxF= @FEch	
	-------------- CASO POR ALMACEN
	select @maxF_alma=cast(convert(char(10),max(fech_tran),103) as smalldatetime) from dbo.kardex  (nolock)
			where periodo=@peri and codi_alma=@codi_alma_aux and codi_prod=@prod and cast(convert(char(10),fech_tran,103) as smalldatetime)<@maxF

	
	select @maxK_alma = max(codi_kard) from dbo.kardex  (nolock) where periodo=@peri and codi_alma=@codi_alma_aux and codi_prod=@prod and  fech_tran =@maxF_alma  

	------ FIN DE PARA EL GENERAL

	if (@maxF is null) set @maxF= @FEch
	if (@maxF_Alma is null) set @maxF_Alma= @FEch

	set @ingr=0
	set @egre=0
	set @valo_i=0
	set @valo_s=0

	if (@maxk is null ) 
	begin
	    set @sald=0
	    set @sto=0
	    set @promed=0
	    set @ingr=0
	    set @egre=0
	    set @valo_i=0
	    set @valo_s=0

	end

	else

	begin
	     --- PARA EL CASO DE GENERAL
	    select @sto= cant_saldo, @sald=valo_saldo, @promed= prec_prom from dbo.kardex  (nolock) where codi_kard=@maxk 

	end
	------------ FIN DE POR ALMACEN---------
	if (@maxk_alma is null ) 
		begin
		  -----ARQUIÑO
		SET @cant_saldo_alma=0
		SET @prec_prom_alma=0
		SET @valor_ingreso_alma=0
		SET @valor_egreso_alma =0
		SET @valor_saldo_alma=0
		--------
		end

	else

	begin
	  select @CANT_SALDO_ALMA = cant_saldo_alma , @valor_saldo_alma=valo_saldo_alma, @prec_prom_alma= prec_prom_alma from dbo.kardex  (nolock) where codi_kard=@maxk_alma

	end	
	------------ FIN DE POR ALMACEN---------

	select @cuen= nro_cuen from dbo.productos (nolock) where codi_prod =@prod

	if(@tp='1')   ---- INGRESO DE MATERIALES
	begin
		select @tpd=codi_tipo_docu , @ser =nro_seri ,@nro= right(codi_nota_ingr,6) ,  @codi_unid_soli= codi_unid_oper_soli, @codi_unid_dest = codi_unid_oper_dest,
			@fech=fech_nota_ingr ,@gui=nro_docu , @cli = isnull(codi_clie_prov,'00000'), @tpc = tipo_camb , @tipo_Ingr= tipo_nota_ingr ,  @codi_alma_ini = codi_alma  , @codi_alma_des=codi_alma_desti
			  from dbo.nota_ingreso  (nolock) where codi_nota_ingr=@codi

		-------------------- TIPOS INGRESOS----------	
		if    @tipo_Ingr in ('01','02','11','18','25','26','37')  --- Compra
		       begin
		           select @con = isnull(denominacion,'') from cliente_proveedor (nolock) where codi_clie_prov=@cli
		           select @con = nemo_tipo_is+', '+@con from tipo_ingr_sali (nolock) where codi_tipo_is=@tipo_ingr;
		      end
		if    @tipo_Ingr='04'  --- inventario
		       begin
		          select @con = nemo_alma from almacen (nolock) where codi_alma=@codi_alma_ini;
		          set @con = 'INVENTARIO, ' + @con
		      end			
		if    @tipo_Ingr='23'  --- Traslado Sucursales
		       begin
		          select @con = nemo_alma from almacen (nolock) where codi_alma=@codi_alma_des;
		          select @con = @con + ' --> '+ isnull(nemo_alma,'') from almacen (nolock) where codi_alma=@codi_alma_ini;
		          set @con = 'TRASL. SUCURSAL, ' + @con
		       end		
		-----------------------------------------------

		select @ingr= cantidad, @pr =prec_unit, @mn =codi_mone, @codi_alma = codi_alma 
			from dbo.detalle_nota_ingreso  (nolock)
			where codi_nota_ingr=@codi and nro_item_nota_ingr=@det and codi_prod=@prod

	--	select @fec=fech_guia_remi from nota_ingreso where codi_nota_ingr=@codi 
		if (@mn<>'01') 
		begin
			if @tpc<=0 or @tpc is null set @tpc= dbo.f_tc(@fech,'V','01','02')
			set @pr=@pr*@tpc   ---- PRECIO POR EL TIPO DE CAMBIO , EN EL CASO QUE SEA EN DOLARES
		end
	end

	if(@tp='2') ---- SALIDA DE MATERIALES

	begin
	        	select @tpd=codi_tipo_docu_sali , @ser =nro_seri_docu_sali ,@nro= right(codi_docu_sali,6) ,  @codi_unid_soli= codi_unid_oper_rece, @codi_unid_dest = '',
			@fech=fech_emis ,  @gui=nro_docu_sali,  @cli = codi_unid_oper_rece , @codi_alma_ini= codi_alma , @tipo_sali=tipo_sali , 
			@codi_alma_des = codi_alma_desti  , @codi_clie_provee= isnull(codi_clie_prov,'00000')
			  from dbo.docu_Sali_mate (nolock) where codi_docu_sali=@codi

		select @con = desc_unid_oper from unid_oper (nolock) where codi_unid_oper=@cli
		----CONCEPTOS SEGUN SALIDA-----
		if @tipo_Sali in ('08','06','07','09','10','14','15','16','19','20','21','22','24','30','36')  --- VENTA
		  begin
		           select @con = isnull(denominacion,'') from cliente_proveedor (nolock) where codi_clie_prov=@codi_clie_provee;
		           select @con = nemo_tipo_is+', '+@con from tipo_ingr_sali (nolock) where codi_tipo_is=@tipo_sali;
		 end	
		if @tipo_Sali='12'  --- merma inventario
		       begin
		          select @con = nemo_alma from almacen (nolock) where codi_alma=@codi_alma_ini;
		          set @con = 'REGULAR. INVENTARIO, ' + @con
		     end			
		if @tipo_Sali='17'  --- Traslado Sucursales
		       begin
		          select @con = nemo_alma from almacen (nolock) where codi_alma=@codi_alma_ini;
		         select @con = @con + ' --> '+ isnull(nemo_alma,'') from almacen (nolock) where codi_alma=@codi_alma_des;

		          set @con = 'TRASL. SUCURSAL, ' + @con
		     end		
		if @tipo_Sali='28'  --- AJUSTE POR REGULARIZACIÓN DE INVENTARIO

		       begin
		          select @con = nemo_alma from almacen (nolock) where codi_alma=@codi_alma_ini;
		         select @con = @con + ' --> '+ isnull(nemo_alma,'') from almacen (nolock) where codi_alma=@codi_alma_des;

		          set @con = 'AJUSTE POR INVENTARIO, ' + @con
		     end		
		if @tipo_Sali='29'  --- AJUSTE POR REGULARIZACIÓN DE MERCADERIA CON CLIENTE
		       begin
		          select @con = nemo_alma from almacen (nolock) where codi_alma=@codi_alma_ini;
		         select @con = @con + ' --> '+ isnull(nemo_alma,'') from almacen (nolock) where codi_alma=@codi_alma_des;

		          set @con = 'AJUSTE POR MERCADERIA CON CLIENTE, ' + @con
		     end		
		--------------------
		select @egre= cantidad, @codi_alma = codi_alma  from dbo.detalle_docu_sali  (nolock) where codi_docu_sali=@codi and codi_deta_docu_sali=@det

		set @mn='01'  -- POR DEFECTO EN SOLES
		set @tpc=0
		set @pr=0
	end

	
	set @sto = @sto + @ingr - @egre  --- saldo stock general
	set @valo_i = isnull(@pr,0) * isnull(@ingr,0)  ---valor de ingreso general : Precio Unitario por Cant. Ingreso
	set @valo_s = @promed * @egre  -----valor de egreso general : Precio Promedio por Cant. Egreso
	set @sald = @sald  + @valo_i - @valo_s ---- saldo valor general
	
	----ARQUIÑO . POR PRODUCTO ALMACEN
	set @cant_saldo_alma=@cant_saldo_alma + @ingr - @egre --
	set @valor_ingreso_alma = isnull(@pr,0) * isnull(@ingr,0)  ---valor de ingreso x almacen : Precio Unitario por Cant. Ingreso
	set @valor_egreso_alma = isnull(@prec_prom_alma , 0) * isnull(@egre , 0)  -----valor de egreso x almacen : Precio Promedio por Cant. Egreso
	set @valor_saldo_alma = @valor_saldo_alma  + @valor_ingreso_alma  - @valor_egreso_alma ---- saldo valor general
	-----FIN DE ARQUIÑO

	if (@sto<>0) set @promed = @sald/@sto  ---- promedio general para el reporte de valorizacion de productos   :  @sto = cant_saldo
             -------- ARQUIÑO ------------------------
	if (@CANT_SALDO_ALMA<>0) set @prec_prom_alma = @valor_saldo_alma / @CANT_SALDO_ALMA  ---- promedio por almacen para el reporte de valorizacion de productos por almacen
	-------FIN DE ARQUIÑO--------------
              --print @mkar + '     PP: '+cast( @prec_prom_alma as char(10))+'   VS:'+cast( @valor_saldo_alma as char(10))+'   CS:'+cast( @cant_saldo_alma as char(10))+'   MK:'+@maxk_alma

	insert into kardex (codi_kard, codi_prod,  codi_tipo_docu, nro_seri, nro_docu, codi_unid_oper_soli, codi_unid_oper_dest,
		codi_cuen, fech_tran, cant_ingr, cant_sali, cant_saldo, prec_unit, prec_prom,  valo_ingr, valo_sali, valo_saldo,
		codi_mone, tipo_camb, I_O,  codi_docu_i_o,  concepto, nro_guia , item, periodo,estado, codi_alma , CANT_SALDO_ALMA , VALO_SALDO_ALMA , prec_prom_alma , valo_ingr_alma , valo_sali_alma)
		values(@mkar, @prod, @tpd, @ser, @nro, @codi_unid_soli, @codi_unid_dest, @cuen, @fech, @ingr,								 ----estuvo @valo_saldo_alma	
			@egre, @sto, @pr, @promed ,  @valo_i, @valo_s, @sald, @mn, @tpc, @tp, @codi , @con, @gui, @det, year(@fech),'', @codi_alma, @CANT_SALDO_ALMA, @valor_saldo_alma , @prec_prom_alma , @valor_ingreso_alma  , @valor_egreso_alma )


	declare @CtK numeric(20)
	declare @CtF numeric(20)
	Declare @CI numeric(18,4)
	Declare @CE numeric(18,4)
	Declare @CS numeric(18,4)
	Declare @VI numeric(18,4)
	Declare @VE numeric(18,4)
	Declare @VS numeric(18,4)
	Declare @PU numeric(18,4)
	Declare @PP numeric(18,4)
	Declare @PPA numeric(18,4)
	Declare @ACS numeric(18,4)
	Declare @AVS numeric(18,4)
	declare @Kar char(20)
	set @ACS=0
	set @AVS=0	
	
	---PARA EL GENERAL ---------------------
	select @Ctk= count(codi_kard) from dbo.kardex (nolock) where periodo=@peri and codi_prod=@prod 

	if (@ctk is null) set @ctk=0
	if (@Ctk>1 )
	begin
		declare C1 cursor for  select codi_kard,cant_ingr, cant_sali, cant_saldo, prec_unit, prec_prom, valo_ingr,valo_sali, valo_saldo  
				from dbo.kardex (nolock) where periodo=@peri  and codi_prod=@prod  
				order by fech_tran, i_o, codi_docu_i_o, item
		open C1
		set @ctF=0
		fetch C1 into @kar, @CI, @Ce, @CS, @PU, @PP, @VI,@VE, @VS
		WHILE @@FETCH_STATUS = 0
		begin		
			set @Ctf= @ctf +1
			if (@ctf=1) 
			    begin
				set @ACS = 0 --@CS	----- se obtiene el saldo cantidad
				set @AVS = 0---@VS	----- se obtiene el saldo valor
				set @PPA  =@pp	---- se obtiene el promedio
	  		    end
			set @cs = @acs + @ci - @ce		--- se calcula nuevo saldo
			set @vi = @ci * @pu			--- se calcula valor ingreso
			set @ve= @ce * @ppa			--- se calcula valor de egreso con promedio anterior
			set @vs  = @avs + @vi  - @ve		--- se calcula saldo valor
			if(@cs<>0)  
			begin
				if (@vi>0 or @CI>0) set @pp=@vs/@cs		---- se calcula nuevo promedio
				else  set @pp=@ppa	
			end
			else set @pp=@ppa	
			if ABS(@pp)>9999999 set @PP=0
			set @ppa = @pp

			update kardex set cant_saldo=@cs, valo_saldo=@vs, prec_prom = @pp , valo_sali= @ve where codi_kard=@kar
			update productos set  prec_prom = @pp where codi_prod=@prod

			set @ACS = @CS			----- se obtiene nuevo saldo cantidad
			set @AVS = @VS			----- se obtiene nuevo saldo valor

			set @CI =0
			set @CE =0
			set @CS =0
			set @VI =0
			set @VE =0
			set @VS =0
			set @PU =0
			fetch C1 into @kar, @CI, @Ce, @CS, @PU, @PP, @VI,@VE, @VS
		end
		close C1
		deallocate C1
	end
	---PARA EL GENERAL ---------------------
	
	--*************************************************************************************
	---PARA EL CASO DE POR ALMACEN----
	set @cs 	= 0		 
	set @vi  	= 0
	set @ve	= 0
	set @vs 	= 0
	-- Tenemos que recuperar a que almacen esta asociado dicho producto ya que puede estar en varios almacen un Producto
/*	declare @codi_alma char(2)
	declare C2 cursor for  select distinct(codi_alma) from dbo.kardex (nolock) where codi_prod=@prod  and periodo=@peri 
	open C2
	fetch C2 into @codi_alma 
	WHILE @@FETCH_STATUS = 0
		begin	*/
		--- creamos un cursor para actualizar el producto segun almacen
		               select @Ctk= count(codi_kard) from dbo.kardex (nolock) where codi_prod=@prod and periodo=@peri and codi_alma=@codi_alma 

			if (@ctk is null) set @ctk=0
			if (@Ctk>1 )
			begin
				declare C3 cursor for  select codi_kard,cant_ingr, cant_sali, cant_saldo_alma, prec_unit, prec_prom_alma,
						valo_ingr_alma ,valo_sali_alma , valo_saldo_alma  
						from dbo.kardex (nolock) where periodo=@peri and codi_alma=@codi_alma  and codi_prod=@prod  
						order by fech_tran, i_o, codi_docu_i_o, item
				open C3
				set @ctF=0
				fetch C3 into @kar, @CI, @Ce, @CS, @PU, @PP, @VI,@VE, @VS
				WHILE @@FETCH_STATUS = 0
				begin		
					set @Ctf= @ctf +1
					if (@ctf=1) 
					    begin
						set @ACS = 0 --@CS	----- se obtiene el saldo cantidad
						set @AVS = 0---@VS	----- se obtiene el saldo valor
						set @PPA  =@pp	---- se obtiene el promedio
			  		    end
					set @cs = @acs + @ci - @ce		--- se calcula nuevo saldo
					set @vi = @ci * @pu			--- se calcula valor ingreso
					set @ve= @ce * @ppa			--- se calcula valor de egreso con promedio anterior
					set @vs  = @avs + @vi  - @ve		--- se calcula saldo valor
					if(@cs<>0)  
					begin
						if (@vi>0 or @CI>0) set @pp=@vs/@cs		---- se calcula nuevo promedio
						else  set @pp=@ppa	
					end
					else set @pp=@ppa	
					if ABS(@pp)>9999999 set @PP=0
					set @ppa = @pp
		
					update kardex set cant_saldo_alma=@cs, valo_saldo_alma=@vs, prec_prom_alma = @pp , valo_sali_alma= @ve where codi_kard=@kar

					update almacen_producto set 	prec_prom_ALMA = @pp where codi_prod=@prod  and codi_alma=@codi_alma
		
					set @ACS = @CS			----- se obtiene nuevo saldo cantidad
					set @AVS = @VS			----- se obtiene nuevo saldo valor
		
					set @CI =0
					set @CE =0
					set @CS =0
					set @VI =0
					set @VE =0
					set @VS =0
					set @PU =0

					fetch C3 into @kar, @CI, @Ce, @CS, @PU, @PP, @VI,@VE, @VS

				end
				close C3
				deallocate C3
			end
		
		--*************************************
/*		fetch C2 into @codi_alma 
		end 
	close C2
	deallocate C2	*/

	--------------------------------------------------------------
	
End
GO
