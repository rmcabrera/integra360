CREATE PROCEDURE [dbo].[usp_listar_traslados_precio_dif]
	@per [char](4)
WITH EXECUTE AS CALLER
AS
--declare @Per char(4)
--select @per ='2009'

set nocount on
declare  @tempo table (codi char(10) , alma_ori char(2) collate sql_latin1_general_cp1_CI_AS, 
		vale varchar(10), alma_des char(2) collate sql_latin1_general_cp1_ci_as )

declare  @Ingre table (almacen char(3) collate sql_latin1_general_cp1_CI_AS, 
		vale char(10), docu char(10))

insert @tempo
select codi_docu_sali, codi_alma, nro_sali, codi_alma_desti
from dbo.docu_sali_mate (nolock) where tipo_sali='17' and codi_alma_desti is not null and year(fech_emis)=@Per

insert @Ingre
select codi_alma, codi_nota_ingr, codi_docu_sali
from dbo.nota_ingreso A (nolock) 
join @Tempo B
on A.codi_docu_sali collate sql_latin1_general_cp1_ci_as  = B.codi 

select fech_tran, fedes, Alma_ori, Alma_des, ValeSalida,  ValeIngreso, A.codi_prod, A.cant_sali,
	A.precio, B.prec_unit, 
	(select desc_alma from dbo.almacen C where codi_alma collate sql_latin1_general_cp1_ci_as  =Alma_ori) AlmacenOrigen,
	(select desc_alma from dbo.almacen C where codi_alma collate sql_latin1_general_cp1_ci_as =Alma_des) AlmacenDestino
from 
	(select fech_tran, alma_ori, codi valesalida, alma_des, codi_prod, cant_sali, prec_prom precio, prec_prom 
		from dbo.kardex A (nolock)
		join @Tempo B
		on A.codi_docu_i_o collate sql_latin1_general_cp1_ci_as  =Codi and A.codi_alma collate sql_latin1_general_cp1_ci_as =alma_ori and A.i_o='2') A 
join 
	(select fech_tran fedes, almacen, vale valeingreso,  codi_prod, cant_ingr, prec_unit, prec_prom  , docu
		from dbo.kardex A (nolock)
		join @Ingre B
		on A.codi_docu_i_o collate sql_latin1_general_cp1_ci_as  =vale and A.codi_alma collate sql_latin1_general_cp1_ci_as  =almacen and A.i_o='1') B
on A.alma_des = B.almacen and A.codi_prod collate sql_latin1_general_cp1_ci_as =B.codi_prod and A.valesalida=B.docu
where A.precio<>B.prec_unit and abs(A.precio-B.prec_unit)>0.05
order by  fech_tran
GO
