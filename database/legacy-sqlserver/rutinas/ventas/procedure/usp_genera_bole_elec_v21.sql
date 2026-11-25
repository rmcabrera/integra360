CREATE PROCEDURE [dbo].[usp_genera_bole_elec_v21]
	@codifact [varchar](10)
WITH EXECUTE AS CALLER
AS
--declare @codifact varchar(10)
--select @codifact='0000899013'

declare @InfoDocu table (item int identity, InvoiceTypeCode char(2), NroSeriDocu varchar(13), IssueDate varchar(10) , moneda varchar(3) , 
                                        NroSeriGuia varchar(30) null, CodiSunatGuia varchar(2) null, NroSeriOtroDocu varchar(30) null, CodiSunatOtroDocu varchar(2) null,
                                        OrdenCompra varchar(30) null, separador char(1) ,
                                        RucEmpresa varchar(11) , IDSunat char(1), RazonSocial varchar(100), nombrecomercial varchar(100), ubigeo varchar(6), direccion varchar(250) ,
                                        Urbanizacion varchar(25), provincia varchar(100),  departamento varchar(100),  distrito varchar(100), pais char(2), separador2 char(2),
                                        RucCliente varchar(15), IDSunatCliente char(2), RazonSocialCliente varchar(100), direccionCliente varchar(250), 
                                        provinciacliente varchar(100),  departamentocliente varchar(100),  distritoCliente varchar(100), paisCliente char(2), separador3 char(2),
                                        igv_fact varchar(15), codiTrib varchar(4), nombTribu varchar(6) , codiIntTrib varchar(3) , separador4 char(1),
                                        total_fact varchar(15),
                                        desc_item varchar(250), codi_prod varchar(30) , unidMedi varchar(3), cantidad varchar(16), valorVenta varchar(15) , preciunitario varchar(15),
                                        tipoprecio varchar(2),  indidesc varchar(5), porcdesc varchar(6), montodesc varchar(15) ,  igvdeta varchar(15) , afecIgv varchar(2), codiTriDeta varchar(4),
                                        nombTriDeta varchar(6) , intTribDeta varchar(3), montoIsc varchar(15) , tipoIsc varchar(2),  TribIsc varchar(4) , nomBISc varchar(6), intIsc varchar(3),
                                        precSinIgv varchar(15), valorFAct varchar(15), totaexon varchar(15),
                                        correocliente varchar(250) null,
                                        tasadetra varchar(18) null, montodetra varchar(18) null, ctadetra varchar(11) null,
                                        sucursal varchar(100) null, SucurDirec varchar(250) null, SucurDistri varchar(100) null, HoraEmis datetime null, TipoPago varchar(100) null, Cajero varchar(250) null,
                                        observaciones ntext null,
                                        telefonoEmp varchar(100), correoEmp varchar(200), paginaweb varchar(200) ,dias_fact int null,
                                        impresora varchar(200),
										adicional1 varchar(200) null,
										adicional2 varchar(200) null,
										adicional3 varchar(200) null,
										codiinterno char(10) null,
										creacion datetime null,
										fax_emp varchar(20) null, codigo_emp varchar(4) null,
										valor_igv numeric(12,2) null,
										observ_adicional  ntext null, tipo_oper char(4) null , total_gratuito numeric(12,2)  null, vence varchar(10) null,
										ubigeo_clie varchar(6) null, codigo_cliente varchar(4) null , impo_item numeric(12,2) null, codi_desc_deta char(2) null, 
										codi_bien_serv varchar(5) null , total_gratuita numeric(12,2) null, precio_base numeric(12,2) null, fech_fact datetime null,
										dscto_fact numeric(12,2) null
										)


declare @Ruc varchar(15)
set @Ruc= (select ruc from empresa (nolock))

