CREATE PROCEDURE [dbo].[SP_KARDEX_Reproceso]
	@prod [char](8),
	@peri [int]
WITH EXECUTE AS CALLER
AS
Begin
	declare @sto numeric(18,4)
	declare @sald numeric(18,4)
	declare @promed numeric(18,4)
	declare @ingr numeric(18,4)
	declare @egre numeric(18,4)
	declare @pr numeric(18,4)
	declare @mn char(2)
	declare @tpc numeric(18,4)
	declare  @valo_i numeric(18,4)
	declare @valo_s numeric(18,4)

	set @ingr=0
	set @egre=0
	set @valo_i=0
	set @valo_s=0

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
	declare @IO int
	declare @DOCU char(10), @tIPO char(2)
	set @ACS=0
	set @AVS=0	
	
	---PARA EL GENERAL ---------------------
	select @Ctk= count(codi_kard) from kardex (nolock) where codi_prod=@prod and periodo=@peri

	if (@ctk is null) set @ctk=0
	if (@Ctk>1 )
	begin
		
		declare C1 cursor for  select codi_kard,cant_ingr, cant_sali, cant_saldo, isnull(prec_unit,0) , prec_prom,
				valo_ingr,valo_sali, valo_saldo ,i_o, codi_docu_i_o from kardex  (nolock) 
				where 	codi_prod=@prod  and periodo=@peri 
				order by fech_tran, i_o, codi_docu_i_o, item
		open C1
		set @ctF=0
		fetch C1 into @kar, @CI, @Ce, @CS, @PU, @PP, @VI,@VE, @VS, @IO, @DOCU
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
			else 
			begin
				if (@vi>0 or @CI>0) set @pp=@pu else set @pp=@ppa	
			end

/*			if @IO=1 
			begin
				select  @tIPO = tipo_nota_ingr from nota_ingreso (nolock) where codi_nota_ingr=@DOCU
				if @Tipo='23' set  @pp=@ppa	
				
			end */
--			else
--				select  @tIPO = tipo_sali  from docu_sali_mate (nolock) where codi_docu_sali=@DOCU


			set @ppa = @pp

			update kardex set cant_saldo=@cs, valo_saldo=@vs, 
				prec_prom = @pp , valo_sali= @ve where codi_kard=@kar

			set @ACS = @CS			----- se obtiene nuevo saldo cantidad
			set @AVS = @VS			----- se obtiene nuevo saldo valor

			set @CI =0
			set @CE =0
			set @CS =0
			set @VI =0
			set @VE =0
			set @VS =0
			set @PU =0
			fetch C1 into @kar, @CI, @Ce, @CS, @PU, @PP, @VI,@VE, @VS ,@IO, @DOCU
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
	declare @codi_alma char(2)
	declare C2 cursor for  select distinct(codi_alma) from kardex (nolock)  where codi_prod=@prod  and periodo=@peri 
	open C2
	fetch C2 into @codi_alma 
	WHILE @@FETCH_STATUS = 0
		begin	
		--- creamos un cursor para actualizar el producto segun almacen
		               select @Ctk= count(codi_kard) from kardex where codi_prod=@prod and periodo=@peri and codi_alma=@codi_alma 

			if (@ctk is null) set @ctk=0
			if (@Ctk>1 )
			begin
				declare C3 cursor for  select codi_kard,cant_ingr, cant_sali, cant_saldo_alma, 
								isnull(prec_unit,0) , prec_prom_alma,
						valo_ingr_alma ,valo_sali_alma , valo_saldo_alma  , i_o, codi_docu_i_o
						from kardex (nolock)  where 
						codi_prod=@prod  and periodo=@peri and codi_alma=@codi_alma 
						order by fech_tran, i_o, codi_docu_i_o, item

				open C3
				set @ctF=0
				fetch C3 into @kar, @CI, @Ce, @CS, @PU, @PP, @VI,@VE, @VS,@IO, @DOCU
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
					else
					begin
						if (@vi>0 or @CI>0) set @pp=@pu else set @pp=@ppa	
					end
/*
					if @IO=1 
					begin
						select  @tIPO = tipo_nota_ingr from nota_ingreso (nolock) where codi_nota_ingr=@DOCU
						if @Tipo='23' set @pp=@ppa	
						
					end 
*/
			
					set @ppa = @pp
		
					update kardex set cant_saldo_alma=@cs, valo_saldo_alma=@vs, 
						prec_prom_alma = @pp , valo_sali_alma= @ve where codi_kard=@kar
		
					set @ACS = @CS			----- se obtiene nuevo saldo cantidad
					set @AVS = @VS			----- se obtiene nuevo saldo valor
		
					set @CI =0
					set @CE =0
					set @CS =0
					set @VI =0
					set @VE =0
					set @VS =0
					set @PU =0

					fetch C3 into @kar, @CI, @Ce, @CS, @PU, @PP, @VI,@VE, @VS,@IO, @DOCU

				end
				close C3
				deallocate C3
			end
		
		--*************************************
		fetch C2 into @codi_alma 
		end 
	close C2
	deallocate C2	

	--------------------------------------------------------------
	
End
GO
