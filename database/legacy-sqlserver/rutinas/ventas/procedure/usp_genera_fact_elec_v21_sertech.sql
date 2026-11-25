CREATE PROCEDURE [dbo].[usp_genera_fact_elec_v21_sertech]
	@codifact [varchar](10)
WITH EXECUTE AS CALLER
AS
--declare @codifact varchar(10)
--select @codifact='0000018099'

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
		/*01*/	isnull((select (select cast(t.Codi_Sunat as varchar) from TIPO_DOCU_IDEN T (nolock) where 
						t.Codi_Tipo_Docu_Iden =C.Codi_Tipo_Docu_Iden ) + '/' +
								isnull(rtrim(ruc),'-') from CLIENTE_PROVEEDOR c (nolock)   where c.CODI_CLIE_PROV=F.CODI_CLIE_PROV),'') +'|'+
		/*02*/ left(dbo.F_Cliente_Proveedor(codi_Clie_prov) ,100)+'|'+
		/*03*/	left(isnull((select c.DIRECCION from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) ,''),100) + '|' +
		/*04*/	isnull((select rtrim(c.DISTRITO) from CLIENTE_PROVEEDOR C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) ,'') + '|' +
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
from factura F (nolock) 
where codi_Fact=@codifact

------------------Linea DEL ---------------------

------------------Linea COM ---------------------
insert @Linea
select /*00*/	'COM' + '|'+ 
		/*01*/	replace(convert(char(10),FECH_FACT,102) ,'.','-')+ 
					isnull(' ' +replace(convert(char(10),creacion,108) ,'.','-'),'')+ '|' +
		--/*02*/	'01' + '|' +
		/*02*/	right(codi_tipo_docu,2) + '|' +
		/*03*/	rtrim(ser_Fact) + '-'+right('00000000'+rtrim(nro_fact),8) + '|' +
		/*04*/	rtrim(isnull(codi_oper,'0101')) + '|' +
		/*05*/	case when codi_tipo_pago=1 then 
						/*isnull(replace(convert(char(10),fech_fact,102) ,'.','-') ,'')*/ '' else isnull(replace(convert(char(10),venc_fact,102) ,'.','-') ,'') end + '|' +
		/*06*/  case when codi_tipo_pago=1 then /*'CONTADO'*/ '' else 'CREDITO ' + cast(isnull(DIAS_FACT,0) as varchar) + ' DIAS' end + '|' +
		/*  */  isnull(upper(rtrim((select isnull(apel_1,'')+isnull(' '+apel_2,'')+isnull(' '+nomb_1,'')+isnull(' '+nomb_2,'') 
						from usuarios U(nolock) where U.codi_usua=cod_usua_vende))),'') --+ '|'
		
from factura F (nolock) 
where codi_Fact=@codifact

------------------REL-F ---------------------
insert @Linea
select /*00*/	'REL-F' + '|'+ 
		/*01*/	rtrim(isnull(orde_fact,'0')) + '|' +
		/*02*/	'' + '|' +
		/*03*/	'09/' + isnull((select right('0000'+isnull(rtrim(nro_seri_docu_sali),''),4) + '-' + right('00000000'+isnull(rtrim(nro_docu_sali),'') ,8)
							from docu_sali_mate S(nolock) where S.codi_fact=F.codi_fact and codi_tipo_docu_sali='0009'),'0000-00000000') + '|'
from factura F (nolock) 
where codi_Fact=@codifact and isnull(orde_fact,'')<>''


------------------Linea PLU ---------------------
declare @coddeta varchar(5)

