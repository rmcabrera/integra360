CREATE PROCEDURE [dbo].[usp_comi_alma_all]
	@FI [datetime],
	@FF [datetime]
WITH EXECUTE AS CALLER
AS
--declare @FI datetime , @FF datetime 
--select @FI='01/02/2018', @FF='28/02/2018'

set nocount on 


declare @Tx table (codi_alma char(2) , nemo_alma varchar(100), codi_lin_pro char(2) null, desc_linea varchar(100) null,
					meta varchar(50) null, valor numeric(12,4) null, utilidad numeric(12,2) null)

create table #Sx (tipo varchar(50) null, venta numeric(12,2) null, porce numeric(12,6) null, meta1 numeric(12,2) null,
					meta2 numeric(12,2) null, meta3 numeric(12,2) null, r1 numeric(12,2) null, r2 numeric(12,2) null,
					r3 numeric(12,2) null, nrometa int null, metaporc numeric(12,2) null, utilneta numeric(12,2) null,
					costototal numeric(12,2) null,
					ventatotal numeric(12,2) null, alta int null)
					
create table #Txx (nemo_alma varchar(50) null, codi_prod char(8) null, desc_prod varchar(250) null, desc_pres varchar(50) null,
					costo_cont_cant numeric(12,2) null, costo_Afec_cont numeric(12,2) null, costo_exo_cont numeric(12,2) null, total_costo_cont numeric(12,2) null,
					afec_cont_vent numeric(12,2) null, exo_cont_vent numeric(12,2) null, total_cont_vent numeric(12,2) null, 
					costo_cred_cant numeric(12,2) null, costo_Afec_cred numeric(12,2) null, costo_exo_cred numeric(12,2) null, total_costo_cred numeric(12,2) null,
					afec_cred_vent numeric(12,2) null, exo_cred_vent numeric(12,2) null, total_cred_vent numeric(12,2) null, cantidad numeric(12,2) null,
					costo_total numeric(12,2) null, total_Venta numeric(12,2) null, linea char(2) null, Alta int null, 
					tipocomi varchar(100) null, LineaProd varchar(100) null ,SubFami varchar(200) null)

declare @Metas table (id_meta int null, valor numeric(12,2) null)					

declare @codi_alma char(2)
declare @codi char(2), @nemo varchar(100)
declare @linea char(2)

declare @Ax table (codi_alma char(2) , codi_lin_pro char(2) null)

declare c2 cursor for select codi_alma 
	from almacen (nolock) where codi_alma not in ('01','10')

open c2
fetch c2 into @codi
while @@FETCH_STATUS=0
begin
	insert @Ax
	select @codi, cod_lin_pro
	from linea_familia_pro (nolock) where cod_lin_pro in ('01','02','03','05')

	fetch c2 into @codi
end

close c2
deallocate c2


declare c1 cursor for select codi_alma, codi_lin_pro
	from @Ax   --where codi_alma='05'
	order by 1,2

