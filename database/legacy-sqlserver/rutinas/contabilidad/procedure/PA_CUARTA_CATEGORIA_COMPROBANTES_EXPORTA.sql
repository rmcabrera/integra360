CREATE PROCEDURE [dbo].[PA_CUARTA_CATEGORIA_COMPROBANTES_EXPORTA]
	@ANIO [char](4),
	@MES [char](2)
WITH EXECUTE AS CALLER
AS
set nocount on 
create table #recibos_x_honorarios 
(codi_vouc varchar(10), nro_doc_iden varchar(20), serie varchar(4), nro_doc varchar(8), monto numeric (9,2), fech_emision datetime, fech_pago datetime, indi_retencion_renta_qta char(1) )

declare @codi_vouc varchar(10)
declare @nro_doc_iden varchar(20)
declare @serie varchar(4)
declare @nro_doc varchar(8)
declare @monto numeric (9,2)
declare @fecha datetime
declare @fecha_pago datetime
declare @indi_retencion_renta_qta char(1)
declare @registro varchar(10)
declare @conta int;
declare @retencion numeric(19,2)

-- capturar rph del mes en netos
declare C1 cursor 
for select mov.codi_vouc , cp.ruc, mov.serie, cast(mov.nro_docu as varchar(8)), 
	mov.importe, 
	mov.fecha,
	(select max(fecha) from dbo.movi_contables (nolock) where registro=mov.registro ),  
	mov.registro
 from dbo.cliente_proveedor cp (nolock)
	left join dbo.Tipo_Docu_Iden TDI (nolock) on TDI.Codi_Tipo_Docu_Iden = cp.Codi_Tipo_Docu_Iden 
	join dbo.movi_contables mov (nolock) on cp.codi_clie_prov=mov.codi_clie_prov 
where mov.anio=@ANIO and mov.mes=@MES and mov.subdia='H' and nro_cuen in ('4210002') and isnull(ltrim(registro),'')<>''

-- cogemos el monto sin la retencion 
open C1
fetch C1 into @codi_vouc , @nro_doc_iden , @serie, @nro_doc, @monto, @fecha, @fecha_pago, @registro

WHILE @@FETCH_STATUS = 0
	begin
		set @conta=0;
		set @retencion=0;
	
		if month(@fecha)<>month(@fecha_pago) or year(@fecha)<>year(@fecha_pago) set @fecha_pago=@fecha;
		
		insert into #recibos_x_honorarios
		(codi_vouc, nro_doc_iden, serie, nro_doc,  monto, fech_emision, fech_pago , indi_retencion_renta_qta)
		values(@codi_vouc, @nro_doc_iden, @serie, @nro_doc , @monto, @fecha, @fecha_pago, 0);

		select @conta=count(*) from movi_contables where nro_cuen='4010702' and importe>0 and codi_vouc=@codi_vouc;
		if @conta>0 --indica que tiene retencion
		begin
			select @retencion=importe from movi_contables where nro_cuen='4010702' and codi_vouc=@codi_vouc;
	
			 update #recibos_x_honorarios 
			 set indi_retencion_renta_qta='1' ,  monto=monto + @retencion	 	
			 where codi_vouc=@codi_vouc;			
		end 

		fetch C1 into @codi_vouc, @nro_doc_iden, @serie, @nro_doc, @monto, @fecha, @fecha_pago, @registro
	end

close C1
deallocate C1

select  '6|' + cast( nro_doc_iden as varchar(15))  + '|R|' +cast( rtrim(serie)  as varchar(4)) + '|' + cast( rtrim(nro_doc) as  varchar(8)) + '|' +
	cast( monto as varchar(10))+ '|' +
	isnull(convert(char(10),fech_emision ,103),'')  + '|' +
	isnull(convert(char(10),fech_pago ,103),'')  + '|' +
	 indi_retencion_renta_qta + '|' 

from   #recibos_x_honorarios

drop table #recibos_x_honorarios
GO
