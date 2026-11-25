CREATE PROCEDURE [dbo].[usp_reporte_declara_jurada]
	@codi [int]
WITH EXECUTE AS CALLER
AS
--declare @codi int
--select @codi=143

set nocount on

declare @alma char(2)
declare @fecha datetime
declare @codi_pers char(5)

select  @alma = codi_alma , @fecha= fecha_decla , @codi_pers= codi_pers
from declara_jurada (nolock) where codi_Decla=@codi

declare @TXD table (idd int, ord int, descrip varchar(250) , codi_mone char(2), monto numeric(12,2) null, codi_decla numeric(12) null)

declare @Cx table (posi int, codi_Carg char(4), desc_Cargo varchar(100))

insert @Cx
select 1,codi_carg, desc_cargo from cargos (nolock) where desc_cargo like 'Encargado de Tienda'	union all
select 2,codi_carg, desc_cargo from cargos (nolock) where desc_cargo like 'Ingeniero Agronomo%' union all
select 3,codi_carg, desc_cargo from cargos (nolock) where desc_cargo like 'Tecnico Agronomo' union all
select 4,codi_carg, desc_cargo from cargos (nolock) where desc_cargo like 'Almacenero'

declare @Ex table (idd int identity,nombres varchar(250) , dni varchar(50), cargo varchar(150))


/*insert @Ex
select 1 posi, p.apel_1 + ' '+p.apel_2 + ' '+ p.nomb_1 + isnull(' ' +p.nomb_2,'') as Nombres, nro_docu_iden,
		'' desc_cargo
from almacen_usuario A (nolock) 
join usuarios b (nolock)
on A.codi_usua=B.codi_usua
join personal P (nolock)
on B.codi_pers=P.codi_pers
join cargos C 
on P.codi_Carg=C.codi_Carg
join Almacen X (nolock)
on X.codi_alma=A.codi_alma
where A.codi_alma=@alma and A.codi_usua<>'00000' and B.esta_clav=1 and P.esta_acti='1'
		and P.codi_pers<>@codi_pers 
		and P.codi_unid_oper=X.codi_unid_oper
order by posi
*/

insert @Ex
select p.apel_1 + ' '+p.apel_2 + ' '+ p.nomb_1 + isnull(' ' +p.nomb_2,'') as Nombres, nro_docu_iden,
		desc_cargo 
		from personal P (nolock)
join cargos C (nolock)
on P.codi_Carg=C.codi_carg
join almacen a (nolock)
on A.codi_unid_oper=P.codi_unid_oper
where A.codi_alma=@alma and P.codi_pers<>@codi_pers and p.esta_acti=1


insert @TxD
select 1 as ID, (select count(*) from DECLARA_JURADA_CAJA x (nolock) where X.codi_decla=DC.codi_decla and 
						X.fecha_caja<=DC.fecha_caja ) as Cont,
		convert(char(10),fecha_caja,103) as Fecha, codi_mone, monto_Caja, codi_decla
from DECLARA_JURADA_CAJA DC (nolock) where codi_Decla=@codi
union all 
select distinct  top 1 1, (select count(*) from DECLARA_JURADA_CAJA x (nolock) where X.codi_decla=DC.codi_decla and 
						X.fecha_caja<=DC.fecha_caja ) - 1  as Cont,
		 convert(char(10),fecha_caja,103),'01', 300 , codi_decla
from DECLARA_JURADA_CAJA DC (nolock) where codi_Decla=@codi
union all
select 3 as ID, 1,
		(select des_lin_pro from LINEA_FAMILIA_PRO L (nolock) where L.cod_lin_pro=DM.codi_lin) as Linea,
		'01', monto_linea , codi_decla
from DECLARA_JURADA_MERCA DM (nolock) where codi_Decla=@codi

declare @Fx table (fecha datetime, docu varchar(10) , serie varchar(10),  mini varchar(10) , maxi varchar(10))			

insert @Fx
select cast(convert(char(10),fech_fact,103) as datetime) as fecha, 
		rtrim((select nemo from tipo_documento T (nolock) where T.codi_tipo_docu=F.codi_tipo_docu)) as Docu, 
		rtrim(ser_Fact), 
		rtrim(min(nro_fact)) mini, 
		rtrim(max(nro_fact)) maxi