declare c1 cursor for select codi_Deta from FACTURA_DETALLE (nolock) where codi_Fact=@codifact order by codi_deta
open c1
fetch c1 into @coddeta
while @@fetch_status=0
begin
	insert @Linea
	select	/*00*/	'PLU' + '|' +
		/*01*/	cast( cast(codi_deta as int) as varchar) +'|'+
		/*02*/	rtrim(isnull(codi_item,''))+ '|' + 
		/*03*/	rtrim(isnull((select '' codi_prod_sunat from productos P (nolock) where P.codi_prod=F.codi_prod),''))+ '|'+
		/*04*/	'|' +
		/*05*/	case when isnull(codi_prod,'')='' then isnull((select isnull(unid_medi_inte,'') from unidad_medida U(nolock) where U.codi_unid_medi=F.codi_unid_medi),'ZZ') else
             isnull((select isnull(unid_medi_inte,'') from UNIDAD_MEDIDA U (nolock)
                    where u.CODI_UNID_MEDI in (select P.CODI_UNID_MEDI from productos P (nolock) where p.codi_prod=F.codi_prod)) ,'') end + '|'+
                    
		--/*06*/	ltrim(isnull(dbo.uf_observ_fact(DESC_ITEM),'')) +'|'+
		/*06*/	case when isnull(F.codi_prod,'')='' then ltrim(isnull(dbo.uf_observ_fact(DESC_ITEM),'')) else 
				isnull(cast(desc_item as varchar(250)),(select desc_prod from productos P(nolock) where P.codi_prod=F.codi_prod)) end +'|'+
				
		/*07*/	cast(cast(F.CANT_ITEM as numeric(12,3)) as varchar) +'|'+
		
	  --/*08*/	cast(cast(PREC_ITEM as numeric(12,2)) as varchar) +'|'+
		/*08*/  cast(cast(case when isnull(codi_tipo_afec,'10') in ('10','12','20','30','40','17') then 
					round(F.prec_item/case when isnull(incl_igv,'1')=0 then 1 else (1 +F.igv/100.00) end,10)
				else 0.00 end as numeric(18,7)) as varchar) +'|'+
		
		/*09*/	'|'+
		
	  --/*10*/	cast(cast(PREC_ITEM*case when tipo_oper<>'0200' and cod_imp=1 then (1+dbo.F_IGV(A.FECH_FACT)/100.00) else 1 end as numeric(12,2)) as varchar) +'|'+			
		/*10*/	cast(cast(F.prec_item * case when isnull(incl_igv,'1')=0 then (1 +F.igv/100.00) else 1 end as numeric(12,2)) as varchar) +'|'+
		
		/*11*/	cast(cast(IMPO_ITEM/case when isnull(incl_igv,'1')=1 then (1 +F.igv/100.00) else 1 end as numeric(12,2)) as varchar) +'|'+ 
					--cast(cast(impo_item*case when tipo_Venta in ('1','4') and exonerado='1' then (1+dbo.F_IGV(A.FECH_FACT)/100.00) else 1 end - impo_item as numeric(12,2)) as varchar) +'|'+
		/*12*/	'|'+
		
	  --/*13*/ cast(cast(PREC_ITEM*case when tipo_oper<>'0200' and cod_imp=1 then (dbo.F_IGV(A.FECH_FACT)/100.00) else 1 end as numeric(12,2)) as varchar) + '|'	
		/*13*/  cast(cast(case when isnull(codi_tipo_afec,'10') in ('10','12','20','30',/*'40',*/'17') then 
					 case when isnull(incl_igv,'1')=0 then F.prec_item*(F.igv/100.00) else F.prec_item - F.prec_item/(1 +F.igv/100.00) end 
							   when isnull(codi_tipo_afec,'10') in ('40') then F.prec_item
					 --* case when isnull(bultos,0)<>0 then bultos else F.CANT_ITEM end 
				else 0.00 end as numeric(12,2)) as varchar) +'|'
		
	from FACTURA_DETALLE F (nolock) 
	join factura a (nolock)
	on F.codi_Fact=A.codi_Fact
	where A.codi_Fact=@codifact and DESC_ITEM is not null and codi_Deta=@coddeta
	order by codi_Deta

	------------------Linea PLU-G ---------------------
	insert @Linea
	select /*00*/	'PLU-G'+ '|' +
		/*01*/	'18' + '|'+
		/*02*/	case when F.codi_imp=1 then '10' else '20' end --isnull(codi_Tipo_afec,'10')
				/*case when tipo_oper<>'0200' and cod_imp=1 then '10'
					when (tipo_oper<>'0200' and cod_imp=3) then '20'
					when (tipo_oper<>'0200' and cod_imp=4) then '30'
					when tipo_oper='0200' then '40' end*/ +'|'+
					
		--/*03*/	cast(cast(PREC_ITEM*case when tipo_oper<>'0200' and cod_imp=1 then (1+dbo.F_IGV(A.FECH_FACT)/100.00) else 1 end - PREC_ITEM  as numeric(12,2)) as varchar) +'|'+
		
		/*03*/	cast(cast(case when isnull(codi_tipo_afec,'10') in ('10','12','20','30','40','17') then 
					 case when isnull(incl_igv,'1')=0 then F.prec_item*(F.igv/100.00) else F.prec_item - F.prec_item/(1 +F.igv/100.00) end 
				else 0.00 end as numeric(12,2)) as varchar) +'|'+
		
		/*04*/	cast(cast(PREC_ITEM/case when isnull(incl_igv,'1')=1 then (1 +F.igv/100.00) else 1 end as numeric(12,2)) as varchar) +'|'
	from FACTURA_DETALLE F (nolock) 
	join factura a (nolock)
	on F.codi_Fact=A.codi_Fact
	where A.codi_Fact=@codifact and DESC_ITEM is not null and codi_deta=@coddeta
	order by codi_Deta
	
	fetch c1 into @coddeta
