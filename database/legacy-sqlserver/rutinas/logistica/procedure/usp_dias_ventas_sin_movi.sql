CREATE PROCEDURE [dbo].[usp_dias_ventas_sin_movi]
	@f1 [datetime],
	@f2 [datetime],
	@alma [char](2),
	@Rep [char](1)
WITH EXECUTE AS CALLER
AS
--declare @f1 datetime, @f2 datetime, @alma char(2), @Rep char(1)
--select @f1 ='01/01/2022', @f2='29/04/2023', @alma='03', @Rep='0'

set nocount on

declare @Tx table (codi_alma char(2), origen varchar(100) , fecha_emis datetime, codi_prod char(8),
					producto varchar(200), presen varchar(50) , cantidad int, linea varchar(50) , subfamilia varchar(200) , laboratorio varchar(200) 
					)

declare @Ax table (codi_alma char(2))

declare @fax datetime
set @fax = @f1

declare @TxF table (fecha datetime)
while @fax <=@f2
begin
	insert @TxF
	select @fax

	set @fax = dateadd(d,1,@Fax)
end


if @alma='00' 
	insert @Ax
	select codi_alma from almacen (nolock)	
else
	insert @Ax
	select @alma


insert @Tx
select D.codi_alma, 
		(select NEMO_ALMA from almacen A (nolock) where a.CODI_ALMA=D.codi_alma) as Origen,
		fech_nota_ingr,
		codi_prod,
		(select desc_prod from productos P (nolock) where P.codi_prod=B.codi_prod) as Producto,

		(select (select desc_pres from presentacion X (nolock) where x.cod_pres=p.cod_pres)
				 from productos P (nolock) where P.codi_prod=B.codi_prod) as Presen,	
		
		b.cantidad,

		(select (select (select (select l.des_lin_pro from LINEA_FAMILIA_PRO L where L.cod_lin_pro=f.cod_lin_pro)
			from familia_producto F (nolock) where F.CODI_FAMI_PROD= S.CODI_FAMI_PROD)
				 from sub_familia_producto S (nolock)
					where S.codi_sub_fami_prod=p.codi_sub_fami_prod) from productos P (nolock) where P.codi_prod=B.codi_prod) as Linea,

		(select (select desc_sub_fami_prod from sub_familia_producto S (nolock)
					where S.codi_sub_fami_prod=p.codi_sub_fami_prod) from productos P (nolock) where P.codi_prod=B.codi_prod) as SubFamilia,		

		(select dbo.F_Cliente_Proveedor(P.codi_clie_prov) from productos P (nolock) where P.codi_prod=B.codi_prod) as Laboratorio
					
from nota_ingreso D (nolock) 
join DETALLE_NOTA_INGRESO B (nolock)
on D.CODI_NOTA_INGR =B.CODI_NOTA_INGR
where D.codi_alma in (select X.codi_alma from @Ax x) and 
		cast(convert(char(10),fech_nota_ingr,103) as datetime) 	between @f1 and @f2 
				and TIPO_NOTA_INGR='23' and D.codi_alma<>'01'

select	codi_alma , 
		origen , 
		fecha_emis , 
		codi_prod ,
		producto , 
		presen , 
		cantidad , 
		linea , 
		subfamilia , 
		laboratorio ,
		(select razon_social from empresa (nolock)) as Empresa,
		
		(select count(*) from @TxF T
			where t.fecha between dateadd(d,1,cast(convert(char(10),x.fecha_emis,103) as datetime))  and @f2) -				
		
		(select count(*) 
		from kardex  K (nolock)
			where K.codi_alma=x.codi_alma  and K.codi_prod=X.codi_prod and 
				cast(convert(char(10),k.fech_tran,103) as datetime) between dateadd(d,1,cast(convert(char(10),x.fecha_emis,103) as datetime))  and @f2
			and i_o=2
			and codi_tipo_docu in ('0001','0003') 
			/*and cast(convert(char(10),fech_tran,103) as datetime)=T.fecha*/) DiasSinVenta,
/*
		(select count(*) from @TxF T
			where t.fecha between dateadd(d,1,cast(convert(char(10),x.fecha_emis,103) as datetime))  and @f2 and 
				not exists ( select * 
						from kardex  K (nolock)
							where K.codi_alma=x.codi_alma  and K.codi_prod=X.codi_prod and 
								cast(convert(char(10),k.fech_tran,103) as datetime) between dateadd(d,1,cast(convert(char(10),x.fecha_emis,103) as datetime))  and @f2
							and i_o=2
							and codi_tipo_docu in ('0001','0003') 
							and cast(convert(char(10),fech_tran,103) as datetime)=T.fecha)) DiasSinVenta,*/
		(select sum(cant_ingr - cant_sali) from kardex k (nolock)
				where k.codi_alma=X.codi_alma and k.codi_prod=X.codi_prod and k.periodo=year(@f2) and 
						convert(char(10),k.fech_tran,103)<=@f2)	stock,
		isnull((select sum(cant_sali) from kardex k (nolock)
				where k.codi_alma=X.codi_alma and k.codi_prod=X.codi_prod and k.periodo=year(@f2) and 
						convert(char(10),k.fech_tran,103)>=X.fecha_emis and 
						convert(char(10),k.fech_tran,103)<=@f2),0)	UV,
		(Select max(w.fecha_emis) from @Tx w where w.codi_prod=x.codi_prod and w.codi_alma=X.codi_alma) UltIngr
from @Tx X 
where case when @rep='0' then fecha_emis else 
		(Select max(w.fecha_emis) from @Tx w where w.codi_prod=x.codi_prod and w.codi_alma=X.codi_alma) end = fecha_emis
order by producto, fecha_emis
GO
