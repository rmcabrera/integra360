CREATE PROCEDURE [dbo].[usp_indicador_stock_sucursal_meses]
	@alma [char](2),
	@f1 [datetime],
	@f2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @alma char(2), @f1 datetime, @f2 datetime
--select @alma ='',  @f1 ='01/01/2016' , @f2='28/03/2016'

set nocount on

--- inventario 04
---- compra		01	23	26
---- devolucion	11	07
-- venta		08

/*producto	stock inicial	abastecimiento	abastecimiento	stock actual	stcok a los 30 dias	stcok a los 60 dias	stcok a los 90 dias	stcok a los 120 dias
movento x lt	253	12	24	289	280	270	260	250
*/
set @f2 = cast(convert(char(10),@f2,103) + ' 23:59:59' as datetime)

select codi_alma, codi_prod, 
	(select nemo_alma from almacen A (nolock) where A.codi_alma=SQ.codi_alma) Almacen,
	(select desc_prod from productos P (nolock) where P.codi_prod=Sq.codi_prod) as DescProd,
	sum(case when tipo='04' or fech_tran<@f1 then cant_ingr else 0 end ) as Inventario,
	sum(case when tipo in ('01','23','26') and fech_Tran>=@f1 then cant_ingr else 0 end ) as Abastecimiento,
	sum(case when tipo in ('04','01','23','26') then cant_ingr else 0 end ) as Stock,	
	--sum(cant_ingr - cant_sali ) as Stock,	
	
	sum(case when tipo in ('01','23','26') and (fech_tran>=@f1 and  fech_tran <= dateadd(dd,30,@f1)) and  fech_tran <=@f2 then cant_ingr else 0 end) as Compra30,
	sum(case when tipo in ('01','23','26') and (fech_tran>=@f1 and (fech_tran>dateadd(dd,30,@f1) and fech_tran <= dateadd(dd,60,@f1)) ) and  fech_tran <=@f2 then cant_ingr else 0 end) as Compra60,
	sum(case when tipo in ('01','23','26') and (fech_tran>=@f1 and (fech_Tran>dateadd(dd,60,@f1) /*and fech_tran <= dateadd(dd,90,@f1)*/) ) and  fech_tran <=@f2 then cant_ingr else 0 end) as Compra90,
	
	sum(case when tipo in ('17','07') then cant_sali else 0 end ) as Devolucion,
	sum(case when (fech_tran>=@f1 and fech_tran <= dateadd(dd,30,@f1)) and  fech_tran <=@f2 then cant_ingr - cant_sali else 0 end) as Stock30,
	sum(case when (fech_tran>=@f1 and fech_tran <= dateadd(dd,60,@f1)) and  fech_tran <=@f2 then cant_ingr - cant_sali else 0 end) as Stock60,
	sum(case when (fech_tran>=@f1 and fech_tran <= dateadd(dd,90,@f1)) and  fech_tran <=@f2 then cant_ingr - cant_sali else 0 end) as Stock90,
	sum(case when (fech_tran>=@f1 and fech_tran <= dateadd(yy,1,@f1)) and  fech_tran <=@f2 then cant_ingr - cant_sali else 0 end) as Stock
--	cant_ingr, cant_sali, tipo
from (select codi_alma, codi_prod, cant_ingr, cant_sali, fech_Tran,
			case when i_o=1 then 
					(select tipo_nota_ingr from nota_ingreso N (nolock)
							where N.codi_nota_ingr=codi_docu_i_o)
				else
					(select tipo_sali from docu_sali_mate D (nolock)
							where D.codi_docu_sali=codi_docu_i_o)
				end as Tipo
	from kardex K (nolock) 
	where periodo= year(@f2) and convert(char(10),fech_tran,103) <= @f2) SQ
where (codi_alma=@alma or isnull(@alma,'')='00' )---codi_prod='00011582' -- codi_alma='02'	
group by codi_alma, codi_prod
order by codi_alma, codi_prod
GO
