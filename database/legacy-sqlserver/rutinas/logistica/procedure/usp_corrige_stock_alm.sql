CREATE PROCEDURE [dbo].[usp_corrige_stock_alm]
	@Per [int],
	@codi [char](8)
WITH EXECUTE AS CALLER
AS
--declare @Per int, @codi char(8)
--select @Per = 2010  , @codi='00011562'

set nocount on

declare @Alm char(2), @Stoc numeric(12,4), @MX numeric(12,4), @Idd numeric(12), @lot numeric(12)

declare @Tx table (codi_prod char(8) null,  Streal numeric(12,4) null, codi_alma char(2) null)

insert @Tx( codi_prod, streal, codi_alma)
select codi_prod, 0, '00' from productos P (nolock) where codi_prod =@codi

update @Tx set streal = isnull((Select isnull(sum (isnull( cant_ingr,0 )-  isnull( CANT_SALi,0 )) ,0) 
		From dbo.Kardex (nolock ) where codi_prod =@codi and periodo=@Per
		group by codi_prod),0)


declare c1 cursor for select codi_alma from almacen A (nolock) where codi_alma='02'
open c1
fetch c1 into @Alm
while @@Fetch_Status=0
begin
	insert @Tx( codi_prod, streal, codi_alma)
	select codi_prod ,0, @alm from productos (nolock ) where codi_prod=@codi
	
	update @Tx set streal = isnull((Select isnull(sum (isnull( cant_ingr,0 )-  isnull( CANT_SALi,0 )) ,0) 
			From dbo.Kardex (nolock ) where periodo=@Per and codi_alma=@alm and codi_prod =@codi 
			group by codi_prod ,codi_alma) ,0 ) 
	where codi_alma=@alm

	fetch c1 into @Alm
end
close c1
deallocate c1

update productos set stock = isnull( ( select streal from @TX T where codi_alma='00'),0 )
where codi_prod=@codi


declare C3 cursor for select codi_alma, streal from @TX T  where codi_alma<>0
open c3
fetch c3 into @alm, @Stoc
while @@Fetch_Status=0
begin
	update almacen_producto set stock_alma = isnull(@Stoc,0)
	where codi_alma=@alm and codi_prod=@codi

	fetch c3 into @alm, @Stoc
end 
close c3
deallocate c3
GO