insert @InfoDocu
select       (select codi_sunat
                    from tipo_documento T (nolock) 
                    where t.codi_tipo_docu=F.codi_tipo_docu) as codiSunat,
             right('0000'+rtrim(cast(ser_Fact as varchar)),4)+ '-'+ right('00000000'+ rtrim(cast(nro_fact as varchar)),8) as SerNro,
             cast(datepart(YEAR,FECH_FACT) as varchar)+'-'+right('00'+cast(datepart(MONTH,FECH_FACT) as varchar),2)+ '-'+right('00'+cast(datepart(DAY,FECH_FACT) as varchar),2) as FechEmis,
             case when codi_mone='01' then 'PEN' else 'USD' end as Moneda,
             '' as NroSeriGuia,
             '' as CodiSunatGuia,
             '' as NroSeriOtroDocu,
             '' as CodiSunatOtroDocu,
             '' as OrdenCompra,
             '}' as Separador1,
             @Ruc as RucEmpresa,
             isnull((select (select Codi_Sunat from TIPO_DOCU_IDEN T (nolock) where T.Codi_Tipo_Docu_Iden=C.Codi_Tipo_Docu_Iden)
                           from cliente_proveedor C (nolock) where c.ruc=@Ruc),'') as IDSunat,
             isnull((select case when TIPO_PERS='JURIDICA' then RAZO_SOCI else denominacion end 
                     from cliente_proveedor C (nolock) where c.ruc=@Ruc) ,'')as RazonSocial,
             '' as NombreComercial,
             isnull((select rtrim(isnull((select Codi_Ubi_Dist_Sunat from UBIGEO_DISTRITO T (nolock) where T.codi_ubi_dist=C.codi_ubi_dist),''))
                           from cliente_proveedor C (nolock) where c.ruc=@Ruc) ,'')as Ubigeo,
             isnull((select rtrim(isnull(direccion,''))
                           from cliente_proveedor C (nolock) where c.ruc=@Ruc),'') as Direccion,
             '' as Urbanizacion,
             '' as Provincia,
             '' as Departamento,
             '' as Distrito,
             'PE' as Pais,
             '}' as Separador2,
             
             (select ruc from cliente_proveedor C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) as RucCliente,
             (select (select Codi_Sunat from TIPO_DOCU_IDEN T (nolock) where T.Codi_Tipo_Docu_Iden=C.Codi_Tipo_Docu_Iden)
                           from cliente_proveedor C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) as IDSunatCliente,
             dbo.F_Cliente_Proveedor(f.CODI_CLIE_PROV) as RazonSocialCliente,
             (select rtrim(isnull(direccion,''))
                           from cliente_proveedor C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV) as DireccionCliente,            
             '' as ProvinciaCliente,
             '' as DepartamentoCliente,
             '' as DistritoCliente,
             'PE' as PaisCliente,
             '}' as Separador3,         
             cast(f.IGV_FACT as numeric(12,2)),
             '1000' as codiTribu,
             'IGV' as NombTribu,
             'VAT' as CodiIntTribu,
             '}' as Separador4,
             cast(f.TOTA_FACT as numeric(12,2)),
             isnull(d.DESC_ITEM,''),
             isnull(d.CODI_PROD,''),
             case when isnull(codi_prod,'')='' then isnull((select isnull(unid_medi_inte,'') from UNIDAD_MEDIDA U (nolock) where U.CODI_UNID_MEDI=D.CODI_UNID_MEDI),'') else
             isnull((select isnull(unid_medi_inte,'') from UNIDAD_MEDIDA U (nolock)
                    where u.CODI_UNID_MEDI in (select P.CODI_UNID_MEDI from productos P (nolock) where p.codi_prod=D.codi_prod)) ,'') end as UniMedi,
             d.CANT_ITEM,
             cast(d.IMPO_ITEM/(1 +d.igv/100.00) as numeric(12,2)) as LineExtensionAmount ,
             --cast(d.prec_item*d.CANT_ITEM as numeric(12,2)),
             --(Observ Sunat) cast(d.IMPO_ITEM as numeric(12,2)),
             cast(d.IMPO_ITEM/d.CANT_ITEM as numeric(12,2)),
             '01' as TipoPrecio,
             '' as IndiDesc,
             '' as PorcDesc,
             '' as MontoDesc,
             cast((d.prec_item - round(d.prec_item/ (1 +d.igv/100.00),2))*d.cant_item  as numeric(12,2))as IgvDeta,
             --cast(d.prec_item as numeric(12,2)) as IgvDeta,
             case when d.codi_imp=1 then '10' else '20' end as AfecIgv,
             '1000' as codiTribuDeta,
             'IGV' as NombTribuDeta,
             'VAT' as CodiIntTribuDeta,
             '' as MontoISc,
             '' as TipoIsc,
             '' as TribuIsc,
             '' as NombTribIsc,
             '' as CodiInteIsc,
             cast(round(d.prec_item/ (1 +d.igv/100.00),2) as numeric(12,2)) as PrecSinIgv,
             ---cast(round(d.prec_item,2) as numeric(12,2)) as PrecSinIgv,	/* cambiado por solicitud...*/
             
             cast(F.VALO_FACT - isnull(f.TOTA_EXONERADO,0) as numeric(12,2)),
             cast(f.TOTA_EXONERADO as numeric(12,2)),
             isnull((select c.E_MAIL
                           from cliente_proveedor C (nolock) where c.CODI_CLIE_PROV=f.CODI_CLIE_PROV),'') as Correo,
             
             case when isnull(detra,'0')='1' or (cod_imp = 3 and valo_fact>700 and codi_tipo_docu='0001') then 
                           cast(isnull((select porc_bien_serv from bien_servicio b (nolock) 
                                  where isnull(F.codi_bien_serv,'035')=B.codi_bien_serv),0) as varchar ) 
             else '' end as Tasa,

             case when isnull(detra,'0')='1'  or (cod_imp = 3 and valo_fact>700 and codi_tipo_docu='0001') then 
                    cast(
                    cast(f.TOTA_FACT*isnull((select porc_bien_serv from bien_servicio b (nolock) 
                           where isnull(F.codi_bien_serv,'035')=B.codi_bien_serv),0) as numeric(12,2)) as varchar) else '' end as montodetra,
                 
             case when isnull(detra,'0')='1' or (cod_imp = 3 and valo_fact>700 and codi_tipo_docu='0001') then
                           isnull((select c.NRO_CTA_CTE
                                  from CTA_CTE_PROV C (nolock) 
									where c.CODI_CLIE_PROV in (select x.CODI_CLIE_PROV from cliente_proveedor x (nolock) where ruc=@Ruc)
									and c.DETRACCION='1'),'') 
			    else '' end as nroCtaDetra,
			                        
			(select a.NEMO_ALMA from ALMACEN A (nolock) where A.codi_alma=F.CODI_ALMA) Sucursal,
			isnull((select a.DIRECCION from ALMACEN A (nolock) where A.codi_alma=F.CODI_ALMA),'') SucursalDirec,
			isnull((select a.distrito from ALMACEN A (nolock) where A.codi_alma=F.CODI_ALMA),'') SucursalDistri,
			fech_fact,
			isnull((select t.Desc_Tipo_Medio_Pago from tipo_pago t (nolock) where t.Codi_Tipo_Medio_Pago=f.CODI_TIPO_PAGO),'') TipoPago ,
			isnull((select apel_1 +isnull(' ' +apel_2,'')+ isnull(' ' +nomb_1 ,'') + isnull(' ' +nomb_2 ,'') 
					 from USUARIOS U (nolock) where U.CODI_USUA=F.cod_usua_vende),'') Cajero,
			'' as observaciones,
			isnull((select rtrim(telefono) from ALMACEN x (nolock) where x.codi_alma = f.codi_alma),'') telefonoEmp,
			isnull((select rtrim(correo) from ALMACEN x (nolock) where x.codi_alma=F.codi_alma),'') correoEmp,
			isnull((select rtrim(PAGI_WEB) from empresa),'') paginaweb,
			ISNULL(dias_fact,0) dias_fact,
			case when isnull((select impresora from almacen A (nolock) where A.codi_alma=F.codi_alma),'')='' then printer_name
			else (select impresora from almacen A (nolock) where A.codi_alma=F.codi_alma) end as printer_name,

			'' as adic1,
			'' as adic2,  
			'' as adic3,
			f.codi_fact,
			f.creacion,
			(select rtrim(e.Fax) from empresa E (nolock)) as fax,
			isnull((select codigo_Estable from almacen e (nolock) 
										where e.codi_alma=f.codi_alma),'0000'),
			dbo.f_igv(f.FECH_FACT) as valor_igv,
			'' /* ISNULL(d.observaciones,'') */ as obser_adici,
			isnull(codi_oper,'0101'), 
			isnull(total_gratuita,0),
			cast(datepart(YEAR,f.VENC_FACT) as varchar)+'-'+right('00'+cast(datepart(MONTH,f.VENC_FACT) as varchar),2)+ '-'+right('00'+cast(datepart(DAY,f.VENC_FACT) as varchar),2) as VENC_FACT,

			isnull((select (select u.Codi_Ubi_Dist_Sunat from UBIGEO_DISTRITO U (nolock)
					where u.codi_ubi_dist=c.codi_ubi_dist) from cliente_proveedor C (nolock) 
					where c.CODI_CLIE_PROV=F.codi_clie_prov),'') , 
					
			isnull((select codi_sunat_esta from cliente_proveedor C (nolock) where c.CODI_CLIE_PROV=F.codi_clie_prov),'0000')  , 
			IMPO_ITEM , codi_Desc_deta, codi_bien_serv, isnull(total_gratuita,0),
			ISNULL(prec_lista,0 ),
			convert(char(10),f.FECH_FACT,103), 
			isnull(dscto_fact,0) 			
