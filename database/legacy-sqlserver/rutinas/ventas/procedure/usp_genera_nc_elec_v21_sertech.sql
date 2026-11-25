CREATE PROCEDURE [dbo].[usp_genera_nc_elec_v21_sertech]
	@codifact [varchar](10)
WITH EXECUTE AS CALLER
AS
--declare @codifact varchar(10)
--select @codifact='0000000159'

set nocount on

declare @Linea table (linea nvarchar(1500) )

------------------Linea EMI ---------------------
insert @linea
select /*00*/	'EMI' + '|'+
		/*01*/	rtrim(ruc) + '|' +
		/*02*/	'|'+
		/*03*/	'0000' + '|'+
		/*04*/	dbo.uf_observ_fact(rtrim(direccion)) + '|' + 
		/*05*/	'|' +
		/*06*/	rtrim(distrito) + '|' +
		/*07*/	rtrim(provincia) + '|' +
		/*08*/	 rtrim(departamento) + '|' +
		/*09*/	'PE' + '|' +
		/*10*/	isnull(ubigeo,'') + '|' +
		/*11*/	'|'
from empresa (nolock)


------------------Linea REC ---------------------
insert @linea
select	/*00*/	'REC|'+
		/*01*/	(select (select cast(t.Codi_Sunat as varchar) from TIPO_DOCU_IDEN T (nolock) where 
						t.Codi_Tipo_Docu_Iden =C.Codi_Tipo_Docu_Iden ) + '/' +
								isnull(rtrim(ruc),'-') from CLIENTE_PROVEEDOR c (nolock)   where c.CODI_CLIE_PROV=F.CODI_CLIE_PROV) +'|'+
		/*02*/ left(dbo.F_Cliente_Proveedor(codi_Clie_prov) ,100)+'|'+
		/*03*/	left(isnull((select c.DIRECCION from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) ,''),100) + '|' +
		/*04*/	isnull((select c.DISTRITO from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) ,'') + '|' +
		/*05*/	isnull((select c.PROVINCIA from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) ,'') + '|' +
		/*06*/	isnull((select c.DEPARTAMENTO from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) ,'') + '|' +
		/*07*/	/*isnull((select c.codi_pais from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) ,*/'PE'/*)*/ + '|' +
		/*08*/	isnull((select rtrim((select u.Codi_Ubi_Dist_Sunat from UBIGEO_DISTRITO U (nolock)
					where u.codi_ubi_dist=c.codi_ubi_dist)) from cliente_proveedor C (nolock) 
					where c.CODI_CLIE_PROV=F.codi_clie_prov),'') + '|' +
		/*09*/	isnull((select c.TELE_1 from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) ,'') + '|' +
		/*10*/	isnull((select case when isnull('0'/*c.notificar_fact*/,'0') ='0' then 'NO' else 'SI' end 
						from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) ,'') + '|' +		
		/*12*/	isnull((select case when '0'/*notificar_fact*/='1' then c.E_MAIL else '' end 
					from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) ,'') +'|'
from nota_credito F (nolock) 
where codi_nota_cred=@codifact

------------------Linea DEL ---------------------

------------------Linea COM ---------------------
insert @Linea
select /*00*/	'COM' + '|'+ 
		/*01*/	replace(convert(char(10),FECH_NOTA_CRED,102) ,'.','-')+ 
					isnull(' ' +replace(convert(char(10),isnull(FECH_NOTA_CRED,getdate()),108) ,'.','-'),'')+ '|' +
		/*02*/	'07' + '|' +
		/*03*/	rtrim(SER_NOTA_CRED) + '-'+right('00000000'+rtrim(NRO_NOTA_CRED),8) + '|' +
		/*04*/	rtrim(isnull(tipo_oper,'0101')) + '|' +
		/*05*/	isnull(replace(convert(char(10),case when rtrim(F.codi_fact)<>'' then 
						(select case when codi_tipo_pago=4 then venc_fact else FECH_NOTA_CRED end from factura FC(nolock) where FC.codi_fact=right(F.codi_fact,10))
					 else FECH_NOTA_CRED end,102) ,'.','-') ,'') + '|' +
		/*  */	'CONTADO' + '|' 
		
				--isnull(replace(convert(char(10),FECH_NOTA_CRED,102) ,'.','-') ,'') + '|' 

