CREATE FUNCTION [dbo].[uf_saldo_credito](@cliente [char](5), @cred [int], @fecha [datetime], @almacen [char](2), @mone [char](2))
RETURNS [numeric](12, 2) WITH EXECUTE AS CALLER
AS 
begin
--	declare @cliente char(5) , @cred int, @fecha datetime, @almacen char(2), @mone char(2)
--	select @cliente='23458', @cred=409 , @fecha='12/12/2018', @almacen='04' , @mone='01'

	declare  @Resul numeric(12,2)
	declare @Rx table  (soles numeric(12,2) , dolar numeric(12,2))

	insert @Rx
	select isnull(sum(tota_fact) ,0) , isnull(sum(tota_fact_d),0)
	from (
	select 	(case when codi_mone='01' then C.monto else 0 end) as tota_fact,
				(case when codi_mone='02' then C.monto else 0 end) as tota_fact_d
		from dbo.factura f (nolock) 
		Join dbo.factura_credito C (nolock)
		on F.codi_fact=C.codi_fact and codi_tipo_pago='4' and isnull(estado,'')<>'A' and fech_fact<DATEADD(day, 1, @fecha) and f.codi_alma=@almacen
		where f.codi_clie_prov=@cliente and C.codi_credito=@cred
		union all
		select 	-1 * (case when C.codi_mone='01' then C.prec_vent else 0 end) as tota_fact,
				-1 * (case when C.codi_mone='02' then C.prec_vent else 0 end) as tota_fact_d
		from dbo.nota_credito C(nolock) 
		join dbo.factura F(nolock)
		on C.codi_fact=F.codi_fact and codi_tipo_pago='4' and isnull(F.estado,'')<>'A' and fech_nota_cred<DATEADD(day, 1, @fecha) and C.codi_alma=@almacen
		join dbo.factura_credito A(nolock)
		on F.codi_fact=A.codi_fact
		where f.codi_clie_prov=@cliente and A.codi_credito=@cred ) S1


	insert @Rx
	select  
		isnull((((case when tipo_io=1 then -1 else 1 end) * (case when codi_mone='01' then importe else 0 end))*cast(round(case when tota_fact=0 then 0 else monto/tota_fact end,2) as numeric(12,2))),0) imp,
		isnull((((case when tipo_io=1 then -1 else 1 end) * (case when codi_mone='02' then importe else 0 end))*cast(round(case when tota_fact=0 then 0 else monto/tota_fact end,2) as numeric(12,2))),0) imp
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


	insert @Rx
	select isnull(sum(tota_fact) ,0) , isnull(sum(tota_fact_d),0) 
	from (
		select (case when codi_mone='01' then C.monto else 0 end) tota_fact,
				(case when codi_mone='02' then C.monto else 0 end) tota_fact_d
		from dbo.registro_vale f (nolock) 
		Join dbo.vale_CREDITO C (nolock)
		on F.codi_Vale=C.codi_vale and codi_tipo_pago='4' and isnull(codi_Fact,'')='' and isnull(estado,'')<>'N' and fecha<DATEADD(day, 1, @fecha) and f.codi_alma=@almacen
		where f.codi_clie_prov=@cliente and C.codi_credito=@cred /*and f.codi_vale not in (select codi_docu from caja_chica_depo (nolock) where tipo_rela='S')*/
		union all
		select -1*(case when codi_mone='01' then /*C.monto -*/ isnull((select sum(importe) from caja_chica_depo ccd(nolock) where tipo_rela='S' and ccd.codi_docu=C.codi_vale),0)  else 0 end) tota_fact,
				-1*(case when codi_mone='02' then /*C.monto -*/ isnull((select sum(importe) from caja_chica_depo ccd(nolock) where tipo_rela='S' and ccd.codi_docu=C.codi_vale),0)  else 0 end) tota_fact_d
		from dbo.registro_vale f (nolock) 
		Join dbo.vale_CREDITO C (nolock)
		on F.codi_Vale=C.codi_vale and codi_tipo_pago='4' and isnull(codi_Fact,'')='' and isnull(estado,'')<>'N' and fecha<DATEADD(day, 1, @fecha) and f.codi_alma=@almacen
		where f.codi_clie_prov=@cliente and C.codi_credito=@cred /*and f.codi_vale not in (select codi_docu from caja_chica_depo (nolock) where tipo_rela='S')*/
	) S2


--select * from @Rx
	
	set @resul = isnull((select case when @mone='01' then sum(soles)  else  sum(dolar) end 
			from @Rx ),0) 
			
	
	return @resul
	
end
GO
