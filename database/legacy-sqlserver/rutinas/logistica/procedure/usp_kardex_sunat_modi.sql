CREATE PROCEDURE [dbo].[usp_kardex_sunat_modi]
	@per [int],
	@codi_prod [char](8)
WITH EXECUTE AS CALLER
AS
--declare @per int, @fec1 datetime, @fec2 datetime, @codi_prod char(8)
--select @per=2014, @fec1='01/01/2014', @fec2='31/12/2014', @codi_prod='00010032'

set nocount on 

declare @Esta varchar(200)
set @Esta=''
if (select ruc from empresa)='20523088361'  set @Esta='AV. VILLA DEL MAR NRO. 796 ANCASH SANTA COISHCO'

SELECT codi_prod,
	 (select (select desc_tipo_exis from tipo_existencia T (nolock) where t.codi_tipo_exis=P.codi_tipo_exis)
		 from productos P (nolock) where P.codi_prod=k.codi_prod) Existencia,
		 
	 (select (select codi_sunat from unidad_medida U (nolock) where u.codi_unid_medi=p.codi_unid_medi)
			 from productos P (nolock) where p.codi_prod=k.codi_prod) Unidad,
			 
	 (select desc_prod from productos P (nolock) where p.codi_prod=k.codi_prod) descripcion,
	 
	 fech_tran, 
	 
	 case when i_o=1 then 
		(Select (select tipo_sunat from tipo_documento t (nolock) 
			where t.codi_tipo_docu=codi_tipo_docu_cont ) from nota_ingreso N (nolock) 
			where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)  
	 else (Select (select tipo_sunat from tipo_documento t (nolock) 
			where codi_tipo_docu = codi_tipo_docu_sali) from docu_sali_mate D (nolock) 
			where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end Tipo,

	 case when i_o=1 then 
		(Select nro_seri_docu_cont  from nota_ingreso N (nolock) 
			where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)  
	 else (Select nro_seri_docu_sali from docu_sali_mate D (nolock) 
			where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end Serie,

	 case when i_o=1 then 
		(Select nro_docu_cont  from nota_ingreso N (nolock) 
			where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)  
	 else (Select nro_docu_sali from docu_sali_mate D (nolock) 
			where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end Numero,

	 case when i_o=1 then 
		(Select (select codi_sunat_moti_tras from tipo_ingr_sali T (nolock)
				where codi_tipo_is=tipo_nota_ingr )  from nota_ingreso N (nolock) 
			where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)  
	 else (Select (select codi_sunat_moti_tras from tipo_ingr_sali T (nolock)
				where codi_tipo_is=tipo_sali )  from docu_sali_mate D (nolock) 
			where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end TipoOper,
	cant_ingr, prec_unit, valo_ingr, 
	cant_sali, 
	case when cant_sali<>0 then prec_prom else 0 end costo_salida, 
	valo_sali, 
	cant_saldo, prec_prom, valo_saldo,
	(select razon_social from empresa E (nolock)) Razon_social,
	(select ruc from empresa E (nolock)) Ruc,
	@ESTa Establecimiento ,  I_O,   Codi_Docu_I_O, codi_kard
    FROM KARDEX K (nolock)
   WHERE  --cast(convert(char(10),fech_tran,103) as datetime) between @fec1 and @fec2 
			periodo=@per
			and codi_prod=@codi_prod
/*union all
select codi_prod,
	 (select (select desc_tipo_exis from tipo_existencia T (nolock) where t.codi_tipo_exis=P.codi_tipo_exis)
		 from productos P (nolock) where P.codi_prod=k.codi_prod) Existencia,
	 (select (select codi_sunat from unidad_medida U (nolock) where u.codi_unid_medi=p.codi_unid_medi)
			 from productos P (nolock) where p.codi_prod=k.codi_prod) Unidad,
	 (select desc_prod from productos P (nolock) where p.codi_prod=k.codi_prod) descripcion,
	fech_tran, 
	'99' tipo, '' Serie, '' Nro, '' tipooper, 0 as cant_ingr, 0, 0 as valo_ingr,0 as  cant_sali, 0, 0 as valo_sali,
		cant_saldo, cc , valo_saldo,
	(select razon_social from empresa E (nolock)) Razon_social,
	(select ruc from empresa E (nolock)) Ruc,
	@ESta Establecimiento, 1 as I_O,  '0' as codi_docu_I_O , '0' codi_karx
from (
select '0' as C, pk.codi_prod,'' as C1, '' as C2,'' as C3, '' as C4,'' as C5,'' as C6,
		 @fec1 as Fech_tran,
		 isnull(sum(cant_ingr),0) as Cant_ingr,	isnull( sum(cant_sali),0) as cant_sali,
		 isnull(sum(cant_ingr) - sum(cant_sali),0) as cant_saldo, 0 as C10, 
		(SELECT PREC_PROM FROM KARDEX as PP (nolock) WHERE CODI_KARD IN 
			(SELECT MAX(CODI_KARD) FROM KARDEX  as P1 (nolock) 
				WHERE p1.CODI_PROD =PK.CODI_PROD AND p1.FECH_TRAN in 
				(select max(fech_tran) 
				from kardex as P2  (nolock) 
				where periodo=@per and p2.codi_prod = PK.CODI_PROD and
					p2.fech_tran < @fec1 ))) as CC,
	 	isnull( sum(valo_ingr),0) as valo_ingr, isnull(sum(valo_sali),0) as valo_sali,
		isnull(sum(valo_ingr) - sum(valo_sali),0) as valo_saldo ,
		'01' as C7,
		0 as C8,	1 as I_O,  '0' as codi_docu_I_O ,
		'SALDO ANTERIOR' as C9
		from kardex  (nolock), 
			(select distinct codi_prod from kardex (nolock) 
				where periodo=@per and fech_tran<=@fec2) as PK
		where periodo=@per and fech_tran<@fec1 and pk.codi_prod *= Kardex.codi_prod  
		group by pk.codi_prod) as K
		where cant_saldo<>0
order by codi_prod, fech_tran
*/
GO
