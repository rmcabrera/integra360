CREATE PROCEDURE [dbo].[usp_genera_automatico]
	@ms [char](2),
	@ani [char](4)
WITH EXECUTE AS CALLER
AS
--declare @ms char(2), @ani char(4)
--select @ms='01' , @ani='2011'

set nocount on 
/*
select codi_nota_ingr, codi_prod,cast((select case when codi_mone='02' then
	 (Select venta from tipo_cambio_a_dolar where codi_mone_camb = '02' and CONVERT(CHAR(10),fech_camb,103) = CONVERT(CHAR(10),isnull(n.fech_reg_fact,n.fech_guia_remi),103))
   else 1 end 	from nota_ingreso N where N.codi_nota_ingr=DN.codi_nota_ingr)*cast(prec_unit*cantidad as numeric(12,2)) as numeric(12,2))Total,
	(case when (select tipo_nota_ingr from nota_ingreso Ni where ni.codi_nota_ingr=Dn.codi_nota_ingr)='13' then 
			(select p.nro_cuen from productos P where P.codi_prod=DN.codi_prod)
			else 	(select nro_sub_cuen from cuentas_contable C 
			where C.nro_cuen= DN.nro_cuen) end ) Cuenta, 'C' cargo_abono,
	(case when (select tipo_nota_ingr from nota_ingreso Ni where ni.codi_nota_ingr=Dn.codi_nota_ingr)='13' then 
					(select (select nro_sub_cuen from cuentas_contable C1 where c1.nro_cuen=p.nro_cuen) 
				from productos P where P.codi_prod=DN.codi_prod) 
	else 
			(select nro_sub_cuen from cuentas_contable CC where CC.nro_cuen in 
				(select nro_sub_cuen from cuentas_contable C where C.nro_cuen= DN.nro_cuen)) end ) Subcuen , 'A' subdia ,'1' compr,
	'01' moneda, 0.00 dolar, codi_prod Glosa, cast(@ms as char(2)) mes , cast(@ani as char(4)) anio,
	cast(cast(codi_nota_ingr as numeric) as char(10)) codi, cast(NULL as char(5)) codi_unid_oper
   from detalle_nota_ingreso DN (nolock)
	where codi_nota_ingr in
	(select codi_nota_ingr from nota_ingreso where month(fech_nota_ingr)=@ms and year(fech_nota_ingr)=@ani
		and not tipo_nota_ingr in ('01','04','11','23','02') )
union all
select codi_nota_ingr, codi_prod,cast((select case when codi_mone='02' then 
	(Select venta from tipo_cambio_a_dolar where codi_mone_camb = '02' and CONVERT(CHAR(10),fech_camb,103) = CONVERT(CHAR(10),isnull(n.fech_reg_fact,n.fech_guia_remi),103))
		 else 1 end 	from nota_ingreso N where N.codi_nota_ingr=DN.codi_nota_ingr)*cast(prec_unit*cantidad as numeric(12,2))  as numeric(12,2))Total,
	case when (select tipo_nota_ingr from nota_ingreso Ni where ni.codi_nota_ingr=Dn.codi_nota_ingr)='13' then dn.nro_cuen
		else 	(select (select nro_sub_cuen from cuentas_contable CC
				 where CC.nro_cuen=C.nro_sub_cuen) from cuentas_contable C where C.nro_cuen=DN.nro_cuen) end Cuenta, 'A' cargo_abono,

	case when (select tipo_nota_ingr from nota_ingreso Ni where ni.codi_nota_ingr=Dn.codi_nota_ingr)='13' then 
		(select nro_sub_cuen from cuentas_contable CCC where CCC.nro_cuen=Dn.nro_cuen )
	else	(select nro_sub_cuen from cuentas_contable CCC where CCC.nro_cuen in 
			(select (select nro_sub_cuen from cuentas_contable CC
				where CC.nro_cuen=C.nro_sub_cuen) from cuentas_contable C where C.nro_cuen=DN.nro_cuen)) end Subcuen , 'A' subdia , '1' compr,
	'01' moneda, 0.00 dolar ,  codi_prod Glosa, @ms mes , @ani anio,
	cast(cast(codi_nota_ingr as numeric) as char(10)) codi, null codi_unid_oper
	  from detalle_nota_ingreso DN (nolock)
	where codi_nota_ingr in
	(select codi_nota_ingr from nota_ingreso where month(fech_nota_ingr)=@ms and year(fech_nota_ingr)=@ani
		and not tipo_nota_ingr in ('01','04','11','23','02') )
union all
*/
select '' codi_nota_ingr, '' prod, abs((case when cargo_abono='C' then importe  else -1*importe end)) total,nro_sub_cuen cuenta,
	case when (case when cargo_abono='C' then importe  else -1*importe end)>0 THEN 'C' else 'A' end cargo_abono,
	(select nro_sub_cuen from cuentas_contable CC where CC.nro_cuen = m.nro_sub_cuen) Subcuen , 'A' subdia ,'1' compr,
	'01' moneda, 0.00 dolar, Glosa, @ms  mes , @ani anio,
	codi_nota_ingr codi, cast(NULL as char(5)) codi_unid_oper	
