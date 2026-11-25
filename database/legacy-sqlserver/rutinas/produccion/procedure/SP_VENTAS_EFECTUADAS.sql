CREATE PROCEDURE [dbo].[SP_VENTAS_EFECTUADAS]
WITH EXECUTE AS CALLER
AS
Begin
	Declare @emb char(5)
	Declare @per char(5)
	Declare @fact char(10)
	Declare @ser char(3)
	Declare @nro varchar(10)
	Declare @fec datetime
	Declare @ii numeric(12)
	Declare @ton numeric(12,3)
	Declare @prec numeric(12,3)
	Declare @tp char(1)
	create Table #temporal (idd numeric(10) null, fecha datetime null,nro_compr varchar(50) null, embar char(5) null, toneladas numeric(12,3) null, 
	psnp_dolar numeric(12,2) null, psnp_soles numeric(12,2) null, tpc numeric(12,3) null, padi_dolar numeric(12,2) null, 
	padi_soles numeric(12,2) null, semana char(8) null)

	insert into #temporal
		select  codi_fact_pesc, fech_emis, rtrim(nro_fact) +'/'+(select top 1 nro_fact from detalle_factura_pesca D1, Factura_pesca F6
		 where D1.codi_deta_zarp in
		(select distinct D2.codi_deta_zarp from detalle_factura_pesca D2, factura_pesca F7 
			where D2.codi_fact_pesc=F.codi_fact_pesc and F7.codi_fact_pesc=D2.codi_fact_pesc
			and (F7.estado='' or  F7.estado is null))
		and F6.codi_fact_pesc=D1.codi_fact_pesc and D1.codi_fact_pesc<>F.codi_fact_pesc and
		(F6.estado='' or F6.estado is null) and F6.tipo_fact='D'), codi_unid_oper,
		(Select sum(cant_tone) from detalle_factura_pesca D where D.codi_fact_pesc=F.codi_fact_pesc) as TM,
		convert(numeric(12,2),(select precio from precio_snp P where P.codi_sema=F.codi_sema)/ 
	  	   isnull((select venta from tipo_cambio_a_dolar where convert(char(10),fech_camb,103) =convert(char(10),F.fech_emis,103) 
			and codi_mone_camb = '02' ),1)) SNPD,	
		(select precio from precio_snp P where P.codi_sema=F.codi_sema) SNPS,	
		(select venta from tipo_cambio_a_dolar where convert(char(10),fech_camb,103) =convert(char(10),F.fech_emis,103) 
			and codi_mone_camb = '02' ) TPC,
		(select top 1 prec_unit  from detalle_factura_pesca D1 ,Factura_pesca FP  
				where D1.codi_deta_zarp in (select codi_deta_zarp from detalle_factura_pesca D2 
				where D2.codi_fact_pesc=F.codi_fact_pesc and D1.codi_fact_pesc<>F.codi_fact_pesc)
				and Fp.codi_fact_pesc = D1.codi_Fact_pesc and Fp.estado is null) PADICD, 
		(select top 1 prec_unit  from detalle_factura_pesca D1 where D1.codi_deta_zarp in 
		(select codi_deta_zarp from detalle_factura_pesca D2 where D2.codi_fact_pesc=F.codi_fact_pesc)
		and D1.codi_fact_pesc<>F.codi_fact_pesc) * 
		(select venta from tipo_cambio_a_dolar 
			where convert(char(10),fech_camb,103) =convert(char(10),F.fech_emis,103) and codi_mone_camb = '02' ) PADICS, 
			codi_sema
		from factura_pesca F
		where (estado is null or estado='') and tipo_fact='P' 
		order by fech_emis, codi_clie_prov,codi_unid_oper , ser_fact,nro_fact


	select * from #temporal
end
GO
