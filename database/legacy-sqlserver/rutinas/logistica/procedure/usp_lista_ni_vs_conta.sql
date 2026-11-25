CREATE PROCEDURE [dbo].[usp_lista_ni_vs_conta]
	@F1 [datetime],
	@F2 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @F1 datetime, @F2 datetime
--select @F1 ='01/12/2013' ,  @F2 ='31/12/2013'

set nocount on

declare @Tx Table (codi_clie_prov char(5) null, serie varchar(10) null, nro_docu varchar(10) null, total numeric(12,4) null, nro_nota varchar(150) null, td  char(4) null)

declare @Rx Table (codi_clie_prov char(5) null, serie varchar(10) null, nro_docu varchar(10) null, total numeric(12,4) null, nro_nota varchar(150) null, td  char(4) null)

declare @Vx Table (codi_clie_prov char(5) null, serie varchar(10) null, nro_docu varchar(10) null, total numeric(12,4) null, contable numeric(12,4) null, nro_nota varchar(150) null, td  char(4) null)

insert @Tx
SELECT codi_clie_prov,
	case when isnumeric(nro_seri_docu_cont) =1 then cast(cast(nro_seri_docu_cont as int) as varchar) else nro_seri_docu_cont end as nro_seri_docu_cont,
	case when isnumeric(nro_docu_cont) =1 then cast(cast(nro_docu_cont as int) as varchar) else nro_docu_cont end as nro_docu_cont,
	cast(importe/*prec_tota*/* case when codi_mone='01' then 1 else tipo_camb end as numeric(12,2)) ,
	NRO_NOTA_INGR, CODI_TIPO_DOCU_CONT
FROM NOTA_INGRESO (nolock)  
where NOTA_INGRESO.tipo_nota_ingr in ('01','02','30')
	and cast(convert(char(10),fech_nota_ingr,103) as datetime ) between @F1 and @F2

insert @Rx
select codi_Clie_prov, serie, nro_docu, sum(total) as total, null, td
from @Tx
group by codi_Clie_prov, serie, nro_docu, td

DECLARE @correos VARCHAR(5000), @cod char(5), @ser varchar(10), @nro varchar(10), @td char(4)

declare C1 cursor for select codi_Clie_prov, serie, nro_docu, td from @Rx
open c1
fetch c1 into @cod, @ser, @nro, @td
while @@FETCH_STATUS=0
begin
	set @correos=null
	
	SELECT @CORREOS=COALESCE(@correos+' , '+ nro_nota,nro_nota) FROM @Tx
	where codi_clie_prov=@cod and serie=@ser and nro_docu=@nro and td=@td

	update @Rx set nro_nota=@CORREOS where codi_clie_prov=@cod and serie=@ser and nro_docu=@nro and td=@td
	
	fetch c1 into @cod, @ser, @nro, @td
end 


close c1
deallocate c1

insert @Vx
select codi_clie_prov , 
	serie , nro_docu , total,
	(select sum(importe*case when Cargo_Abono='C' then 1 else -1 end) from Movi_Contables  M (nolock)  
		WHERE M.codi_contable in (select codi_contable from movi_contables X (nolock)	
			where  X.Subdia = 'C'  and   X.Codi_Clie_Prov = A.Codi_Clie_Prov and X.Codi_Tipo_Docu = A.td)
		and (case when isnumeric(M.serie)=1 then cast(cast(M.serie as numeric(18)) as varchar(20)) else M.serie end)=A.serie
		AND (case when isnumeric(m.nro_docu)=1 then cast( cast(M.nro_docu as numeric(18)) as varchar(20)) else M.nro_docu end)=A.nro_docu
		and left(nro_cuen,2) not in ('42','43','40') ) as Contable,  nro_nota, td
from @Rx A 
order by 2, 3,4

declare @Mx table (codi_clie_prov char(5) null, serie varchar(10) null , nro_docu varchar(10) null, importe numeric(12,2) null, td char(4) null)

insert @Mx 
select codi_clie_prov, (case when isnumeric(M.serie)=1 then cast(cast(M.serie as numeric(18)) as varchar(20)) else M.serie end) as serie,
		(case when isnumeric(m.nro_docu)=1 then cast( cast(M.nro_docu as numeric(18)) as varchar(20)) else M.nro_docu end) as nro_docu,
		importe*case when Cargo_Abono='C' then 1 else -1 end importe , Codi_Tipo_Docu
from Movi_Contables  M (nolock)  
		WHERE M.Subdia = 'C'  and fecha between @F1 and @F2	 and 
				 left(nro_cuen,2) not in ('42','43','40')  

select codi_clie_prov , 
	dbo.f_cliente_proveedor(codi_clie_prov) Razon,
	serie , nro_docu , isnull(total,0) as total, isnull(contable,0) as  contable,
	isnull(total,0) - isnull(contable,0)  as diferencia, nro_nota
from @Vx 
/*
select * from @Mx M 
where NOT exists (select * from @Vx V 
	where v.codi_clie_prov=M.codi_clie_prov and V.serie=M.serie and V.nro_docu=M.nro_docu)
		*/
GO
