CREATE PROCEDURE [dbo].[SP_REPORTE_LIBRO_MAYOR]
	@mes [char](6)
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

	set @m = cast(left(@mes,2) as numeric(2)) - 1
	set @mesaux =replicate('0', 2 - len(convert(varchar(2),@m) )) +convert(varchar(2),@m) + right(@mes,4)

	declare C1 cursor for SELECT Movi_Contables.Fecha,         Movi_Contables.Nro_Docu,          isnull(Movi_Contables.Importe , 0 ) ,          Movi_Contables.Cargo_Abono,   
		         Movi_Contables.Registro,         Movi_Contables.Compr,          Movi_Contables.Subdia,          Movi_Contables.Mes,        Movi_Contables.Codi_Contable,   
		         Movi_Contables.Nro_Cuen,       CUENTAS_CONTABLE.DESC_CUEN,    Movi_Contables.Codi_Clie_Prov,   
		         CLIENTE_PROVEEDOR.denominacion    FROM Movi_Contables,    CUENTAS_CONTABLE,    CLIENTE_PROVEEDOR  
		   WHERE ( CUENTAS_CONTABLE.NRO_CUEN =* Movi_Contables.Nro_Cuen ) and  ( CLIENTE_PROVEEDOR.CODI_CLIE_PROV =* Movi_Contables.Codi_Clie_Prov ) and  not (movi_contables.nro_cuen is null) and
		         ( ( Movi_Contables.Anio = right(@mes,4) ) AND ( Movi_Contables.Mes = left(@mes,2) ) )     and not ( Movi_Contables.Nro_Cuen is null)
			order by movi_contables.nro_cuen, movi_contables.fecha, codi_contable
	
	create table #temporal ( fecha datetime null, codiprov char(5) null, razon varchar(100) null, nrodocu char(10) null,  cargo numeric(12,2) null, abonos numeric(12,2) null, registro char(10) null,
			compr char(10) null, subdia char(1) null, nfile char(2) null , cuenta char(7) , desc_cuenta varchar(100) null, codicontable char(10) null,saldoante numeric(12,2) null)

	open c1
	fetch c1 into @fec,@doc, @imp, @ca, @reg, @comp, @sd, @ms, @codi, @cuen, @desc, @codpro, @raz
	WHILE @@FETCH_STATUS=0
	begin	
		set @cg=0
		set @ab=0

		if (@ca='C') set @cg=@imp
		if (@ca='A') set @ab=@imp

		insert into #temporal ( fecha , codiprov , razon , nrodocu ,  cargo , abonos , registro,	compr , subdia , nfile  , cuenta, desc_cuenta, codicontable, saldoante)
		values (@fec, @codpro, @raz , @doc, @cg, @ab, @reg, @comp, @sd, @ms,@cuen,  @desc, @codi, dbo.f_saldo_ant(@mesaux, @cuen))
	
		fetch c1 into @fec,@doc, @imp, @ca, @reg, @comp, @sd, @ms, @codi, @cuen, @desc, @codpro, @raz
	end
	close C1
	deallocate C1
	
	declare @sal numeric(12,2)
	declare @ant numeric(12,2)
	declare @saln numeric(12,2)

	DEclare C3 cursor for select nro_cuen , saldonue from saldos_cuentas where not nro_cuen in ( select movi_contables.nro_cuen from movi_contables 
		where mes=left(@mes,2) and anio=right(@mes,4) and not(movi_contables.nro_cuen is null) group by movi_contables.nro_cuen)  and mesanio=@mesaux
	open c3
	fetch c3 into @cuen,@saln	
	WHILE @@FETCH_STATUS=0
	begin	
		set @desc=''
		select @desc=desc_cuen from cuentas_contable where nro_cuen=@cuen

		insert into #temporal ( cargo , abonos , cuenta, desc_cuenta, saldoante)
		values (0, 0, @cuen,  @desc,  @saln)
		
		fetch c3 into @cuen, @saln	
	end
	close C3
	deallocate C3

	select *	 from #temporal
END
GO
