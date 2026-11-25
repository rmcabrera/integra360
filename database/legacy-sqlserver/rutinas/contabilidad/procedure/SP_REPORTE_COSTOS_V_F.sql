CREATE PROCEDURE [dbo].[SP_REPORTE_COSTOS_V_F]
	@mesa [char](6)
WITH EXECUTE AS CALLER
AS
BEGIN
--	create table #Tempo1 ( tipo varchar(20) null , nro_cuen char(7) null ,desc_cuen varchar(200) null,  monto numeric(12,2) null , mesanio char(6) null)
	
	select  'Fijo' Tipo, nro_cuen, (select desc_cuen from cuentas_contable C where C.nro_cuen = S.nro_cuen) Desc_cuen,
		 isnull(sum(cargoacum - abonoacum),0) Monto , identity(int,1, 1) IDD 
	into #Tempo1
	from saldos_cuentas S
			where nro_cuen in (select nro_Cuen from cuentas_contable where tipo_costo='F') 
				and S.mesanio=@mesa
		group by nro_cuen

	select 'Variable' tipo2,nro_cuen nro_cuen2, (select desc_cuen from cuentas_contable C where C.nro_cuen = S.nro_cuen) Desc_cuen2,
		 isnull(sum(cargoacum - abonoacum),0) Monto2, identity(int,1,1) idd 
	into #Tempo2
		from saldos_cuentas S		
			where nro_cuen in (select nro_Cuen from cuentas_contable where tipo_costo='V') 
			and mesanio=@mesa
		group by nro_cuen

	select #tempo1.idd, tipo,nro_cuen, desc_cuen, isnull(monto,0) monto, @mesa mesanio, 
	          #tempo2.idd idd2, tipo2,nro_cuen2, desc_cuen2, isnull(monto2,0) monto2 ,
		(SELECT top 1 razon_social from empresa) empre	from #tempo1
	full join	#tempo2 on #tempo1.idd=#tempo2.idd

END
GO