from movi_contables M (nolock)
where mes= @ms and anio= @ani  and left(nro_cuen,1)='6' and left(nro_cuen,2) not in ('69' ,'61','66') 
	and left( nro_sub_cuen ,1 ) = '2'  --and codi_tipo_docu <>'0007'
	and not (SUBDIA='Y' or SUBDIA='Z' or SUBDIA='X'  or SUBDIA='S'  or SUBDIA='A' )
union all
select null, null , abs((case when cargo_abono='C' then importe  else -1*importe end)) total,
	(select nro_sub_cuen from cuentas_contable CC where CC.nro_cuen = m.nro_sub_cuen) nro_cuen,
	case when (case when cargo_abono='C' then importe  else -1*importe end)>0 THEN 'A' else 'C' end cargo_abono,
	(select nro_sub_cuen from cuentas_contable c where c.nro_cuen in 
		(select nro_sub_cuen from cuentas_contable CC where CC.nro_cuen = m.nro_sub_cuen)) Subcuen , 'A' subdia ,'1' compr,
	'01' moneda, 0.00 dolar, Glosa, @ms mes , @ani anio,
	codi_nota_ingr codi, cast(NULL as char(5)) codi_unid_oper	
from movi_contables M (nolock)
where mes= @ms and anio= @ani  and left(nro_cuen,1)='6' and left(nro_cuen,2) not in ('69' ,'61','66') 
	and left( nro_sub_cuen ,1 ) = '2'--  and codi_tipo_docu <>'0007'
	and not (SUBDIA='Y' or SUBDIA='Z'  or SUBDIA='X'  or SUBDIA='S' or SUBDIA='A' ) 
union all 
select null, null, abs((case when cargo_abono='C' then isnull(sum(isnull(importe,0)),0) else 0 end -
		case when cargo_abono='A' then isnull(sum(isnull(importe,0)),0) else 0 end)) ,
		nro_sub_cuen, 
		(case when (case when cargo_abono='C' then isnull(sum(isnull(importe,0)),0) else 0 end -
		case when cargo_abono='A' then isnull(sum(isnull(importe,0)),0) else 0 end)> 0 then 'C' else 'A' end) cargo_abono,
		(select nro_sub_cuen from cuentas_contable C2 where C2.nro_cuen=movi_contables.nro_sub_cuen) subc, 'A',	'1', '01',
		0.00, glosa, @ms, @ani, null, codi_unid_oper
	from movi_contables (nolock)
	where mes= @ms and anio= @ani  and ( ( left(nro_cuen,1)='6' and left(nro_cuen,2) not in ('69' ,'66') ) or left(nro_cuen,1)='9'  )
		and left( nro_sub_cuen ,1 ) = '9' 
		and not (SUBDIA='Y' or SUBDIA='Z'  or SUBDIA='X'or SUBDIA='S' or SUBDIA='A' )
	group by nro_sub_cuen, cargo_abono,codi_unid_oper, glosa
		having abs((case when cargo_abono='C' then isnull(sum(isnull(importe,0)),0) else 0 end -
		case when cargo_abono='A' then isnull(sum(isnull(importe,0)),0) else 0 end)) >0 
union all
select null, null, sum((case when cargo_abono='C' then isnull(importe,0) else -1 * importe end)) ,
		dbo.f_cuenta_prov('15') cuenta, 
		(case when sum((case when cargo_abono='C' then isnull(importe,0) else -1 * importe  end ))> 0 then 'A' else 'C' end) cargo_abono,
		(select nro_sub_cuen from cuentas_contable C2 
		where C2.nro_cuen =( select top 1 cuenta from cuentas_provision where codigo='15')) subc, 
		 'A',	'1', '01',	0.00, 'Destino Automático 79', @ms, @ani, null, null
	from movi_contables (nolock) 
	where mes= @ms and anio= @ani  and ( ( left(nro_cuen,1)='6' and left(nro_cuen,2) not in ('69' ,'66')  ) or left(nro_cuen,1)='9'  )
		and left( nro_sub_cuen ,1 ) = '9' 
		and not (SUBDIA='Y' or SUBDIA='Z'  or SUBDIA='X' or SUBDIA='S' or SUBDIA='A' )
	order by cuenta, codi_nota_ingr
GO