from NOTA_CREDITO F (nolock) 
where codi_nota_Cred=@codifact
------------------REL-F ---------------------

------------------REL-N ---------------------
insert @Linea
select  /*'00'*/ 'REL-N' + '|' +
		/*01*/ isnull(
					--'01/'+
						(select right(codi_tipo_docu,2)+'/'+ case when isnumeric(f.ser_Fact)=1 then 
							 right('0000'+rtrim(f.ser_Fact),4) else rtrim(f.ser_fact) end +'-'+ right('00000000'+rtrim(f.nro_fact),8) 
								from factura F (nolock) where f.codi_Fact=N.codi_fact),'') +
					'|'+
		/*02*/	isnull((select codi_sunat from motivo_nota_cred M(nolock) where M.id_moti=N.id_moti),'') + '|' + 
		/*03*/	/*case isnull((select codi_sunat from motivo_nota_cred M(nolock) where M.id_moti=N.id_moti),'') 
					when '01' then 'Anulación de la operación' 
					when '02' then 'Anulación por error en el RUC'
					when '03' then 'Corrección por error en la descripción'
					when '04' then 'Descuento global'
					when '05' then 'Descuento por ítem'
					when '06' then 'Devolución total' 
					when '07' then 'Devolución por ítem' 
					when '08' then 'Bonificación'
					when '09' then 'Disminución en el valor' 
					when '10' then 'Otros Conceptos' 
					when '11' then 'Ajustes de operaciones de exportación' 
					when '13' then 'Ajustes - montos y/o fechas de pago'
					else '' end +'|'*/
					
				rtrim(case when moti_otro is null or rtrim(moti_otro)='' then '-' else moti_otro end) +'|'
					
from NOTA_CREDITO N (nolock) 
where codi_nota_Cred=@codifact


------------------Linea PLU ---------------------
declare @coddeta varchar(5)

