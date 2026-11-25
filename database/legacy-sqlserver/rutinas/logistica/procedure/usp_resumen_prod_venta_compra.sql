CREATE PROCEDURE [dbo].[usp_resumen_prod_venta_compra]
	@per [char](4),
	@Fec1 [datetime],
	@fec2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @per char(4) , @Fec1 datetime, @fec2 datetime
--select @per='2014', @Fec1 ='01/01/2014', @Fec2='02/01/2014'

set nocount on 

create table #Tx (codi_alma  char(2) null, codi_prod char(8) null)

insert #Tx
select distinct codi_alma,codi_prod
from kardex (nolock)
where periodo=@per

declare @ini char(5)
set @ini = left(CONVERT(char(10),@fec1, 103),5)

select codi_prod, (select desc_prod from productos P (nolock) where P.codi_prod=SQ.codi_prod)  Nombre,
		codi_alma, (select nemo_alma from almacen A (nolock) where A.codi_alma=SQ.codi_alma) Almacen,
		inicial, compra, Otros_ingre, trasladoIngr, TrasladoSAli, venta, otras_sali, Stock,
		(select razon_Social from empresa) Empresa
from
	(select codi_alma, codi_prod,
		
		isnull((select sum(cant_ingr- cant_sali) from kardex K (nolock)
			where K.periodo=@per and k.codi_alma=A.codi_alma and K.codi_prod=A.codi_prod and k.fech_tran<@fec1),0) +
		
		case when @ini='01/01' then 
			isnull((select sum(cantidad) 
				from detalle_nota_ingreso d (nolock)
					join nota_ingreso N (nolock)
				on D.codi_nota_ingr=N.codi_nota_ingr
				where N.codi_alma=A.codi_alma and Tipo_nota_ingr='04' and 
						(fech_nota_ingr = @fec1 ) and D.codi_prod=A.codi_prod ),0) else 0 end Inicial,
			
		isnull((select sum(cantidad) 
			from detalle_nota_ingreso d (nolock)
				join nota_ingreso N (nolock)
			on D.codi_nota_ingr=N.codi_nota_ingr
			where N.codi_alma=A.codi_alma and Tipo_nota_ingr='01' and 
					(fech_nota_ingr between @fec1 and @Fec2) and D.codi_prod=A.codi_prod ),0) Compra,

		isnull((select sum(cantidad*case when left(CONVERT(char(10),fech_nota_ingr, 103),5)='01/01' then 0 else 1 end)
			from detalle_nota_ingreso d (nolock)
				join nota_ingreso N (nolock)
			on D.codi_nota_ingr=N.codi_nota_ingr
			where N.codi_alma=A.codi_alma and Tipo_nota_ingr not in ('01','23') and 
					(fech_nota_ingr between @fec1 and @Fec2) and D.codi_prod=A.codi_prod ),0) Otros_ingre,
					
		isnull((select sum(cantidad) 
			from detalle_docu_sali d (nolock)
				join docu_Sali_mate N (nolock)
			on D.codi_docu_sali=N.codi_docu_sali
			where N.codi_alma=A.codi_alma and tipo_Sali='08' and 
					(fech_emis between @fec1 and @Fec2) and D.codi_prod=A.codi_prod ) ,0) Venta,

		isnull((select sum(cantidad) 
			from detalle_nota_ingreso d (nolock)
				join nota_ingreso N (nolock)
			on D.codi_nota_ingr=N.codi_nota_ingr
			where N.codi_alma=A.codi_alma and Tipo_nota_ingr='23' and 
					(fech_nota_ingr between @fec1 and @Fec2) and D.codi_prod=A.codi_prod ),0) trasladoIngr,

		isnull((select sum(cantidad) 
			from detalle_docu_sali d (nolock)
				join docu_Sali_mate N (nolock)
			on D.codi_docu_sali=N.codi_docu_sali
			where N.codi_alma=A.codi_alma and tipo_Sali='17' and 
					(fech_emis between @fec1 and @Fec2) and D.codi_prod=A.codi_prod ) ,0) TrasladoSali,
		
		isnull((select sum(cantidad) 
			from detalle_docu_sali d (nolock)
				join docu_Sali_mate N (nolock)
			on D.codi_docu_sali=N.codi_docu_sali
			where N.codi_alma=A.codi_alma and tipo_Sali not in('17','23','08') and 
					(fech_emis between @fec1 and @Fec2) and D.codi_prod=A.codi_prod ) ,0) Otras_Sali,
		
		isnull((select sum(cant_ingr- cant_sali) from kardex K (nolock)
			where K.periodo=@per and k.codi_alma=A.codi_alma and K.codi_prod=A.codi_prod and k.fech_tran<dateadd(d,1,@fec2)),0) Stock
					
					
	from #Tx A	) SQ
where not (inicial=0 and compra=0 and venta=0 and trasladoIngr=0)
order by 2, codi_alma

drop table #Tx
GO
