CREATE PROCEDURE [dbo].[sp_actu_sald_mens_cuen]
	@ANIO [char](4)
WITH EXECUTE AS CALLER
AS
declare @mes as numeric

delete from SALD_TOTA_C where  anio = @anio;
set @mes = 1



while @mes <= 12
begin
	print @mes

	Insert into SALD_TOTA_C ( anio, mes, nro_cuen, desc_cuen, importe_c, importe_a, importe_d_c, importe_d_a )
	( Select anio, mes, nro_cuen, ( Select desc_cuen from cuentas_contable where nro_cuen = mc.nro_cuen) , 
			isnull( Sum( case cargo_abono  when 'C' then  isnull( importe  , 0 ) else 0 end ), 0 )    as importe_C,
			isnull( Sum( case cargo_abono  when 'A' then isnull( importe , 0 ) else 0 end ), 0 )   as importe_A,
			isnull( Sum( case cargo_abono  when 'C' then isnull( importe_d , 0 ) else 0 end ) , 0 )  as importe_d_C,
			isnull( Sum( case cargo_abono  when 'A' then isnull( importe_d , 0 ) else 0 end ) , 0 )  as importe_d_A
		from movi_contables mc
		where anio = @anio and left(nro_cuen, 1) >= '1' and cast( mes as numeric ) = @mes and ( subdia <> 'X' )
		group by  anio, mes, nro_cuen
	) 	
			
	set @mes = @mes + 1
end
GO
