CREATE PROCEDURE [dbo].[usp_detalle_creditos_vence]
	@alma [char](2),
	@fecha [datetime],
	@tipo [char](1),
	@mone [char](2),
	@dias [int]
WITH EXECUTE AS CALLER
AS
--declare @alma char(2), @fecha datetime , @tipo char(1), @mone char(2), @dias int
--select @alma ='00', @fecha='01/04/2010' ,@tipo ='V', @mone='02', @dias = 0

/*
Parametros:
	A: Vigentes
	V: Vencidas
*/
set nocount on 
set quoted_identifier off

declare @Condi_Alma varchar(20)
declare @Condi_Alma2 varchar(20)

if @alma='00' 
begin
	set @condi_alma='' 
	set @condi_alma2='' 
end
else
begin
	set @condi_alma="codi_alma="+@alma +" and "
	set @condi_alma2="C.codi_alma="+@alma +" and "
end 

declare @SQLSTRing nvarchar(4000)
declare @ParmString nvarchar(100)

set @ParmString = "@fecha datetime "
create table #Tx (codi_alma char(2), codi_mone char(2), codi_clie_prov char(5) null, ser_fact int, nro_fact numeric(18) null, 
			tota_fact numeric(12,2) null, tota_fact_d numeric(12,2) null,
			canc int,  fvenc datetime null)

set @SQLSTRing = "insert #Tx
		select codi_alma, codi_mone, codi_clie_prov, ser_fact, nro_fact, 
			(case when codi_mone='01' then C.monto else 0 end) tota_fact,
			(case when codi_mone='02' then C.monto else 0 end) tota_fact_d, 
			0 Canc, isnull(f.venc_fact,DATEADD(day, 30, f.fech_fact)) fvenc
		from dbo.factura f (nolock) 
		Join dbo.factura_credito C (nolock)
		on " +@condi_alma +" F.codi_fact=C.codi_fact and codi_tipo_pago='4' and isnull(estado,'')<>'A' 
			and fech_fact<DATEADD(day, 1, @fecha)
		union all
		select codi_alma , codi_mone,codi_clie_prov, serie, nro_docu,
			((case when tipo_io=1 then -1 else 1 end) * (case when codi_mone='01' then importe else 0 end))*cast(round(monto/(case when tota_fact=0 then 1 else tota_fact end),2) as numeric(12,2)) imp,
			((case when tipo_io=1 then -1 else 1 end) * (case when codi_mone='02' then importe else 0 end))*cast(round(monto/(case when tota_fact=0 then 1 else tota_fact end),2) as numeric(12,2)) impd ,
			tipo_io canc, isnull(venc_fact,DATEADD(day, 30, fech_fact)) fvenc
		from dbo.caja_chica Ax (nolock)
		Join (select nro_recibo, codi_fact,tota_fact,venc_fact,fech_fact 
			from dbo.caja_chica C(nolock) 
			Join dbo.factura f (nolock)
			On " + @Condi_alma2 +" cast(ser_fact as int)=cast(serie as int) and cast(nro_fact as int)=cast(nro_docu as int) and 
				F.codi_tipo_docu=c.codi_tipo_docu  and ((tipo_io=1 and tipo_contab in ('005','036','037','130')) or (tipo_io=0 and tipo_contab in ('026'))))  S
		on Ax.nro_recibo=S.nro_recibo
		    	and ((tipo_io=1 and tipo_contab in ('005','036','037','130')) or (tipo_io=0 and tipo_contab in ('026')))
				and Ax.fecha<DATEADD(day, 1, @fecha) 
		Join dbo.factura_Credito FC (nolock)
		on " +@Condi_alma +" Fc.codi_fact=S.codi_Fact "

execute sp_executesql @SQLString, @ParmString, @fecha=@fecha

declare @condi varchar(100)

if @Tipo='V'  
begin
	if @dias=0 set @condi=" datediff(dd,  fvenc, getdate())>0 "  
	else 
	begin
		if @dias>120 set @condi=" datediff(dd, fvenc, getdate())>120"
		else set @condi=" datediff(dd, fvenc, getdate())>" + cast(@dias - 30 as varchar)+" and datediff( dd,fvenc, getdate())<= "+ cast(@dias as varchar)  
	end
end
else set @condi=" datediff(dd,  fvenc, getdate())<=0 "

set @SQLSTRing = "select codi_alma , codi_mone , codi_clie_prov, 
		    (select case when isnull(razo_soci,'')='' then denominacion else razo_soci end 
			from cliente_proveedor C where c.codi_clie_prov collate sql_latin1_general_cp1_ci_as =T.codi_clie_prov) Razon,
			ser_fact, nro_fact,
			 sum(tota_fact) soles , sum(tota_fact_d) dolares , min(fvenc) fvenc ,
			(select nemo_alma from almacen A where a.codi_alma collate sql_latin1_general_cp1_ci_as=t.codi_alma) Almacen
			from #TX T
			where codi_mone="+@mone +" and " +@condi + " 
			group by codi_alma, codi_mone, codi_clie_prov, ser_fact, nro_fact
			having not (sum(tota_fact)=0 and sum(tota_fact_d)=0)
			order by codi_alma,ser_Fact, nro_fact "

execute sp_executesql @SQLString

drop table #TX
set quoted_identifier off
GO
