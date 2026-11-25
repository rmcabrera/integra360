CREATE FUNCTION [dbo].[uf_precio_prom](@fecha [datetime], @cod [char](8))
RETURNS [numeric](12, 4) WITH EXECUTE AS CALLER
AS 
begin

---declare @Fecha datetime, @cod char(8), @alm char(2)
--select @Fecha = '31/12/2009' , @cod ='00000020', @alm='01'

--set nocount on

	declare @Mx numeric(18,0), @rt numeric(12,4)
	declare @Per int
	Set @Per= year(@fecha)
	declare @TX table (idd int IDENTITY (1, 1) NOT NULL   , prec numeric(12,5) null,  saldo numeric(12,4) null)
	
	insert @Tx(prec, saldo)
	select 0,0 
	
	insert @Tx(prec, saldo)
	Select  isnull( prec_prom,0), isnull( CANT_SALDo,0 )
				From dbo.Kardex (nolock ) where codi_prod =@cod
		 and cast(convert(char(10),fech_Tran,103) as smalldatetime) <=@fecha
		and periodo=@Per 
		order by codi_prod,fech_tran, i_o, codi_docu_i_o, item
	
	set @Mx = isnull((select max(idd) from @Tx),0)
	
	select @rt=prec from @TX where idd=@Mx
	
	if @rt is null set @rt=0

	return @rt

end
GO
