CREATE PROCEDURE [dbo].[usp_reporte_ventas_daot]
	@sd [char](1),
	@anio [char](4),
	@fi [datetime],
	@ff [datetime],
	@UIT [numeric](12, 4)
WITH EXECUTE AS CALLER
AS
--declare @sd char(1), @anio char(4), @fi datetime, @ff datetime , @UIT numeric(12,4)
--select @sd ='V', @anio ='2010', @fi ='01/01/2010' , @ff ='31/01/2010' , @UIT =3*3600

set nocount on 

declare @ctaexo char(7)

set @ctaexo = (select cuenta from cuentas_provision (nolock) where codigo=22)

SELECT  MC.Codi_Clie_Prov ,
	(select ruc from cliente_proveedor c (nolock) where c.codi_clie_prov=Mc.codi_clie_prov) ruc,
	(select denominacion from cliente_proveedor c (nolock) where c.codi_clie_prov=Mc.codi_clie_prov) RAZO_SOCI,
	(select Razon_Social from empresa (nolock) ) razon_social,
	(select Ruc from empresa (nolock) ) rucempre,
	sum(case when left(nro_cuen,1)='7' and nro_cuen<>@ctaexo then Importe*(case when cargo_abono='A' then 1 else -1 end) else 0 end) venta,
	sum(case when left(nro_cuen,2)='40' then Importe*(case when cargo_abono='A' then 1 else -1 end)  else 0 end) igv,
	sum(case when nro_cuen=@ctaexo then Importe*(case when cargo_abono='A' then 1 else -1 end)  else 0 end) otros,
	sum(case when left(nro_cuen,2)='12' then Importe* (case when cargo_abono='C' then 1 else -1 end)else 0 end) total,
	sum(case when left(nro_cuen,2)='12' then Importe_d* (case when cargo_abono='C' then 1 else -1 end) else 0 end) totalDolar,
	@uit uit
FROM Movi_Contables MC  (nolock)
WHERE MC.Anio =@anio  And   MC.Subdia = @sd
	And  ( MC.Fecha >= @fi ) And  ( MC.Fecha < DATEADD ( day, 1,@ff ) )
group by codi_clie_prov
GO
