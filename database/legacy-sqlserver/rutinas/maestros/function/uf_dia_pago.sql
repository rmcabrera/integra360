CREATE FUNCTION [dbo].[uf_dia_pago](@f [datetime])
RETURNS [datetime] WITH EXECUTE AS CALLER
AS 
begin
	--declare @f datetime
	--select @f='05/04/2012'

	declare @nv_f datetime
	declare @c int 

	set @c=0

	set @c = (select isnull(count(*),0) from feriados (nolock) where fecha=@f)

	if @c>0 
	begin
		set @f=DATEADD(DAY, -1, @f)
	end

	set @nv_f=@f
	if DATEPART ( dw , @f )=6 
	begin
		set @nv_f=DATEADD(DAY, -1, @f)
	end

	if DATEPART ( dw , @f )=7 
	begin
		set @nv_f=DATEADD(DAY, -2, @f)
	end


	--select @nv_f
	return @nv_f
end
GO
