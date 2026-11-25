CREATE PROCEDURE [dbo].[SP_Precio_pactado]
	@semana [char](8),
	@cliente [char](5),
	@precio [numeric](12, 3),
	@moneda [char](2)
WITH EXECUTE AS CALLER
AS
begin 
	declare @pre numeric(12,3)
	select @pre=prec_pact from precio_pactado where codi_sema=@semana and
		codi_clie_prov=@cliente
	if(@pre=Null)
	begin
		insert into precio_pactado (codi_sema,codi_clie_prov,codi_espe,prec_pact,codi_mone)
		values(@semana,@cliente,'01',@precio,@moneda)
	end
	else
	begin
		update precio_pactado set prec_pact=@precio where codi_sema=@semana
		and codi_clie_prov=@cliente and codi_espe='01'
	end
end
GO
