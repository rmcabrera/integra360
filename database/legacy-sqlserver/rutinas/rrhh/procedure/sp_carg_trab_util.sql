CREATE PROCEDURE [dbo].[sp_carg_trab_util]
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
Begin
	Declare @per char(5)
	Declare @car char(4)
	declare @net numeric(12,3)
	declare @grati numeric(12,3)
	declare @porc_dist numeric(12,3)
	declare @p varchar(70)
	declare @sem char(8)
	Declare @emb char(5)
	Declare @nro_sema smallint
	Declare @inic varchar(10)
	DECLARE @tota_ingr numeric(12,3)
	DECLARE @tota_ingrB numeric(12,3)
	DECLARE @rent_quin numeric(12,3)
	DECLARE @juic numeric(12,3)
	DECLARE @mont_juic numeric(12,3)
	DECLARE @tipo_juic smallint
	declare @cont_juic integer
	declare @tota_juic numeric(12,3)
	declare @tota_desc numeric(12,3)
	declare @codi_juic char (10)
	declare @tota_grat numeric(12,3)
	DECLARE @NA CHAR(1)
	Select @inic = inicial from empresa

	Declare Curs_carg_trab_con_util cursor for
	Select codi_pers, util03
	from personal where util03 > 0 ;
	open Curs_carg_trab_con_util;
	fetch Curs_carg_trab_con_util into @per, @net;
	while @@fetch_status = 0 
	begin
		Insert Into UTIL_PERS_ANUAL (codi_pers, importe, periodo)
		values (@per, @net, @anio )
		fetch Curs_carg_trab_con_util into @per, @net;
	end
	
End
GO
