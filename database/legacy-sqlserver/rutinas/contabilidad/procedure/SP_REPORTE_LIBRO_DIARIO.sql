CREATE PROCEDURE [dbo].[SP_REPORTE_LIBRO_DIARIO]
	@mes [char](6),
	@proc [char](1)
WITH EXECUTE AS CALLER
AS
BEGIN
	DECLARE @cuen char(7)
	declare @fec datetime
	declare @doc char(10)
	declare @imp numeric(12,2)
	declare @ca char(1)
	declare @reg char(10)
	declare @comp char(10)
	declare @sd char(1)
	declare @ms char(2)
	declare @codi char(10)
	declare @desc varchar(100)
	declare @codpro char(5)
	declare @raz varchar(100)
	declare @cg numeric(12,2)
	declare @ab numeric(12,2)
	declare @mesaux char(6)
	declare @m numeric(2)
	declare @glo varchar(200)
	declare @sub char(7)
	declare @ven datetime	
	declare @dol numeric(12,2)

	set @m = cast(left(@mes,2) as numeric(2)) - 1
	set @mesaux =replicate('0', 2 - len(convert(varchar(2),@m) )) +convert(varchar(2),@m) + right(@mes,4)

	declare C1 cursor for SELECT Movi_Contables.Fecha,  Movi_Contables.Nro_Docu,   Movi_Contables.Importe,  Movi_Contables.Cargo_Abono,  Movi_Contables.Registro,   
		         Movi_Contables.Compr,  Movi_Contables.Subdia,    Movi_Contables.Codi_Contable,   Movi_Contables.Nro_Cuen,   CUENTAS_CONTABLE.DESC_CUEN,   
		         Movi_Contables.Codi_Clie_Prov,  CLIENTE_PROVEEDOR.DENOMINACION,  Movi_Contables.Glosa,  Movi_Contables.Nro_Sub_Cuen,
		         Movi_Contables.Fecha_Venc, Movi_Contables.Importe_d  FROM Movi_Contables,   CUENTAS_CONTABLE,   CLIENTE_PROVEEDOR  
		   WHERE ( CUENTAS_CONTABLE.NRO_CUEN =* Movi_Contables.Nro_Cuen ) and  ( CLIENTE_PROVEEDOR.CODI_CLIE_PROV =* Movi_Contables.Codi_Clie_Prov ) and  
		         ( ( Movi_Contables.Anio = right(@mes,4) ) AND ( Movi_Contables.Mes = left(@mes,2) ) )   and not ( Movi_Contables.Nro_Cuen is null)
			order by movi_contables.subdia, movi_contables.compr,
			movi_contables.cargo_abono desc, movi_contables.codi_contable, movi_contables.nro_cuen, movi_contables.fecha 

	
	create table #temporal ( fecha datetime null, codiprov char(5) null, razon varchar(100) null, nrodocu char(10) null,  cargo numeric(12,2) null, abonos numeric(12,2) null, registro char(10) null,
			compr char(10) null, subdia char(1) null, fechavenc datetime null , cuenta char(7) null , desc_cuenta varchar(100) null, codicontable char(10) null,saldoante numeric(12,2) null,
			impordol numeric(12,2) null, glosa varchar(200) null, subcuenta char(7) null , CAb char(1) null, suc numeric(12,2) null, sua numeric(12,2) null)
	open c1
	fetch c1 into @fec,@doc, @imp, @ca, @reg, @comp, @sd, @codi, @cuen, @desc, @codpro, @raz, @glo, @sub, @ven, @dol
	WHILE @@FETCH_STATUS=0
	begin	
		set @cg=0
		set @ab=0

		if (@ca='C') set @cg=@imp
		if (@ca='A') set @ab=@imp

		insert into #temporal ( fecha , codiprov , razon , nrodocu ,  cargo , abonos , registro,	compr , subdia , fechavenc  , cuenta, desc_cuenta, codicontable, saldoante,
			impordol , glosa  , subcuenta , cab)
		values (@fec, @codpro, @raz , @doc, @cg, @ab, @reg, @comp, @sd, @ven, @cuen,  @desc, @codi, dbo.f_saldo_ant(@mesaux, @cuen),
			@dol, @glo, @sub, @ca)
	
		fetch c1 into @fec,@doc, @imp, @ca, @reg, @comp, @sd, @codi, @cuen, @desc, @codpro, @raz, @glo, @sub, @ven, @dol
	end
	close C1
	deallocate C1
	
	declare @sal numeric(12,2)
	declare @ant numeric(12,2)
	declare @saln numeric(12,2)
	if (@proc='1')
	begin	
		declare C2 cursor for select cuenta, sum( ISNULL( cargo , 0 ) ) , sum ( isnull( abonos , 0 ) )   
		from #temporal group by cuenta order by cuenta
		open C2
		
		fetch C2 into @cuen , @cg, @ab
		WHILE @@FETCH_STATUS=0
		begin	
			set @ant=0

			if (@m>0) select @ant= ISNULL(saldonue , 0) from saldos_cuentas where nro_cuen=@cuen and mesanio=@mesaux
			
			insert into saldos_cuentas (mesanio, nro_cuen, saldoant, cargo, abono, saldonue, cargoacum,abonoacum)
			values( @mes, @cuen, @ant, isnull( @cg , 0 ) ,  isnull( @ab, 0 ) , isnull( @ant , 0 ) + isnull(  @cg , 0 ) -  isnull( @ab, 0 ) ,0,0)
	
			fetch C2 into @cuen , @cg, @ab
		end
		close C2		deallocate C2

		if (@m>0)
		begin
			DEclare C3 cursor for select nro_cuen , isnull( saldonue , 0 ) from saldos_cuentas where not nro_cuen in ( select movi_contables.nro_cuen from movi_contables 
				where mes=left(@mes,2) and anio=right(@mes,4) and not(movi_contables.nro_cuen is null) group by movi_contables.nro_cuen)  and mesanio=@mesaux
			open c3
			fetch c3 into @cuen,@saln	
			WHILE @@FETCH_STATUS=0
			begin	
				insert into saldos_cuentas (mesanio, nro_cuen, saldoant, cargo, abono, saldonue)
				values( @mes, @cuen, @saln, 0,0,@saln )
				fetch c3 into @cuen, @saln	
			end
			close C3
			deallocate C3
		end
		Declare C4 cursor for select nro_cuen, sum( isnull( cargo, 0 ) ) as C, sum( isnull( abono, 0 ) ) as A from saldos_cuentas 
				where mesanio<=@mes and right(mesanio,4)=right(@mes,4) group by nro_cuen order by nro_cuen
		Open C4
		fetch c4 into @cuen , @cg, @ab
		WHILE @@FETCH_STATUS=0
		begin	
			update saldos_cuentas set cargoacum=@cg, abonoacum=@ab  where nro_cuen=@cuen and mesanio=@mes
			fetch c4 into @cuen , @cg, @ab
		end 
		close C4
		deallocate C4	
	end

	declare @tcc numeric(12,2)
	declare @tca numeric(12,2)
---	select @tcc = sum(cargo) , @tca=sum(abono) from saldos_cuentas where left(mesanio,2)<=left(mes,2) and 

	select *	 from #temporal
END
GO
