CREATE PROCEDURE [dbo].[usp_genera_fact_elec]
	@codifact [varchar](10)
WITH EXECUTE AS CALLER
AS
--declare @codifact varchar(10)
--select @codifact='0000747974'

declare @InfoDocu table (InvoiceTypeCode char(2), NroSeriDocu varchar(13), IssueDate varchar(10) , moneda varchar(3) , 
                                        NroSeriGuia varchar(30) null, CodiSunatGuia varchar(2) null, NroSeriOtroDocu varchar(30) null, CodiSunatOtroDocu varchar(2) null,
                                        OrdenCompra varchar(30) null, separador char(1) ,
                                        RucEmpresa varchar(11) , IDSunat char(1), RazonSocial varchar(100), nombrecomercial varchar(100), ubigeo varchar(6), direccion varchar(250) ,
                                        Urbanizacion varchar(25), provincia varchar(100),  departamento varchar(100),  distrito varchar(100), pais char(2), separador2 char(2),
                                        RucCliente varchar(15), IDSunatCliente char(1), RazonSocialCliente varchar(100), direccionCliente varchar(250), 
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
                                        impresora varchar(200)
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
             cast(d.IMPO_ITEM as numeric(12,2)),
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
			else (select impresora from almacen A (nolock) where A.codi_alma=F.codi_alma) end as printer_name
			
from factura F (nolock)
join factura_detalle D (nolock)
on F.codi_fact=D.codi_Fact
where F.codi_Fact=@codifact


select distinct 
       /*'01' */ InvoiceTypeCode +'|'+
       /*'02' */ NroSeriDocu +'|'+
       /*'03' */ IssueDate +'|'+
       /*'04' */ moneda +'|'+
       /*'05' */ NroSeriGuia +'|'+
       /*'06' */ CodiSunatGuia +'|'+
       /*'07' */ NroSeriOtroDocu +'|'+
       /*'08' */ CodiSunatOtroDocu +'|'+
       /*'09' */ OrdenCompra +  --'|'
       /*'10' */ separador  
from @InfoDocu
union all
select distinct 
       /*'12' */ RucEmpresa +'|'+
       /*'13' */ IDSunat +'|'+
       /*'14' */ RazonSocial +'|'+
       /*'15' */ nombrecomercial +'|'+
       /*'16' */ ubigeo +'|'+
       /*'17' */ direccion +'|'+
       /*'18' */ Urbanizacion +'|'+
       /*'19' */ provincia +'|'+
       /*'20' */ departamento +'|'+
       /*'21' */ distrito +'|'+
       /*'22' */ pais +'|'+
       /*'23' */ separador2  
from @InfoDocu
union all
select distinct 
       /*'25' */ RucCliente +'|'+
       /*'26' */ IDSunatCliente +'|'+
       /*'27' */ RazonSocialCliente +'|'+
       /*'28' */ direccionCliente +'|'+
       /*'29' */ provinciacliente +'|'+
       /*'30' */ departamentocliente +'|'+
       /*'31' */ distritoCliente +'|'+
       /*'32' */ paisCliente +'|'+
       /*'33' */ separador3  
from @InfoDocu
union all
select '~'
union all
select distinct 
       /* 36 */  igv_fact +'|'+
       /* 37 */  codiTrib +'|'+
       /* 38 */  nombTribu +'|'+ 
       /* 39 */  codiIntTrib +'|'+
       /* 40 */  separador4 
from @InfoDocu
union all
select 
       /*41*/ '|'+
       /*42*/ '|'+
       /*43*/ '|'+
       /*44*/ '|'+
       /*45*/ '}'
union all
select 
       /*46*/ '|'+
       /*47*/ '|'+
       /*48*/ '|'+
       /*49*/ '|'+
       /*50*/ '}'
union all
select '~'
union all
select distinct 
       /*53*/ '|'+
       /*54*/ total_fact +'|'+
       /*55*/ '|'+
       /*56*/ '|' +
       /*57*/ '}' 
from @InfoDocu
union all
select '~'
union all
select 
       /*59*/ '|'+
       /*60*/ '|'+
       /*61*/ '|'+
       /*62*/ '|'+
       /*63*/ '|'+
       /*64*/ '|'+
       /*65*/ '}'
union all
select '~'
union all
select 
       /*68*/ i.desc_item +'|'+
       /*69*/  '|'   +
       /*70*/ i.codi_prod +'|'+
       /*71*/ i.unidMedi    +'|'+
       /*72*/ i.cantidad    +'|'+
       /*73*/ i.valorVenta +'|'+
       /*74*/ i.preciunitario+'|'+
       /*75*/ i.tipoprecio +'|'+
       /*76*/  i.indidesc +'|'+
       /*77*/ i.porcdesc +'|'+
       /*78*/ i.montodesc +'|'+
       /*79*/ i.igvdeta +'|'+
       /*80*/ i.afecIgv +'|'+
       /*81*/ i.codiTriDeta +'|'+
       /*82*/ i.nombTriDeta +'|'+
       /*83*/ i.intTribDeta +'|'+
       /*84*/ i.montoIsc +'|'+
       /*85*/ i.tipoIsc +'|'+
       /*86*/ i.TribIsc +'|'+
       /*87*/ i.nomBISc+'|'+
       /*88*/ i.intIsc +'|'+
       /*89*/ precSinIgv +'|'+
       /*90*/ '}'
from @InfoDocu I
union all
select '~'
union all
select distinct 
             /*93*/ valorFAct +'|'+
             /*94*/ '|'    +
             /*95*/ case when totaexon<>'0.00' then totaexon  else '' end  +'|'+
             /*96*/ '|'    +
             /*97*/ '|'    +
             /*98*/ '|'    +
             /*99*/ '|'    +
             /*100*/       '|'    +
          /*101*/       '|'    +
             /*102*/       '}'    
from @InfoDocu i
union all
select 
       /*98*/ '|'+
       /*99*/ '|'+
       /*100*/ '|'+
       /*101*/ '|'+
       /*102*/ '}'
union all
select distinct     
       /*102*/       I.tasadetra +'|'+ 
       /*103*/       i.montodetra + '|'+        
       /*104*/       i.ctadetra + '|'+
       /*105*/ '|}' 
from @InfoDocu as I
union all
select '~'
union all
select distinct 
       /*113*/ sucursal +'|'+
       /*114*/ SucurDirec+ '|'+
       /*115*/ SucurDistri +'|'+
       /*116*/ rtrim(convert(char(10),HoraEmis,108)) + '|'+
       /*117*/ case when TipoPago='CREDITO' then 
					 case when dias_fact is null or dias_fact=0 
						then TipoPago 
						else TipoPago + ' '+ cast(dias_fact as varchar)+ ' DÍAS' end 
					 else TipoPago end  +'|'+
       /*118*/ Cajero + '|'+
       /*119*/ TelefonoEmp + '|'+
       /*120*/ CorreoEmp + '|'+
       /*121*/ PaginaWeb + '}'     
from @InfoDocu as I
union all
select distinct 
       /*120*/  'GRACIAS POR SU COMPRA'+    '|'+
       /*121*/  dbo.F_NUMLET(i.total_fact) + case when Moneda='PEN' then ' Soles' else ' Dólares' end+ '|'+
       /*122*/  correocliente +'|'+
       ---	rtrim(substring(isnull(impresora,''), 1, patindex('%(%',isnull(impresora,'')) - 1 ))+ '|'+
	   /*123*/	isnull(impresora,'') +  '|'+       
       /*124*/  '1' + '|'+
       /*125*/       '}'
from @InfoDocu I
union all
select '~'
union all
select '\'
GO