from factura F (nolock)
where codi_alma=@alma and cast(convert(char(10),fech_fact,103) as datetime) in (select cast(descrip as datetime)
		from @TxD
			where idd=1)
group by cast(convert(char(10),fech_fact,103) as datetime), codi_tipo_docu, ser_Fact
order by 1

DECLARE @correos VARCHAR(5000)
declare @fec datetime

declare C1 cursor for select distinct fecha from @Fx
open c1
fetch c1 into @fec
while @@fetch_status=0
begin
	set @CORREOS =null
	
	SELECT @CORREOS=COALESCE(@correos+' , '+ docu + ' ' +serie + ' ' + mini + ' - '  + maxi, 
					 docu + ' ' +serie + ' ' + mini + ' - '  + maxi) 
	FROM @Fx
	where fecha=@fec
	
	insert @TXD
	select 2 as ID, (select count(*) from DECLARA_JURADA_CAJA x (nolock) where X.codi_decla=@codi and 
						X.fecha_caja<=@fec) as Cont,
		convert(char(10),@fec,103) + ' ' +@correos as Descr, 
		'01' codi_mone, 0.00 monto_Caja, @codi
	
	fetch c1 into @fec		
end 
close c1
deallocate c1 

if (select count(*) from @TXD where idd=1)<=0 
begin
	insert @TXD
	select 1,1,'','01',0.00, @codi

	insert @TXD
	select 2,1,'','01',0.00, @codi
end

-------------------- Busqueda de  Guias
insert @TXD
select 4, 1,'Emitidas ' + rtrim(cast(ser_guia  as varchar))+' - ' + rtrim(cast(nro_guia as varchar)),
			'01',0.00, @codi
from guia (nolock)
where codi_alma=@alma and cast(convert(char(10),fech_tras ,103) as datetime)= convert(char(10),@fecha ,103) 
union all 
select 4, 2,'Aceptadas ' + rtrim(nro_seri) +' - ' +rtrim(nro_docu) ,
			'01',0.00, @codi
from nota_ingreso (nolock)
where cast(convert(char(10),fech_nota_ingr,103) as datetime )=convert(char(10),@fecha ,103) and tipo_nota_ingr='23'
and codi_alma=@alma


if (select count(*) from @TXD where idd=4)<=0 
begin
	insert @TXD
	select 4,1,'','01',0.00, @codi
end

select codi_pers, 
		(select apel_1 + ' ' +apel_2 + ' '+ nomb_1 + isnull(' ' +nomb_2,'') from personal P (nolock) where P.codi_pers=d.codi_pers) Nombres,
		(select NRO_DOCU_IDEN from personal P (nolock) where P.codi_pers=d.codi_pers) DNI,
		codi_alma, 
		(select desc_alma from almacen a (nolock) where a.codi_alma=D.codi_alma) Sucursal,
		fecha_decla,direccion, 
		idd, descrip, codi_mone, monto, lugar, ord,
		
		(select (select desc_cargo from cargos c (nolock) where c.codi_carg=p.codi_Carg)
				 from personal P (nolock) where P.codi_pers=d.codi_pers) Cargo,
		
		isnull((select nombres from @ex where idd=1),'') as Nomb2,
		isnull((select dni from @ex where idd=1),'') as DNI2,
		isnull((select cargo from @ex where idd=1) ,'') as Cargo2,

		isnull((select nombres from @ex where idd=2),'')  as Nomb3,
		isnull((select dni from @ex where idd=2),'') as DNI3,
		isnull((select cargo from @ex where idd=2) ,'')as Cargo3,

		isnull((select nombres from @ex where idd=3),'') as Nomb4,
		isnull((select dni from @ex where idd=3),'') as DNI4,
		isnull((select cargo from @ex where idd=3),'') as Cargo4
				
from DECLARA_JURADA D (nolock) 
join @TxD B
on D.codi_decla=B.codi_decla
where D.codi_decla=@codi
order by idd, ord,descrip, codi_mone
GO