declare c1 cursor for select codi_Deta from nota_credito_deta (nolock) where CODI_NOTA_CRED=@codifact order by codi_deta
open c1
fetch c1 into @coddeta
while @@fetch_status=0
begin
	insert @Linea
	select	/*00*/	'PLU' + '|' +
		/*01*/	cast( cast(codi_deta as int) as varchar) +'|'+
		/*02*/	rtrim(isnull(codi_item,'')) + '|' + 
		/*03*/	rtrim(isnull((select '' codi_prod_sunat from productos P (nolock) where P.codi_prod=F.codi_item),''))+ '|'+
		/*04*/	'|' +
		/*05*/	isnull((select unid_medi_inte from UNIDAD_MEDIDA u (nolock) where u.CODI_UNID_MEDI=F.codi_unid_medi),'')+ '|'+
		/*06*/	ltrim(isnull(dbo.uf_observ_fact(DESC_ITEM),'')) +'|'+
		/*07*/	cast(cast(/*case when isnull((select equivalente from productos P(nolock) where P.codi_prod=F.codi_item),0)<=0 then*/ F.CANT_ITEM
						/*else 
					cast(CANT_ITEM/(select equivalente from productos P(nolock) where P.codi_prod=F.codi_item) as numeric(18,2))
					end*/ as numeric(12,3)) as varchar) +'|'+
		/*08*/	case when id_moti='13' then '0' else cast(cast(PREC_ITEM as numeric(12,3)) as varchar) end +'|'+
		/*09*/	'|'+
		
		/*10*/  case when id_moti='13' then '0' else
				cast(cast(PREC_ITEM*case when FT.codi_oper<>'0200' and cod_imp=1 then (1+dbo.F_IGV(A.fech_nota_Cred)/100.00) else 1 end as numeric(12,2)) as varchar) end +'|'+
		/*11*/	case when id_moti='13' then '0' else
				cast(cast(IMPO_ITEM as numeric(12,2)) as varchar) end +'|'+ 

		/*12*/	'|'+

		/*13*/  case when id_moti='13' then '0' else
				cast(cast(PREC_ITEM*case when FT.codi_oper<>'0200' and cod_imp=1 then (dbo.F_IGV(A.fech_nota_Cred)/100.00) else 1 end as numeric(12,2)) as varchar) end + '|'

	from NOTA_CREDITO_DETA F (nolock) 
	join NOTA_CREDITO a (nolock)
	on F.CODI_NOTA_CRED=A.CODI_NOTA_CRED
	join FACTURA FT(nolock) on right(A.codi_Fact,10)=FT.codi_fact
	where A.CODI_NOTA_CRED=@codifact and DESC_ITEM is not null and codi_Deta=@coddeta
	--order by codi_Deta
	

	------------------Linea PLU-G ---------------------
	insert @Linea
	select /*00*/	'PLU-G'+ '|' +
		/*01*/	'18' + '|'+

		/*02*/  isnull((select codi_Tipo_afec from factura_detalle FD(nolock) where FD.codi_fact=FT.codi_fact and FD.codi_prod=F.CODI_ITEM),'10')
				/*case when tipo_Venta in ('1','4') and exonerado='1' then '10'
					when (tipo_Venta in ('1','4') and exonerado='0' and isnull(tipo_exo,'')='1') then '20'
					when (tipo_Venta in ('1','4')and exonerado='0' and isnull(tipo_exo,'')='2') then '30'
					when tipo_venta='2' then '40' end*/ +'|'+
					
		/*03	cast(cast(PREC_ITEM*(1+dbo.F_IGV(A.fech_nota_cred)/100.00) - PREC_ITEM  as numeric(12,2)) as varchar) +'|'+*/
		
		/*03*/  case when id_moti='13' then '0' else
				cast(cast(PREC_ITEM*case when FT.codi_oper<>'0200' and cod_imp=1 then (1+dbo.F_IGV(A.fech_nota_cred)/100.00) else 1 end - PREC_ITEM  as numeric(12,2)) as varchar) end +'|'+
				
		/*04*/	case when id_moti='13' then '0' else cast(cast(PREC_ITEM as numeric(12,2)) as varchar) end +'|'

	from NOTA_CREDITO_DETA F (nolock) 
	join NOTA_CREDITO a (nolock)
	on F.CODI_NOTA_CRED=A.CODI_NOTA_CRED
	join FACTURA FT(nolock) on right(A.codi_Fact,10)=FT.codi_fact
	where A.CODI_NOTA_CRED=@codifact and DESC_ITEM is not null and codi_Deta=@coddeta
	--order by codi_Deta
	
	fetch c1 into @coddeta
end 
close c1
deallocate c1


------------------Linea TOT---------------------
insert @Linea
select	/*00*/	'TOT'+ '|'+	
		/*01*/	'|'+
		/*02*/	'|'+
		/*03*/	case when id_moti='13' then '0' else cast(cast(VALO_VENT as numeric(12,2)) as varchar) end +'|'+
		/*04*/	'|'+
		/*05*/	case when id_moti='13' then '0.00' else cast(cast(igv as numeric(12,2)) as varchar) end +'|'+
		/*06*/	'|'+
		/*07*/	'|'+
		/*08*/	case when id_moti='13' then '0' else cast(cast(igv as numeric(12,2)) as varchar) end +'|'+
		/*09*/	'|' +
		/*10*/	 '|' +
		/*11*/	case when id_moti='13' then '0' else cast(cast(PREC_VENT as numeric(12,2)) as varchar) end +'|'+
		/*12*/	case when id_moti='13' then '0' else cast(cast(PREC_VENT as numeric(12,2)) as varchar) end +'|'