end 
close c1
deallocate c1


------------------Linea DET ---------------------
declare @Ruc varchar(11)
set @Ruc=(select  ruc from empresa (nolock))

insert @Linea
select	
		/*00*/	'DET' + '|' +
		/*01*/	left(isnull(codi_bien_serv,''),3) +'|'+
		/*02*/	 isnull((select c.NRO_CTA_CTE
                                  from CTA_CTE_PROV C (nolock) 
									where c.CODI_CLIE_PROV in (select x.CODI_CLIE_PROV from cliente_proveedor x (nolock) where rtrim(ruc)=@Ruc)
									and c.DETRACCION='1'),'') +'|'+
		/*03*/	'999|'+
		/*04*/ 	cast(cast(isnull((select porc_bien_serv*100 from bien_servicio b (nolock) 
                                  where isnull(b.codi_bien_serv,'')=F.codi_bien_serv ),0) as numeric(12,2)) as varchar ) +'|'+
		/*05*/	 cast(cast(round(tota_fact*isnull((select porc_bien_serv from bien_servicio b (nolock) 
                                  where isnull(b.codi_bien_serv,'')=F.codi_bien_serv ),0),0) as numeric(12,2)) as varchar ) +'|'	
from FACTURA F (nolock) where codi_Fact=@codifact and codi_bien_serv is not null 

/*declare @idguia numeric(12)

declare c1 cursor for select id_guia from FACTURA_DOCU_RELA (nolock) where codi_fact=@codifact
open c1 
fetch c1 into @idguia
while @@fetch_status =0
begin
--select @idguia
	------------------Linea DET - C ---------------------
	insert @Linea
	select 
			/*00*/	'DET-C'+ '|'+
			/*01*/	isnull((select u.Codi_Ubi_Dist_Sunat from ubigeo_distrito U (nolock) where u.Codi_Ubi_Dist = C.dist_part) ,'') + '|' +
			/*02*/	dbo.uf_observ_fact( isnull(c.partida,'')) + '|' +
			/*03*/	isnull((select u.Codi_Ubi_Dist_Sunat from ubigeo_distrito U (nolock) where u.Codi_Ubi_Dist = C.dist_dest) ,'') + '|' +
			/*04*/	dbo.uf_observ_fact( isnull(c.llegada,'')) + '|' +
			/*05*/	isnull(c.observaciones,'') + '|' +
			/*06*/	cast(isnull(valor_refe,0) as varchar(20)) + '|' +
			/*07*/	cast(isnull(carga_efect,0) as varchar(20)) + '|' +
			/*08*/	cast(isnull(carga_nomi,0) as varchar(20)) + '|' 
	from FACTURA F (nolock)
	join FACTURA_DOCU_RELA  B (nolock)
	on F.codi_fact=B.codi_fact
	join GUIA_TRANSPORTISTA C (nolock)
	on b.id_guia=C.id_guia
	where F.codi_Fact=@codifact and left(isnull(codi_bien_serv,''),3) ='027'
			and C.id_guia=@idguia

	------------------Linea DET - T ---------------------
	insert @Linea
	select 
			/*00*/	'DET-T'+ '|'+
			/*01*/	isnull((select u.Codi_Ubi_Dist_Sunat from ubigeo_distrito U (nolock) where u.Codi_Ubi_Dist = C.dist_part) ,'') + '|' +
			/*02*/	isnull((select u.Codi_Ubi_Dist_Sunat from ubigeo_distrito U (nolock) where u.Codi_Ubi_Dist = C.dist_dest) ,'') + '|' +
			/*03*/	'|' +
			/*04*/	'|' +
			/*05*/	'|' 
	from FACTURA F (nolock)
	join FACTURA_DOCU_RELA  B (nolock)
	on F.codi_fact=B.codi_fact
	join GUIA_TRANSPORTISTA C (nolock)
	on b.id_guia=C.id_guia
	where F.codi_Fact=@codifact and left(isnull(codi_bien_serv,''),3) ='027'
			and C.id_guia=@idguia

	------------------Linea DET - V ---------------------
	insert @Linea
	select 
			/*00*/	'DET-V'+ '|'+
			/*01*/	isnull(config_vehi,'') + '|' +
			/*02*/	'|' +
			/*03*/	'|' +
			/*04*/	'|' +
			/*05*/	'|'  +
			/*06*/	'|'  
	from FACTURA F (nolock)
	join FACTURA_DOCU_RELA  B (nolock)
	on F.codi_fact=B.codi_fact
	join GUIA_TRANSPORTISTA C (nolock)
	on b.id_guia=C.id_guia
	where F.codi_Fact=@codifact and left(isnull(codi_bien_serv,''),3) ='027'
			and C.id_guia=@idguia
	
	fetch c1 into @idguia
