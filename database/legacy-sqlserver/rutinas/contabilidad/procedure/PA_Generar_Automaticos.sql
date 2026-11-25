CREATE PROCEDURE [dbo].[PA_Generar_Automaticos]
	@mes [char](2),
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
create table #tempC 
	       (	codigo			char(10)		,
		nro_cuen 		char(7)		NULL,
		nro_sub_cuen_2 	char(7)   	null ,
		importe 			decimal(18,2)	,
		importe_d 		decimal(18,2)	null ,
		codi_mone		char (2)		,
		tipo_cambio 		decimal(18,4)	null ,
		Codi_Unid_Oper 	char (5)		,
		cargo_abono  		char(1)
	       )

insert into #tempC 
select  mc.codi_contable,
	mc.nro_sub_cuen, 
	(Select nro_sub_cuen from cuentas_contable where nro_cuen =  mc.nro_sub_cuen),
	mc.importe, 
	mc.importe_d, 
	mc.codi_mone,
	mc.tipo_cambio,
	isnull(mc.codi_unid_oper,''),
	mc.cargo_abono
from movi_contables mc
where mc.anio= @ANIO and mc.mes = @MES and 		--arg
     ( 
       ( mc.subdia not in ('X','S') and 
	 ( (left(mc.nro_cuen,2) in ('60') and Left(mc.nro_sub_cuen,1) in ('2'))
	    OR
	    (left(mc.nro_cuen,2) in ('62','63','64','65','67','68') and  left(mc.nro_sub_cuen,1) in ('9'))
	  )
	)	
      )

insert into #tempC 
select  codigo,
	isnull(nro_sub_cuen_2,'7910101'),
	null,
	importe,
     	importe_d,
	codi_mone,
	tipo_cambio,
	codi_unid_oper,
	(Case when cargo_abono='C' Then 'A' Else 'C' End)
from #tempC
	

Select 	nro_cuen,
	importe ,
	importe_d ,
	codi_mone,
	tipo_cambio,
	Codi_Unid_Oper ,
	cargo_abono
from #tempC
order by codigo, cargo_abono desc



select
Cargo = sum( case when cargo_abono='C' THEN IMPORTE ELSE 0 END ),
Abono = sum( case when cargo_abono='A' THEN IMPORTE ELSE 0 END )
FROM #tempC
GO
