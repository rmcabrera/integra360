CREATE PROCEDURE [dbo].[usp_registros_x_cancelar_rubros]
	@fec [datetime],
	@prov [char](5),
	@ruc [varchar](20)
WITH EXECUTE AS CALLER
AS
--declare @fec datetime, @prov char(5) ,@ruc varchar(20)
--select @fec ='01/01/2010',  @prov='', @ruc ='20114228452'

--select * from cliente_proveedor where denominacion like '%Agropecuaria%'
set nocount on
SET QUOTED_IDENTIFIER OFF

DECLARE @SQLString NVARCHAR(1500)
DECLARE @ParmDefinition NVARCHAR(500)
Declare @CondicionCuentas Nvarchar(500) , @var varchar(20)
create table #TX (idd int , rubros varchar(100), CTA CHAR(2) collate SQL_Latin1_General_CP1_CI_AS)

insert #TX
select 1, 'CUENTAS POR COBRAR','12' union all
select 1, 'CUENTAS POR COBRAR','13' union all
select 2, 'CUENTAS POR PAGAR' ,'42' union all
select 2, 'CUENTAS POR PAGAR' ,'43' 

set @CondicionCuentas = " and left(nro_cuen,2) in (select cta from #Tx ) "

create table #Tempo (codigo char(10) collate sql_latin1_general_cp1_CI_AS,
			cliente char(5) collate SQL_Latin1_General_CP1_CI_AS , fecha datetime, 
			importe numeric(12,2) null ,importe_d numeric(12,2) null,
			registro varchar(12) collate SQL_Latin1_General_CP1_CI_AS null, 
			nro_cuen char(7) collate SQL_Latin1_General_CP1_CI_AS null, 
			cta_2 char(2) collate SQL_Latin1_General_CP1_CI_AS )

set @SQLString="select  min(codi_contable) , codi_clie_prov, min(cast(convert(char(10),fecha,103) as datetime)) fecha, 
		sum(case when cargo_abono='C' then 1 else -1 end * importe) importe,  
		sum(case when cargo_abono='C' then 1 else -1 end *importe_d) importe_d , 
		 registro, nro_cuen , left(nro_cuen,2) 
		from dbo.movi_contables (nolock) 
		where anio=year(@fec) and cast( convert(char(10),fecha,103) as datetime) <= @fec and 
				 rtrim(isnull(registro,''))<>'' " + @CondicionCuentas 

if not (@prov is null or rtrim(@prov)='' ) set @SQLString= @SQLString + " and codi_clie_prov=@prov " 
if not (@ruc is null or rtrim(@ruc)='' ) set @SQLString= @SQLString + " and codi_clie_prov in ( select X.codi_clie_prov from cliente_proveedor X (nolock) where x.ruc collate SQL_Latin1_General_CP1_CI_AS = @prov )"

if not (@prov is null or rtrim(@prov)='' ) set @var = @prov else set @var = @ruc

set @SQLString= @SQLString +" group by codi_clie_prov, nro_cuen,registro 
	having not (sum(case when cargo_abono='C' then 1 else -1 end * importe)=0 and 
		sum(case when cargo_abono='C' then 1 else -1 end * importe_d)=0) "

if not (@prov is null or rtrim(@prov)='' ) or not (@ruc is null or rtrim(@ruc)='' )
begin
	
	SET @ParmDefinition = "@fec datetime, @prov varchar(20)"
	insert #Tempo
	EXECUTE sp_executesql @SQLString, @ParmDefinition, @fec = @fec , @prov =@var
end
else
begin
	SET @ParmDefinition = "@fec datetime"
	insert #Tempo
	EXECUTE sp_executesql @SQLString, @ParmDefinition, @fec = @fec 
end 

select  '0' as Chec, codi_tipo_docu, codigo,codi_clie_prov,  B.importe, B.importe_d, B.fecha, B.registro,B.nro_cuen,
 	(select top 1 razon_social from dbo.empresa (nolock)) Razon_social,
	nro_docu, compr, glosa, subdia, fecha_venc, anio, mes, codi_mone, tipo_cambio ,serie,
	(select idd from #TX where cta=cta_2) iddRubro,
	(select rubros from #TX where cta=cta_2) Rubro,
	 cta_2,
	(SELECT desc_clas_cuen FROM CLASES_CUENTAS C (nolock) WHERE C.CODI_CLAS_CUEN = cta_2) sub,
	left(a.nro_cuen,3) codsub,
	(select desc_subc from sub_clas_cuen S (nolock) where s.codi_subc=left(A.nro_cuen,3)) SubClase,
	(select razo_soci from cliente_proveedor C(nolock) where C.codi_clie_prov= A.codi_clie_prov ) cliente
from dbo.movi_contables A (nolock)
join #Tempo B on A.codi_contable=B.codigo 
order by A.nro_cuen

drop table #tempo
drop table #tx

SET QUOTED_IDENTIFIER ON
GO
