CREATE PROCEDURE [dbo].[usp_valida_guias]
	@f1 [datetime],
	@f2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime, @f2 datetime, @alma char(2)
--select @f1='01/01/2014', @f2='30/06/2014', @alma='00'

set nocount on 

declare @Alm table (codi_alma char(2) null)
declare @Docu table (codi_alma char(2) null, codi_tipo_docu char(4) null, serie int null, nro numeric(12) null)
declare @TX table (codi_alma char(2) null, codi_tipo_docu char(4) null, serie int null, nro numeric(12) null, Cantidad int)
declare @RX table (codi_alma char(2) null, codi_tipo_docu char(4) null, serie int null, inic numeric(12) null, fin numeric(12) null)
declare @FX table (codi_tipo_docu char(4) null, serie int null, nro numeric(12) null)

declare @al char(2), @dc char(4), @sr int, @in numeric(12), @fi numeric(12), @ct numeric(12)

declare @rt int

	insert @Alm
	select codi_alma from almacen (nolock)

insert @Rx
select distinct '00' codi_alma , '0009' as codi_tipo_docu, cast(ser_guia as int),  
	min(cast(nro_guia as numeric)), max(cast(nro_guia as numeric)) 
from guia (nolock)
where cast(convert(char(10),fech_tras,103) as datetime) between @f1 and @f2 
group by /*codi_tipo_docu, */cast(ser_guia as int)
order by 2,3

insert @Fx
select '0009' as codi_tipo_docu, cast(ser_guia as int ) , cast(nro_guia as numeric(12))
from  guia (nolock)
order by codi_tipo_docu, 2,3

declare c1 cursor for select codi_alma, codi_tipo_docu, serie, inic, fin from @RX
			order by codi_alma, codi_tipo_docu, serie
open c1
fetch c1 into @al, @dc, @sr, @in, @fi
while @@Fetch_status=0
begin
	--select @al, @dc, @sr, @in, @fi
	set @Ct= @in
	while @ct<=@fi
	begin
		insert @TX
		select  @al, @dc, @sr, @ct,@rt
/*		set @rt=isnull((select count(*) from @Fx 
			where /*codi_alma=@al and */ codi_tipo_docu=@dc and serie=@sr and nro=@ct),0)

		if @rt<=0 or @rt>1
			insert @Tx
			select @al, @dc, @sr, @ct,@rt
*/
		set @ct= @ct +1
	end
	fetch c1 into @al, @dc, @sr, @in, @fi
end
close c1
deallocate c1

--select * from @Fx --where codi_tipo_docu=1 and serie=1 and nro in (52,54,53,55,110,111,112,86,87,88)
--select * from @Tx T -- where codi_tipo_docu=1 and serie=1 and nro in (52,54,53,55,110,111,112,86,87,88)


SELECT '00' codi_alma, codi_tipo_docu, serie, nro,1 cantidad,'' almacen,
	(select desc_tipo_docu from tipo_documento X (nolock) 
		where x.codi_tipo_docu=D.codi_tipo_docu) Docu	
FROM (SELECT codi_tipo_docu, serie, nro ,'Tx1' AS tab
FROM @TX
UNION ALL
SELECT codi_tipo_docu, serie, nro ,'Tx2' AS tab
FROM @FX) AS d
GROUP BY codi_tipo_docu, serie, nro
HAVING (MIN(tab) = 'Tx1' AND MAX(tab) = 'Tx1')
GO
