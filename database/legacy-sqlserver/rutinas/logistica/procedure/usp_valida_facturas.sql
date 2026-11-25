CREATE PROCEDURE [dbo].[usp_valida_facturas]
	@f1 [datetime],
	@f2 [datetime],
	@alma [char](2)
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime, @f2 datetime, @alma char(2)
--select @f1='19/05/2017', @f2='23/05/2017', @alma='03'

set nocount on 

declare @Alm table (codi_alma char(2) null)
declare @Docu table (codi_alma char(2) null, codi_tipo_docu char(4) null, serie varchar(10) null, nro numeric(12) null)
declare @TX table (codi_alma char(2) null, codi_tipo_docu char(4) null, serie varchar(10) null, nro numeric(12) null, Cantidad int)
declare @RX table (codi_alma char(2) null, codi_tipo_docu char(4) null, serie varchar(10) null, inic numeric(12) null, fin numeric(12) null)
declare @FX table (codi_tipo_docu char(4) null, serie varchar(10) null, nro numeric(12) null, codi_alma char(2) null)

declare @al char(2), @dc char(4), @sr varchar(10), @in numeric(12), @fi numeric(12), @ct numeric(12)

declare @rt int

--if @alma='00' 
	insert @Alm
	select codi_alma from almacen (nolock)
--else
--	insert @Alm
--	select @alma


/*insert @Docu
select codi_alma , codi_tipo_docu, cast(ser_fact as int),  cast(nro_fact as numeric)
from factura (nolock)
where cast(convert(char(10),fech_fact,103) as datetime) between @f1 and @f2 and codi_alma in (select codi_alma from @alm)
	and ser_fact=9 and codi_tipo_docu=3
order by 2,3,4
*/

insert @Rx
select distinct /*'00'*/ codi_alma , codi_tipo_docu, 
	case when isnumeric(ser_fact)=0 then ser_fact else cast(cast(ser_fact as numeric(12)) as varchar(10)) end,
	min(cast(nro_fact as numeric)), max(cast(nro_fact as numeric)) 
from factura (nolock)
where cast(convert(char(10),fech_fact,103) as datetime) between @f1 and @f2 
	--and codi_alma in (select codi_alma from @alm)
group by codi_alma, 
		codi_tipo_docu, 
		case when isnumeric(ser_fact)=0 then ser_fact else cast(cast(ser_fact as numeric(12)) as varchar(10)) end
		
order by 2,3


insert @Fx
select codi_tipo_docu, 
       case when isnumeric(ser_fact)=0 then ser_fact else cast(cast(ser_fact as numeric(12)) as varchar(10)) end,
	   cast(nro_fact  as numeric(12)), codi_alma
from  factura (nolock)
--where cast(convert(char(10),fech_fact,103) as datetime) between @f1 and @f2 
order by codi_tipo_docu, 2,3

--return 

declare c1 cursor for select codi_alma, codi_tipo_docu, serie, inic, fin from @RX
			--where serie=9 and codi_tipo_docu=3
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


SELECT /*'00'*/ codi_alma, codi_tipo_docu, serie, nro,1 cantidad, 
	(select nemo_alma from ALMACEN a(nolock) where a.codi_alma = d.codi_alma) almacen,
	(select desc_tipo_docu from tipo_documento X (nolock) 
		where x.codi_tipo_docu=D.codi_tipo_docu) Docu	
FROM (SELECT codi_tipo_docu, serie, nro ,'Tx1' AS tab, codi_alma
FROM @TX
UNION ALL
SELECT codi_tipo_docu, serie, nro ,'Tx2' AS tab, codi_alma
FROM @FX) AS d
GROUP BY codi_alma, codi_tipo_docu, serie, nro
HAVING (MIN(tab) = 'Tx1' AND MAX(tab) = 'Tx1')
GO
