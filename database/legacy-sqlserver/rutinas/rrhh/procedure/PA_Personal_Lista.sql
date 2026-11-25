CREATE PROCEDURE [dbo].[PA_Personal_Lista]
	@tipo [tinyint]
WITH EXECUTE AS CALLER
AS
set nocount on 
if @tipo<2
begin
	Select p.codi_pers , p.apel_1, p.apel_2, p.nomb_1, p.nomb_2, p.nro_docu_iden , p.CARN_ESSALUD, p.NRO_CENSO , p.esta_acti,
	(select top 1 desc_tipo_pers from tipo_trabajador tp (nolock) where tp.codi_tipo_pers=ptt.codi_tipo_pers) Tipo_Trab ,
	sp.desc_sist_pens  , p.fech_inic_afil , p.nro_cupss
	From Personal P  (nolock)  left join personal_por_tipo_trabajador ptt  (nolock) on p.codi_pers=ptt.codi_pers
	left join sistema_pensiones sp  (nolock)  on p.codi_sist_pens=sp.codi_sist_pens
	where p.esta_acti=@tipo
end 

else  --- mostramos todos

begin
	Select p.codi_pers , p.apel_1, p.apel_2, p.nomb_1, p.nomb_2, p.nro_docu_iden , p.CARN_ESSALUD, p.NRO_CENSO , p.esta_acti,
	(select top 1 desc_tipo_pers from tipo_trabajador tp  (nolock)  where tp.codi_tipo_pers=ptt.codi_tipo_pers) Tipo_Trab ,
	sp.desc_sist_pens , p.fech_inic_afil , p.nro_cupss
	From Personal P  (nolock)  left join personal_por_tipo_trabajador ptt  (nolock)  on p.codi_pers=ptt.codi_pers
	left join sistema_pensiones sp  (nolock)  on p.codi_sist_pens=sp.codi_sist_pens
	

end
GO