end 

close c1
deallocate c1*/
 				
------------------Linea ANT---------------------
insert @Linea
select	/*00*/	'ANT' + '|' +
		/*01*/	@ruc + '|' +
		/*02*/	'01' + '|'+
		/*03*/	isnull(replace(convert(char(10),d.fecha_pago_rece,102) ,'.','-'),'') +  '|' +
		/*04*/	(select case when codi_sunat='01' then '02' else '03' end from tipo_documento T (nolock) where T.codi_tipo_docu=D.codi_tipo_docu) + '/'+
					 + serie +'-' + right('00000000' + cast(cast(d.numero as numeric) as varchar),8) +  '|' +
		/*05*/	isnull(cast(cast(monto_anti/(select case when isnull(incl_igv,'1')=1 then (1 +Fd.igv/100.00) else 1 end from factura_detalle fd(nolock) where fd.codi_fact=d.codi_Fact_anti)
			    as numeric(12,2))as varchar),'') +'|'+
		/*06*/	(select case when codi_mone ='01' then 'PEN' else 'USD' end from factura f (nolock) where f.codi_fact=D.codi_fact_anti) + '|' +
		/*07*/	'04' + '|' 

from factura f (nolock)		
join factura_anticipos d (nolock)
on f.codi_Fact=D.codi_Fact
where f.codi_Fact=@codifact

------------------Linea TOT---------------------
insert @Linea
select	/*00*/	'TOT'+ '|'+	
		/*01*/	'|'+
		/*02*/	'|'+
	  --/*03*/  case when tipo_oper<>'0200' and cod_imp=1 then cast(cast(subtota_fact as numeric(12,2)) as varchar) else '' end +'|'+
		/*03*/	cast(cast(case when cod_imp=3 then tota_exonerado else subtota_fact end as numeric(12,2)) as varchar) +'|'+
		/*04*/	'|'+
		/*05*/	cast(cast(igv_fact as numeric(12,2)) as varchar)+'|'+
		/*06*/	'|'+
		/*07*/	'|'+
		/*08*/	cast(cast(igv_fact as numeric(12,2)) as varchar)+'|'+
		/*09*/	'|' +
		/*10*/	cast(isnull((select sum(a.monto_anti) from factura_anticipos A (nolock) where a.codi_Fact=F.codi_Fact),0) as varchar(10) ) + '|' +
		/*11*/	cast(cast(tota_fact as numeric(12,2)) + isnull((select sum(a.monto_anti) from factura_anticipos A (nolock) where a.codi_Fact=F.codi_Fact) ,0) as varchar)+'|'+
		/*12*/	cast(cast(tota_fact as numeric(12,2)) as varchar)+'|'
from FACTURA F (nolock) where codi_Fact=@codifact

------------------Linea TOT-S ---------------------
insert @Linea
select /*00*/ 'TOT-S' + '|' + 
		/*01*/ case when codi_oper<>'0200' and cod_imp=1 then cast(cast(subtota_fact as numeric(12,2)) as varchar) else '' end +'|'+
		/*02*/	'|' +
		/*03*/	case when (codi_oper<>'0200' and cod_imp=3) then cast(cast(tota_exonerado as numeric(12,2)) as varchar) else '' end +'|'+
		/*04*/	case when (codi_oper<>'0200' and cod_imp=4)  then cast(cast(subtota_fact as numeric(12,2)) as varchar) else '' end +'|'+
		/*05*/	'|' +
		/*06*/	case when codi_oper='0200' then cast(cast(tota_fact as numeric(12,2)) as varchar) else '' end +'|'+
		/*07*/	'|'+
		/*08*/	'|'
