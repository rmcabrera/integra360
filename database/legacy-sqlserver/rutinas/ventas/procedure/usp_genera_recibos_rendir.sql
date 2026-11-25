CREATE PROCEDURE [dbo].[usp_genera_recibos_rendir]
	@nro_reci [char](10)
WITH EXECUTE AS CALLER
AS
--declare @nro_reci char(10)
--select @nro_reci='PIE000024'

set nocount on

declare @alma char(2), @fec datetime

declare @Tx table (idx int identity , codi_alma	char(2) null, nro_recibo char(10) null,  fecha datetime null, 
			tipo_io	int null, codi_mone char(2) null,codi_clie_prov	char(5) null,
			glosa	varchar	(150) null, codi_tipo_docu char	(4) null, serie	varchar	(10) null,
			nro_docu varchar(20) null, tipo_contab	char(3) null, importe numeric(12,2) null,
			codi_usua_soli	char (5) null, prov_canc char(1) null, hora_Real datetime null,
			codi_unid_oper	char (5) null, placa_carreta char(5) null, rendir char(1) null,
			nro_recibo_aux char(10) null, ident int , sec int)


declare @Rx table (idx int identity , codi_alma	char(2) null, nro_recibo char(10) null,  fecha datetime null, 
			tipo_io	int null, codi_mone char(2) null,codi_clie_prov	char(5) null,
			glosa	varchar	(150) null, codi_tipo_docu char	(4) null, serie	varchar	(10) null,
			nro_docu varchar(20) null, tipo_contab	char(3) null, importe numeric(12,2) null,
			codi_usua_soli	char (5) null, prov_canc char(1) null, hora_Real datetime null,
			codi_unid_oper	char (5) null, placa_carreta char(5) null, rendir char(1) null,
			nro_recibo_aux char(10) null, ident int , sec int)


insert @tx
select codi_alma, null ,fecha, 1 tipo_io,codi_mone,codi_clie_prov,
	'ingreso para rendir' glosa,codi_tipo_docu,serie,nro_docu,tipo_contab,
	importe,codi_usua_soli,isnull(prov_canc,'0'),hora_Real,codi_unid_oper,placa_carreta,rendir, nro_recibo_aux, 0,0 
 from caja_chica where nro_recibo=@nro_reci


select @alma=codi_alma, @fec=fecha from caja_chica where nro_recibo=@nro_reci


insert @tx
select @alma, null, @fec fecha, 0,  '01', B.codi_clie_prov, detalle, codi_tipo_docu, B.serie, B.nro_docu, tipo_contab,
	importe, codi_trans, '0', getdate(), placa_Tracto, placa_carreta, 0, null, a.codi_liqu, codi_deta
from liquidacion A (nolock)
join liquidacion_deta B (nolock)
on A.codi_liqu=b.codi_liqu
where  A.nro_recibo=@nro_reci


declare @ls_nemo varchar(20)
declare @LD_CODI_AUX numeric(18)

select @ls_nemo = substring(nemo_alma,1,2)  from dbo.almacen (nolock) 
		where codi_alma=@alma 

insert @Rx
select codi_alma, @ls_nemo+case when tipo_io=1 then 'I' else 'E' end +
	right('000000'+cast((SELECT CAST(MAX(SUBSTRING(nro_recibo,4, LEN(nro_recibo))) AS NUMERIC)  FROM  dbo.CAJA_CHICA C (nolock)
		WHERE C.CODI_ALMA=@alma AND C.TIPO_IO=T.tipo_io) + idx - case when tipo_io =1 then 0 else 1 end as varchar),6) 	nro_recibo ,
        fecha , tipo_io , codi_mone ,codi_clie_prov,
	glosa, codi_tipo_docu , serie	,nro_docu ,'068' tipo_contab	, importe ,
	codi_usua_soli	, prov_canc , hora_Real ,codi_unid_oper	, placa_carreta , rendir , nro_recibo_aux , ident , sec
from @Tx T


begin transaction
	declare @errno  int,@errmsg	varchar(255), @error varchar(10)

	insert caja_chica
	select codi_alma, nro_recibo ,
	        fecha , tipo_io , codi_mone ,codi_clie_prov,
		glosa, codi_tipo_docu , serie	,nro_docu , tipo_contab	, importe ,
		codi_usua_soli	, prov_canc , hora_Real ,codi_unid_oper	, placa_carreta , rendir , nro_recibo_aux 
	from @Rx
	
	if @@error <> 0 
	begin
		select @errno = 30002, @errmsg = 'No se puede insertar registro caja_chica'
		goto error
	end 

	update caja_chica set nro_recibo_aux=(select nro_recibo from @Rx where ident=0) , rendir='1'
		where nro_recibo=@nro_reci
	if @@error <> 0 
	begin
		select @errno = 30002, @errmsg = 'No se puede actualizar registro caja_chica Egreso'
		goto error
	end 

	update liquidacion set rendir='1' where nro_recibo=@nro_reci
	if @@error <> 0 
	begin
		select @errno = 30002, @errmsg = 'No se puede actualizar Liquidaciones'
		goto error
	end 

	update liquidacion_deta set nro_recibo=(select nro_recibo from @Rx where ident=B.codi_liqu and sec=B.codi_deta)
	from liquidacion A (nolock)
	join liquidacion_deta B (nolock)
	on A.codi_liqu=b.codi_liqu where A.nro_Recibo=@nro_reci	

	if @@error <> 0 
	begin
		select @errno = 30002, @errmsg = 'No se puede actualizar rendir cuenta recibo'
		goto error
	end 
	
	commit transaction 	
return
error:
	rollback transaction	
	raiserror @errno @errmsg
GO
