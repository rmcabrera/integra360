CREATE PROCEDURE [dbo].[usp_analisis_producto_lote]
	@anio [int],
	@f1 [datetime],
	@f2 [datetime],
	@prod [char](8)
WITH EXECUTE AS CALLER
AS
--declare @anio int,@f1 datetime, @f2 datetime, @prod char(8)
--select @anio='2015' , @f1='01/01/2015' , @f2='31/12/2015', @prod='00012337'

set nocount on

create table #Tx (codi_alma char(2), fecha datetime, tipo_nota char(2), codi_prod char(8), 
		codi_nota_ingr char(10), docu_sali char(10) null, alma_orig char(2) null)
create table #Lx (codi_nota_ingr char(10),codi_lote numeric(12), cantidad numeric(12,2) null, fecha datetime, lote varchar(100))

declare @codigo char(10), @fec datetime	

insert #Tx
select B.codi_alma,fech_nota_ingr, tipo_nota_ingr, codi_prod, codi_nota_ingr, codi_docu_sali, codi_alma_desti
from kardex A(nolock)
join nota_ingreso B (nolock)
on A.codi_docu_i_o = B.codi_nota_ingr
where periodo=@anio and codi_prod=@prod and 
		cast(convert(char(10),fech_tran,103) as datetime) between @f1 and @f2 and i_o=1
		and tipo_nota_ingr in ('01')
order by fech_nota_ingr
/*
declare c1 cursor for select codi_nota_ingr , fecha from #Tx
open c1
fetch c1 into @codigo, @fec
while @@Fetch_status=0
begin*/
	insert #Lx
	select A.codi_nota_ingr,codi_prod_alma_lote, B.cantidad , T.fecha , --@fec,
		(select rtrim(lote) from producto_almacen_lote X (nolock) where X.codi_prod_alma_lote=B.codi_prod_alma_lote)
	from detalle_nota_ingreso A (nolock)
	join productos_lotes_ingre_sali B (nolock)
	on A.nro_item_nota_ingr=B.codi_deta_ingre_sali
	join #Tx T
	on T.codi_nota_ingr=A.codi_nota_ingr
	where /*codi_nota_ingr=@codigo and  */ A.codi_prod=@prod

	/*fetch c1 into @codigo, @fec
end
close c1
deallocate c1
*/

create table #Mx (codi_nota char(10), codi_lote numeric(12) , lote_movi numeric(12))

insert #Mx
select codi_nota_ingr, codi_lote, /*cantidad, fecha, B.lote,*/ 
	   codi_prod_alma_lote
from producto_almacen_lote A
join #Lx B
on rtrim(A.lote)= B.lote

create table #RT (codi_nota char(10), codi_alma char(2), alma_desti char(2) null, tipo_nota char(2), cantidad numeric(12,2), 
			fecha datetime /*, codi_Deta varchar(12)*/ , codi_lote numeric(12,2))

insert #Rt
select codi_nota, codi_alma, codi_alma_desti, tipo_nota_ingr, cantidad, cast(convert(char(10),fecha,103) as datetime)--, codi_deta_ingre_sali
		, codi_lote
from 
	
	(select A.codi_nota, codi_alma, codi_alma_desti,tipo_nota_ingr, cantidad, fech_nota_ingr  as fecha, codi_deta_ingre_sali, codi_lote
	from #Mx A
	join productos_lotes_ingre_sali B (nolock)
	on A.lote_movi=B.codi_prod_alma_lote 
	join nota_ingreso C (nolock)
	on c.codi_nota_ingr=B.codi_ingr_sali
	where io=1 and tipo_nota_ingr<>'23'
	union all
	select A.codi_nota, codi_alma, codi_alma_desti, tipo_sali, cantidad, fech_emis, codi_deta_ingre_sali, codi_lote
	from #Mx A
	join productos_lotes_ingre_sali B (nolock)
	on A.lote_movi=B.codi_prod_alma_lote 
	join docu_sali_mate c (nolock)
	on C.codi_docu_sali=B.codi_ingr_sali
	where io=2 and tipo_sali='08') SQ
where fecha between @f1 and @f2
order by fecha

/*
select * 
from #Rt Y
--where codi_Alma in ('02','19')
order by codi_alma, fecha*/

declare @nota char(10), @almaorig char(2), @almadesti char(2), @tipo char(2), @cant numeric(12,2), @fecx datetime
declare @notax char(10), @almaorigx char(2), @almadestix char(2), @tipox char(2), @cantx numeric(12,2), @fecxx datetime, @lotex numeric(12,2)
declare @tipoaux char(2), @suma numeric(12,2),  @lote numeric(12,2)

create table #Resul (codi_nota char(10), codi_alma char(2), alma_desti char(2) null, tipo_nota char(2), cantidad numeric(12,2), 
			fecha datetime /*, codi_Deta varchar(12)*/, codi_lote numeric(12,2))

declare CM cursor for select distinct codi_nota, codi_alma, codi_lote
		from #Rt Y 
		--where codi_Alma in ('02','19')
		order by codi_nota,codi_alma
open CM
fetch CM into @nota, @Almaorig, @lote
while @@fetch_status=0
begin		
	set @tipoaux=''
	set @suma=0
	declare c1 cursor for select alma_desti, tipo_nota, cantidad, fecha
		from #Rt Y
			where codi_nota=@nota and codi_Alma=@Almaorig and codi_lote= @lote
				order by codi_alma, fecha
	open c1
	fetch c1 into @almadesti, @tipo, @cant,@fecx
	while @@fetch_status=0
	begin
		if @tipoaux='' 
		begin
			set @tipoaux=@tipo				
			if @tipo='08'
				set @suma= @suma + @cant 
			else
			begin
				set @suma = @cant						
			end
		end 
		else	
		begin
			if @tipoaux=@tipo and @tipo='08'
				set @suma= @suma + @cant 
			else
			begin
				insert #Resul
				select @notax, @almaorigx, @almadestix, @tipox,  @suma	, @fecxx,  @lotex
				set @suma= @cant 	
				set @tipoaux=@tipo			
			end		
		end
			
		--select @nota, @almaorig, @almadesti, @tipo, @cant,@fecx, @suma		
		set @notax=@nota 
		set @almaorigx=@almaorig
		set @almadestix=@almadesti
		set @tipox=@tipo
		set @cantx=@cant
		set @fecxx=@fecx
		set @lotex=@lote
		
		fetch c1 into @almadesti, @tipo, @cant,@fecx
	end
	
	insert #Resul
	select @notax, @almaorigx, @almadestix, @tipox, @suma,@fecxx, @lotex

	close c1
	deallocate c1
	
	fetch CM into @nota, @Almaorig, @lote
end		
close cm
deallocate cm

select codi_nota , 
			codi_alma+ ' - ' +(select nemo_alma from almacen A (nolock) where A.codi_alma=R.codi_alma)  as Codi_alma, 
			isnull(alma_desti + ' - ' +(select nemo_alma from almacen A (nolock) where A.codi_alma=R.alma_desti),'')    as alma_desti, 
			(select i_s + ' - '+NEMO_TIPO_IS from TIPO_INGR_SALI T (nolock) where T.CODI_TIPO_IS=R.tipo_nota) as tipo_nota , 
			cantidad , 	fecha,  
			(select lote from PRODUCTO_ALMACEN_LOTE P (nolock) where P.codi_prod_alma_lote=codi_lote)  as Lote
from #Resul R
order by fecha

drop table #Tx
drop table #Lx
drop table #Mx
drop table #Rt
drop table #Resul
GO