from FACTURA F (nolock) where codi_Fact=@codifact

------------------Linea PAG ---------------------
insert @Linea
select  /*00*/	'PAG'+ '|' +
		/*01*/	'999|' +
		/*02*/	'|' +
		/*03*/	'|' +
		/*04*/	case when codi_mone='01' then 'PEN' else 'USD' end + '|' +
		/*05*/	case when codi_mone='02' then cast(dbo.F_TPc_Sem(f.fech_fact) as varchar(10)) else '' end  +'|' 
from FACTURA F (nolock) where codi_Fact=@codifact
------------------Linea 7 ---------------------

------------------Linea PDF ---------------------
/*if len(dbo.uf_observ_fact_detalle(@codifact))>0
begin
	insert @Linea
	select /*00*/	'PDF' + '|' +
			/*01*/	'Obs.'+'|'+
			/*02*/	'Observaciones'	+'|' +
			/*03*/  rtrim(dbo.uf_observ_fact_detalle(F.codi_fact)) +'|' 
	from FACTURA F (nolock) where codi_Fact=@codifact
end*/


----Calculamos Detracción y Retención
declare @valor_ret numeric(18,2), @valor_detra numeric(18,2)

select 
	@valor_detra = (case when isnull(detra,'0')='1' then cast(f.TOTA_FACT * 
				    isnull((select porc_bien_serv from bien_servicio b (nolock) where F.codi_bien_serv=B.codi_bien_serv),0) as numeric(12,2)) else 0 end),
	
	@valor_ret = 0 /*(case when isnull(aplica_reten,'')='1' then	
			case when codi_bien_serv is null or rtrim(codi_bien_serv)='' then				
				cast(tota_fact * isnull((select porc_reten from cliente_proveedor C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV),0)/100.00 as numeric(12,2)) else 0 end 
				else 0 end)*/
					
from factura F (nolock)
where F.codi_Fact=@codifact
	
--select @valor_ret, @valor_detra
---------------------------------------------

------------------Linea FPAGO ---------------------
insert @Linea
select /*00*/	'FPAGO' + '|'+ 
	   /*01*/  case when codi_tipo_pago=1 then 'Contado' else 'Credito' end + '|' +
	   /*02*/  case when codi_tipo_pago=1 then '0' else cast(cast(tota_fact - @valor_ret - @valor_detra as numeric(12,2)) as varchar) end + '|' 
from factura F (nolock) 
where codi_Fact=@codifact

------------------Linea CPAGO---------------------
insert @Linea
select	/*00*/	'CPAGO'+ '|'+	
		/*01*/	'Cuota' + right('000'+cast(id_sec as varchar),3) + '|'+
		/*02*/	cast(cast(monto -  @valor_ret - @valor_detra as numeric(12,2)) as varchar) + '|' +
		/*03*/  isnull(replace(convert(char(10),fecha,102) ,'.','-') ,'')

from FACTURA_CUOTAS F (nolock) 
join FACTURA FT(nolock)
on F.codi_Fact=FT.codi_Fact
where F.codi_Fact=@codifact and FT.codi_tipo_pago=4
/*
------------------Linea CAR ---------------------
insert @Linea
select /*00*/	'CAR' + '|'+ 
	   /*01*/  cast(cast(tota_fact as numeric(12,2)) as varchar)  + '|' +
	   /*02*/  cast(cast(porc_reten as numeric(12,2)) as varchar)  + '|' +
	   /*03*/  '01' + '|' +
	   /*04*/  cast(cast(tota_fact - tota_fact*isnull(porc_reten/100,0)
			   as numeric(12,2)) as varchar) + '|' 
from factura F (nolock) 
join cliente_proveedor C(nolock)
on F.codi_clie_prov=C.codi_clie_prov
where codi_Fact=@codifact and isnull(detra,'')='0' and codi_tipo_pago=4 and isnull(reten,'')='3'
*/

------------------Linea PDFIMP ---------------------
insert @Linea
select /*00*/  'PDFIMP' + '|'+ 
	   /*01*/  ltrim(rtrim(tipo_impr)) --case when rtrim(tipo_impr)='1' then '2' else '1' end
	   
from factura F (nolock) 
where codi_Fact=@codifact and isnull(tipo_impr,'')<>''

select linea 
from @linea
GO