from factura F (nolock)
join factura_detalle D (nolock)
on F.codi_fact=D.codi_Fact
where F.codi_Fact=@codifact


select distinct 
       /*'01' */ InvoiceTypeCode +'|'+
       /*'02' */ NroSeriDocu +'|'+
       /*'03' */ IssueDate +'|'+
       /*'04' */ moneda +'|'+
       /*'05' */ isnull(NroSeriGuia,'') +'|'+
	   /*'06' */ isnull(CodiSunatGuia,'') +'|'+
       /*'07' */ isnull(NroSeriOtroDocu,'') +'|'+
       /*'08' */ isnull(CodiSunatOtroDocu,'') +'|'+
       /*'09' */ isnull(OrdenCompra,'') +  '|'+ 
	   /*'10' */ isnull(vence,'') + '|'+   
	   /*'11' */ rtrim(isnull(convert(char(10),creacion,108) ,'')) + '|'+
	   /*'12' */ isnull(tipo_oper,'0101') +'|'+
	   --/*'13' */ isnull(cast((select count(*) from factura_detalle D (nolock) where D.codi_Fact=@codifact) as varchar(3)),'0') +'|'+
       /*'13' */ '' +'|'+
	   /*'14' */ '' +'|'+	   
       /*'15' */ separador  
