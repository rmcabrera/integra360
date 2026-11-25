CREATE PROCEDURE [dbo].[usp_liquidacion_impuestos]
	@anio [char](4),
	@mes [char](2),
	@bonif [numeric](12, 2),
	@cofigv [numeric](12, 6),
	@cofrenta [numeric](12, 6),
	@porc [numeric](12, 6),
	@credant [numeric](12, 2),
	@percep [numeric](12, 2),
	@reten [numeric](12, 2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2) , @bonif numeric(12,2) , @cofigv numeric(12,6) , @cofrenta numeric(12,6), @porc numeric(12,6), @credant numeric(12,2), @percep numeric(12,2) , @reten numeric(12,2) 
--select @anio ='2015', @mes ='05' , @bonif=1995 , @cofigv =0.469 , @cofrenta =0.004100, @porc=0.015, @credant=-224411.00, @percep =200, @reten =100

set nocount on 

create table #OC (oc char(10) null, ni char(10) null, fecha datetime null, afec_rete char(1))
create table #NI (codi_oc char(10) null, prod char(8) null, canti numeric(18,2) null, fecha datetime null, afec_rete char(1))

declare @Rx table (idd int , grupo int ,descri varchar(100), base numeric(12,2), igv numeric(12,2))

declare @Bas numeric(12,2), @NoGra numeric(12,2), @Total_ant numeric(12,2)
declare @BasPar numeric(12,2), @NoGraPar numeric(12,2)
declare @Ld_IGV numeric(12,2), @Ld_IGVPar numeric(12,2)
declare @anio_a char(4), @mes_A char(2)

set @anio_a= cast(cast(@anio as int) - 1 as varchar)
set @mes_a = @mes

----------------- VENTAS ------------------
select @Bas=sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							and left(nro_cuen,2)<>'40'/* and isnull(tipo_venta,'1') not in ('E','4','5','6')*/
							and not(nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta,'1')='4')
		                        then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end) ,
	  @NoGra=sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132') 
						or left(nro_Cuen,4) in ('1311'))
							 and left(nro_cuen,2)<>'40' /*and isnull(tipo_venta,'1') ='5'*/
							and (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4')
		                        then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)	,
	@Ld_IGV = sum(case when left(nro_cuen,2)='40' then  importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  
from movi_contables (nolock)
where anio=@anio and mes=@mes and subdia='V'


select @Total_ant=sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132')
						or left(nro_Cuen,4) in ('1311'))
							and left(nro_cuen,2)<>'40'/* and isnull(tipo_venta,'1') not in ('E','4','5','6')*/
							and not(nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta,'1')='4')
		                        then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end) 
				 + sum(case when (left(nro_Cuen,1) ='7' or left(nro_Cuen,2) ='49' or left(nro_Cuen,3) in ('122','132') 
						or left(nro_Cuen,4) in ('1311'))
							 and left(nro_cuen,2)<>'40' /*and isnull(tipo_venta,'1') ='5'*/
							and (nro_cuen=dbo.f_cuenta_prov('22') or isnull(tipo_venta ,'1')='4')
		                        then importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)	/*,
	@Ld_IGV = sum(case when left(nro_cuen,2)='40' then  importe*case when cargo_abono='A' then 1 else -1 end  else 0 end)  */
from movi_contables (nolock)
where anio=@anio_a and mes=@mes_a and subdia='V'

insert @Rx
select 10,1, 'Ventas Gravadas',@Bas,@Ld_IGV union all
select 20,1, 'Ventas No Gravadas',@NoGra, 0

insert @RX
select 30,1,'TOTAL DE VENTAS', sum(base),0
from @Rx where idd in (10,20)

insert @RX
select 40,1,'IGV-VENTAS', 0 ,sum(igv)
from @Rx where idd in (10,20)

insert @RX
select 41,1,'', 0 ,0

insert @RX
select 42,1,'Total Ventas Año Anterior', @total_ant ,0

----------------- FIN VENTAS ------------------


----------------- COMPRAS ------------------
declare @CompGraNo numeric(12,2), @IgvGraNo numeric(12,2)
set @Bas=0
set @NoGra=0
set @Ld_IGV=0

select  @Bas=sum(case when isnull(tipo_venta,'1')='1' and (left(nro_cuen,2) not in ('42','43','40') or left(nro_cuen,4)='4211') and (otros=0 or isnull(otros,0)=0)
		   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end ) ,
    
        @Ld_IGV=sum(case when isnull(tipo_venta,'1')='1' and (left(nro_cuen,2) in ('40'))     
				then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end ),

		@CompGraNo=sum(case when isnull(tipo_venta,'1')='2' and (left(nro_cuen,2) not in ('42','43','40') or left(nro_cuen,4)='4211') and (otros=0 or isnull(otros,0)=0)
				then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end ) ,       
    
        @IgvGraNo=sum(case when isnull(tipo_venta,'1')='2' and (left(nro_cuen,2) in ('40'))     
				then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end ),

		@NoGra=sum(case when isnull(tipo_venta,'1')='3' and (left(nro_cuen,2) not in ('42','43','40') or left(nro_cuen,4)='4211') and (otros=0 or isnull(otros,0)=0)
		   then (case when cargo_abono='C' then Importe else -1*Importe end) else 0 end ) 
