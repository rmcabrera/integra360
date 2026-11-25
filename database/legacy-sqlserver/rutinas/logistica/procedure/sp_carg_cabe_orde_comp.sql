CREATE PROCEDURE [dbo].[sp_carg_cabe_orde_comp]
	@codi_coti_unic [char](10),
	@codi_orde_pedi [char](10),
	@Codi_clie_prov [char](5) OUTPUT,
	@fecha [datetime] OUTPUT,
	@estado [char](1) OUTPUT,
	@Codi_mone [char](2) OUTPUT,
	@importe [decimal](9, 2) OUTPUT,
	@codi_unid_oper_soli [char](5) OUTPUT,
	@codi_unid_oper_dest [char](5) OUTPUT,
	@cond_pago [char](10) OUTPUT,
	@fech_entr [datetime] OUTPUT,
	@luga_entr [varchar](100) OUTPUT,
	@codi_unid_medi [char](2) OUTPUT,
	@tiem_plaz_cred [decimal](9, 2) OUTPUT
WITH EXECUTE AS CALLER
AS
declare @codi_list_requ char(8)
declare @codi_COTI_PROV char(10)
declare @codi_deta_coti char(12)
declare @codi_coti char(10)

Create Table #Orde_comp 
(codi_clie_prov char(5), fecha datetime, estado char(1), codi_mone char(2), importe decimal(9,2), codi_uos char(5), codi_uod char(5), cond_pago char(10), fech_entr datetime, luga_entr varchar (100), codi_unid_medi char(2), tiem_plaz_cred decimal(9,2))

if @codi_coti_unic = '0'
	Begin
		Select @Codi_list_requ = (Select Codi_list_requ From ORDEN_DE_PEDIDO Where codi_orde_pedi = @codi_orde_pedi)
		Select @fecha = (Select Getdate())
		Select @codi_clie_prov = (Select min(Codi_clie_prov) From Cliente_proveedor)
		Select @estado = (Select Estado From Estados Where upper(desc_esta) = 'PENDIENTE' or upper(desc_esta) = 'PENDIENTES') 
		Select @codi_mone = (Select Codi_mone From Monedas Where upper(desc_mone) = 'NUEVO SOL' or upper(desc_mone) = 'NUEVOS SOLES') 
		Set @importe = 0
		Select @codi_unid_oper_soli = (Select codi_unid_oper_soli From Lista_de_Requerimientos Where codi_list_requ = @codi_list_requ)
		Select @codi_unid_oper_dest = (Select codi_unid_oper_dest From Lista_de_Requerimientos Where codi_list_requ = @codi_list_requ)
		Set @cond_pago = 'CRÉDITO'
		Set @fech_entr = dateadd(day, 7, @fecha)
		Set @luga_entr = ''
		Select @codi_unid_medi = (Select codi_unid_medi From Unidad_Medida Where UPPER(DESC_UNID_MEDI) = 'SEMANAS')
		Set @tiem_plaz_cred = '2'		
	End
Else
	Begin
		Select @codi_coti_prov = (Select min(codi_coti_prov) From Cotizacion_unica Where codi_coti_unic_prov = @codi_coti_unic)
		Select @codi_clie_prov = (Select codi_clie_prov From Cotizacion_por_proveedor Where Codi_coti_prov = @codi_coti_prov)
		Select @fecha = (Select Getdate())
		Select @estado = (Select Estado From Estados Where upper(desc_esta) = 'PENDIENTE' or upper(desc_esta) = 'PENDIENTES') 
		Select @codi_mone = (Select Codi_mone From Cotizacion_por_proveedor Where Codi_coti_prov = @codi_coti_prov)
		Select @importe = (Select prec_tota From Cotizacion_por_proveedor Where Codi_coti_prov = @codi_coti_prov)

		Select @Codi_deta_coti = (Select min(codi_deta_coti) From COTI_POR_PROV_DETA_COTI Where Codi_coti_prov = @Codi_coti_prov)
		Select @Codi_coti = (Select codi_coti From Detalle_Cotizacion_Pedido Where codi_deta_coti = @codi_deta_coti) 
		Select @Codi_list_requ = (Select CODI_LIST_REQU_ORIG From cotizacion_de_pedidos Where codi_coti = @codi_coti)
		
		Select @codi_unid_oper_soli = (Select codi_unid_oper_soli From Lista_de_Requerimientos Where codi_list_requ = @codi_list_requ)
		Select @codi_unid_oper_dest = (Select codi_unid_oper_dest From Lista_de_Requerimientos Where codi_list_requ = @codi_list_requ)		
		Set @cond_pago = 'CRÉDITO'
		Set @fech_entr = dateadd(day, 7, @fecha)
		Set @luga_entr = ''
		Select @codi_unid_medi = (Select codi_unid_medi From Unidad_Medida Where UPPER(DESC_UNID_MEDI) = 'SEMANAS')
		Set @tiem_plaz_cred = '2'		
	End

Insert Into #Orde_comp (codi_clie_prov , fecha , estado , codi_mone , importe , codi_uos , codi_uod , cond_pago , fech_entr , luga_entr , codi_unid_medi , tiem_plaz_cred )
Values (@Codi_clie_Prov, @fecha, @estado, @codi_mone, @importe, @codi_unid_oper_soli, @codi_unid_oper_dest, @cond_pago, @fech_entr, @luga_entr, @codi_unid_medi, @tiem_plaz_cred)

Select * 
From #Orde_Comp
GO
