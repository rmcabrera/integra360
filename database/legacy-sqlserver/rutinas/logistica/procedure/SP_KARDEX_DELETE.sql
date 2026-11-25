CREATE PROCEDURE [dbo].[SP_KARDEX_DELETE]
	@maxf [smalldatetime],
	@prod [char](8),
	@codi_alma [char](2)
WITH EXECUTE AS CALLER
AS
Begin
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
	declare @MFech datetime
	declare @peri  int

	set @ACS=0
	set @AVS=0	
	set @peri = year(@MaxF)

	--- **************************--- CASO GENERAL ---*****************------------------
	select  @MFech = max(fech_tran) from kardex(nolock) where periodo=@peri and codi_prod=@prod and  fech_tran <@MaxF 

	select  @Kar = max(codi_kard) from kardex (nolock) where periodo=@peri and codi_prod=@prod   and fech_tran = @MFech 
	
	if(not (@kar is null))  select @Acs=cant_saldo, @PPA= prec_prom, @AVS= valo_saldo  from kardex (nolock) where codi_kard=@kar
	else
	begin
		set @Acs=0
		set @Avs=0
		set @ppa=0
	end
	set @kar=null
	select @Ctk= count(codi_kard) from kardex (nolock) where periodo=@peri and codi_prod=@prod  and  fech_tran>=@maxF  
	
	declare C1 cursor for  select codi_kard,cant_ingr, cant_sali, cant_saldo, prec_unit, prec_prom,
			valo_ingr,valo_sali, valo_saldo  from kardex (nolock) 
			where periodo=@peri   and codi_prod=@prod   and fech_tran>=@maxF  
			order by codi_prod,fech_tran, i_o, codi_docu_i_o, item, codi_kard
	open C1
	
	fetch C1 into @kar, @CI, @Ce, @CS, @PU, @PP, @VI,@VE, @VS
	WHILE @@FETCH_STATUS = 0
	begin		

		set @cs = @acs + @ci - @ce		--- se calcula nuevo saldo
		set @vi = @ci * @pu			--- se calcula valor ingreso
		set @ve= @ce * @ppa			--- se calcula valor de egreso con promedio anterior
		set @vs  = @avs + @vi  - @ve		--- se calcula saldo valor
		if(@cs<>0) 
		begin
			if ( @vi>0 or @CI>0)  set @pp=@vs/@cs		---- se calcula nuevo promedio
			else  set @pp=@ppa	
		end
		else set @pp=@ppa	
		if ABS(@pp) >9999999 set @PP=0
		
		set @ppa = @pp

		update kardex set cant_saldo=@cs, valo_saldo=@vs, 
			prec_prom = @pp , valo_sali= @ve where codi_kard=@kar
		---arqui
		update productos set  prec_prom=@pp  where codi_prod=@prod 
		----
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

	---  FIN DE CASO GENERAL ------------------


	--- **************************--- CASO POR ALMACEN ---*****************------------------
	SET @CI	=0
	SET @Ce	=0
	SET @CS	=0
	SET @PU	=0
	SET @PP	=0
	SET @VI	=0
	SET @VE	=0
	SET @VS	=0

	select  @MFech = max(fech_tran) from kardex (nolock) where periodo=@peri and codi_alma=@codi_alma and codi_prod=@prod and  fech_tran<@MaxF 

	select  @Kar = max(codi_kard) from kardex (nolock) where periodo=@peri and codi_alma=@codi_alma and codi_prod=@prod  and  fech_tran = @MFech 
	
	if(not (@kar is null))  select @Acs=cant_saldo_alma , @PPA= prec_prom_alma, @AVS= valo_saldo_alma  from kardex (nolock) where codi_kard=@kar
	else
	begin
		set @Acs=0
		set @Avs=0
		set @ppa=0
	end
	set @kar=null
	select @Ctk= count(codi_kard) from kardex (nolock) where periodo=@peri and codi_alma=@codi_alma and codi_prod=@prod  and fech_tran>=@maxF 
	
	declare C2 cursor for  select codi_kard,cant_ingr, cant_sali, cant_saldo_alma , prec_unit , prec_prom_alma ,
			valo_ingr_alma ,valo_sali_alma , valo_saldo_alma  from kardex (nolock) 
			where periodo=@peri and codi_alma=@codi_alma   and codi_prod=@prod   and  fech_tran>=@maxF 
			order by codi_prod,fech_tran, i_o, codi_docu_i_o, item, codi_kard
	open C2
	
	fetch C2 into @kar, @CI, @Ce, @CS, @PU, @PP, @VI,@VE, @VS
	WHILE @@FETCH_STATUS = 0
	begin		

		set @cs = @acs + @ci - @ce		--- se calcula nuevo saldo
		set @vi = @ci * @pu			--- se calcula valor ingreso
		set @ve= @ce * @ppa			--- se calcula valor de egreso con promedio anterior
		set @vs  = @avs + @vi  - @ve		--- se calcula saldo valor
		if(@cs<>0) 
		begin
			if ( @vi>0 or @CI>0)  set @pp=@vs/@cs		---- se calcula nuevo promedio
			else  set @pp=@ppa	
		end
		else set @pp=@ppa	
		if ABS(@pp) >9999999 set @PP=0
		set @ppa = @pp

		update kardex set cant_saldo_alma=@cs, valo_saldo_alma=@vs, 
			prec_prom_alma = @pp , valo_sali_alma= @ve where codi_kard=@kar
		----arqui
		 update almacen_producto set  prec_prom_alma=@pp  where codi_prod=@prod and codi_alma=@codi_alma
		-----*******
		set @ACS = @CS			----- se obtiene nuevo saldo cantidad
		set @AVS = @VS			----- se obtiene nuevo saldo valor

		set @CI =0
		set @CE =0
		set @CS =0
		set @VI =0
		set @VE =0
		set @VS =0
		set @PU =0
		fetch C2 into @kar, @CI, @Ce, @CS, @PU, @PP, @VI,@VE, @VS
	end
	close C2
	deallocate C2

	---  FIN DE CASO POR ALMACEN ------------------

end
GO
