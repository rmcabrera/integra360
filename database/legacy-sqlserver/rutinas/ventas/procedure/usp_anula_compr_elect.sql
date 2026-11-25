CREATE PROCEDURE [dbo].[usp_anula_compr_elect]
	@codi_Fact [char](10),
	@Tipo [char](1)
WITH EXECUTE AS CALLER
AS
--declare @codi_Fact char(10) ,@Tipo char(1)
--select @codi_fact='0000000055' , @Tipo='C'

set nocount on

declare @felim datetime, @femis datetime
declare @corre int
declare @docu char(4), @serie varchar(5), @nro_docu varchar(10)
declare @ruc varchar(15), @razon varchar(100),  @motivo varchar(100)

select @ruc =ruc , @razon  = razon_Social from empresa (nolock)

if @tipo='F'
begin
	select @felim = isnull(fecha_elim,fech_Fact),  @docu=CODI_TIPO_DOCU, @serie=SER_FACT, @nro_docu=cast(NRO_FACT as int),
			@femis  = fech_fact, @motivo= isnull(motivo_elim,'')
	from factura (nolock)
	where codi_Fact=@codi_Fact
end
if @tipo='C'
begin
	select @felim = isnull(fecha_elim,FECH_NOTA_CRED),  @docu='0007', @serie=SER_NOTA_CRED, @nro_docu=cast(NRO_NOTA_CRED as int),
			@femis  = FECH_NOTA_CRED, @motivo= isnull(motivo_elim,'')
	from nota_Credito (nolock)
	where CODI_NOTA_CRED=@codi_Fact
end
if @tipo='D'
begin
	select @felim = isnull(fecha_elim,FECH_NOTA_DEBI),  @docu='0008', @serie=SER_NOTA_DEBI, @nro_docu=cast(NRO_NOTA_DEBI as int),
			@femis  = FECH_NOTA_DEBI, @motivo= isnull(motivo_elim,'')
	from nota_debito (nolock)
	where CODI_NOTA_DEBI=@codi_Fact
end


select @corre=correlativo
from eliminar_corre (nolock)
where fecha=cast(convert(char(10),@felim,103) as datetime) and codi_tipo_docu=@docu and serie=@serie and nro_docu=@nro_docu

if @corre is null set @corre=0

select 'RA-'+replace(convert(char(10),@felim,102),'.','')+'-'+ right('0000'+cast(@corre as varchar),4)+ '|' +
		replace(convert(char(10),@felim,102),'.','-') + '|' +
		replace(convert(char(10),@femis,102),'.','-') + '|' +
		'RA'+ '|'+
		'}'
union all
select '~' 
union all
select rtrim(@ruc) + '|'   +
		'6'	+'|' +
		rtrim(@razon) + '|'+
		'}'
union all
select '~' 
union all
select (select t.codi_sunat from TIPO_DOCUMENTO t (nolock) where t.CODI_TIPO_DOCU=@docu)	 + '|'+
		rtrim(@serie) + '|' +
		rtrim(@nro_docu) + '|' +
		rtrim(@motivo) + '|' +
		'1'+ '|'+
		'}'
union all
select '~' 
union all
select '\'
GO