from movi_contables (nolock)
where anio=@anio and mes=@mes and subdia='C'


insert @Rx
select 50,2, 'Compras dest. a ventas Grav.',@Bas,@Ld_IGV union all
select 60,2, 'Compras dest. a ventas Grav y no Grav',@CompGraNo, @IgvGraNo*@cofigv union all
select 70,2, 'Compras dest. a ventas no Grav. ',@NoGra, 0

insert @RX
select 80,2,'TOTAL DE COMPRAS', sum(base),0
from @Rx where idd in (50,60,70)

insert @RX
select 90,2,'IGV-COMPRAS', 0 ,sum(igv)
from @Rx where idd in (50,60,70)

----------------- FIN COMPRAS ------------------


----------------IGV------------------------
insert @Rx
select 100,3,'(+) '+descri,base, igv
from @Rx where idd=40

insert @Rx
select 110,3,'(-) '+descri,base, igv
from @Rx where idd=90

insert @Rx
select 111,3,'(-) Percepciones declaradas',0,@percep union all
select 112,3,'(-) Retenciones declaradas ',0 , @reten

insert @Rx
select 120,3,'IGV-POR PAGAR',0, sum(igv*case when idd=100 then 1 else -1 end)
from @Rx where idd in (100,110,111,112)

----------------FIN IGV------------------------


--SÓLO OC
select @Bas = isnull(sum(importe),0) , 
		@Ld_IGV = isnull(sum(igv),0) 
from orden_de_compra a(nolock) 
where year(fecha)=@anio and month(fecha)=@mes and afec_rete='1' and 
		a.codi_orde_comp not in (select b.codi_orde_comp from nota_ingr_por_orde_comp b(nolock))

--SÓLO OC INAFECTAS
select @NoGra = isnull(sum(importe),0) --importe, isnull(sum(igv),0) igv 
from orden_de_compra a(nolock) 
where year(fecha)=@anio and month(fecha)=@mes and afec_rete='0'
		and a.codi_orde_comp not in (select b.codi_orde_comp from nota_ingr_por_orde_comp b(nolock))

---------------------------------- OC PARCIALES---------------------------------
insert #OC 
select b.codi_orde_comp, b.codi_nota_ingr, fecha, afec_rete
from orden_de_compra a(nolock) 
join nota_ingr_por_orde_comp b(nolock)
on a.codi_orde_comp = b.codi_orde_comp
where year(fecha)=@anio and month(fecha)=@mes 

insert #NI
select oc, codi_prod, sum(cantidad) cantidad, max(fecha) fecha, max(afec_rete)
from detalle_nota_ingreso D(nolock)
join #OC T
on D.codi_nota_ingr=T.ni
group by T.oc, codi_prod
order by 1,2

select @BasPar=isnull(sum(importe),0), 
		@Ld_IGVPar= isnull(sum(IGV),0)
from (select ((D.cantidad) - (canti)) * (precio) importe,
       ((D.cantidad) - (canti)) * (precio) *
       (Select isnull(Valor, 0)/100 From Valores_Unitarios_Anuales (nolock)
            Where Codi_Valo_Unit = 2 And Fech_Asig <= (R.fecha) And Fech_Asig_Fin >= (R.fecha)) igv        
from detalle_orden_compra D(nolock)
join #NI R
on D.codi_orde_comp = R.codi_oc and D.codi_prod=R.prod
where canti-cantidad<>0 and afec_rete='1') SQL

select @NoGraPar= isnull(sum(importe),0)
from (select ((D.cantidad) - (canti)) * (precio) importe
from detalle_orden_compra D(nolock)
join #NI R
on D.codi_orde_comp = R.codi_oc and D.codi_prod=R.prod
where canti-cantidad<>0 and afec_rete='0') SQL

---------------------------------- OC PARCIALES

insert @RX
select 91,2,'', 0 ,0

insert @RX
select 92,2,'O/C Afectas', @Bas + @BasPar ,@Ld_IGV + @Ld_IGVPar

insert @RX
select 93,2,'O/C Inafectas', @NoGra + @NoGraPar,0


select idd, grupo, 
		case grupo when 1 then 'VENTAS' 
					when 2 then 'COMPRAS' 
					when 3 then 'IGV'
					else '' end Grup, 
		descri, base, igv,
		(select razon_social from empresa (nolock)) Empresa
from @Rx
order by idd


drop table #OC
drop table #NI
GO