from @InfoDocu
union all
select distinct 
       /*'17' */ RucEmpresa +'|'+
       /*'18' */ IDSunat +'|'+
       /*'19' */ RazonSocial +'|'+
       /*'20' */ nombrecomercial +'|'+
       /*'21' */ ubigeo +'|'+
       /*'22' */ direccion +'|'+
       /*'23' */ Urbanizacion +'|'+
       /*'24' */ provincia +'|'+
       /*'25' */ departamento +'|'+
       /*'26' */ distrito +'|'+
       /*'27' */ pais +'|'+
	   /*'28' */ isnull(paginaweb,'') + '|'+
	   /*'29' */ telefonoEmp + '|'+
	   /*'30' */ isnull(correoEmp,'') +'|'+
	   /*'31' */ isnull(codigo_emp,'') + '|'+
       /*'32' */ separador2  
from @InfoDocu
union all
select distinct 
	   /*'34' */ RucCliente +'|'+
       /*'35' */ IDSunatCliente +'|'+
       /*'36' */ RazonSocialCliente +'|'+
	   /*'37' */ '' + '|' + 
	   /*'38' */ rtrim(isnull(ubigeo_clie,'')) + '|'+
       /*'39' */ direccionCliente +'|'+
       /*'41' */ provinciacliente +'|'+
       /*'42' */ departamentocliente +'|'+
       /*'43' */ distritoCliente +'|'+
       /*'44' */ paisCliente +'|'+
	   /*'45' */ rtrim(isnull(codigo_cliente,'')) + '|' +
       /*'46' */ separador3  
