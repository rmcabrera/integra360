CREATE FUNCTION [dbo].[uf_saldo_credito_costo](@cliente [char](5), @cred [int], @fecha [datetime], @almacen [char](2), @mone [char](2), @tipo [char](2))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
begin
		
	declare  @Resul numeric(12,2)
	--declare @cred int , @cliente  char(5), @fecha datetime, @almacen char(2), @mone char(2), @tipo char(2)
	--select @cred=567, @cliente='15509', @fecha='07/11/2019', @almacen='04', @mone='01', @tipo='UT'
		
	declare @Tx table(codi_fact varchar(10) null, codi_tipo_docu char(4) null, serie varchar(20) null, nro int null, 
	                  tota_fact numeric(12,2) null, tota_fact_d numeric(12,2) null, 
	                  tota_costo numeric(12,2) null, tota_costo_d numeric(12,2) null)

	insert @Tx
	select F.codi_fact, F.codi_tipo_docu,
		case when isnumeric(ser_fact)=0 then ser_fact else cast(cast(ser_fact as int) as varchar) end serie, 
		cast(nro_fact as int) nro, 
		(case when F.codi_mone='01' then C.monto else 0 end) tota_fact,
		(case when F.codi_mone='02' then C.monto else 0 end) tota_fact_d, 
(case when F.codi_mone='01' then round(cant_item * prec_costo*(case when cod_impuesto=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end),2) else 0 end) costo,
(case when F.codi_mone='02' then round(cant_item * (prec_costo*(case when cod_impuesto=3 then 1 else 1 + dbo.f_igv(fech_fact)/100 end)/ case when isnull(F.tcambio,0)=0 then 1 else F.tcambio end),2) else 0 end) costo_d
		
	from dbo.factura f (nolock) 
	join factura_detalle d (nolock)
	on F.codi_fact=D.codi_fact
	Join productos P(nolock)
	on D.codi_prod=P.codi_prod
	Join dbo.factura_credito C (nolock)
	on F.codi_fact=C.codi_fact and codi_tipo_pago='4' and isnull(estado,'')<>'A' and fech_fact<DATEADD(day, 1, @fecha) and f.codi_alma=@almacen
	where f.codi_clie_prov=@cliente and C.codi_credito=@cred

	union all

	select Ax.nro_recibo, Ax.codi_tipo_docu,
		 case when isnumeric(serie)=0 then serie else cast(cast(serie as int) as varchar) end serie, 
		 cast(nro_docu as int),
		
		((case when tipo_io=1 then -1 else 1 end) * (case when codi_mone='01' then importe else 0 end))* 
		case when isnull(tota_fact,0)=0 then 0 else cast(round(monto/tota_fact,2) as numeric(12,2)) end imp,
		((case when tipo_io=1 then -1 else 1 end) * (case when codi_mone='02' then importe else 0 end))*
		case when isnull(tota_fact,0)=0 then 0 else cast(round(monto/tota_fact,2) as numeric(12,2)) end impd,
		0, 0
		
	from dbo.caja_chica Ax (nolock)
		Join (
				select nro_recibo, codi_fact, tota_fact from dbo.caja_chica C(nolock) 
				join (
				select case when isnumeric(ser_fact)=0 then ser_fact 
							else cast( cast(ser_fact as int) as varchar) end as serie,
						nro_fact, codi_Tipo_docu, f.codi_fact, tota_fact 
				from dbo.factura f (nolock) 
					Join dbo.factura_credito C (nolock)
					on F.codi_fact=C.codi_fact and codi_tipo_pago='4' and isnull(estado,'')<>'A' and 
						fech_fact<DATEADD(day, 1, @fecha) and f.codi_alma=@almacen
					where f.codi_clie_prov=@cliente and C.codi_credito=@cred
						--	and ser_Fact='014' and nro_fact in (393,460)
					) Fx
				on c.codi_tipo_docu=Fx.codi_Tipo_docu and 
						case when isnumeric(c.serie)=1 then cast(cast(c.serie as int) as varchar(5)) else c.serie end =Fx.serie and
						C.nro_docu =Fx.nro_fact	
				where ((tipo_io=1 and tipo_contab in ('005','036','037','130','020')) or (tipo_io=0 and tipo_contab in ('026')))
				
		)  S
		on Ax.nro_recibo=S.nro_recibo
			and ((tipo_io=1 and tipo_contab in ('005','036','037','130','020')) or (tipo_io=0 and tipo_contab in ('026')))
			and Ax.fecha<DATEADD(day, 1, @fecha) and Ax.codi_alma=@almacen
		Join dbo.factura_Credito FC (nolock)
		on Fc.codi_fact=S.codi_Fact 
		where  Ax.codi_clie_prov=@cliente and FC.codi_credito=@cred

	union all

	select cast(F.codi_Vale as varchar),
		 '9999'  as codi_tipo_docu,
		 '0' as  serie, nro_vale as  nro,
		(case when codi_mone='01' then C.monto else 0 end) tota_fact,
		(case when codi_mone='02' then C.monto else 0 end) tota_fact_d,
		0.00, 0.00
		
	from dbo.registro_vale f (nolock) 
	Join dbo.vale_CREDITO C (nolock)
	on F.codi_Vale=C.codi_vale and codi_tipo_pago='4' and isnull(codi_Fact,'')='' and isnull(estado,'')<>'N' and fecha<DATEADD(day, 1, @fecha) and f.codi_alma=@almacen
	where f.codi_clie_prov=@cliente and C.codi_credito=@cred /*and f.codi_vale not in (select codi_docu from caja_chica_depo (nolock) where tipo_rela='S')*/
		
	--select * from @Tx
	--return
	
	declare @Rx table(codi_tipo_docu char(4) null, serie varchar(20) null, nro int null, tota_fact numeric(12,2) null, tota_fact_d numeric(12,2) null)

	insert @Rx
	select codi_tipo_docu ,serie, nro , sum(tota_fact) tota_fact , sum(tota_fact_d) tota_fact_d
	from 
		(select distinct codi_Fact,codi_tipo_docu ,serie, nro ,max(tota_fact) tota_fact, max(tota_fact_d) tota_fact_d
			from @Tx
			group by codi_Fact, codi_tipo_docu, serie, nro 
				--where nro=8877
				) as SQ
	group by codi_tipo_docu, serie, nro
	having sum(tota_fact)<>0 or sum(tota_fact_d)<>0
		
	declare  @vventa numeric(12,2), @vcosto numeric(12,2)	
	
	select @vventa = sum(venta), @vcosto = sum(costo)
	from(
		select case when @mone='01' then max(B.tota_fact)else max(B.tota_fact_d) end venta,
			   case when @mone='01' then sum(tota_costo)else sum(tota_costo_d) end costo
		from @Rx A
		join @Tx B
		on A.codi_tipo_docu=B.codi_tipo_docu and A.serie=B.serie and A.nro=B.nro
		where len(codi_fact)=10
	group by codi_fact) as SQL
	
	--select @vventa, @vcosto
	
	
	if @tipo='UT' set @resul = @vventa - @vcosto                         ----util
	if @tipo='PR' set @resul = case when isnull(@vventa,0)=0 then 0 else ( (@vventa - @vcosto) / @vventa ) * 100 end  ----%util
	
	if @resul is null set @resul = 0
	
	return @resul
	
end
GO
