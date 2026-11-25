CREATE PROCEDURE [dbo].[usp_tipo_pago]
	@tipo [char](1),
	@codi [int]
WITH EXECUTE AS CALLER
AS
--declare @tipo char(1), @codi int
--select @tipo ='T', @codi =1

set nocount on

if @tipo='T'
begin
	select codi_tipo_medio_pago, desc_tipo_medio_pago
	from dbo.tipo_pago (nolock)
	where codi_tipo_medio_pago in (1,4)
end

else
begin
	select codi_tipo_medio_pago, desc_tipo_medio_pago
	from dbo.tipo_pago (nolock)
	--where codi_tipo_medio_pago = @codi
	where codi_tipo_medio_pago in (1,4)
end
GO