from @InfoDocu
union all
select /*'47' */ '~'
union all
select distinct 
	   /*49*/	case when i.afecIgv in ('20','30','40') then cast(sum(cast(i.valorVenta as numeric(12,2))) as varchar(20)) else '' end + '|' +
	   /*50*/	case when i.afecIgv in ('20','30','40') then '0.00' else '' end + '|' + 
	   /*51*/	case when i.afecIgv in ('20','30','40') then 'O' else '' end + '|' +
	   /*52*/	case  i.afecIgv  
					when '20'  then '9997'  when '30' then '9998' when '40' then '9995' 
						  else '' end +  '|' +
	   /*53*/	case  i.afecIgv  
					when '20'  then 'EXO'  when '30' then 'INA' when '40' then 'EXP' 
						  else '' end +  '|' +
	   /*54*/	case  i.afecIgv  
					when '20'  then 'VAT'  when '30' then 'FRE' when '40' then 'FRE' 
						  else '' end +  '|' +
	   /*55*/	'}'
from @InfoDocu I 
group by i.afecIgv
union all
select distinct 
	   /*56*/	case when i.afecIgv in ('11','12','13','14','16','21') then cast(sum(cast(i.valorVenta as numeric(12,2))) as varchar(20))else '' end + '|' +
	   /*57*/	case when i.afecIgv in ('11','12','13','14','16','21') then '0.00' else '' end + '|' + 
	   /*58*/	case when i.afecIgv in ('11','12','13','14','16','21') then 'Z' else '' end + '|' +
	   /*59*/	case when i.afecIgv in ('11','12','13','14','16','21') then '9996' else '' end +  '|' +
	   /*60*/	case when i.afecIgv in ('11','12','13','14','16','21') then 'GRA' else '' end  + '|' + 
	   /*61*/	case when i.afecIgv in ('11','12','13','14','16','21') then 'FRE' else '' end + '|'  +
	   /*62*/	'}'
from @InfoDocu I 
group by i.afecIgv
union all
select distinct 
	   /*63*/	case when i.afecIgv in ('10') then cast(sum(cast(i.valorVenta as numeric(12,2))) as varchar) else '' end + '|' +
	   /*64*/	case when i.afecIgv in ('10') then cast(sum(cast(i.igvdeta as numeric(12,2))) as varchar) else '' end + '|' + 
	   /*65*/	case when i.afecIgv in ('10') then 'S' else '' end + '|' +
	   /*66*/	case when i.afecIgv in ('10') then '1000' else '' end +  '|' +
	   /*67*/	case when i.afecIgv in ('10') then 'IGV' else '' end  + '|' + 
	   /*68*/	case when i.afecIgv in ('10') then 'VAT' else '' end + '|' +
	   /*69*/	'}'
