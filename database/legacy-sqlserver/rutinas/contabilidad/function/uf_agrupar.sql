CREATE FUNCTION [dbo].[uf_agrupar](@sub [char](1))
RETURNS [varchar](10) WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @ls_Voucher varchar(10)
	declare @ll_Cont_Compr int
	declare @ll_Max_Registro numeric(12)

	set @ll_Cont_Compr =  isnull( (Select Count(Codi_Vouc) From Movi_Contables (nolock) Where Subdia=@sub),0) 
	If @ll_Cont_Compr<=0 
	begin
		set @ls_Voucher = '1'
	end
	Else
	begin	
		set @ll_Max_Registro = isnull( ( Select Max(Cast(Codi_Vouc as numeric)) From Movi_Contables (nolock) Where Subdia=@Sub), 0 ) 
		set @ls_Voucher =  cast(@ll_Max_Registro + 1  as varchar)
	end

	Return @ls_Voucher
END
GO
