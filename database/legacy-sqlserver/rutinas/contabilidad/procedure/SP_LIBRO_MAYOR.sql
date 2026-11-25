CREATE PROCEDURE [dbo].[SP_LIBRO_MAYOR]
	@mes [char](6),
	@Tipo [char](1)
WITH EXECUTE AS CALLER
AS
--declare @mes char(6) , @Tipo char(1)
--select @mes ='062009' , @Tipo='D'

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
	declare @codi char(10)
	declare @desc varchar(100)
	declare @codpro char(5)
	declare @raz varchar(100)
	declare @cg numeric(12,2)
	declare @ab numeric(12,2)
	declare @mesaux char(6)
	declare @m numeric(2)

	declare @msx int
	declare @anix int
	declare @sal numeric(12,2)
	declare @ant numeric(12,2)
	declare @saln numeric(12,2)

	set @anix = cast (right(@mes,4) as int)
	set @msx = cast ( left(@mes,2) as int)

	set @m = cast(left(@mes,2) as numeric(2)) - 1
	set @mesaux =replicate('0', 2 - len(convert(varchar(2),@m) )) +convert(varchar(2),@m) + right(@mes,4)

	
	create table #temporal ( fecha datetime null, codiprov char(5) null, razon varchar(100) null, nrodocu char(10) null,  cargo numeric(12,2) null, abonos numeric(12,2) null, registro char(10) null,
			compr char(10) null, subdia char(1) null, nfile char(2) null , cuenta char(7) , desc_cuenta varchar(100) null, codicontable char(10) null,saldoante numeric(12,2) null, orden int null)

	if @Tipo='D'
	begin
		insert into #temporal( fecha , codiprov , razon , nrodocu ,  cargo , abonos , registro ,
			compr , subdia , nfile  , cuenta , desc_cuenta , codicontable ,saldoante , orden)
		 SELECT Movi_Contables.Fecha,     Movi_Contables.Codi_Clie_Prov, 
			(Select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end 
				from cliente_proveedor (nolock) where codi_clie_prov=Movi_Contables.Codi_Clie_Prov),
			    Movi_Contables.Nro_Docu,      case when cargo_abono='C' then    Movi_Contables.Importe else 0 end,
	   			case when cargo_abono='A' then    Movi_Contables.Importe else 0 end,
			              Movi_Contables.Registro,         Movi_Contables.Compr,          Movi_Contables.Subdia,          Movi_Contables.Mes,     
				 Movi_Contables.Nro_Cuen, 
				(Select desc_cuen from cuentas_contable (nolock) where nro_cuen =  Movi_Contables.Nro_Cuen) ,
				  Movi_Contables.Codi_Contable , 
				isnull(  (select saldonue from saldos_cuentas (nolock) where mesanio=@mesaux and nro_Cuen= Movi_Contables.Nro_Cuen), 0) SAldAn,
				(select orden from subdiario (nolock) where nemotec= subdia)
			      FROM Movi_Contables (nolock)  
			      WHERE  ( ( Movi_Contables.Anio = @anix ) AND ( Movi_Contables.Mes =@msx ) )   
			         	  and not ( Movi_Contables.Nro_Cuen is null)
				order by movi_contables.nro_cuen, movi_contables.fecha, codi_contable
	

		insert into #temporal ( cargo , abonos , cuenta, desc_cuenta, saldoante)
				select  0, 0, nro_cuen , 
					(select desc_cuen from cuentas_contable (nolock) where nro_cuen= saldos_cuentas.nro_cuen) ,	
					isnull(saldonue,0) from saldos_cuentas where not nro_cuen in ( select movi_contables.nro_cuen from movi_contables (nolock)
						where anio=@anix and  mes=@msx and not(movi_contables.nro_cuen is null)
				group by movi_contables.nro_cuen)  and mesanio=@mesaux
	end
	else
	begin
		insert into #temporal( fecha , codiprov , razon , nrodocu ,  cargo , abonos , registro ,
			compr , subdia , nfile  , cuenta , desc_cuenta , codicontable ,saldoante , orden)
		 SELECT Movi_Contables.Fecha,     Movi_Contables.Codi_Clie_Prov, 
			(Select case when razo_soci is null or rtrim(razo_soci)='' then denominacion else razo_soci end 
				from cliente_proveedor (nolock) where codi_clie_prov=Movi_Contables.Codi_Clie_Prov),
			    Movi_Contables.Nro_Docu,      case when cargo_abono='C' then    Movi_Contables.Importe else 0 end,
	   			case when cargo_abono='A' then    Movi_Contables.Importe else 0 end,
			              Movi_Contables.Registro,         Movi_Contables.Compr,          Movi_Contables.Subdia,          Movi_Contables.Mes,     
				 Movi_Contables.Nro_Cuen, 
				(Select desc_cuen from cuentas_contable (nolock) where nro_cuen =  Movi_Contables.Nro_Cuen) ,
				  Movi_Contables.Codi_Contable , 
				0.00 SaldAn,
				(select orden from subdiario (nolock) where nemotec= subdia)
			      FROM Movi_Contables (nolock)  
			      WHERE  ( Movi_Contables.Anio = @anix ) AND ( Movi_Contables.Mes <=@msx ) 
					  and not ( Movi_Contables.Nro_Cuen is null)
				order by movi_contables.nro_cuen, movi_contables.fecha, codi_contable
	end


	select  fecha , codiprov , razon , nrodocu ,  cargo , abonos , registro ,
		compr , subdia , nfile  , cuenta , desc_cuenta , codicontable ,saldoante , orden 
	from #temporal

	drop table #temporal
END
GO
