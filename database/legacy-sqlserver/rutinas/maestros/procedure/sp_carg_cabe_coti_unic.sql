CREATE PROCEDURE [dbo].[sp_carg_cabe_coti_unic]
	@Codi_coti_unic [char](10),
	@Codi_clie_prov [char](5) OUTPUT,
	@Fech_coti_unic [datetime] OUTPUT,
	@Codi_Unid_Medi [char](2) OUTPUT,
	@Tiem_plaz_cred [decimal](9, 2) OUTPUT,
	@Estado [char](1) OUTPUT,
	@codi_mone [char](2) OUTPUT,
	@prec_tota [decimal](9, 2) OUTPUT
WITH EXECUTE AS CALLER
AS
declare @CCP CHAR(10) 
declare @CCPV CHAR(10) 
declare @FCP DATETIME
declare @CUM CHAR(2) 
declare @TPC DECIMAL(9,2)
declare @ESTA CHAR (1) 
declare @prec_tota_auxi decimal(9,2)

Select @CCP = (Select min(codi_coti_prov)From cotizacion_unica Where codi_coti_unic_prov = @codi_coti_unic)
Select @CCPV = (Select Codi_Clie_prov From COTIZACION_POR_PROVEEDOR Where Codi_coti_prov = @CCP)
Select @FCP = (Select min(Fech_Coti_unic) From COTIZACION_UNICA Where Codi_Coti_Unic_Prov = @Codi_Coti_Unic)
Select @CUM = (Select Codi_unid_medi From COTIZACION_POR_PROVEEDOR Where Codi_coti_prov = @CCP)
Select @TPC = (Select Tiemp_plaz_cred From COTIZACION_POR_PROVEEDOR Where Codi_coti_prov = @CCP)
Select @ESTA = (Select min(Estado) From COTIZACION_UNICA Where Codi_Coti_Unic_Prov = @Codi_Coti_Unic)
Select @Codi_Mone = (Select Codi_Mone From COTIZACION_POR_PROVEEDOR Where Codi_coti_prov = @CCP)

set @prec_tota = 0
Declare Curs_prec_tota Cursor for 
Select codi_coti_prov 
From Cotizacion_unica
Where CODI_COTI_UNIC_PROV = @codi_coti_unic;
Open Curs_prec_tota;
Fetch Next From Curs_prec_tota into @CCP
WHILE @@FETCH_STATUS = 0
	Begin
		Select @prec_tota_auxi =  (Select isnull(prec_tota,0) From Cotizacion_por_proveedor Where codi_coti_prov = @ccp)
		set @prec_tota = @prec_tota + @prec_tota_auxi
		Fetch Next From Curs_prec_tota into @CCP
	End
Close curs_prec_tota;
Deallocate curs_prec_tota;

SET @Codi_clie_prov  = @CCPV
SET @Fech_coti_unic = @FCP
SET @Codi_Unid_Medi = @CUM
SET @Tiem_plaz_cred = @TPC
SET @Estado = @ESTA
GO
