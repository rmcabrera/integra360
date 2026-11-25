CREATE PROCEDURE [dbo].[usp_reporte_recibo_gastos]
	@alma [char](2),
	@F1 [datetime],
	@F2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @alma char(2), @F1 datetime, @F2 datetime
--select @alma=null, @F1='01/01/2013', @F2='31/12/2014'

declare @CX table(nro_recibo char(10) null, codi_unid_oper char(5) null, importe numeric(18,2) null)

set nocount on

insert @CX
select a.nro_recibo, a.codi_unid_oper, a.importe 
from caja_chica a(nolock)
where (cast(convert(char(10),fecha,103) as  datetime) between @F1 and @F2) and (isnull(@alma,'')='' or codi_alma=@alma) and tipo_io=0 and tipo_contab='029'
/*join movi_contables b(nolock)
on a.codi_nota_ingr=b.nro_recibo
where anio = @ani and mes = @ms and subdia in ('C', 'M') and left(nro_cuen,1)='6' and tipo_contab='029'*/

select (select desc_unid_oper from unid_oper uo(nolock) where uo.codi_unid_oper = c.codi_unid_oper) unid_oper, 
	nro_recibo, importe, c.codi_unid_oper,
       (select desc_trans from transportistas t(nolock) where t.codi_trans=ut.codi_trans) transportista,
       tipo_unidad, (select desc_unid_oper from unid_oper uo(nolock) where uo.codi_unid_oper=codi_tracto) codi_tracto, 
	(select desc_unid_oper from unid_oper uo(nolock) where uo.codi_unid_oper=codi_carreta) codi_carreta, 
       (select nro_lice_cond from transportistas t(nolock) where t.codi_trans=ut.codi_trans) brevete,
       (select desc_conf from configuracion_vehicular cv(nolock) where cv.id_conf=ut.id_conf) conf_vehi,
       marc_unid_tran, lice_unid_trans, permiso, 
       (select nextel from transportistas t(nolock) where t.codi_trans=ut.codi_trans) nextel,
       soat_ini, soat_fin,
       (select isnull(apel_1,'') + isnull(' ' + apel_2,'') + isnull(' ' + nomb_1,'') + isnull(' ' + nomb_2,'') 
        from personal p(nolock) where p.codi_pers=ut.codi_prop) propiedad,
	(select nemo_alma from almacen a(nolock) where a.codi_alma = ut.codi_alma) almacen
from @CX c
join unidad_transporte ut(nolock)
on C.codi_unid_oper = ut.codi_unid_oper
GO
