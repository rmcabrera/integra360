CREATE PROCEDURE [dbo].[usp_compras_PRODUCTOS_FECHAS_d]
	@TIPO [varchar](2),
	@CODI_ALMA [char](2),
	@FEC1 [datetime],
	@FEC2 [datetime],
	@CODI_CLIE_PROV [char](5),
	@SUBFAMILIA [char](4),
	@CODI_PRES [int],
	@registro [char](11)
WITH EXECUTE AS CALLER
AS
--declare @TIPO varCHAR(2) , @CODI_ALMA CHAR(2) , @FEC1 DATETIME , @FEC2 DATETIME  , @CODI_CLIE_PROV CHAR(5)  , @SUBFAMILIA char(4) , @CODI_PRES INT , @registro char(11)
--select @TIPO ='0', @CODI_ALMA ='00' , @FEC1 ='01/01/2014', @FEC2 ='30/10/2014', @CODI_CLIE_PROV ='', @SUBFAMILIA ='', @CODI_PRES =0 , @registro='407L0020'
            
set nocount on            
            
declare @TS table (codi_prod char(8), saldo numeric(12,4) null )            
declare @KA table (codi_prod_k char(8), saldo_k numeric(12,4) null )            
declare @Tx table (nemo_alma varchar(50) null, codi_clie_prov char(5) null, laboratorio varchar(150) null, desc_sub_fami_prod varchar(150) null,             
     desc_prod char(150) null, desc_pres varchar(50) null, venta_cant_conta numeric(18,3) null, venta_valor_conta numeric(18,3) null,             
     venta_cant_exo numeric(18,3) null, venta_valor_exo numeric(18,3) null, codi_prod char(8) null,codi_alma char(2) null, desc_pago varchar(150) null, fecha datetime,
     tipo_prod varchar(10) null)            
      
declare @Rot table (rot int null, codi_clie_prov char(5) null, codi_prod char(8) null, venta_cant_conta_rota numeric(12,3) null, venta_cant_cred_rota numeric(12,3) null)      

create table #Xx (nemo_alma varchar(50) null, codi_clie_prov char(5) null, laboratorio varchar(150) null, desc_sub_fami_prod varchar(150) null, desc_prod char(150) null,            
                  desc_pres varchar(50) null, venta_cant_conta numeric(18,3) null, venta_valor_conta numeric(18,3) null, venta_cant_exo numeric(18,3) null,            
                   venta_valor_exo numeric(18,3) null, codi_prod char(8) null, desc_pago varchar(150) null)            
      
create table #Rota (rot int null, codi_clie_prov char(5) null, cod_cultivo int null,       
      codi_prod char(8) null, venta_cant_conta_rota numeric(12,3) null, venta_cant_cred_rota numeric(12,3) null)      
      
declare @anio char(4)            
declare @SQLString nvarchar(4000), @SQLString_rot nvarchar(4000)         
declare @Condi varchar(100) ,@Grup varchar(100)            
declare @ParmString nvarchar(100)            
            
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
            
SET @anio=year(dateadd(yyyy,-1,@FEC1))            
            
set nocount on            
          
if @registro<>''
	begin
	declare @Mx table ( anio char(4) , mes char(2), subdia char(1), compr varchar(10))
	declare @Reg table ( registro char(11))
	declare @DCt table ( codi_clie_prov char(5), codi_tipo_docu char(4), serie char(5) , nro_docu varchar(10) , fecha datetime)
	declare @Nx table (codi_nota_ingr char(10))
	declare @Px table (codi_nota_ingr char(10), codi_prod char(8))
	
	insert @Mx
	select anio, mes, subdia,compr 
	from movi_contables (nolock)  where registro=@registro and subdia='L'

	insert @Reg
	select registro
	from movi_contables A (nolock)
	join @Mx B
	on A.anio=b.anio and A.mes=B.mes and A.subdia=B.subdia and A.compr=B.compr
	where substring(registro,4,1)='C'

	insert @Dct
	select codi_clie_prov, codi_tipo_docu, serie, nro_docu, fecha
	from movi_contables A (nolock)
	join @Reg B
	on A.registro=B.registro
	where subdia='C' and left(nro_cuen,2) in ('42','43')

	insert @Px 
	select distinct D.codi_nota_ingr,D.codi_prod
	from detalle_nota_ingreso D (nolock)
	where D.codi_nota_ingr in (
		select codi_nota_ingr
		from nota_ingreso A (nolock) 
		join @Dct B
		on A.codi_clie_prov=B.codi_clie_prov and A.codi_tipo_docu_cont=B.codi_tipo_docu and 
			case when isnumeric(nro_seri_docu_cont)=1 then cast(cast(nro_seri_docu_cont as int)as varchar) else nro_seri_docu_cont end  = Serie and
			case when isnumeric(nro_docu_cont)=1 then cast(cast(nro_docu_cont as int) as varchar) else nro_docu_cont end= B.nro_docu and
			fech_reg_fact=fecha	)
end
   
---- TODOS LOS PRODUCTOS SIN TENER EN CUENTA EL LABORATORIO                                  

