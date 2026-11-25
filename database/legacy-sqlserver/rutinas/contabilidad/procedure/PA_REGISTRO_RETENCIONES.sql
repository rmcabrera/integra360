CREATE PROCEDURE [dbo].[PA_REGISTRO_RETENCIONES]
	@TIPO [tinyint],
	@anio [char](4),
	@mes [char](2)
WITH EXECUTE AS CALLER
AS
DECLARE
	@anio_fpago	smallint,
	@mes_fpago	tinyint

	set @anio_fpago	= cast(@anio as smallint) 
	set @mes_fpago	= cast(@mes as tinyint) 

IF @TIPO= 1  -- MES Y ANIO
   BEGIN
	select  distinct COM.FECHA AS FECHA_PAGO, CLIE_PROV.codi_sunat as td, CLIE_PROV.ruc as DOCU_IDEN, CLIE_PROV.prov as APEL_NOM, 
	        (select sum(importe) from Movi_contables mv 
	         where mv.subdia='H' and mv.codi_vouc = MC.Codi_vouc and left(mv.nro_cuen,1)='6' and mv.cargo_abono='C') as BRUTO,
	        (select sum(importe) from Movi_contables mm 
		where mm.subdia='H' and mm.codi_vouc = MC.Codi_vouc and left(mm.nro_cuen,2)='40' and mM.cargo_abono='A') as RETEN,
	        (select sum(importe) from Movi_contables mt
		where mt.subdia='H' and mt.codi_vouc = MC.Codi_vouc and left(mt.nro_cuen,2)='46' and mt.cargo_abono='A') as NETO,
	        (select sum(importe_D) from Movi_contables m1 
	         where m1.subdia='H' and m1.codi_mone ='02' and m1.codi_vouc = MC.Codi_vouc and left(m1.nro_cuen,1)='6' and m1.cargo_abono='C') as BRUTO_D,
	        (select sum(importe_D) from Movi_contables m2 
		where m2.subdia='H'  and m2.codi_mone ='02' and m2.codi_vouc = MC.Codi_vouc and left(m2.nro_cuen,2)='40' and m2.cargo_abono='A') as RETEN_D,
	        (select sum(importe_D) from Movi_contables m3
		where m3.subdia='H'  and m3.codi_mone ='02' and m3.codi_vouc = MC.Codi_vouc and left(m3.nro_cuen,2)='46' and m3.cargo_abono='A') as NETO_D,
		COM.COMPR as NRO_DOCU_PAGO, 
	        (select max(registro)from movi_contables c where c.subdia='H' and c.codi_vouc = MC.codi_vouc )as REGISTRO,
		 MC.fecha
	from movi_contables MC INNER JOIN 
				     (select cp.codi_clie_prov, cp.ruc, tdi.codi_sunat,(case when upper(cp.tipo_pers)='NATURAL' then apel_1+' '+apel_2+ isnull(' '+nomb_1,'')+isnull(' '+nomb_2,'') else razo_soci end) as prov 
				      from cliente_proveedor  cp inner join TIPO_DOCU_IDEN tdi on cp.Codi_Tipo_Docu_Iden = tdi.Codi_Tipo_Docu_Iden 
				      ) CLIE_PROV
				      ON MC.Codi_clie_prov = CLIE_PROV.codi_clie_prov
				LEFT JOIN
				     (select distinct compr, fecha , registro from movi_contables mcon 
				      where mcon.ANIO > = @ANIO and mcon.MES >= @MES and mcon.subdia ='E' --IN ('E','M','L')
				      ) COM
				      ON (select max(registro)from movi_contables x where x.subdia='H' and x.codi_vouc = MC.codi_vouc ) = com.registro
	where ANIO =@ANIO and MES = @MES and subdia='H'
   END
ELSE
   BEGIN
	select  distinct COM.FECHA AS FECHA_PAGO, CLIE_PROV.codi_sunat as td, CLIE_PROV.ruc as DOCU_IDEN, CLIE_PROV.prov as APEL_NOM, 
	        (select sum(importe) from Movi_contables mv 
	         where mv.subdia='H' and mv.codi_vouc = MC.Codi_vouc and left(mv.nro_cuen,1)='6' and mv.cargo_abono='C') as BRUTO,
	        (select sum(importe) from Movi_contables mm 
		where mm.subdia='H' and mm.codi_vouc = MC.Codi_vouc and left(mm.nro_cuen,2)='40' and mM.cargo_abono='A') as RETEN,
	        (select sum(importe) from Movi_contables mt
		where mt.subdia='H' and mt.codi_vouc = MC.Codi_vouc and left(mt.nro_cuen,2)='46' and mt.cargo_abono='A') as NETO,
	        (select sum(importe_D) from Movi_contables m1 
	         where m1.subdia='H' and m1.codi_mone ='02' and m1.codi_vouc = MC.Codi_vouc and left(m1.nro_cuen,1)='6' and m1.cargo_abono='C') as BRUTO_D,
	        (select sum(importe_D) from Movi_contables m2 
		where m2.subdia='H'  and m2.codi_mone ='02' and m2.codi_vouc = MC.Codi_vouc and left(m2.nro_cuen,2)='40' and m2.cargo_abono='A') as RETEN_D,
	        (select sum(importe_D) from Movi_contables m3
		where m3.subdia='H'  and m3.codi_mone ='02' and m3.codi_vouc = MC.Codi_vouc and left(m3.nro_cuen,2)='46' and m3.cargo_abono='A') as NETO_D,
		COM.COMPR as NRO_DOCU_PAGO, 
	        (select max(registro)from movi_contables c where c.subdia='H' and c.codi_vouc = MC.codi_vouc )as REGISTRO,
		 MC.fecha
	from movi_contables MC INNER JOIN 
				     (select cp.codi_clie_prov, cp.ruc, tdi.codi_sunat,(case when upper(cp.tipo_pers)='NATURAL' then apel_1+' '+apel_2+ isnull(' '+nomb_1,'')+isnull(' '+nomb_2,'') else razo_soci end) as prov 
				      from cliente_proveedor  cp inner join TIPO_DOCU_IDEN tdi on cp.Codi_Tipo_Docu_Iden = tdi.Codi_Tipo_Docu_Iden 
				      ) CLIE_PROV
				      ON MC.Codi_clie_prov = CLIE_PROV.codi_clie_prov
				LEFT JOIN
				     (select distinct compr, fecha , registro from movi_contables mcon 
				      where mcon.ANIO > = @ANIO and mcon.MES >= @MES and mcon.subdia ='E' --IN ('E','M','L')
				      ) COM
				      ON (select max(registro)from movi_contables x where x.subdia='H' and x.codi_vouc = MC.codi_vouc ) = com.registro
	where year(COM.FECHA) = @ANIO_fpago 	and 
	      month(COM.FECHA)= @MES_fpago	and 
	      subdia ='H'
   END
GO