open c1
fetch c1 into @codi_alma, @linea
while @@FETCH_STATUS=0
begin

	if @linea ='02'
		insert @Metas
		select 1,5 

	if @linea ='03'
		insert @Metas
		select 1,7

	if @linea not in ('02','03')
		insert @Metas
		select 1,12 union all
		select 2,10 union all
		select 3, 8

	insert #Txx 
	exec usp_repo_comi_2014 @FI =@Fi , @FF =@FF , @codi_alma =@Codi_alma, @linea=@linea

	declare @Cx table (total numeric(12,2) null, costo numeric(12,2) null)

	insert @Cx
	select 	sum(total_cont_vent), sum(total_costo_cont)
	from #Txx

	declare @PX table (alta int null, tipo varchar(100) null, costo numeric(12,2) null, venta numeric(12,2) null, utilacum numeric(12,2) null,
						renta numeric(12,2) null, utilneta numeric(12,2) null, porcen numeric(12,2) null)
						
	insert @Px
	select alta, tipocomi,sum(total_costo_cont) Costo, sum(total_cont_vent) Venta,
		sum(total_cont_vent - total_costo_cont) UtilAcum, round(sum(total_cont_vent - total_costo_cont)*0.30,2) Renta,
		sum(total_cont_vent - total_costo_cont) - round (sum(total_cont_vent - total_costo_cont)*0.30 ,2) UtilNeta,
		round(case when (select total from @Cx)<>0 then 
				sum(total_cont_vent) /(select total from @Cx) else 0 end *100,2) Porcen
	from #Txx
	group by alta, tipocomi
	order by 1

	declare @Mx table (alta int null, r1 numeric(12,2) null, r2 numeric(12,2) null, r3 numeric(12,2) null)

	insert @Mx
	select alta , porcen - meta1 R1, porcen - meta2 R2, porcen - meta3 R3
	from METAS_LINEA_ROTA M (nolock)
	join @Px P
	on M.codi_rota=P.Alta
	where cod_lin_pro=@linea

	declare @Ex table (meta int null, Menor numeric(12,2) null)


	if (select count(*) from @Mx)>0 
	begin
		insert @Ex
		select 1, round((min(r1) - max(r1) )/  count(r1),2) M1 from @Mx

		insert @Ex
		select 2, round((min(r2) - max(r2) )/  count(r2),2) M2 from @Mx

		insert @Ex
		select 3, round((min(r3) - max(r3) )/  count(r3),2) M3 from @Mx

		declare @l_meta  int 
		select @l_meta =(select meta from (select top 1 meta , abs(menor) menor from @Ex order by 2) Sel)	
		
		insert #Sx
		select tipo, venta, porcen/100.00, meta1, meta2, meta3 , porcen - meta1 R1, porcen - meta2 R2, porcen - meta3 R3, 
				@l_meta as  nrometa, (select valor from @Metas M where id_meta=@l_meta) as MetaPorc, utilneta,
				(select costo from @cX) Costototal, (select total from @cX) Ventatotal, ALTA
		from METAS_LINEA_ROTA M (nolock)
		join @Px P
		on M.codi_rota=P.Alta
		where cod_lin_pro=@linea --and tipo<>'GENERAL'
		 
	end
	else
	begin
		insert #Sx
		select tipo, venta, porcen/100.00, 0 meta1, 0 meta2, 0 meta3 , 0 R1, 0 R2, 0 R3, 
				0  nrometa, (select valor from @Metas M where id_meta=1) as MetaPorc, utilneta,
				(select costo from @cX) Costototal, (select total from @cX) Ventatotal, ALTA
		from @Px P 
	end

	declare @nrometa int

	select @nrometa=nrometa from #Sx

	--select * from #Sx

	if @nrometa=0
	begin
		insert @Tx
		select @codi_alma,(select nemo_alma from almacen a (nolock) where a.codi_alma=@codi_alma) Almacen,
				@linea,
				(select des_lin_pro from linea_familia_pro F (nolock) where f.cod_lin_pro=@linea) as Linea,
				'',ROUND((MIN(R1) -  MAX(R1))/count(*),2), ROUND(SUM( utilneta ) * max(metaporc) /100.00,2)  
		from #Sx
	end

	if @nrometa=1
	begin
		insert @Tx
		select @codi_alma,(select nemo_alma from almacen a (nolock) where a.codi_alma=@codi_alma) Almacen,
				@linea,
				(select des_lin_pro from linea_familia_pro F (nolock) where f.cod_lin_pro=@linea) as Linea,
				'META 1',ROUND((MIN(R1) -  MAX(R1))/count(*),2), ROUND(SUM( utilneta ) * max(metaporc) /100.00,2)  
		from #Sx
	end
	if @nrometa=2
	begin
		insert @Tx
		select @codi_alma,(select nemo_alma from almacen a (nolock) where a.codi_alma=@codi_alma) Almacen,
				@linea,
				(select des_lin_pro from linea_familia_pro F (nolock) where f.cod_lin_pro=@linea) as Linea,
				'META 2',ROUND((MIN(R2) -  MAX(R2))/count(*),2) , ROUND(SUM( utilneta ) * max(metaporc) /100.00,2)  
		from #Sx
	end
	if @nrometa=3
	begin
		insert @Tx
		select @codi_alma,(select nemo_alma from almacen a (nolock) where a.codi_alma=@codi_alma) Almacen,
				@linea,
				(select des_lin_pro from linea_familia_pro F (nolock) where f.cod_lin_pro=@linea) as Linea,
				'META 3',ROUND((MIN(R3) -  MAX(R3))/count(*),2) , ROUND(SUM( utilneta ) * max(metaporc) /100.00,2)  
		from #Sx
	end

	delete #Sx 				
	delete #Txx
	delete @Metas 
	delete @PX
	delete @Cx
	delete @MX
	delete @Ex
	
	fetch c1 into @codi_alma, @linea
end 

close c1
deallocate c1

select * 
from @Tx

drop table #Txx 
drop table #Sx
GO
