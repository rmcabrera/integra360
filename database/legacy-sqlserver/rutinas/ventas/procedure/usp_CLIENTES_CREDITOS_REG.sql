CREATE PROCEDURE [dbo].[usp_CLIENTES_CREDITOS_REG]
	@codi_alma [char](2),
	@F1 [datetime]
WITH EXECUTE AS CALLER
AS
--declare @codi_alma char(2), @F1 datetime  
--select @codi_alma='06', @F1 ='29/10/2019'
  
set nocount on    
create table #alma (codi_alma char(2) null)    

IF @codi_alma = '00'    
BEGIN    
 insert #alma    
 Select codi_alma from almacen (nolock)    
END    
ELSE    
BEGIN    
 insert #alma    
 Select codi_alma from almacen (nolock) where codi_alma = @codi_alma    
END    
    
set nocount on     

create table #Credx (codi_credito numeric(12,0)  null) 

create table #CredMonto (codi_credito numeric(12,0)  null, monto numeric(12,2) null) 

create table #CredFact (codi_credito numeric(12,0)  null, codi_Fact char(10) null, codi_tipo_docu char(4) null,
			serie varchar(10) null, nro_docu varchar (10) null, tota_fact numeric(12,2) null, montocred numeric(12,2) null) 
			
create table #CredPago (codi_credito numeric(12,0)  null, pago numeric(12,2) null) 

insert #Credx
select codi_Credito
from cliente_creditos cc (nolock)    
join #alma A 
on Cc.codi_alma=A.codi_alma
--where codi_credito=409

--select * from CLIENTE_CREDITOS where codi_clie_prov=23458

insert #CredMonto
select fc.codi_credito, sum(monto) as monto
from factura_credito fc (nolock)
join #CredX C
on fc.codi_credito=C.codi_Credito
join factura F (nolock)
on F.codi_fact=Fc.codi_fact 
where f.estado is null and convert(char(10),f.fech_Fact,103)<=@f1
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
where f.estado is null and f.fech_Fact<=@f1

insert #CredPago
select F.codi_credito, 
	  sum(((case when tipo_io=1 then 1 else -1 end) * importe )*cast(round(montocred/tota_fact,2) as numeric(12,2))) imp    
from dbo.caja_chica C(nolock)     
Join #CredFact f 
On  
	case when isnumeric(c.serie)=0 then c.serie else cast(cast(c.serie as int) as varchar) end =
		 case when isnumeric(f.serie)=0 then f.serie else cast(cast(f.serie as int) as varchar) end  	and 
		
	case when isnumeric(c.nro_docu)=0 then c.nro_docu else cast(cast(c.nro_docu as int) as varchar) end =
		 case when isnumeric(f.nro_docu)=0 then f.nro_docu else cast(cast(f.nro_docu as int) as varchar) end  	and 
		
		F.codi_tipo_docu=c.codi_tipo_docu and    
		(   (tipo_io=1 and tipo_contab in ('005','036','037','130','020')) or
			 	(tipo_io=0 and tipo_contab in ('026'))  )
where c.fecha<=@f1
group by f.codi_credito


select  A.codi_clie_prov, 
	Cp.denominacion,
	a.codi_credito,
	A.fec_inic_cred,
	A.monto_cred,
	A.estado,
	cp.tele_1,
	cp.tele_2,
	(case A.tipo_pago when 1 then 'CAM' when 2 then 'ROT' when 3 then 'MOR' else 'ESP' end) observa_cred,    

	A.monto_cred - 
		dbo.uf_saldo_credito (a.codi_clie_prov , a.codi_Credito, @f1 , a.codi_alma, a.codi_mone)
/*	
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
	on C.codi_fact=F.codi_fact and codi_tipo_pago='4' and isnull(F.estado,'')<>'A' and fech_nota_cred<DATEADD(day, 1, @F1) and C.codi_alma=@codi_alma
	join dbo.factura_credito Ax(nolock)
	on F.codi_fact=Ax.codi_fact
	where f.codi_clie_prov=A.codi_clie_prov and Ax.codi_credito=A.codi_credito),0)
			
*/
	as Saldo_favor,


	
	A.codi_mone,
	(select X.nemo_alma from almacen X (nolock) where X.codi_alma=A.codi_alma) nemo_alma,
	cp.ruc as nro_docu_iden,

	(Select  D.doc_garantia from dbo.documento_garantia D (nolock) 
		where D.codi_docg=isnull(A.doc_garantia,0)) doc_garantia,    
	A.fec_fin_cred,    
	(select U.nomb_1+' '+U.apel_1 from usuarios U (nolock) where U.codi_usua=A.codi_usua_responsa) responsable, 
	A.fec_pago, 
	A.infocorp,    
	(select top  1 convert(char(10),fecha,103) + ': ' + decripcion     
	   from CLIENTE_CREDITO_HISTORIAL X (nolock) where x.codi_credito=A.codi_credito order by fecha desc ) Historial,
	dbo.uf_saldo_credito_costo(a.codi_clie_prov , a.codi_Credito, @f1 , a.codi_alma, a.codi_mone,'UT') as utilidad,
	dbo.uf_saldo_credito_costo(a.codi_clie_prov , a.codi_Credito, @f1 , a.codi_alma, a.codi_mone,'PR') as utilidad_porc
	
	   
from Cliente_creditos A (nolock)
join #CredX B
on A.codi_Credito=B.codi_credito
join cliente_proveedor cp (nolock)
on A.codi_Clie_prov=Cp.codi_clie_prov
--where A.codi_clie_prov in ('64550') and estado=1
order by 2

drop table #alma
drop table #Credx 
drop table #CredPago
drop table #CredMonto 
drop table #CredFact
GO