from @InfoDocu I 
group by i.afecIgv
union all
select 
       /*70*/ '|'+
       /*71*/ '|'+
       /*72*/ '|'+
       /*73*/ '|'+
       /*74*/ '|'+
       /*75*/ '}'
	   /*76*/	'}'
union all
select /*77*/ '~'
union all
select distinct 
       /*78*/ I.valorFAct  + '|'+
       /*80*/ isnull(total_fact,'') +'|'+
       /*81*/ cast(i.dscto_fact as varchar(10))+	'|'+
	   /*82*/ '0.00' +	'|' + 
	   /*83*/ isnull((select cast(cast(sum(d.monto_anti/(1 + dbo.F_IGV(d.fecha_pago_rece)/100.00)) as numeric(12,2)) as varchar)  from factura F (nolock)
					 join FACTURA_ANTICIPOS D (nolock)
					on F.codi_fact=D.codi_Fact
					where F.codi_Fact=@codifact),'') + '|' +
       /*84*/ isnull( cast(cast(total_fact as numeric(12,2)) as varchar),'') +'|'+
	   /*85*/	'|' + 
	   /*86*/	igv_fact  + '|' +
       /*87*/ '}' 
from @InfoDocu I 
union all
select /*88*/ '~'
union all
select /*90*/	case when codi_desc is null then '' else 'false' end + '|' + 
		/*91*/	isnull(rtrim(codi_desc),'') + '|' +
		/*92*/	case when codi_desc is null then '' else cast(factor_dscto as  varchar(10)) end + '|'  +  
		/*93*/	case when codi_desc is null then '' else cast(dscto_global as varchar(20)) end  + '|' + 
		/*94*/	case when codi_desc is null then '' else cast(f.SUBTOTA_FACT as varchar(20)) end + '|' + 
		/*95*/ '}' 
from factura F (nolock)
where F.codi_Fact=@codifact
union all
select /*96*/ '~'
union all
select 
       /*98*/  isnull(cast(cast(d.monto_anti/(1 + dbo.F_IGV(d.fecha_pago_rece)/100.00) as numeric(12,2)) as varchar),'') +'|'+
       /*99*/  case D.codi_mone when '01' then 'PEN' when '02' then 'USD' else '' end  + '|' + 	   
       /*100*/ case when d.codi_tipo_docu is not null then 
					case when isnumeric(serie)=1 then 
					right('0000'+ cast(cast(serie as numeric) as varchar),4) else serie end + '-'+ right('00000000'+ cast( cast(numero as numeric) as varchar),8) 
				else '' end + '|'+

	   /*101*/	case when d.codi_tipo_docu is not null then 
					case when D.codi_tipo_docu='0001' then '02' else '03' end
				else '' end  + '|'+
	   /*102*/ 	  '|' +        
       /*103*/ isnull(cast(datepart(YEAR,d.fecha_pago_efec ) as varchar)+'-'+right('00'+cast(datepart(MONTH,d.fecha_pago_efec ) as varchar),2)+ '-'+right('00'+cast(datepart(DAY,d.fecha_pago_efec ) as varchar),2) ,'') + '|'+
       /*104*/ '}'