from NOTA_CREDITO F (nolock) where CODI_NOTA_CRED=@codifact


------------------Linea TOT-S ---------------------
insert @Linea
select /*00*/ 'TOT-S' + '|' + 
		/*01*/  case when id_moti='13' then '0' else cast(cast(VALO_VENT as numeric(12,2)) as varchar) end +'|'+
		/*02*/	'|' +
		/*03*/	'|'+
		/*04*/	'|'+
		/*05*/	'|' +
		/*06*/	'|'+
		/*07*/	'|'+
		/*08*/	'|'
from NOTA_CREDITO F (nolock) where CODI_NOTA_CRED=@codifact

------------------Linea PAG ---------------------
insert @Linea
select  /*00*/	'PAG'+ '|' +
		/*01*/	'999|' +
		/*02*/	cast(year(FECH_NOTA_CRED) as varchar(4))+ '-' + 
				right('00'+cast(month(fech_nota_cred) as varchar(2)),2) + '-01' + '|' +			
		/*03*/	cast(year(FECH_NOTA_CRED) as varchar(4))+ '-' + 
				right('00'+cast(month(fech_nota_cred) as varchar(2)),2) + '-' +
					cast(dbo.f_ulti_dia(year(FECH_NOTA_CRED),month(FECH_NOTA_CRED)) as varchar(2) )+ '|' +			
		/*04*/	case when codi_mone='01' then 'PEN' else 'USD' end + '|' +
		/*05*/	case when codi_mone='02' then 
				cast(dbo.F_TPc_Sem((select fech_fact
									from factura F (nolock) where f.codi_Fact=N.codi_fact)) as varchar(10)) else '' end  +'|' 
									
from NOTA_CREDITO N (nolock) where CODI_NOTA_CRED=@codifact

/*
------------------Linea PDF ---------------------
insert @Linea
select /*00*/	'PDF' + '|' +
		/*01*/	'Obs.'+'|'+
		/*02*/	'Observaciones'	+'|' +
		/*03*/  ISNULL(observaciones,'') +'|' 
from NOTA_CREDITO N (nolock) where CODI_NOTA_CRED=@codifact
		and ISNULL(observaciones,'') <>''*/
		

------------------Linea FPAGO ---------------------
insert @Linea
select /*00*/	'FPAGO' + '|' +
		/*01*/	'Credito'+'|'+
		/*02*/	cast(cast(PREC_VENT as numeric(12,2)) as varchar) +'|' 
		
from NOTA_CREDITO N (nolock) where CODI_NOTA_CRED=@codifact
		and ISNULL(id_moti,'')='13'

------------------Linea CPAGO ---------------------
insert @Linea
select /*00*/	'CPAGO' + '|' +
		/*01*/	'Cuota001'+'|'+
		/*02*/  cast(cast(monto as numeric(12,2)) as varchar) +'|' +
		/*/*03*/	isnull(replace(convert(char(10),case when left(N.codi_fact,1)='F' then 
						(select case when codi_tipo_pago=4 then venc_fact else FECH_NOTA_CRED end from factura FC(nolock) where FC.codi_fact=right(N.codi_fact,10))
					 else FECH_NOTA_CRED end,102) ,'.','-') ,'')*/
		/*03*/  isnull(replace(convert(char(10),fecha,102) ,'.','-') ,'')			 
		
from NOTA_CREDITO N (nolock) 
join factura_cuotas F(nolock) 
on F.codi_fact = right(N.codi_fact,10) 
where CODI_NOTA_CRED=@codifact and ISNULL(id_moti,'')='13'

------------------Linea PDFIMP ---------------------
insert @Linea
select /*00*/  'PDFIMP' + '|'+ 
	   /*01*/  ltrim(rtrim(tipo_impr))
	   
from NOTA_CREDITO F (nolock) 
where CODI_NOTA_CRED=@codifact and isnull(tipo_impr,'')<>''



select linea 
from @linea
GO
