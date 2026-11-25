CREATE PROCEDURE [dbo].[usp_compras_resumen_anual]
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
--select @TIPO ='0', @CODI_ALMA ='00' , @FEC1 ='02/01/2017', @FEC2 ='31/12/2017', @CODI_CLIE_PROV ='', @SUBFAMILIA ='', @CODI_PRES =0 , @registro='407L0020'
            
set nocount on            
            
declare @TS table (codi_prod char(8), saldo numeric(12,4) null )            
declare @KA table (codi_prod_k char(8), saldo_k numeric(12,4) null )            
declare @Tx table (nemo_alma varchar(50) null, codi_clie_prov char(5) null, laboratorio varchar(150) null, desc_sub_fami_prod varchar(150) null,             
     desc_prod char(150) null, desc_pres varchar(50) null, venta_cant_conta numeric(18,3) null,
    codi_prod char(8) null,codi_alma char(2) null,fecha datetime)            
      
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
          
   
---- TODOS LOS PRODUCTOS SIN TENER EN CUENTA EL LABORATORIO                                  
        
INSERT @Tx            
select SUC.NEMO_ALMA , CP.CODI_CLIE_PROV, CP.DENOMINACION as laboratorio, upper(SF.DESC_SUB_FAMI_PROD) as 'DESC_SUB_FAMI_PROD' ,            
            PROD.DESC_PROD , PRES.DESC_PRES ,            
	         
	sum(case when isnull(tipo_COMPRA,'N')='N' then fd.cantidad  else 0 end)  as venta_cant_conta    ,

	max(FD.codi_prod) ,SUC.codi_alma,      
	max(fech_reg_fact)   
	
	FROM ALMACEN as SUC (nolock) inner join nota_ingreso as FAC  (nolock)on suc.codi_alma=FAC.codi_alma            
		inner join detalle_nota_ingreso as FD  (nolock)on FAC.codi_nota_ingr = FD.codi_nota_ingr          
		inner join ALMACEN_PRODUCTO  as AP  (nolock)on (FD.CODI_ALMA=AP.CODI_ALMA AND FD.CODI_PROD=AP.CODI_PROD)            
		inner join PRODUCTOS  as PROD (nolock) on AP.codi_prod = PROD.codi_prod            
		INNER join PRESENTACION  AS PRES (nolock) ON PROD.COD_PRES=PRES.COD_PRES            
		inner join CLIENTE_PROVEEDOR  as CP  (nolock)on fac.codi_clie_prov = CP.CODI_CLIE_PROV            
		INNER JOIN SUB_FAMILIA_PRODUCTO AS SF  (nolock)ON PROD.CODI_SUB_FAMI_PROD=SF.CODI_SUB_FAMI_PROD                     
	where SUC.codi_alma collate sql_latin1_general_cp1_ci_as in (Select codi_alma collate sql_latin1_general_cp1_ci_as  from #alma )            
			and  (cast(convert(varchar(10), isnull(fech_reg_fact, fech_guia_remi) , 103) as smalldatetime) between @fec1 and @fec2)             
			AND tipo_nota_ingr in ('01','26')
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
			desc_pres, T.venta_cant_conta, 
	  isnull(saldo, 0) stock, isnull(saldo_k, 0) saldo,codi_alma, t.codi_prod, 
		 fecha
	 from @Tx T         
	 left join @TS S            
	 on S.codi_prod=T.codi_prod            
	 left join @KA X            
	 on S.codi_prod = X.codi_prod_k
	 order by 5
	-- where t.codi_prod='00040024'          
             
END            
                               
drop table #alma             
drop table #Xx            
drop table #Rota
GO
