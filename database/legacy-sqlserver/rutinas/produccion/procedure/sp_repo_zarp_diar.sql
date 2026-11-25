CREATE PROCEDURE [dbo].[sp_repo_zarp_diar]
	@fecha [datetime]
WITH EXECUTE AS CALLER
AS
Declare @codi_pers varchar(30)
Declare @apel_1 varchar(30)
Declare @apel_2 varchar(30)
Declare @nomb_1 varchar(30)
Declare @nomb_2 varchar(30)
Declare @desc_carg varchar(100)
Declare @codi_carg char(4)
declare @jera_carg int
Declare @codi_ep char(5)
Declare @desc_emba varchar(50)
Declare @nro_matri varchar(15)
Declare @arqu_brut decimal(9,4)
Declare @desc_tipo_cert varchar(50)
Declare @codi_tipo_Cert char(6)
declare @fech_inic_cert datetime
declare @fech_term_cert datetime
declare @fech_inic_le datetime
declare @fech_term_le datetime
Declare @nro_le varchar(15)
declare @repr_flot varchar(100)
declare @dire_empr varchar(100)
declare @tele_empr varchar(50)
declare @razo_soci_empr varchar(100)

CREATE TABLE #zarp_diar(codi_unid_oper char(5), desc_unid_oper varchar(100), nro_matri varchar(20) null, arqu_brut decimal(9,3), 
		codi_tipo_cert char(6) null, desc_tipo_cert varchar(50) null, fech_inic_cert datetime null, fech_term_cert datetime null, 
		codi_pers char(5), apel_1 varchar(30) , apel_2 varchar(30), nomb_1 varchar(30) , nomb_2 varchar(30) null, codi_carg char(4) null, 
		desc_carg varchar(100) null, jera_carg int null, 
		fech_inic_le datetime null, fech_term_le datetime null, nro_libr_emba varchar(15) null, 
		repr_flot varchar(100) null, dire_empr varchar(150) null, tele_empr varchar(50) null, razo_soci_empr varchar(100), indi smallint 
 		)

Select @repr_flot = UPPER( repr_flota), @dire_empr = direccion, @tele_empr = telefono, @razo_soci_empr = razon_social
from empresa;

Declare Curs_carg_emba cursor for
Select codi_unid_oper, desc_unid_oper, nro_matri, isnull( arqu_brut, 0 ) 
from embarcaciones;
open Curs_carg_emba;
fetch Curs_carg_emba into @codi_ep , @desc_emba, @nro_matri, @arqu_brut
while @@fetch_status = 0
begin
	set @codi_pers = ''
	set @apel_1 = ''
	set @apel_2 = ''
	set @nomb_1 = ''
	set @nomb_2 = ''
	set @codi_carg = ''
	set @desc_carg = ''
	set @jera_carg = 0
	Declare Curs_carg_trip_emba cursor for
	Select codi_pers, apel_1, apel_2, isnull(nomb_1, '') , ISNULL(nomb_2, '') , p.codi_carg, ca.desc_cargo, ca.jera
	from personal p, cargos ca
	where p.codi_carg = ca.codi_carg and ( p.fech_Cese >=@fecha or p.fech_cese is null ) and p.codi_unid_oper = @codi_ep;
	open Curs_carg_trip_emba;
	fetch Curs_carg_trip_emba into @codi_pers, @apel_1, @apel_2, @nomb_1, @nomb_2, @codi_carg, @desc_carg, @jera_carg
	while @@fetch_status = 0
	begin
		set @codi_tipo_cert = ''
		set @desc_tipo_Cert = ''	

		Declare curs_carg_cert_emba cursor for
		Select codi_tipo_cert, desc_tipo_Cert
		From tipo_cert_emba ;
		open curs_carg_cert_emba;
		fetch curs_carg_cert_emba into @codi_tipo_cert, @desc_tipo_cert
		while @@fetch_status = 0
		begin
			set @fech_inic_cert = null
			set @fech_term_cert = null
			set @fech_inic_le = null
			set @fech_term_le = null
			set @nro_le = ''
			SELECT @fech_inic_cert = ec.fech_inic , @fech_term_cert = ec.fech_term
			FROM emba_venc_cert ec, tipo_cert_emba tc
			where ec.codi_tipo_cert = tc.codi_tipo_Cert and ec.codi_unid_oper = @codi_ep and ec.codi_tipo_cert = @codi_tipo_cert

			SELECT @fech_inic_le = le.fech_inic_vige, @fech_term_le = le.fech_term_vige, @nro_le = le.nro_matr
			FROM pers_trip_vige_cert le, personal p
			where le.codi_pers = p.codi_pers and p.codi_pers = @codi_pers ;

-- @fech_inic_cert, @fech_term_cert, @fech_inic_le, @fech_term_le, @nro_le

			Insert into #zarp_diar(codi_unid_oper, desc_unid_oper, nro_matri, arqu_brut, codi_tipo_cert, desc_tipo_cert, fech_inic_cert, fech_term_cert, 
				codi_pers, apel_1, apel_2, nomb_1, nomb_2, codi_carg, desc_carg, jera_carg, fech_inic_le, fech_term_le, nro_libr_emba, 
				repr_flot, dire_empr, tele_empr, razo_soci_empr , indi)
			Values ( @codi_ep, @desc_emba,  @nro_matri, @arqu_brut, @codi_tipo_cert, @desc_tipo_cert, @fech_inic_cert, @fech_term_cert,
				@codi_pers, @apel_1, @apel_2, @nomb_1, @nomb_2, @codi_carg, @desc_carg, @jera_carg, @fech_inic_le, @fech_term_le, @nro_le,
				@repr_flot, @dire_empr, @tele_empr, @razo_soci_empr, 0
				)	
			fetch curs_carg_cert_emba into @codi_tipo_cert, @desc_tipo_cert
		end
		close curs_carg_cert_emba;
		deallocate curs_carg_cert_emba;
		
		fetch Curs_carg_trip_emba into @codi_pers, @apel_1, @apel_2, @nomb_1, @nomb_2, @codi_carg, @desc_carg, @jera_carg
	end
	close Curs_carg_trip_emba;
	deallocate Curs_carg_trip_emba;

	fetch Curs_carg_emba into @codi_ep , @desc_emba, @nro_matri, @arqu_brut
end
close Curs_carg_emba;
deallocate Curs_carg_emba;

Select * from #zarp_diar
order by desc_unid_oper, jera_carg, apel_1, apel_2, nomb_1, nomb_2, codi_tipo_Cert
GO
