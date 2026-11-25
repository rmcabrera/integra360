CREATE PROCEDURE [dbo].[usp_ventas_x_sucur_compar]
	@TIPO [char](1),
	@ANIO1 [int],
	@ANIO2 [int],
	@CODI_TIPO_PAGO [int]
WITH EXECUTE AS CALLER
AS
--declare @TIPO CHAR(1) ,  @ANIO1 int ,  @ANIO2 int  ,  @CODI_TIPO_PAGO int
--select @TIPO = 0 ,  @ANIO1 =2016 ,  @ANIO2 =2016 ,  @CODI_TIPO_PAGO =0

set nocount on

declare  @TP table (CODI_TIPO_PAGO int )

IF @TIPO='1'
	insert @TP
	select @CODI_TIPO_PAGO
else
	insert @TP
	select 1 union all
	select 4 


declare @Rx table (nemo_alma varchar(50) null, codi_tipo_pago int null, 
			anio int null , mes int null, venta numeric(18,2) null, costo numeric(18,2) null)

insert @Rx
select nemo_alma, codi_tipo_pago, year(fech_fact), month(fech_Fact),
	sum((CASE fac.CODI_MONE WHEN '01' THEN 1 ELSE fac.tcambio END ) * ( CANT_ITEM *  PREC_ITEM )) valor,
	sum((CASE COD_IMPUESTO WHEN 3 THEN 1 ELSE 1+valor_igv/100.00 END ) * ( CANT_ITEM * PREC_COSTO )) costo
FROM dbo.ALMACEN as SUC (nolock)  
	inner join dbo.FACTURA as FAC (nolock) on suc.codi_alma=FAC.codi_alma
	inner join dbo.FACTURA_DETALLE as FD (nolock)  on FAC.codi_fact = FD.codi_fact 
	inner join dbo.PRODUCTOS as P (nolock) on FD.codi_prod=P.Codi_prod
   where FAC.CODI_TIPO_PAGO in (select CODI_TIPO_PAGO from @TP ) and  
		-- cast(convert(char(10), fac.fech_fact,103) as datetime) between @f1 and @f2 and  
		year(fac.fech_fact) between @anio1 and @anio2 and 
		( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)
		--and fac.codi_alma='04'
group by  SUC.NEMO_ALMA , FAC.CODI_TIPO_PAGO, year(fech_fact), month(fech_Fact)


select  anio,
	right('0'+cast(Mes as varchar),2)+'-'+dbo.uf_nom_mes(mes) Mes,
	NEMO_ALMA , 
	'1.Venta' as Tipo, 
	(CASE  CODI_TIPO_PAGO WHEN 1 THEN 'CONTADO' WHEN 4 THEN 'CREDITO' ELSE '' END) AS 'TIPO_VENTA' ,
	 cast(venta as numeric(12,2)) as valor
   FROM @Rx			--- venta
union all
select  anio,
	right('0'+cast(Mes as varchar),2)+'-'+dbo.uf_nom_mes(mes) Mes,
	NEMO_ALMA , 
	'2.Costo' as Tipo, 
	(CASE  CODI_TIPO_PAGO WHEN 1 THEN 'CONTADO' WHEN 4 THEN 'CREDITO' ELSE '' END) AS 'TIPO_VENTA' ,
	 cast(costo as numeric(12,2))
   FROM @Rx			--- costo
union all
select  anio,
	right('0'+cast(Mes as varchar),2)+'-'+dbo.uf_nom_mes(mes) Mes,
	NEMO_ALMA , 
	'3.Utilidad' as Tipo, 
	(CASE  CODI_TIPO_PAGO WHEN 1 THEN 'CONTADO' WHEN 4 THEN 'CREDITO' ELSE '' END) AS 'TIPO_VENTA' ,
	cast(venta - costo as numeric(12,2)) as utilidad
   FROM @Rx			---- utilidad
union all
select  anio,
	right('0'+cast(Mes as varchar),2)+'-'+dbo.uf_nom_mes(mes) Mes,
	NEMO_ALMA , 
	'4.%Utilidad' as Tipo, 
	(CASE  CODI_TIPO_PAGO WHEN 1 THEN 'CONTADO' WHEN 4 THEN 'CREDITO' ELSE '' END) AS 'TIPO_VENTA' ,
	cast(round((venta - costo)/ case when venta<>0 then venta*100.00 else 1 end ,2) as numeric(12,2)) PorcUtil
   FROM @Rx			---- porcutil

order by 1,2
GO