insert @Rot      
	select count(FD.codi_prod) rot,  CP.codi_clie_prov, FD.CODI_PROD,      
	venta_cant_conta_rota    = sum( case FAC.CODI_TIPO_PAGO when 1 then FD.CANT_ITEM else 0 end ) ,       
	venta_cant_cred_rota     = sum( case FAC.CODI_TIPO_PAGO when 4 then FD.CANT_ITEM else 0 end )          
	--FD.codi_prod, dbo.f_producto(FD.codi_prod) producto, CP.codi_clie_prov, dbo.f_cliente_proveedor(CP.codi_clie_prov) razon,      
	FROM ALMACEN as SUC inner join FACTURA as FAC  (nolock)on suc.codi_alma=FAC.codi_alma      
	inner join FACTURA_DETALLE  as FD (nolock)on FAC.codi_fact = FD.codi_fact      
	inner join ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)      
	inner join PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod      
	INNER join PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES      
	inner join CLIENTE_PROVEEDOR  as CP  (nolock)on PROD.codi_clie_prov = CP.CODI_CLIE_PROV      
	INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD      
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )      
		and  (cast(convert(varchar(10), FAC.fech_fact , 103) as smalldatetime) between @fec1 and @fec2)       
		AND ( FAC.ESTADO NOT IN ('A') OR FAC.ESTADO IS NULL)      
		and ( FD.codi_prod in (select P.codi_prod from @Px as P)
				or (select count(*) from @Px as P)=0 )
		and ( prod.codi_clie_prov=@CODI_CLIE_PROV  or @CODI_CLIE_PROV is null or @CODI_CLIE_PROV ='')
	group by FD.codi_prod, CP.codi_clie_prov--, cod_cultivo        
  
        
INSERT @Tx            
select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' ,            
            PROD.DESC_PROD , PRES.DESC_PRES ,            
	         
	--  venta_cant_conta    = sum(case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else fd.cantidad  end end) , --sum(fd.cantidad ),            
	--  venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )*             
	--    case when afecto=0 then 0 else case when cod_impuesto=3 then 0 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end end   ),             
	venta_cant_conta    = sum(case when isnull(tipo_COMPRA,'N')='N' then fd.cantidad  else 0 end) , --sum(fd.cantidad ),            
	venta_valor_conta  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )*             
	case when isnull(tipo_COMPRA,'N')='N'  then case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end else 0 end   ),             
	venta_cant_exo = sum(case when tipo_COMPRA='F' then fd.cantidad  else 0 end),  --sum(case when tipo_COMPRA='F' then fd.cantidad else 0 end)    ,            
	venta_valor_exo  = SUM( (CASE FAC.CODI_MONE WHEN '01' THEN 1 ELSE FAC.tipo_camb END ) * ( FD.cantidad *  FD.prec_unit )*             
	case when tipo_COMPRA='F'  then case when cod_impuesto=3 then 1 else 1+dbo.F_IGV (isnull(fech_reg_fact, fech_guia_remi))/100.00  end else 0 end )	, 
	max(FD.codi_prod) ,SUC.codi_alma,      
	(select desc_cond_pago from orden_de_compra A(nolock) where A.codi_orde_comp in      
		(select distinct left(codi_deta_orde_comp,10) 
			from detalle_nota_ingreso D(nolock) where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) desc_pago,    
	max(fech_reg_fact)    ,
	(select top 1 tipo_prod from detalle_orden_compra A(nolock) where A.codi_deta_orde_comp in      
		 (select distinct D.codi_deta_orde_comp from detalle_nota_ingreso D(nolock) 
			where D.codi_nota_ingr=max(FD.codi_nota_ingr)) ) tipo_prod      
	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma            
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr          
		inner join ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)            
		inner join PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod            
		INNER join PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES            
		inner join CLIENTE_PROVEEDOR  as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV            
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD                     
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )            
			and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)             
			AND tipo_nota_ingr='01'
			and ( FD.codi_nota_ingr in (select P.codi_nota_ingr from @Px as P)
					or (select count(*) from @Px as P)=0 )
			and ( prod.codi_clie_prov=@CODI_CLIE_PROV  or @CODI_CLIE_PROV is null or @CODI_CLIE_PROV ='')
	group by   SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION  , SF.DESC_SUB_FAMI_PROD , PROD.DESC_PROD , PRES.DESC_PRES ,suc.codi_alma            
                        
IF @TIPO<>'1'            
BEGIN            
            
	 insert @KA            
	 select K.codi_prod, sum(cant_ingr - cant_sali) Saldo    
	 from kardex k (nolock)            
	 where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )            
	 and periodo=@anio and year(fech_tran)=@anio and K.codi_prod in (select distinct T.codi_prod from @Tx T)             
	 group by K.codi_prod            
             
	 insert @TS            
	 select K.codi_prod, sum(cant_ingr - cant_sali) Saldo from kardex k (nolock)            
	   where K.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )            
	 and cast(convert(char(10),fech_tran,103)  as datetime )<= @Fec2 and periodo=year(@Fec2) and             
		K.codi_prod in (select distinct T.codi_prod from @Tx T)             
	 group by K.codi_prod            

            
	 select nemo_alma, T.codi_clie_prov, laboratorio, desc_sub_fami_prod, desc_prod,            
			desc_pres, T.venta_cant_conta, T.venta_valor_conta, T.venta_cant_exo, T.venta_valor_exo,            
	  isnull(saldo, 0) stock, isnull(saldo_k, 0) saldo,codi_alma, t.codi_prod, rot,      
		 R.venta_cant_conta_rota, R.venta_cant_cred_rota, T.desc_pago ,fecha, tipo_prod
	 from @Tx T         
	 left join @Rot R      
	 on /*T.codi_clie_prov=R.codi_clie_prov and T.cod_cultivo = R.cod_cultivo and*/ T.codi_prod=R.codi_prod         
	 left join @TS S            
	 on S.codi_prod=R.codi_prod            
	 left join @KA X            
	 on S.codi_prod = X.codi_prod_k
	 order by 5
	-- where t.codi_prod='00040024'          
             
END            
                               
drop table #alma             
drop table #Xx            
drop table #Rota
GO
