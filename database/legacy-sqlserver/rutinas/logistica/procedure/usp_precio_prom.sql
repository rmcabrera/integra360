CREATE PROCEDURE [dbo].[usp_precio_prom]
	@fecha [datetime],
	@cod [char](8),
	@alm [char](2)
WITH EXECUTE AS CALLER
AS
--declare @Fecha datetime, @cod char(8), @alm char(2)
--select @Fecha = '31/12/2009' , @cod ='00000004', @alm='02'

set nocount on
SET QUOTED_IDENTIFIER OFF

declare @Mx numeric(18,0)
declare @Per int
Set @Per= year(@fecha)
create table #TX(idd int IDENTITY (1, 1) NOT NULL   , prec numeric(12,5) null,  saldo numeric(12,4) null)

insert #Tx(prec, saldo)
select 0,0 

declare @SQLString nvarchar(2000),@ParmDefinition nvarchar(100)

SET @ParmDefinition = "@fec datetime"

if @alm='00'
	set @SQLString = "Select  isnull( prec_prom,0), isnull( CANT_SALDo,0 )
			From dbo.Kardex (nolock ) where codi_prod ="+ @cod+"
				 and cast(convert(char(10),fech_Tran,103) as smalldatetime) <=@fec 
			and periodo="+ cast(@Per as varchar) + 
			"order by codi_prod,fech_tran, i_o, codi_docu_i_o, item"
else
	set @SQLString = "Select  isnull( prec_prom_alma,0), isnull( CANT_SALDo_alma,0 )
			From dbo.Kardex (nolock ) where codi_prod ="+ @cod+"
				 and cast(convert(char(10),fech_Tran,103) as smalldatetime) <=@fec 
			and periodo="+ cast(@Per as varchar) +"and codi_alma="+@alm+
			"order by codi_prod,fech_tran, i_o, codi_docu_i_o, item"



insert #Tx(prec, saldo)
EXECUTE sp_executesql @SQLString, @ParmDefinition, @fec = @fecha


set @Mx = isnull((select max(idd) from #Tx),0)

select prec, saldo from #TX where idd=@Mx

drop table #TX

SET QUOTED_IDENTIFIER ON
GO
