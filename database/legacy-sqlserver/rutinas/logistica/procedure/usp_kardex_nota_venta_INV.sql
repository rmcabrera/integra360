CREATE PROCEDURE [dbo].[usp_kardex_nota_venta_INV]
	@fec1 [datetime],
	@Fec2 [datetime],
	@per [int],
	@alma [char](2),
	@prod [char](8),
	@subfam [char](4),
	@labo [char](5)
WITH EXECUTE AS CALLER
AS
--declare @fec1 datetime , @Fec2 datetime, @per int , @alma char(2), @prod char(8) , @subfam char(4) , @labo char(5)
--select @fec1='01/08/2020', @fec2='06/08/2020', @per=2020, @Alma='11', @prod ='00080461', @subfam ='' , @labo =''

set nocount on

declare @TxA table(codi_alma char(2))
if @alma='00'  or @alma='' or @alma is null
	insert @TxA
	select codi_alma from almacen (nolock)

if not (@alma='00'  or @alma='' or @alma is null)
	insert @TxA
	select @alma

declare @TxR table (codi_prod char(8) null, fecha datetime null, ingreso numeric(12,4) null, salida numeric(12,4) null,
					i_o int null, concepto varchar(250) null, razon varchar(150) null, desc_prod varchar(250) null, nro_cuen char(7) null,
					codi_unid_medi char(2) null, desc_cuen varchar(150) null, nro_docu varchar(15) null)

declare @TxV table (codi_prod char(8) null , cantidad numeric(12,4) null)

------------------- obtiene los vales anteriores a la fecha inicial
insert @TxV
select B.codi_prod, sum(cantidad) 
from NOTA_VENTA A (nolock)
join NOTA_VENTA_DETALLE b (nolock)
on A.codi_nota_venta=B.codi_nota_venta
join productos P (nolock)
on B.codi_prod=P.codi_prod 
join sub_familia_producto s (nolock)
on S.codi_sub_fami_prod = p.codi_sub_Fami_prod
where codi_fact is null	and isnull(A.estado,'')<>'N' and A.codi_alma in (select codi_alma from @TxA)	 and 
		--year(fecha)=@per and
		 fecha<@FEC1 
		and (B.codi_prod =@prod or isnull(@prod,'') ='')						
		and (s.codi_sub_fami_prod=@subfam or isnull(@subfam,'') ='')
		and (P.codi_clie_prov =@labo or isnull(@labo,'') ='')	
group by b.codi_prod
		
		
-------------- inserta todo el detalle de movimientos 		
insert @TxR
SELECT	KARDEX.codi_prod,  
         KARDEX.fech_tran, 
         KARDEX.cant_ingr,   
         KARDEX.cant_sali, 
         KARDEX.I_O,   
         KARDEX.concepto,   
         Empresa.Razon_Social, 
         PRODUCTOS.DESC_PROD,   
         PRODUCTOS.NRO_CUEN,   
         PRODUCTOS.CODI_UNID_MEDI,   
         CUENTAS_CONTABLE.DESC_CUEN,
		 case when i_o=1 then 
			(Select top 1 nro_nota_ingr from nota_ingreso (nolock) where codi_nota_ingr = KARDEX.codi_docu_i_o and i_o = 1)  
		 else (Select top 1 nro_sali from docu_sali_mate (nolock) where codi_docu_sali = KARDEX.codi_docu_i_o and i_o = 2 ) end nro_docu
    FROM KARDEX (nolock), Empresa (nolock), PRODUCTOS (nolock),CUENTAS_CONTABLE (nolock)  , sub_familia_producto s (nolock)
   WHERE periodo=@per and 
		 ( PRODUCTOS.NRO_CUEN *= CUENTAS_CONTABLE.NRO_CUEN) and  
         ( KARDEX.codi_prod = PRODUCTOS.CODI_PROD ) and  ( ( cast( convert(char(10),fech_tran,103) as datetime) between  @fec1 AND @fec2 ) )  
			and codi_alma in (select codi_alma from @TxA)
			and (kardex.codi_prod =@prod or isnull(@prod,'') ='') and 
			s.codi_sub_fami_prod=productos.codi_sub_fami_prod and 
			(s.codi_sub_fami_prod=@subfam or isnull(@subfam,'') ='') and
			(Productos.codi_clie_prov =@labo or isnull(@labo,'') ='')	

union all
select B.codi_prod, fecha, 0, cantidad, case when codi_tipo_pago=4 then 3 else 4 end , case when codi_tipo_pago=4 then 'NV Crédito' else 'NV Efectivo' end ,
		(select razon_social from empresa (nolock) ) , desc_item, 
		(select nro_cuen from productos P (nolock) where p.codi_prod= B.codi_prod) cuenta,
		(select codi_unid_medi from productos P (nolock) where p.codi_prod= B.codi_prod) unid_medi,		
		(select (select desc_cuen from cuentas_contable c (nolock) where C.nro_cuen =p.nro_cuen)
			 from productos P (nolock) where p.codi_prod= B.codi_prod) cuenta, nro_nota_venta as nro_vale
