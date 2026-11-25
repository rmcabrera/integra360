CREATE PROCEDURE [dbo].[SP_REPORTE_POSI_DETA_BANC]
	@mes [char](6),
	@proc [char](1),
	@FECHA [datetime]
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
	declare @tipo_docu char(4)

	set @m = cast(left(@mes,2) as numeric(2)) - 1
	set @mesaux =replicate('0', 2 - len(convert(varchar(2),@m) )) + convert(varchar(2),@m) + right(@mes,4)

	declare C1 cursor for SELECT Movi_Contables.Fecha,  Movi_Contables.Nro_Docu,   Movi_Contables.Importe,  Movi_Contables.Cargo_Abono,  Movi_Contables.Registro,   
		         Movi_Contables.Compr,  Movi_Contables.Subdia,    Movi_Contables.Codi_Contable,   Movi_Contables.Nro_Cuen,   CUENTAS_CONTABLE.DESC_CUEN,   
		         Movi_Contables.Codi_Clie_Prov,  CLIENTE_PROVEEDOR.DENOMINACION,  Movi_Contables.Glosa,  Movi_Contables.Nro_Sub_Cuen,
		         Movi_Contables.Fecha_Venc, Movi_Contables.Importe_d  , MOVI_CONTABLES.CODI_TIPO_DOCU
		         FROM Movi_Contables,   CUENTAS_CONTABLE,   CLIENTE_PROVEEDOR  
		         WHERE ( CUENTAS_CONTABLE.NRO_CUEN = Movi_Contables.Nro_Cuen ) and  ( CLIENTE_PROVEEDOR.CODI_CLIE_PROV = Movi_Contables.Codi_Clie_Prov ) 
		         and  (  Movi_Contables.Anio = right(@mes,4) ) AND ( movi_contables.fecha <= @fecha ) and ( left(movi_contables.nro_cuen , 3) = '104' ) 
			order by movi_contables.subdia, movi_contables.compr, movi_contables.cargo_abono desc, 	movi_contables.codi_contable, movi_contables.nro_cuen, movi_contables.fecha 

	
	create table #temporal ( fecha datetime null, codiprov char(5) null, razon varchar(100) null, nrodocu char(10) null,  cargo numeric(12,2) null, abonos numeric(12,2) null, registro char(10) null,
			compr char(10) null, subdia char(1) null, fechavenc datetime null , cuenta char(7) , desc_cuenta varchar(100) null, codicontable char(10) null,saldoante numeric(12,2) null,
			impordol numeric(12,2) null, glosa varchar(200) null, subcuenta char(7) null , CAb char(1) null, suc numeric(12,2) null, sua numeric(12,2) null , tipo_docu char(4))

	create table #temporal_2 ( fecha datetime null, codiprov char(5) null, razon varchar(100) null, nrodocu char(10) null,  cargo numeric(12,2) null, abonos numeric(12,2) null, 
			compr char(10) null, subdia char(1) null, cuenta char(7) , desc_cuenta varchar(100) null, 
			impordol numeric(12,2) null, glosa varchar(200) null, CAb char(1) null, INDI_SALD CHAR(1), TIPO_DOCU CHAR(4))

	open c1
	fetch c1 into @fec,@doc, @imp, @ca, @reg, @comp, @sd, @codi, @cuen, @desc, @codpro, @raz, @glo, @sub, @ven, @dol, @tipo_docu
	WHILE @@FETCH_STATUS=0
	begin	
		set @cg=0
		set @ab=0

		if (@ca='C') set @cg=@imp
		if (@ca='A') set @ab=@imp

		insert into #temporal ( fecha , codiprov , razon , nrodocu ,  cargo , abonos , registro,	compr , subdia , fechavenc  , cuenta, desc_cuenta, codicontable, saldoante,
			impordol , glosa  , subcuenta , cab, tipo_docu)
		values (@fec, @codpro, @raz , @doc, @cg, @ab, @reg, @comp, @sd, @ven, @cuen,  @desc, @codi, dbo.f_saldo_ant(@mesaux, @cuen),
			@dol, @glo, @sub, @ca, @tipo_docu )
	
		fetch c1 into @fec,@doc, @imp, @ca, @reg, @comp, @sd, @codi, @cuen, @desc, @codpro, @raz, @glo, @sub, @ven, @dol, @tipo_docu
	end
	close C1
	deallocate C1
	
	declare @sal numeric(12,2)
	declare @ant numeric(12,2)
	declare @saln numeric(12,2)
	
	declare C2 cursor for select fecha , codiprov , razon , nrodocu ,  cargo , abonos , registro, compr , subdia , fechavenc  , cuenta, desc_cuenta, 
				impordol , glosa  , cab, tipo_docu   from #temporal group by cuenta order by cuenta
	open C2
	
	fetch C2 into  @fec, @codpro, @raz, @doc, @cg, @ab, @reg, @comp, @sub, @ven, @cuen, @desc, @dol, @glo, @ca, @tipo_docu

	WHILE @@FETCH_STATUS=0
	begin	

		insert into #temporal_2 ( fecha , codiprov , razon , nrodocu ,  cargo , abonos ,  compr , subdia , cuenta, desc_cuenta, 
			impordol , glosa , cab, tipo_docu)
		values (@fec, @codpro, @raz , @doc, @cg, @ab, @comp, @sub, @cuen,  @desc,  @dol, @glo, @ca, @tipo_docu )

		fetch C2 into  @fec, @codpro, @raz, @doc, @cg, @ab, @reg, @comp, @sub, @ven, @cuen, @desc, @dol, @glo, @ca, @tipo_docu
	end
	close C2	deallocate C2


	select *	 from #temporal order by cuenta, fecha
END
GO
