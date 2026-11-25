CREATE PROCEDURE [dbo].[SP_LIBRO_CENTRALIZADO]
	@mesanio [char](6)
WITH EXECUTE AS CALLER
AS
BEGIN
	declare @sd char(1)
	declare @cen char(1)
	declare @des varchar(150)
	Declare @da numeric(12,2)
	declare @ha numeric(12,2)
	declare @ord int
	declare @m int
	declare @mesaux char(6)
	set @da=0
	set @ha=0

	set @m = cast(left(@mesanio,2) as numeric(2)) - 1
	set @mesaux =replicate('0', 2 - len(convert(varchar(2),@m) )) +convert(varchar(2),@m) + right(@mesanio,4)

	if (@m>0) 
	begin	
	      select @da=sum(case when cargo_abono='C' then importe else 0 end), @ha=sum(case when cargo_abono='A' then importe else 0 end)
		from movi_contables where (mes between '01' and left(@mesaux,2)) and anio=right(@mesaux,4)
	end
	create table #temporal (cuenta char(5) null,descripcion varchar(200) null, debe numeric(12,2) null, haber numeric(12,2) null,  auxiliar varchar(20) null, 
		cliente varchar(200) null, subdia char(1) null, campo char(8) null, orden int null, debeante numeric(12,2) null, haberante numeric(12,2) null, glosa varchar(150) null)
	
	declare C1 cursor for select nemotec, central, orden, descrip  from subdiario order by orden, nemotec
	open c1
	fetch C1 into @sd, @cen, @ord, @des
	while @@Fetch_Status = 0
	begin
		if (@cen = 'S')
		begin
			 insert into #temporal
			select left(nro_cuen,5) , (select desc_lcc from linea_clase_c 
				where linea_clase_c.codi_lcc=left(nro_cuen,5)), sum(case when cargo_abono ='C' then importe else 0 end) as Debe,
				sum(case when cargo_abono ='A' then importe else 0 end) as Debe, 
				'','',subdia, @mesanio, @ord, @da, @ha, 'Registro Central de '+@des
				from movi_contables 
					where mes=left(@mesanio,2) and anio=right(@mesanio,4) and subdia=@sd
					   group by subdia,left(nro_cuen,5)
						order by subdia,left(nro_cuen,5)
		end
		else
		begin
		 insert into #temporal
			select left(nro_cuen,5) , (select desc_lcc from linea_clase_c 
				where linea_clase_c.codi_lcc=left(nro_cuen,5)), sum(case when cargo_abono ='C' then importe else 0 end) as Debe,
				sum(case when cargo_abono ='A' then importe else 0 end) as Debe, 
				(select ruc from cliente_proveedor 
					where cliente_proveedor.codi_clie_prov = movi_contables.codi_clie_prov) as Auxiliar,
				(select denominacion from cliente_proveedor 
					where cliente_proveedor.codi_clie_prov = movi_contables.codi_clie_prov) as Cliente, subdia, 
					@mesanio, @ord, @da, @ha, @des
				from movi_contables 
					where mes=left(@mesanio,2) and anio=right(@mesanio,4) and subdia=@sd
					   group by subdia,left(nro_cuen,5), codi_clie_prov
						order by subdia,left(nro_cuen,5)
		end
		fetch C1 into @sd, @cen, @ord, @des
	end
	close C1
	deallocate C1
	select  * from #temporal order by orden, cuenta
END
GO
