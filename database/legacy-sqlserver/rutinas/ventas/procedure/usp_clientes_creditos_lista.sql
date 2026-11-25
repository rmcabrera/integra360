CREATE PROCEDURE [dbo].[usp_clientes_creditos_lista]
	@codigo [char](5),
	@mone [char](2),
	@codi_alma [char](2),
	@ps_pago [char](1),
	@fec [datetime]
WITH EXECUTE AS CALLER
AS
--declare @codigo char(5), @mone char(2), @codi_alma char(2), @ps_pago char(1), @fec datetime
--select @codigo='26233', @mone='01', @codi_alma='03', @ps_pago='4', @fec ='19/12/2018'

set nocount on    

create table #Credx (codi_credito numeric(12,0)  null) 

create table #CredMonto (codi_credito numeric(12,0)  null, monto numeric(12,2) null) 
create table #CredFact (codi_credito numeric(12,0)  null, codi_Fact char(10) null, codi_tipo_docu char(4) null,
			serie varchar(10) null, nro_docu varchar (10) null, tota_fact numeric(12,2) null, montocred numeric(12,2) null) 		
create table #CredPago (codi_credito numeric(12,0)  null, pago numeric(12,2) null) 

insert #Credx
select codi_Credito
from cliente_creditos cc (nolock)    
where Cc.codi_alma=@codi_alma and @fec <= cast(convert(char(10),cc.fec_fin_cred, 103) as datetime)

insert #CredMonto
select fc.codi_credito, sum(monto) as monto
from factura_credito fc (nolock)
join #CredX C
on fc.codi_credito=C.codi_Credito
join factura F (nolock)
on F.codi_fact=Fc.codi_fact 
where f.estado is null and convert(char(10),f.fech_Fact,103)<=@fec
group by fc.codi_credito

insert #CredFact
select  fc.codi_credito, f.codi_fact, codi_tipo_docu, 
		case when isnumeric(ser_fact)=0 then ser_fact else cast(cast(ser_fact as int) as varchar) end ser_fact,
		nro_fact, tota_fact, monto
from factura_credito fc (nolock)
join #CredX C
on fc.codi_credito=C.codi_Credito
join factura F (nolock)
on F.codi_fact=Fc.codi_fact
where f.estado is null and f.fech_Fact<=@fec

insert #CredPago
select F.codi_credito, 
	  sum(((case when tipo_io=1 then 1 else -1 end) * importe )*cast(round(montocred/tota_fact,2) as numeric(12,2))) imp    
from dbo.caja_chica C(nolock)     
Join #CredFact f 
On  
	case when isnumeric(c.serie)=0 then c.serie else cast(cast(c.serie as int) as varchar) end =
		 case when isnumeric(f.serie)=0 then f.serie else cast(cast(f.serie as int) as varchar) end  	and 
		
	case when isnumeric(c.nro_docu)=0 then c.nro_docu else cast(cast(c.nro_docu as numeric(12)) as varchar) end =
		 case when isnumeric(f.nro_docu)=0 then f.nro_docu else cast(cast(f.nro_docu as numeric(12)) as varchar) end  	and 
		
		F.codi_tipo_docu=c.codi_tipo_docu and    
		(   (tipo_io=1 and tipo_contab in ('005','036','037','130','020')) or
			 	(tipo_io=0 and tipo_contab in ('026'))  )
where c.fecha<=@fec
group by f.codi_credito


select '' as selec, A.codi_credito, A.fec_inic_cred,

	A.monto_cred - 
	
	isnull((select x.monto from #CredMonto X where x.codi_credito=A.codi_credito),0) + 
	
	isnull((select x.pago from #CredPago X where x.codi_credito=A.codi_credito),0) - 
 	
 	isnull((select sum(monto) from vale_credito v(nolock) 
		join registro_vale r(nolock) 
		on v.codi_vale=r.codi_vale  
	  where V.codi_credito=A.codi_credito and isnull(r.codi_fact,'')='' and ISNULL(estado,'')<>'N'),0) +
	  
	isnull((select sum(importe) from caja_chica_depo ccd(nolock) where tipo_rela='S' and ccd.codi_docu in 
		(select v.codi_vale from vale_credito v(nolock)
			join registro_vale r (nolock) on v.codi_Vale=R.codi_vale 
				where v.codi_credito=A.codi_credito and r.codi_fact is null and isnull(r.estado,'')='')),0) +
	
	isnull((select sum(c.prec_vent)
	from dbo.nota_credito C(nolock) 
	join dbo.factura F(nolock)
	on C.codi_fact=F.codi_fact and codi_tipo_pago='4' and isnull(F.estado,'')<>'A' and fech_nota_cred<DATEADD(day, 1, @fec) and C.codi_alma=@codi_alma
	join dbo.factura_credito Ax(nolock)
	on F.codi_fact=Ax.codi_fact
	where f.codi_clie_prov=A.codi_clie_prov and Ax.codi_credito=A.codi_credito),0)
			
	as saldo_favor, 0.000 as descontar, A.codi_mone
	
from cliente_creditos A (nolock)
join #credX B
on A.codi_credito=B.codi_credito
join cliente_proveedor cp (nolock)
on A.codi_Clie_prov=Cp.codi_clie_prov
where A.codi_clie_prov = @codigo and A.codi_mone=@mone and tipo_pago=@ps_pago
order by 2

drop table #Credx 
drop table #CredPago
drop table #CredMonto 
drop table #CredFact
GO
