CREATE PROCEDURE [dbo].[SP_LIBRO_DIARIO]
	@mes [char](6),
	@proc [char](1)
WITH EXECUTE AS CALLER
AS
--declare @mes char(6), @proc char(1) 
--select @mes ='022016', @proc ='1'

set nocount on 
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
	
	create table #temporal ( fecha datetime null, codiprov char(5) null, razon varchar(100) null, nrodocu char(20) null,  cargo numeric(12,2) null, abonos numeric(12,2) null, registro char(10) null,
			compr char(10) null, subdia char(1) null, fechavenc datetime null , cuenta char(7) null , desc_cuenta varchar(100) null, codicontable char(10) null,saldoante numeric(12,2) null,
			impordol numeric(12,2) null, glosa varchar(200) null, subcuenta char(7) null , CAb char(1) null, suc numeric(12,2) null, sua numeric(12,2) null, orden int null)

	insert into #temporal 
	SELECT Movi_Contables.Fecha, Movi_Contables.Codi_Clie_Prov, 
		(Select denominacion from cliente_proveedor  where codi_clie_prov = Movi_Contables.Codi_Clie_Prov ) as Denominacion,
		 Movi_Contables.Nro_Docu, 
		case when cargo_abono='C' then  Movi_Contables.Importe else 0 end as Cargo , 
		 case when cargo_abono='A' then Movi_Contables.Importe else 0 end as Abono,
		 Movi_Contables.Registro, Movi_Contables.Compr,  Movi_Contables.Subdia,Movi_Contables.Fecha_Venc,
		Movi_Contables.Nro_Cuen, (Select desc_cuen from cuentas_contable where nro_cuen=Movi_Contables.Nro_Cuen) as DESC_CUEN, 
		Movi_Contables.Codi_Contable,
		isnull(   (select saldonue from saldos_cuentas where mesanio=@mesaux and nro_Cuen= Movi_Contables.Nro_Cuen), 0) SAldAnt,  
		Movi_Contables.Importe_d, Movi_Contables.Glosa,  Movi_Contables.Nro_Sub_Cuen,
		Movi_Contables.cargo_abono,0,0 ,(select orden from subdiario where nemotec = subdia) 
	FROM Movi_Contables
	WHERE  ( ( Movi_Contables.Anio = right(@mes,4) ) AND ( Movi_Contables.Mes = left(@mes,2) ) )   and not ( Movi_Contables.Nro_Cuen is null)
	ORDER BY  movi_contables.subdia, movi_contables.compr,
		         movi_contables.cargo_abono desc, movi_contables.codi_contable, movi_contables.nro_cuen, movi_contables.fecha 
	
	declare @sal numeric(12,2)
	declare @ant numeric(12,2)
	declare @saln numeric(12,2)


	if (@proc='1')
	begin	
		INSERT INTO  saldos_cuentas
	    	SELECT  @mes, cuenta,  avg(saldoante),
			  sum(cargo), sum(abonos), avg(saldoante) + sum(cargo) - sum(abonos) , 0,0  
		FROM  #temporal
		GROUP BY cuenta 
		ORDER BY cuenta
	
		INSERT INTO  saldos_cuentas
		SELECT  @mes,  k.nro_cuen ,isnull( k.saldonue,0) ,0,0, isnull(k.saldonue ,0) ,0,0
 		FROM      saldos_cuentas as K
		WHERE   not k.nro_cuen in ( 
					 select movi_contables.nro_cuen from movi_contables 
		 			where mes=left(@mes,2) and anio=right(@mes,4) and not (movi_contables.nro_cuen is null )
					group by movi_contables.nro_cuen
					) 
			and mesanio=@mesaux



		UPDATE saldos_cuentas 
		SET cargoacum= (
				  select sum(cargo) 
				  from saldos_cuentas as k
				  where mesanio<=@mes and right(mesanio,4)=right(@mes,4) and k.nro_cuen= saldos_cuentas.nro_cuen
				   ),
		       abonoacum =(
				    select sum(abono) from saldos_cuentas as k
				    where mesanio<=@mes and right(mesanio,4)=right(@mes,4) and k.nro_cuen=saldos_cuentas.nro_cuen
                                                                     ) 
		WHERE  mesanio=@mes






	end

	select *	 from #temporal
	drop table #temporal
END
GO