from factura F (nolock)
left join FACTURA_ANTICIPOS D (nolock)
on F.codi_fact=D.codi_Fact
where F.codi_Fact=@codifact
union all
select /*105*/ '~'
union all
select 
		/*107*/	cast(item as varchar(10) ) + '|' +
		/*108*/	i.cantidad + '|' + 
       /*109*/ i.unidMedi    +'|'+
	   /*110*/ i.valorVenta +'|'+
       /*111*/ i.igvdeta +'|'+
       /*112*/ i.preciunitario+'|'+
       /*113*/ i.tipoprecio +'|'+
       /*114*/  i.indidesc +'|'+
	   /*115*/	isnull(rtrim(codi_desc_deta),'') + '|' +
       /*116*/ i.porcdesc +'|'+
	   /*117*/ i.montodesc +'|'+
	   /*118*/ case when codi_desc_deta is null then '' else cast(i.precio_base as varchar(20)) end +'|'+
	   /*119*/	i.valorVenta  + '|' +
	   /*120*/	i.igvdeta + '|' + 
	   /*121*/	case i.afecIgv  when '10' then 'S' when '30' then 'O'  else 'Z' end + '|' +
	   /*122*/	cast(i.valor_igv as varchar(10))+ '|' + 
	   /*123*/	i.afecIgv +'|'+
	   /*124*/	case  i.afecIgv  
					when '20'  then '9997'  when '30' then '9998' when '40' then '9995' 
	   					when '10' then '1000' else '9996' end +  '|' +
		/*125*/case  i.afecIgv  
					when '20'  then 'EXO'  when '30' then 'INA' when '40' then 'EXP' 
						when '10' then 'IGV'   else 'GRA' end +  '|' +
		/*126*/	case  i.afecIgv  
					when '20'  then 'VAT'  when '30' then 'FRE' when '40' then 'FRE' 
						when '10' then 'VAT'   else 'FRE' end +  '|' +
		/*127*/  '|' +
		/*128*/  '|' +
		/*129*/  '|' +
		/*130*/  '|' +
		/*131*/  '|' +
		/*132*/  '|' +
		/*133*/  '|' +
		/*134*/  '|' +
		/*135*/  '|' +
		/*136*/  '|' +
		/*137*/  '|' +
		/*138*/  '|' +
		/*139*/  '|' +
		/*140*/  '|' +
		/*141*/  '|' +
       /*142*/ isnull(rtrim(i.desc_item),'') + '|'+
       /*143*/ isnull(ltrim(case when cast(observ_adicional as varchar)<>'' then dbo.uf_observ_fact(cast(observ_adicional as varchar(1000))) else '' end),'') + '|'   +
       /*144*/ i.codi_prod +'|'+
	   /*145*/	isnull((select x.codi_prod_sunat from productos x (nolock) where x.codi_prod=i.codi_prod),'') + '|' + 
	   /*146*/	'|' +
       /*147*/ precSinIgv +'|'+	   
	   /*149*/ '|'+
	   /*150*/ '|'+
	   /*151*/ '|'+
	   /*152*/ '|'+
	   /*153*/ '|'+
	   /*154*/ '|'+
       /*155*/ '}'  as d
from @InfoDocu I 
union all
select /*156*/ '~'
union all
select distinct 
       /*158*/  dbo.F_NUMLET(i.total_fact)+ case when Moneda='PEN' then ' SOLES' else ' DÓLARES' end +'|'+
	   /*159*/	'1000'+ 
	   /*160*/	'}' 
from @InfoDocu I
union all
select /*161*/ '~'
union all
select distinct 
		/*163*/	  sucursal +	'|'+
		/*164*/	  SucurDirec +	'|'+
		/*165*/	  SucurDistri +		'|'+
		/*166*/	  rtrim(isnull(convert(char(10),HoraEmis,108) ,''))  +	'|'+
       /*167*/   case when TipoPago='CREDITO' then 
					 case when dias_fact is null or dias_fact=0 
						then TipoPago 
						else TipoPago + ' '+ cast(dias_fact as varchar)+ ' DÍAS' end 
					 else TipoPago end  +'|'+
		/*168*/	Cajero + '|' +			 
       /*169*/	'}'              
from @InfoDocu as I	   
union all
select distinct 
	   /*170*/	cast(observaciones as varchar)+  '|' +
       /*172*/  correocliente +'|'+
       /*173*/  isnull(impresora,'') + '|'+
       /*174*/  '1' + '|'+
	   /*175*/  'emitir_tkt'+ '|'+
       /*176*/       '}'
from @InfoDocu I
union all
select /*177*/ '~'
union all
select /*178*/ '\'
GO