from NOTA_VENTA A (nolock)
join NOTA_VENTA_DETALLE b (nolock)
on A.codi_nota_venta=B.codi_nota_venta
join productos P (nolock)
on B.codi_prod=P.codi_prod 
join sub_familia_producto s (nolock)
on S.codi_sub_fami_prod = p.codi_sub_Fami_prod
where codi_fact is null and isnull(A.estado,'')<>'N' and A.codi_alma in (select codi_alma from @TxA)	
	and ( ( cast( convert(char(10),fecha,103) as datetime) between  @fec1 AND @fec2 ) )  
	and year(fecha)=@per 
	and (b.codi_prod =@prod or isnull(@prod,'') ='') 
	and (s.codi_sub_fami_prod=@subfam or isnull(@subfam,'') ='')
	and (P.codi_clie_prov =@labo or isnull(@labo,'') ='')		
union all
select S.codi_prod, fech_tran, cant_ingr, cant_sali, 
		i_o, c9, empresa.Razon_Social,
         productos.DESC_PROD, productos.NRO_CUEN, PRODUCTOS.CODI_UNID_MEDI, CUENTAS_CONTABLE.dESC_CUEN,''
from (select pk.codi_prod,
		dateadd(d,-1,@FEC1) as Fech_tran,
		isnull( case when isnull(sum(cant_ingr - cant_sali),0) -
				isnull((select cantidad from @TxV X where x.codi_prod=pk.codi_prod ),0) >0 then 
						isnull(sum(cant_ingr - cant_sali),0) - isnull((select cantidad from @TxV X where x.codi_prod=pk.codi_prod ),0) else 0 end,0) as Cant_ingr,	
		isnull( case when isnull(sum(cant_ingr - cant_sali),0) - isnull((select cantidad from @TxV X where x.codi_prod=pk.codi_prod ),0) >0 then 0 
				else abs(isnull(sum(cant_ingr - cant_sali),0) - isnull((select cantidad from @TxV X where x.codi_prod=pk.codi_prod ),0)) end,0) as cant_sali,
		1 as I_O,  
		'SALDO ANTERIOR' as C9
		from kardex (nolock) , 
			(select distinct codi_prod from kardex (nolock) where cast(convert(char(10),fech_tran,103) as datetime) <=@FEC2) as PK
			where periodo=@per and fech_tran<@FEC1 and pk.codi_prod *= Kardex.codi_prod 
					and codi_alma in (select codi_alma from @TxA)
			group by pk.codi_prod) as S,PRODUCTOS (nolock),   
		         CUENTAS_CONTABLE (nolock), EMPRESA (nolock), sub_familia_producto SF (nolock)
		where  PRODUCTOS.NRO_CUEN *= CUENTAS_CONTABLE.NRO_CUEN and  
         	 S.codi_prod = PRODUCTOS.CODI_PROD   
			and not (Cant_ingr=0 and cant_sali=0)
			and (s.codi_prod =@prod or isnull(@prod,'') ='') and 
			sf.codi_sub_fami_prod=productos.codi_sub_fami_prod and 
			(sf.codi_sub_fami_prod=@subfam or isnull(@subfam,'') ='') and 
			(Productos.codi_clie_prov =@labo or isnull(@labo,'') ='')	
----------- reporta los datos
--declare @Fx table(codi_prod char(8) null, desc_prod varchar(250) null, afecto int null, sub_fam varchar(150) null,
--                  fam varchar(150) null, linea varchar(150) null, saldo numeric(18,2) null)

--insert @Fx
select codi_prod, max(desc_prod) as desc_prod, (select cod_impuesto from productos p(nolock) where p.codi_prod=T.codi_prod) afecto,
	(select desc_sub_fami_prod from sub_familia_producto s(nolock) where s.codi_sub_fami_prod in
		(select codi_sub_fami_prod from productos p(nolock) where p.codi_prod=T.codi_prod)) as sub_fam,
	
	(select desc_fami_prod from familia_producto f(nolock) where f.codi_fami_prod in
		(select codi_fami_prod from sub_familia_producto s(nolock) where s.codi_sub_fami_prod in
			(select codi_sub_fami_prod from productos p(nolock) where p.codi_prod=T.codi_prod))) as fam,

	(select des_lin_pro from linea_familia_pro l(nolock) where l.cod_lin_pro in
		(select cod_lin_pro from familia_producto f(nolock) where f.codi_fami_prod in
			(select codi_fami_prod from sub_familia_producto s(nolock) where s.codi_sub_fami_prod in
				(select codi_sub_fami_prod from productos p(nolock) where p.codi_prod=T.codi_prod)))) as linea,
	
	isnull(sum(ingreso), 0) - isnull(sum(salida), 0) as saldo,
	case when rtrim(isnull(@labo,''))='' then '' else dbo.f_cliente_proveedor(@labo) end as Laboratorio,
	case when @alma='00' then 'TODOS' else 
		(select nemo_alma from almacen A (nolock) where A.codi_alma=@alma) end as Almacen	
from @TxR T
group by codi_prod
order by desc_prod
GO
