CREATE PROCEDURE [dbo].[sp_actu_sald_mens_cuen_uo_p]
	@ANIO [char](4)
WITH EXECUTE AS CALLER
AS
declare @mes as numeric

delete from SALD_TOTA_C_UO_P where  anio = @anio;
set @mes = 1



while @mes <= 12
begin
	print @mes

	Insert into SALD_TOTA_C_UO_P ( anio, mes, nro_cuen, codi_unid_oper, codi_clie_prov, desc_cuen, desc_unid_oper, ruc_prov, desc_prov,
					importe_c, importe_a, importe_d_c, importe_d_a )
	( Select anio, mes, nro_cuen, codi_unid_oper, codi_clie_prov, 
			( Select desc_cuen from cuentas_contable where nro_cuen = mc.nro_cuen) , 			
			( Select desc_unid_oper from unid_oper where codi_unid_oper = mc.codi_unid_oper )  ,
			(Select ruc from cliente_proveedor where codi_clie_prov = mc.codi_clie_prov ) ,
			(Select case when LEFT( UPPER( tipo_pers) , 1 )  = 'N' then isnull( apel_1, '')  + ' ' + isnull( apel_2, '')  + ' ' + isnull( nomb_1, '')  + ' ' + isnull( nomb_2, '') 
					else isnull( razo_soci  , '') end
				from cliente_proveedor where codi_clie_prov = mc.codi_clie_prov ) ,
			isnull( Sum( case cargo_abono  when 'C' then  isnull( importe  , 0 ) else 0 end ), 0 )    as importe_C,
			isnull( Sum( case cargo_abono  when 'A' then isnull( importe , 0 ) else 0 end ), 0 )   as importe_A,
			isnull( Sum( case cargo_abono  when 'C' then isnull( importe_d , 0 ) else 0 end ) , 0 )  as importe_d_C,
			isnull( Sum( case cargo_abono  when 'A' then isnull( importe_d , 0 ) else 0 end ) , 0 )  as importe_d_A
		from movi_contables mc
		where anio = @anio and left(nro_cuen, 1) >= '1' and cast( mes as numeric ) = @mes 
			and (not codi_unid_oper is null )  and codi_unid_oper <> '' and codi_unid_oper <> '00000' and ( subdia <> 'X' )
			and (not codi_clie_prov is null )  and codi_clie_prov <> '' and codi_clie_prov <> '00000'
		group by  anio, mes, nro_cuen, codi_unid_oper, codi_clie_prov 
	) 	
			
	set @mes = @mes + 1
end
GO
