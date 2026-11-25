CREATE PROCEDURE [dbo].[usp_listar_registros_x_cancelar]
	@fec [datetime],
	@prov [char](5),
	@cuentas [nvarchar](1000)
WITH EXECUTE AS CALLER
AS
--declare @fec datetime, @prov char(5) ,@cuentas varchar(250)
--select @fec ='24/09/2008', @prov='04635', @cuentas =''

set nocount on
SET QUOTED_IDENTIFIER OFF

DECLARE @SQLString NVARCHAR(1500)
DECLARE @ParmDefinition NVARCHAR(500)
Declare @CondicionCuentas Nvarchar(500) ,@aux varchar(250)

if rtrim(@Cuentas)='' or @Cuentas is null set @CondicionCuentas ='' else  set @CondicionCuentas  = @cuentas

create table #Tempo (codigo char(10) collate sql_latin1_general_cp1_CI_AS,
			cliente char(5) collate SQL_Latin1_General_CP1_CI_AS , fecha datetime, 
			importe numeric(12,2) null ,importe_d numeric(12,2) null,
			registro varchar(12) collate SQL_Latin1_General_CP1_CI_AS null, 
			nro_cuen char(7) collate SQL_Latin1_General_CP1_CI_AS null)


set @SQLString="select  min(codi_contable) , codi_clie_prov, min(cast(convert(char(10),fecha,103) as datetime)) fecha, 
		sum(case when cargo_abono='C' then 1 else -1 end * importe) importe,  
		sum(case when cargo_abono='C' then 1 else -1 end *importe_d) importe_d , 
		 registro, nro_cuen 
		from dbo.movi_contables (nolock) 
		where cast( convert(char(10),fecha,103) as datetime) <= @fec and 
		 not (registro is null or rtrim(registro)='') and anio=year(@fec) " + @CondicionCuentas 

if not (@prov is null or rtrim(@prov)='' ) set @SQLString= @SQLString + " and codi_clie_prov=@prov " 

set @SQLString= @SQLString +" group by codi_clie_prov, nro_cuen,registro 
	having not (sum(case when cargo_abono='C' then 1 else -1 end * importe)=0 and 
		sum(case when cargo_abono='C' then 1 else -1 end * importe_d)=0) "

if not (@prov is null or rtrim(@prov)='' )
begin
	SET @ParmDefinition = "@fec datetime, @prov char(5)"
	insert #Tempo
	EXECUTE sp_executesql @SQLString, @ParmDefinition, @fec = @fec , @prov =@prov
end
else
begin
	SET @ParmDefinition = "@fec datetime"
	insert #Tempo
	EXECUTE sp_executesql @SQLString, @ParmDefinition, @fec = @fec 
end 


select  '0' as Chec, codi_tipo_docu, codigo,codi_clie_prov,  B.importe, B.importe_d, B.fecha, B.registro,B.nro_cuen,
 	(select top 1 razon_social from dbo.empresa (nolock)) Razon_social,
	(select desc_cuen from dbo.cuentas_contable C(nolock) where C.nro_cuen=B.nro_cuen) desc_cuen,
	nro_docu, compr, glosa, subdia, fecha_venc, anio, mes, codi_mone, tipo_cambio ,serie
from dbo.movi_contables A (nolock)
join #Tempo B on A.codi_contable=B.codigo

drop table #tempo
SET QUOTED_IDENTIFIER ON
GO
